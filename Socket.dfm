object SocketForm: TSocketForm
  Left = 0
  Top = 0
  Caption = 'SocketForm'
  ClientHeight = 252
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PasswdEdit: TLabeledEdit
    Left = 40
    Top = 40
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    PasswordChar = '.'
    TabOrder = 0
  end
  object HostIPEdit: TLabeledEdit
    Left = 40
    Top = 83
    Width = 121
    Height = 21
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Host IP'
    TabOrder = 1
  end
  object TimeoutEdit: TLabeledEdit
    Left = 40
    Top = 128
    Width = 121
    Height = 21
    EditLabel.Width = 38
    EditLabel.Height = 13
    EditLabel.Caption = 'Timeout'
    TabOrder = 2
  end
  object PortEdit: TLabeledEdit
    Left = 40
    Top = 176
    Width = 121
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Socket Port'
    TabOrder = 3
  end
  object SocketSaveBtn: TBitBtn
    Left = 24
    Top = 214
    Width = 81
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = SocketSaveBtnClick
  end
  object CancelBtn: TBitBtn
    Left = 152
    Top = 214
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
end
