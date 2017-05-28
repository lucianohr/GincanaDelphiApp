object frmGenerateLicence: TfrmGenerateLicence
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gerador de Licen'#231'a'
  ClientHeight = 198
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 18
  object edtClientId: TLabeledEdit
    Left = 36
    Top = 27
    Width = 321
    Height = 26
    EditLabel.Width = 111
    EditLabel.Height = 18
    EditLabel.Caption = 'C'#243'digo de Cliente'
    TabOrder = 0
  end
  object edtSerialNumber: TLabeledEdit
    Left = 36
    Top = 134
    Width = 321
    Height = 26
    Hint = 'Clique aqui para copiar o n'#250'mero de s'#233'rie'
    EditLabel.Width = 158
    EditLabel.Height = 18
    EditLabel.Caption = 'N'#250'mero de s'#233'rie gerado'
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 2
    OnClick = edtSerialNumberClick
  end
  object btnGenerate: TButton
    Left = 36
    Top = 59
    Width = 321
    Height = 33
    Caption = 'Gerar N'#250'mero de S'#233'rie'
    TabOrder = 1
    OnClick = btnGenerateClick
  end
end
