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
  unImageZoom in 'Source\unImageZoom.pas' {frmImageZoom},
  unGlobals in 'Source\unGlobals.pas';

{$R *.res}

begin
  if CreateMutex(nil, True, unGlobals.APP_ID) = 0 then
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
