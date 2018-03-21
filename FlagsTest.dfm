object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 337
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 88
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 162
    Top = 88
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Edit1: TEdit
    Left = 72
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '64'
  end
  object Button1: TButton
    Left = 88
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object CheckListBox1: TCheckListBox
    Left = 72
    Top = 176
    Width = 145
    Height = 97
    ItemHeight = 13
    Items.Strings = (
      '0x01'
      '0x02'
      '0x04'
      '0x08'
      '0x10'
      '0x20'
      '0x40'
      '0x80'
      '0x100'
      '0x200'
      '0x400'
      '0x800'
      '0x1000'
      '0x2000'
      '0x4000'
      '0x8000')
    TabOrder = 3
  end
end
