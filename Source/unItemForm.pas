unit unItemForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmItemForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItemForm: TfrmItemForm;

implementation

{$R *.dfm}

procedure TfrmItemForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Release;
//  frmItemForm := nil;
  FreeAndNil(frmItemForm);
end;

end.
