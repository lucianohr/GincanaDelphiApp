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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPassword: TfrmPassword;

implementation

uses unMainDM;

function VerifyPassword(pass: string): boolean;
begin
  frmPassword.lblError.Visible := True;
  result := pass = 'caveira';
end;

{$R *.dfm}

procedure TfrmPassword.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (frmPassword.ModalResult = mrCancel) then
  begin
    CanClose := true;
  end
  else if (frmPassword.ModalResult = mrOk) and (VerifyPassword(edtPassword.Text)) then
  begin
    CanClose := true;
  end
  else begin
    edtPassword.SelectAll;
    edtPassword.SetFocus;
    CanClose := false;
  end;
end;

end.

