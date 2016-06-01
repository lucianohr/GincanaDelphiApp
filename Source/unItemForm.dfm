object frmItemForm: TfrmItemForm
  Left = 0
  Top = 0
  ActiveControl = DBEdit1
  BorderStyle = bsDialog
  Caption = 'Incluir / Modificar Objeto'
  ClientHeight = 237
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    750
    237)
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 63
    Top = 8
    Width = 43
    Height = 18
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 71
    Top = 39
    Width = 35
    Height = 18
    Caption = 'Caixa'
  end
  object Label3: TLabel
    Left = 81
    Top = 71
    Width = 25
    Height = 18
    Caption = 'Ano'
  end
  object Label4: TLabel
    Left = 8
    Top = 102
    Width = 98
    Height = 18
    Caption = 'Palavras-chave'
  end
  object Label5: TLabel
    Left = 54
    Top = 192
    Width = 56
    Height = 18
    Caption = 'Imagem'
    Visible = False
  end
  object Image1: TImage
    Left = 116
    Top = 192
    Width = 207
    Height = 207
    Proportional = True
    Visible = False
  end
  object btnSave: TButton
    Left = 457
    Top = 198
    Width = 91
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salvar'
    Default = True
    ImageIndex = 0
    Images = dmMain.ImageList1
    ModalResult = 1
    TabOrder = 4
    OnClick = btnSaveClick
    ExplicitTop = 368
  end
  object btnCancel: TButton
    Left = 651
    Top = 198
    Width = 91
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ImageIndex = 1
    Images = dmMain.ImageList1
    ModalResult = 2
    TabOrder = 6
    OnClick = btnCancelClick
    ExplicitTop = 368
  end
  object DBEdit1: TDBEdit
    Left = 116
    Top = 36
    Width = 121
    Height = 26
    DataField = 'box_number'
    DataSource = dmMain.dsItemsCRUD
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 116
    Top = 68
    Width = 77
    Height = 26
    DataField = 'year'
    DataSource = dmMain.dsItemsCRUD
    TabOrder = 2
  end
  object DBMemo1: TDBMemo
    Left = 116
    Top = 100
    Width = 626
    Height = 86
    DataField = 'keywords'
    DataSource = dmMain.dsItemsCRUD
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 116
    Top = 4
    Width = 121
    Height = 26
    Color = clBtnFace
    DataField = 'id'
    DataSource = dmMain.dsItemsCRUD
    ReadOnly = True
    TabOrder = 0
  end
  object btnDelete: TButton
    Left = 554
    Top = 198
    Width = 91
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Excluir'
    ImageIndex = 4
    Images = dmMain.ImageList1
    TabOrder = 5
    OnClick = btnDeleteClick
    ExplicitTop = 368
  end
  object btnLoadImage: TButton
    Left = 77
    Top = 46
    Width = 33
    Height = 31
    Hint = 'Adicionar imagem'
    Anchors = [akRight, akBottom]
    ImageIndex = 7
    Images = dmMain.ImageList1
    TabOrder = 7
    Visible = False
    OnClick = btnLoadImageClick
    ExplicitTop = 216
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'Todos (*.gif;*.png;*.jpg;*.jpeg)|*.gif;*.png;*.jpg;*.jpeg|GIF Im' +
      'age (*.gif)|*.gif|Portable Network Graphics (*.png)|*.png|JPEG I' +
      'mage File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Selecionar Imagem'
    Left = 620
    Top = 36
  end
end
