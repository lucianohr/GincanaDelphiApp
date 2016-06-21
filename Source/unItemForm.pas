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
    LoadImage: TOpenPictureDialog;
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
    procedure SaveImage(objCode: integer);
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
var
  TmpName: string;
begin
  btnDelete.Enabled := dmMain.cdsItemsCRUD.State in [dsEdit, dsBrowse];
  if dmMain.cdsItemsCRUDid.AsInteger <> 0 then
  begin
    TmpName := dmMain.FindObjectImage(dmMain.cdsItemsCRUDid.AsInteger);
    if TmpName <> '' then
      Image1.Picture.LoadFromFile(TmpName);
  end;
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
  begin
    if (dmMain.FObjectID <> 0) then
      SaveImage(dmMain.FObjectID)
    else
      SaveImage(dmMain.cdsItemsCRUDid.AsInteger);
    RefreshAndClose;
  end;
end;

procedure TfrmItemForm.btnLoadImageClick(Sender: TObject);
begin
  if LoadImage.Execute then
  begin
    Image1.Picture.LoadFromFile(LoadImage.FileName);
  end;
end;


procedure TfrmItemForm.RefreshAndClose;
begin
  dmMain.cdsItemsCRUD.Close;
  dmMain.cdsItemsList.Refresh;
  Self.Close;
end;

procedure TfrmItemForm.SaveImage(objCode: integer);
begin
  if (LoadImage.FileName <> '') and (Image1.Picture <> nil)
    and (LoadImage.FileName <> dmMain.FindObjectImage(objCode)) then
  begin
    if FileExists(dmMain.FindObjectImage(objCode)) then
      DeleteFile(dmMain.FindObjectImage(objCode));
    Image1.Picture.SaveToFile(dmMain.ImagesPath + dmMain.ObjectImageName(objCode, ExtractFileExt(LoadImage.FileName)));
  end;
end;

end.
