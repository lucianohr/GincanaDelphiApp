unit unLicence;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmLicence = class(TForm)
    PageControl1: TPageControl;
    tsReadOnly: TTabSheet;
    tsRegistry: TTabSheet;
    Label1: TLabel;
    btnReadOnlyMode: TButton;
    btnRegistry: TButton;
    btnClose: TButton;
    edtClientId: TLabeledEdit;
    Label2: TLabel;
    edtSerialNumber: TLabeledEdit;
    btnSave: TButton;
    procedure tsRegistryShow(Sender: TObject);
    procedure btnRegistryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtClientIdClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLicence: TfrmLicence;

implementation

{$R *.dfm}

uses
  unGlobals, Clipbrd;

procedure TfrmLicence.btnRegistryClick(Sender: TObject);
begin
  PageControl1.ActivePage := tsRegistry;
end;

procedure TfrmLicence.btnSaveClick(Sender: TObject);
begin
  if edtSerialNumber.Text = unGlobals.GenerateSerial(edtClientId.Text) then
  begin
    unGlobals.SaveSerialNumber(edtSerialNumber.Text);
    ModalResult := mrOk;
    Self.CloseModal;
  end
  else
    ShowMessage('Número de série inválido!');
end;

procedure TfrmLicence.edtClientIdClick(Sender: TObject);
begin
  edtClientId.SelectAll;
  Clipboard.AsText := edtClientId.Text;
end;

procedure TfrmLicence.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage := tsReadOnly;
end;

procedure TfrmLicence.tsRegistryShow(Sender: TObject);
begin
  edtClientId.Text := unGlobals.GetClientId;
end;

end.
