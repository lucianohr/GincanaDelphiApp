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
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsItemsCRUDBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

uses
  Vcl.forms, Dialogs, System.UITypes;

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

end.
