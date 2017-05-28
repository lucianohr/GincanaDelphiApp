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
  Vcl.Controls,
  Dialogs,
  unNewPassword in 'Source\unNewPassword.pas' {frmNewPassword},
  unImageZoom in 'Source\unImageZoom.pas' {frmImageZoom},
  unGlobals in 'Source\unGlobals.pas',
  unLicence in 'Source\unLicence.pas' {frmLicence};

{$R *.res}

var
  licResult: TModalResult;
  validate: Byte;
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
  validate := unGlobals.ValidateLicence;
  if validate > 1 then
  begin
    Application.CreateForm(TfrmLicence, frmLicence);
    licResult := frmLicence.ShowModal;
    if licResult = mrIgnore then
      dmMain.dbConnection.UpdateOptions.ReadOnly := True
    else if licResult = mrOk then
      dmMain.dbConnection.UpdateOptions.ReadOnly := False
    else
      Application.Terminate;
  end
  else if validate = 1 then
  begin
    ShowMessage('Licença inválida para este computador.');
    Application.Terminate;
  end;

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
