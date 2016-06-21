unit unMainDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Data.DB,
  FireDAC.Comp.Client, System.ImageList, Vcl.ImgList, Vcl.Controls, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider,
  Datasnap.DBClient, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.FMXUI.Wait;

type
  TdmMain = class(TDataModule)
    dbConnection: TFDConnection;
    ImageList1: TImageList;
    qryItemsList: TFDQuery;
    dbTransaction: TFDTransaction;
    dspItemsList: TDataSetProvider;
    cdsItemsList: TClientDataSet;
    dsItemsList: TDataSource;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    cdsItemsListid: TAutoIncField;
    cdsItemsListbox_number: TIntegerField;
    cdsItemsListyear: TIntegerField;
    cdsItemsListdescription: TStringField;
    cdsItemsListcreated_at: TDateTimeField;
    cdsItemsListupdated_at: TDateTimeField;
    qryItemsCRUD: TFDQuery;
    dspItemsCRUD: TDataSetProvider;
    cdsItemsCRUD: TClientDataSet;
    dsItemsCRUD: TDataSource;
    cdsItemsCRUDid: TAutoIncField;
    cdsItemsCRUDbox_number: TIntegerField;
    cdsItemsCRUDyear: TIntegerField;
    cdsItemsCRUDdescription: TStringField;
    cdsItemsCRUDkeywords: TMemoField;
    cdsItemsCRUDcreated_at: TDateTimeField;
    cdsItemsCRUDupdated_at: TDateTimeField;
    qryUsers: TFDQuery;
    dspUsers: TDataSetProvider;
    cdsUsers: TClientDataSet;
    cdsUsersid: TAutoIncField;
    cdsUsersusername: TStringField;
    cdsUserspassword: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsItemsCRUDBeforePost(DataSet: TDataSet);
    procedure dspItemsCRUDAfterUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
    procedure cdsItemsCRUDNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    FObjectID: integer;
    function HashMD5(source: string): string;
    function HasAdminUser: boolean;
    procedure CreateFirstUser(newPass: string);
    function VerifyPassword(pass: string): boolean;
    function ImagesPath: string;
    function ObjectImageName(id: integer; ext: string): string;
    function FindObjectImage(id: integer): TFileName;
  end;

var
  dmMain: TdmMain;

implementation

uses
  Vcl.forms, Dialogs, System.UITypes, IdGlobal, IdHash, IdHashMessageDigest;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMain.cdsItemsCRUDBeforePost(DataSet: TDataSet);
var
  field: TField;
begin
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('created_at').AsDateTime := Now;
  end;
  DataSet.FieldByName('description').AsString := Copy(DataSet.FieldByName('keywords').AsWideString, 1, 255);
  DataSet.FieldByName('updated_at').AsDateTime := Now;

  for field in DataSet.Fields do
  begin
    if field.IsNull and field.Required then
    begin
      MessageDlg(Format('O campo "%s" é requerido!', [field.DisplayName]), mtError, [mbOK], 0);
      Abort;
    end;
  end;
end;

procedure TdmMain.cdsItemsCRUDNewRecord(DataSet: TDataSet);
begin
  FObjectID := 0;
end;

procedure TdmMain.CreateFirstUser(newPass: string);
begin
  with cdsUsers do
  begin
    Close;
    Open;
    if RecordCount = 0 then
    begin
      Insert;
      FindField('username').AsString := 'admin';
      FindField('password').AsString := HashMD5(newPass);
      Post;
      ApplyUpdates(0);
    end;
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
var
  dbFile: string;
begin
  dbConnection.Connected := false;
  dbConnection.Params.Database := '';
  dbFile := ExtractFilePath(Application.ExeName) + 'dbGincana.sl3';
  if FileExists(dbFile) = true then
  begin
    dbConnection.Params.Database := dbFile;
    dbConnection.Connected := true;
  end;
end;

procedure TdmMain.dspItemsCRUDAfterUpdateRecord(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
begin
  // id do novo Objeto inserido. Nome da imagem
  if (UpdateKind = ukInsert) then
    FObjectID := SourceDS.FieldByName('id').Value;
end;

function TdmMain.FindObjectImage(id: integer): TFileName;
var
  SRec: TSearchRec;
  TmpName: string;
begin
  TmpName := format('%.7d', [id]);
  if FindFirst(ImagesPath + TmpName + '.*', faAnyfile, SRec ) = 0 then
    result := ImagesPath + SRec.Name
  else
    result := '';
end;

function TdmMain.HashMD5(source: string): string;
var
  md5: TIdHashMessageDigest5;
begin
  md5 := TIdHashMessageDigest5.Create;
  try
    Result := md5.HashStringAsHex(source);
  finally
    FreeAndNil(md5);
  end;
end;

function TdmMain.ImagesPath: string;
begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + 'Images');
  result := ExtractFilePath(Application.ExeName) + 'Images\';
end;

function TdmMain.ObjectImageName(id: integer; ext: string): string;
begin
  result := format('%.7d%s', [id, ext]);
end;

function TdmMain.VerifyPassword(pass: string): boolean;
begin
  with cdsUsers do
  begin
    Close;
    Open;
    result := (RecordCount = 1) and (FindField('password').AsString = HashMD5(pass));
  end;
end;

function TdmMain.HasAdminUser: boolean;
begin
  with cdsUsers do
  begin
    Close;
    Open;
    result := RecordCount = 1;
  end;
end;

end.
