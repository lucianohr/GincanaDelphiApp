object frmLicence: TfrmLicence
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Registrar aplicativo'
  ClientHeight = 262
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 400
    Height = 262
    ActivePage = tsRegistry
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    ExplicitWidth = 509
    ExplicitHeight = 309
    object tsReadOnly: TTabSheet
      Caption = 'Passo 1'
      ExplicitWidth = 501
      ExplicitHeight = 273
      object Label1: TLabel
        Left = 20
        Top = 24
        Width = 349
        Height = 37
        AutoSize = False
        Caption = 
          'N'#227'o foi encontrada licen'#231'a de execu'#231#227'o do aplicativo neste compu' +
          'tador. O que deseja fazer?'
        WordWrap = True
      end
      object btnReadOnlyMode: TButton
        Left = 20
        Top = 84
        Width = 349
        Height = 33
        Caption = 'Executar em modo somente leitura'
        ModalResult = 5
        TabOrder = 0
      end
      object btnRegistry: TButton
        Left = 20
        Top = 123
        Width = 349
        Height = 33
        Caption = 'Registrar o aplicativo'
        TabOrder = 1
        OnClick = btnRegistryClick
      end
      object btnClose: TButton
        Left = 20
        Top = 162
        Width = 349
        Height = 33
        Cancel = True
        Caption = 'Fechar'
        ModalResult = 2
        TabOrder = 2
      end
    end
    object tsRegistry: TTabSheet
      Caption = 'Passo 2'
      ImageIndex = 1
      OnShow = tsRegistryShow
      ExplicitLeft = 104
      ExplicitTop = 96
      object Label2: TLabel
        Left = 36
        Top = 55
        Width = 321
        Height = 33
        AutoSize = False
        Caption = 
          'Informe este c'#243'digo para receber o n'#250'mero de s'#233'rie e registrar o' +
          ' aplicativo.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtClientId: TLabeledEdit
        Left = 36
        Top = 27
        Width = 321
        Height = 26
        Hint = 'Clique aqui para copiar o c'#243'digo'
        EditLabel.Width = 111
        EditLabel.Height = 18
        EditLabel.Caption = 'C'#243'digo de Cliente'
        ReadOnly = True
        TabOrder = 0
        OnClick = edtClientIdClick
      end
      object edtSerialNumber: TLabeledEdit
        Left = 36
        Top = 134
        Width = 321
        Height = 26
        EditLabel.Width = 249
        EditLabel.Height = 18
        EditLabel.Caption = 'Digite aqui o n'#250'mero de s'#233'rie recebido'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object btnSave: TButton
        Left = 256
        Top = 171
        Width = 101
        Height = 33
        Caption = 'Salvar'
        TabOrder = 2
        OnClick = btnSaveClick
      end
    end
  end
end
