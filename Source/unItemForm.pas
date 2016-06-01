unit unItemForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Controls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Bind.Navigator, Data.Bind.Components, Data.Bind.DBScope,
  FireDAC.UI.Intf, FireDAC.VCLUI.Error, FireDAC.Stan.Error, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  Vcl.ExtDlgs;

type
  TfrmItemForm = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    btnDelete: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    btnLoadImage: TButton;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
  private
    procedure RefreshAndClose;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItemForm: TfrmItemForm;

implementation

{$R *.dfm}

uses
  unMainDM, Data.DB, Jpeg;

procedure TfrmItemForm.btnCancelClick(Sender: TObject);
begin
  dmMain.cdsItemsCRUD.Cancel;
  dmMain.cdsItemsCRUD.CancelUpdates;
  Self.Close;
end;

procedure TfrmItemForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmItemForm);
end;

procedure TfrmItemForm.FormShow(Sender: TObject);
begin
  btnDelete.Enabled := dmMain.cdsItemsCRUD.State in [dsEdit, dsBrowse];
end;

procedure TfrmItemForm.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir o objeto?', PWideChar(Application.Title), MB_YESNO or MB_ICONQUESTION) = IDYES then
  begin
    dmMain.cdsItemsCRUD.Delete;
    if dmMain.cdsItemsCRUD.ApplyUpdates(0) = 0 then
      RefreshAndClose;
  end;
end;

procedure TfrmItemForm.btnSaveClick(Sender: TObject);
begin
  dmMain.cdsItemsCRUD.Post;
  if dmMain.cdsItemsCRUD.ApplyUpdates(0) = 0 then
    RefreshAndClose
end;

procedure TfrmItemForm.btnLoadImageClick(Sender: TObject);
//var
//  ms: TMemoryStream;
begin
//  if OpenPictureDialog1.Execute then
//  begin
//    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
//    ms := TMemoryStream.Create;
//    ms.position:=0;
//    Image1.Picture.Graphic.SaveToStream(ms);
//    ms.position:=0;
//    with dmMain.cdsItemsCRUDimage as TBlobField do
//      LoadFromStream(ms);
//    FreeAndNil(ms);
//  end;

//  if OpenPictureDialog1.Execute then
//  try
//    if OpenPictureDialog1.FileName <> '' then
//      dmMain.cdsItemsCRUDimage.LoadFromFile(OpenPictureDialog1.FileName)
//    else
//      dmMain.cdsItemsCRUDimage.Clear;
//  except
//    dmMain.cdsItemsCRUDimage.Clear;
//    Application.MessageBox('Não foi possível carregar a imagem!','ATENÇÃO',MB_OK+MB_ICONERROR);
//  end;
end;

procedure TfrmItemForm.RefreshAndClose;
begin
  dmMain.cdsItemsCRUD.Close;
  dmMain.cdsItemsList.Refresh;
  Self.Close;
end;

end.
