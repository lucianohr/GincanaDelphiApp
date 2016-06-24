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
    dsItemsCRUD: TDataSource;
    qryUsers: TFDQuery;
    dspUsers: TDataSetProvider;
    cdsUsers: TClientDataSet;
    cdsUsersid: TAutoIncField;
    cdsUsersusername: TStringField;
    cdsUserspassword: TStringField;
    FDUpdateSQL1: TFDUpdateSQL;
    qryItemsCRUDid: TFDAutoIncField;
    qryItemsCRUDbox_number: TIntegerField;
    qryItemsCRUDyear: TIntegerField;
    qryItemsCRUDdescription: TStringField;
    qryItemsCRUDkeywords: TMemoField;
    qryItemsCRUDcreated_at: TDateTimeField;
    qryItemsCRUDupdated_at: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryItemsCRUDBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure DeleteAdminUser;
  public
    { Public declarations }
    function HashMD5(source: string): string;
    function HasAdminUser: boolean;
    procedure CreateAdminUser(newPass: string);
    function VerifyPassword(pass: string): boolean;
    function ImagesPath: string;
    function ItemImagesPath(id: integer): string;
    function FindItemImages(id: integer): TStrings;
  end;

var
  dmMain: TdmMain;

implementation

uses
  Vcl.forms, Dialogs, System.UITypes, IdGlobal, IdHash, IdHashMessageDigest;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMain.qryItemsCRUDBeforePost(DataSet: TDataSet);
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

procedure TdmMain.CreateAdminUser(newPass: string);
begin
  DeleteAdminUser;
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

procedure TdmMain.DeleteAdminUser;
begin
  with cdsUsers do
  begin
    Close;
    Open;
    if RecordCount = 1 then
    begin
      Delete;
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

function TdmMain.FindItemImages(id: integer): TStrings;
var
  SRec: TSearchRec;
  Res: integer;
begin
  result := TStringList.Create;
  Res := FindFirst(ItemImagesPath(id) + '*.*', faNormal, SRec );
  if Res = 0 then
  try
    while res = 0 do
    begin
      if (SRec.Attr and faDirectory <> faDirectory) then
        Result.Add( SRec.Name );
      Res := FindNext(SRec);
    end;
  finally
    FindClose(SRec)
  end;
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
  result := ExtractFilePath(Application.ExeName) + 'Images\';
end;

function TdmMain.ItemImagesPath(id: integer): string;
begin
  ForceDirectories(ImagesPath + 'Item_' + IntToStr(id));
  result := ImagesPath + 'Item_' + IntToStr(id) + '\';
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
