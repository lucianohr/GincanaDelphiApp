program prjAppGincana;

uses
  Vcl.Forms,
  System.SysUtils,
  unMainWindow in 'Source\unMainWindow.pas' {frmMainWindow},
  unMainDM in 'Source\unMainDM.pas' {dmMain: TDataModule},
  unItemForm in 'Source\unItemForm.pas' {frmItemForm},
  unPassword in 'Source\unPassword.pas' {frmPassword},
  Vcl.Themes,
  Vcl.Styles,
  Windows,
  unNewPassword in 'Source\unNewPassword.pas' {frmNewPassword},
  unImageZoom in 'Source\unImageZoom.pas' {frmImageZoom};

{$R *.res}

begin
  if CreateMutex(nil, True, 'C5B7B5E3-5AEA-4589-AF35-77C5629F806B') = 0 then
    RaiseLastOSError;

  if GetLastError = ERROR_ALREADY_EXISTS then
    Exit;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gincana - Cadastro de Objetos';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMainWindow, frmMainWindow);
  if dmMain.HasAdminUser then
  begin
    Application.CreateForm(TfrmPassword, frmPassword);
    frmPassword.ShowModal;
  end
  else
  begin
    Application.CreateForm(TfrmNewPassword, frmNewPassword);
    frmNewPassword.ShowModal;
  end;

  Application.Run;
end.
