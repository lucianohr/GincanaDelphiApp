unit unGenerateLicence;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmGenerateLicence = class(TForm)
    edtClientId: TLabeledEdit;
    edtSerialNumber: TLabeledEdit;
    btnGenerate: TButton;
    procedure edtSerialNumberClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGenerateLicence: TfrmGenerateLicence;

implementation

uses
  Clipbrd, unGlobals;

{$R *.dfm}

procedure TfrmGenerateLicence.btnGenerateClick(Sender: TObject);
begin
  edtSerialNumber.Text := unGlobals.GenerateSerial(edtClientId.Text);
end;

procedure TfrmGenerateLicence.edtSerialNumberClick(Sender: TObject);
begin
  edtSerialNumber.SelectAll;
  Clipboard.AsText := edtSerialNumber.Text;
end;

end.
