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
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

uses Vcl.forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

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
