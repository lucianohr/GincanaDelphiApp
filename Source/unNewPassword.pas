unit unNewPassword;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unPassword, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmNewPassword = class(TfrmPassword)
    Label2: TLabel;
    edtConfirmPassword: TEdit;
    lblError2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewPassword: TfrmNewPassword;

implementation

{$R *.dfm}

uses unMainWindow, unMainDM;

function ConfirmPassword: boolean;
begin
  result := (frmNewPassword.edtPassword.Text = frmNewPassword.edtConfirmPassword.Text)
    and (frmNewPassword.edtPassword.Text <> '');
end;

procedure TfrmNewPassword.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if not ConfirmPassword then
    begin
      edtPassword.SelectAll;
      edtPassword.SetFocus;
      edtConfirmPassword.Text := '';
      lblError2.Visible := True;
      Action := caNone;
      Abort;
    end;
    dmMain.CreateFirstUser(edtConfirmPassword.Text);
    frmMainWindow.FormShow(Sender);
  end
  else
    Application.Terminate;
end;

end.
