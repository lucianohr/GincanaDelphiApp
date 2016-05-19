unit unMainWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmMainWindow = class(TForm)
    btnNewItem: TButton;
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
