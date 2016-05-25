program prjAppGincana;

uses
  Vcl.Forms, System.SysUtils,
  unMainWindow in 'Source\unMainWindow.pas' {frmMainWindow},
  unMainDM in 'Source\unMainDM.pas' {dmMain: TDataModule},
  unItemForm in 'Source\unItemForm.pas' {frmItemForm},
  unPassword in 'Source\unPassword.pas' {frmPassword};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMainWindow, frmMainWindow);
  Application.CreateForm(TfrmPassword, frmPassword);
  if frmPassword.Showmodal = 1 then
  begin
    FreeAndNil(frmPassword);
    Application.Run;
  end
  else
  begin
    Application.Terminate;
  end;
end.
