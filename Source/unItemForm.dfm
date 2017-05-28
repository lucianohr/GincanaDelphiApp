object frmItemForm: TfrmItemForm
  Left = 0
  Top = 0
  ActiveControl = DBEdit1
  BorderStyle = bsDialog
  Caption = 'Incluir / Modificar Objeto'
  ClientHeight = 451
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
    451)
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
    Left = 353
    Top = 39
    Width = 25
    Height = 18
    Caption = 'Ano'
  end
  object Label4: TLabel
    Left = 8
    Top = 110
    Width = 98
    Height = 18
    Caption = 'Palavras-chave'
  end
  object Label10: TLabel
    Left = 589
    Top = 39
    Width = 37
    Height = 18
    Caption = 'Custo'
  end
  object PnlLoadedImages: TPanel
    Left = 4
    Top = 192
    Width = 369
    Height = 213
    BevelOuter = bvNone
    TabOrder = 10
    object Label5: TLabel
      Left = 44
      Top = 0
      Width = 58
      Height = 36
      Alignment = taRightJustify
      Caption = 'Imagens salvas'
      WordWrap = True
    end
    object Label6: TLabel
      Left = -1
      Top = 162
      Width = 103
      Height = 42
      Alignment = taRightJustify
      Caption = '(clique no item ao lado para visualizar a imagem)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object ImagesList: TListBox
      Left = 112
      Top = 0
      Width = 245
      Height = 207
      ItemHeight = 18
      TabOrder = 0
      OnClick = ImagesListClick
    end
  end
  object PnlPreviewImage: TPanel
    Left = 420
    Top = 192
    Width = 322
    Height = 213
    BevelOuter = bvNone
    TabOrder = 9
    object Image1: TImage
      Left = 112
      Top = 0
      Width = 207
      Height = 207
      Hint = 'Duplo clique para ampliar imagem'
      Center = True
      Proportional = True
      OnDblClick = Image1DblClick
    end
    object Label7: TLabel
      Left = 30
      Top = 0
      Width = 76
      Height = 18
      Alignment = taRightJustify
      Caption = 'Visualiza'#231#227'o'
      WordWrap = True
    end
  end
  object btnSave: TButton
    Left = 457
    Top = 412
    Width = 91
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Salvar'
    Default = True
    ImageIndex = 0
    Images = dmMain.ImageList1
    ModalResult = 1
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 651
    Top = 412
    Width = 91
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ImageIndex = 1
    Images = dmMain.ImageList1
    ModalResult = 2
    TabOrder = 8
    OnClick = btnCancelClick
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
    Left = 388
    Top = 36
    Width = 77
    Height = 26
    DataField = 'year'
    DataSource = dmMain.dsItemsCRUD
    TabOrder = 2
  end
  object DBMemo1: TDBMemo
    Left = 116
    Top = 68
    Width = 626
    Height = 118
    DataField = 'keywords'
    DataSource = dmMain.dsItemsCRUD
    ScrollBars = ssVertical
    TabOrder = 4
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
    Top = 412
    Width = 91
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Excluir'
    ImageIndex = 4
    Images = dmMain.ImageList1
    TabOrder = 7
    OnClick = btnDeleteClick
  end
  object btnLoadImage: TButton
    Left = 73
    Top = 234
    Width = 33
    Height = 31
    Hint = 'Adicionar imagem'
    Anchors = [akRight, akBottom]
    ImageIndex = 7
    Images = dmMain.ImageList1
    TabOrder = 5
    OnClick = btnLoadImageClick
  end
  object PnlNewImages: TPanel
    Left = 0
    Top = 264
    Width = 742
    Height = 113
    BevelOuter = bvNone
    TabOrder = 11
    Visible = False
    object Label8: TLabel
      Left = 48
      Top = 4
      Width = 58
      Height = 36
      Alignment = taRightJustify
      Caption = 'Novas Imagens'
      WordWrap = True
    end
    object Label9: TLabel
      Left = 116
      Top = 96
      Width = 158
      Height = 14
      Caption = '(ser'#227'o processadas ao salvar)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object NewImagesList: TListBox
      Left = 116
      Top = 0
      Width = 623
      Height = 93
      ItemHeight = 18
      TabOrder = 0
      OnClick = ImagesListClick
    end
  end
  object BtnRemoveImage: TButton
    Left = 73
    Top = 271
    Width = 33
    Height = 31
    Hint = 'Remover imagem'
    Anchors = [akRight, akBottom]
    ImageIndex = 11
    Images = dmMain.ImageList1
    TabOrder = 12
    OnClick = BtnRemoveImageClick
  end
  object DBEdit4: TDBEdit
    Left = 632
    Top = 36
    Width = 110
    Height = 26
    DataField = 'cost'
    DataSource = dmMain.dsItemsCRUD
    TabOrder = 3
  end
  object LoadImage: TOpenPictureDialog
    Filter = 
      'Todos (*.png;*.jpg;*.jpeg)|*.png;*.jpg;*.jpeg|Portable Network G' +
      'raphics (*.png)|*.png|JPEG Image File (*.jpg)|*.jpg|JPEG Image F' +
      'ile (*.jpeg)|*.jpeg'
    Options = [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Selecionar Imagem'
    Left = 12
    Top = 136
  end
end
