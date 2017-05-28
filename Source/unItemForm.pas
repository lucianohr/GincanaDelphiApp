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
    ImagesList: TListBox;
    PnlPreviewImage: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    PnlLoadedImages: TPanel;
    PnlNewImages: TPanel;
    Label8: TLabel;
    NewImagesList: TListBox;
    Label9: TLabel;
    BtnRemoveImage: TButton;
    DBEdit4: TDBEdit;
    Label10: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure ImagesListClick(Sender: TObject);
    procedure BtnRemoveImageClick(Sender: TObject);
  private
    procedure RefreshAndClose;
    procedure SaveImages(objCode: integer);
    procedure LoadImages(id: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItemForm: TfrmItemForm;

implementation

{$R *.dfm}

uses
  unMainDM, Data.DB, Jpeg, unImageZoom, System.IOUtils;

procedure TfrmItemForm.btnCancelClick(Sender: TObject);
begin
  dmMain.qryItemsCRUD.Cancel;
  Self.Close;
end;

procedure TfrmItemForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmItemForm);
end;

procedure TfrmItemForm.FormShow(Sender: TObject);
begin
  btnSave.Enabled := not dmMain.dbConnection.UpdateOptions.ReadOnly;
  btnDelete.Enabled := (dmMain.qryItemsCRUD.State in [dsEdit, dsBrowse]) and (not dmMain.dbConnection.UpdateOptions.ReadOnly);
  btnLoadImage.Enabled := not dmMain.dbConnection.UpdateOptions.ReadOnly;
  BtnRemoveImage.Enabled := not dmMain.dbConnection.UpdateOptions.ReadOnly;
  LoadImages(dmMain.qryItemsCRUDid.AsInteger);
end;

procedure TfrmItemForm.Image1DblClick(Sender: TObject);
begin
  if (frmImageZoom = nil) and (Image1.Picture <> nil) then
  begin
    frmImageZoom := TfrmImageZoom.Create(Application);
    frmImageZoom.Image1.Picture := Image1.Picture;
    frmImageZoom.Show;
  end;
end;

procedure TfrmItemForm.ImagesListClick(Sender: TObject);
begin
  if (ImagesList.Items.Count <> 0) then
    Image1.Picture.LoadFromFile(dmMain.ItemImagesPath(dmMain.qryItemsCRUDid.AsInteger) + ImagesList.Items[ImagesList.ItemIndex]);
end;

procedure TfrmItemForm.LoadImages(id: integer);
begin
  if id <> 0 then
  begin
    ImagesList.Items := dmMain.FindItemImages(id);
    ImagesList.ItemIndex := 0;
    ImagesListClick(self);
  end;
end;

procedure TfrmItemForm.btnDeleteClick(Sender: TObject);
var
  objCode: integer;
begin
  if Application.MessageBox('Deseja excluir o objeto?', PWideChar(Application.Title), MB_YESNO or MB_ICONQUESTION) = IDYES then
  begin
    objCode := dmMain.qryItemsCRUDid.AsInteger;
    dmMain.qryItemsCRUD.Delete;
    TDirectory.Delete(dmMain.ItemImagesPath(objCode), true);
    RefreshAndClose;
  end;
end;

procedure TfrmItemForm.btnSaveClick(Sender: TObject);
begin
  dmMain.qryItemsCRUD.Post;
  SaveImages(dmMain.qryItemsCRUDid.AsInteger);
  RefreshAndClose;
end;

procedure TfrmItemForm.btnLoadImageClick(Sender: TObject);
begin
  if LoadImage.Execute then
  begin
    try
      PnlLoadedImages.Visible := False;
      PnlPreviewImage.Visible := False;
      PnlNewImages.Visible := True;
      NewImagesList.Items := LoadImage.Files;
    finally
      LoadImage.Files.Clear;
    end;
  end;
end;


procedure TfrmItemForm.BtnRemoveImageClick(Sender: TObject);
begin
  if (ImagesList.ItemIndex >= 0) and (Application.MessageBox('Deseja remover a imagem selecionada?', PWideChar(Application.Title), MB_YESNO or MB_ICONQUESTION) = IDYES) then
  begin
    DeleteFile(dmMain.ItemImagesPath(dmMain.qryItemsCRUDid.AsInteger) + ImagesList.Items[ImagesList.ItemIndex]);
    LoadImages(dmMain.qryItemsCRUDid.AsInteger);
  end;
end;

procedure TfrmItemForm.RefreshAndClose;
begin
  dmMain.qryItemsCRUD.Close;
  dmMain.cdsItemsList.Refresh;
  Self.Close;
end;

procedure TfrmItemForm.SaveImages(objCode: integer);
var
  item: string;
begin
  if (NewImagesList.Items.Count > 0) then
  begin
    for item in NewImagesList.Items do
    begin
      Image1.Picture.LoadFromFile(item);
      if (Image1.Picture <> nil) then
        Image1.Picture.SaveToFile(dmMain.ItemImagesPath(objCode) + ExtractFileName(item));
    end;
    LoadImages(objCode);
  end;
end;

end.
