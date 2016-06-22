unit unImageZoom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TfrmImageZoom = class(TForm)
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImageZoom: TfrmImageZoom;

implementation

{$R *.dfm}

procedure TfrmImageZoom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmImageZoom);
end;

end.
