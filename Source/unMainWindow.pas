unit unMainWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmMainWindow = class(TForm)
    btnNewItem: TButton;
    pnlActions: TPanel;
    Label1: TLabel;
    searchFieldSelect: TComboBox;
    searchText: TEdit;
    btnSearch: TButton;
    DBGrid1: TDBGrid;
    btnClear: TButton;
    btnChangePass: TButton;
    Button1: TButton;
    procedure btnNewItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnChangePassClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure CreateFormItem;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainWindow: TfrmMainWindow;

implementation

{$R *.dfm}

uses unMainDM, unItemForm, unNewPassword;

procedure TfrmMainWindow.btnChangePassClick(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja alterar a senha de acesso?', PWideChar(Application.Title), MB_YESNO or MB_ICONQUESTION) = IDYES then
  begin
    frmNewPassword := TfrmNewPassword.Create(Self);
    frmNewPassword.ShowModal;
  end;
end;

procedure TfrmMainWindow.btnClearClick(Sender: TObject);
begin
  dmMain.cdsItemsList.Filtered := False;
  searchText.Clear;
  searchText.SetFocus;
end;

procedure TfrmMainWindow.btnNewItemClick(Sender: TObject);
begin
  CreateFormItem;
  dmMain.qryItemsCRUD.Open;
  dmMain.qryItemsCRUD.Insert;
  frmItemForm.Show;
end;

procedure TfrmMainWindow.btnSearchClick(Sender: TObject);
var
  item, filterCondition: string;
  index: byte;
  Splitted: TArray<String>;
begin
  with dmMain.cdsItemsList do
  begin
    try
      Filtered := False;
      case searchFieldSelect.ItemIndex of
        0: begin
          Splitted := AnsiUpperCase(searchText.Text).Split([' ', ',', ';', '\', '/']);
          filterCondition := '';
          index := 0;
          for item in Splitted do
          begin
            inc(index);
            filterCondition := filterCondition + '(UPPER(description) Like ''%' + item + '%'')';
            if index <> Length(Splitted) then
              filterCondition := filterCondition + ' OR ';
          end;
          Filter := filterCondition;
        end;
        1: Filter := Format('box_number = %d', [StrToInt(searchText.Text)]);
        2: Filter := Format('year = %d', [StrToInt(searchText.Text)]);
      end;
      Filtered := True;
    except
      MessageDlg('Critério de pesquisa inválido!', mtError, [mbOK], 0);;
      btnClear.Click;
    end;
  end;
end;

procedure TfrmMainWindow.Button1Click(Sender: TObject);
begin
  dmMain.frxReport1.FileName := 'object_list.fr3';
  dmMain.frxReport1.ShowReport(True);
end;

procedure TfrmMainWindow.DBGrid1DblClick(Sender: TObject);
begin
  CreateFormItem;
  dmMain.qryItemsCRUD.Close;
  dmMain.qryItemsCRUD.ParamByName('id').AsInteger := dmMain.cdsItemsList.FieldByName('id').AsInteger;
  dmMain.qryItemsCRUD.Open;
  if not dmMain.dbConnection.UpdateOptions.ReadOnly then
    dmMain.qryItemsCRUD.Edit;
  frmItemForm.Show;
end;

procedure TfrmMainWindow.DBGrid1TitleClick(Column: TColumn);
begin
  dmMain.cdsItemsList.IndexFieldNames := Column.FieldName;
end;

procedure TfrmMainWindow.CreateFormItem;
begin
  if frmItemForm = nil then
  begin
    frmItemForm := TfrmItemForm.Create(Application);
  end;
end;

procedure TfrmMainWindow.FormShow(Sender: TObject);
begin
  if dmMain.dbConnection.Connected = true then
  begin
    dmMain.cdsItemsList.Active := true;
    btnNewItem.Enabled := not dmMain.dbConnection.UpdateOptions.ReadOnly;
  end;
end;

end.
