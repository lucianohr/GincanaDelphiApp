inherited frmNewPassword: TfrmNewPassword
  Caption = 'Nova Senha'
  ClientHeight = 188
  ClientWidth = 297
  ExplicitWidth = 303
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 18
  inherited Label1: TLabel
    Width = 223
    Caption = 'Informe a nova senha de acesso:'
    ExplicitWidth = 223
  end
  object Label2: TLabel [3]
    Left = 62
    Top = 80
    Width = 210
    Height = 18
    Caption = 'Repita a nova senha de acesso:'
  end
  object lblError2: TLabel [4]
    Left = 62
    Top = 130
    Width = 108
    Height = 13
    Caption = 'Senhas n'#227'o conferem!'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  inherited edtPassword: TEdit
    Width = 223
    ExplicitWidth = 223
  end
  inherited OKBtn: TButton
    Left = 97
    Top = 149
    TabOrder = 2
    ExplicitLeft = 97
    ExplicitTop = 149
  end
  inherited CancelBtn: TButton
    Left = 194
    Top = 149
    TabOrder = 3
    ExplicitLeft = 194
    ExplicitTop = 149
  end
  object edtConfirmPassword: TEdit
    Left = 62
    Top = 104
    Width = 223
    Height = 26
    PasswordChar = '*'
    TabOrder = 1
  end
end
