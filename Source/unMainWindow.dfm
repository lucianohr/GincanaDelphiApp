object frmMainWindow: TfrmMainWindow
  Left = 0
  Top = 0
  ActiveControl = searchFieldSelect
  Caption = 'Gingana - Cadastro de Objetos'
  ClientHeight = 661
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnShow = FormShow
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
      Left = 44
      Top = 19
      Width = 87
      Height = 18
      Caption = 'Pesquisar por'
    end
    object btnNewItem: TButton
      Left = 896
      Top = 11
      Width = 81
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Novo'
      ImageIndex = 2
      Images = dmMain.ImageList1
      TabOrder = 5
      OnClick = btnNewItemClick
    end
    object searchFieldSelect: TComboBox
      Left = 144
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
      Left = 275
      Top = 16
      Width = 450
      Height = 26
      TabOrder = 2
      TextHint = 'o que deseja pesquisar'
    end
    object btnSearch: TButton
      Left = 731
      Top = 11
      Width = 81
      Height = 33
      Caption = '&Buscar'
      Default = True
      ImageIndex = 6
      Images = dmMain.ImageList1
      TabOrder = 3
      OnClick = btnSearchClick
    end
    object btnClear: TButton
      Left = 814
      Top = 11
      Width = 81
      Height = 33
      Cancel = True
      Caption = '&Limpar'
      ImageIndex = 1
      Images = dmMain.ImageList1
      TabOrder = 4
      OnClick = btnClearClick
    end
    object btnChangePass: TButton
      Left = 3
      Top = 11
      Width = 33
      Height = 33
      Hint = 'Alterar a senha de acesso'
      ImageIndex = 10
      Images = dmMain.ImageList1
      TabOrder = 0
      TabStop = False
      OnClick = btnChangePassClick
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 56
    Width = 978
    Height = 602
    Hint = 'Duplo clique para editar o objeto'
    Align = alClient
    BorderStyle = bsNone
    DataSource = dmMain.dsItemsList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'box_number'
        Width = 64
        Visible = True
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'year'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'description'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'created_at'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'updated_at'
        Width = 64
        Visible = True
      end>
  end
end
