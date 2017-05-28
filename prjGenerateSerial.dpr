program prjGenerateSerial;

uses
  Vcl.Forms,
  unGenerateLicence in 'Source\unGenerateLicence.pas' {frmGenerateLicence},
  unGlobals in 'Source\unGlobals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGenerateLicence, frmGenerateLicence);
  Application.Run;
end.
