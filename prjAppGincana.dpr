program prjAppGincana;

uses
  Vcl.Forms,
  System.SysUtils,
  unMainWindow in 'Source\unMainWindow.pas' {frmMainWindow},
  unMainDM in 'Source\unMainDM.pas' {dmMain: TDataModule},
  unItemForm in 'Source\unItemForm.pas' {frmItemForm},
  unPassword in 'Source\unPassword.pas' {frmPassword},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gincana - Cadastro de Objetos';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMainWindow, frmMainWindow);
  Application.CreateForm(TfrmPassword, frmPassword);
  frmPassword.Showmodal;
  Application.Run;
end.
