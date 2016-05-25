unit unMainWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmMainWindow = class(TForm)
    btnNewItem: TButton;
    pnlActions: TPanel;
    Label1: TLabel;
    searchFieldSelect: TComboBox;
    searchText: TEdit;
    Button1: TButton;
    DBGrid1: TDBGrid;
    procedure btnNewItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainWindow: TfrmMainWindow;

implementation

{$R *.dfm}

uses unMainDM, unItemForm;

procedure TfrmMainWindow.btnNewItemClick(Sender: TObject);
begin
  if frmItemForm = nil then
  begin
    frmItemForm := TfrmItemForm.Create(Application);
  end;
  frmItemForm.Show;
end;

procedure TfrmMainWindow.DBGrid1TitleClick(Column: TColumn);
begin
  dmMain.cdsItemsList.IndexFieldNames := Column.FieldName;
end;

procedure TfrmMainWindow.FormShow(Sender: TObject);
begin
  if dmMain.dbConnection.Connected = true then
  begin
    dmMain.cdsItemsList.Active := true;
  end;
end;

end.
