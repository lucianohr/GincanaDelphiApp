unit unPassword;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmPassword = class(TForm)
    Label1: TLabel;
    edtPassword: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    lblError: TLabel;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPassword: TfrmPassword;

implementation

uses unMainDM, unMainWindow;

function VerifyPassword(pass: string): boolean;
begin
  frmPassword.lblError.Visible := True;
  result := pass = '123456';
end;

{$R *.dfm}

procedure TfrmPassword.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if not VerifyPassword(edtPassword.Text) then
    begin
      edtPassword.SelectAll;
      edtPassword.SetFocus;
      Action := caNone;
      Abort;
    end;
    frmMainWindow.FormShow(Sender);
  end
  else
    Application.Terminate;
end;

end.

