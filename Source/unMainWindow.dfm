object frmMainWindow: TfrmMainWindow
  Left = 0
  Top = 0
  ActiveControl = searchFieldSelect
  Caption = 'Gingana - Cadastro de Objetos'
  ClientHeight = 662
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 18
  object pnlActions: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      984
      53)
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 87
      Height = 18
      Caption = 'Pesquisar por'
    end
    object btnNewItem: TButton
      Left = 896
      Top = 13
      Width = 81
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Novo'
      ImageIndex = 2
      Images = dmMain.ImageList1
      TabOrder = 0
      OnClick = btnNewItemClick
    end
    object searchFieldSelect: TComboBox
      Left = 116
      Top = 16
      Width = 125
      Height = 26
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Palavra-chave'
      Items.Strings = (
        'Palavra-chave'
        'Caixa'
        'Ano')
    end
    object searchText: TEdit
      Left = 252
      Top = 16
      Width = 505
      Height = 26
      TabOrder = 2
      TextHint = 'o que deseja pesquisar'
    end
    object Button1: TButton
      Left = 763
      Top = 13
      Width = 81
      Height = 33
      Caption = 'Buscar'
      Default = True
      ImageIndex = 6
      Images = dmMain.ImageList1
      TabOrder = 3
    end
  end
end
