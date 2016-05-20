unit unMainWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMainWindow = class(TForm)
    btnNewItem: TButton;
    pnlActions: TPanel;
    Label1: TLabel;
    searchFieldSelect: TComboBox;
    searchText: TEdit;
    Button1: TButton;
    procedure btnNewItemClick(Sender: TObject);
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

end.
