object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TouchPoint Program'
  ClientHeight = 526
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 76
    Width = 764
    Height = 371
    Align = alClient
    DataSource = ActiveSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 499
    Width = 764
    Height = 27
    Panels = <
      item
        Width = 150
      end
      item
        Text = 'IDLE'
        Width = 150
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 447
    Width = 764
    Height = 52
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 113
      Top = 15
      Width = 34
      Height = 15
      Caption = 'Go To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SendAllChk: TCheckBox
      Left = 284
      Top = 12
      Width = 97
      Height = 24
      Caption = 'Send Whole File'
      TabOrder = 0
    end
    object SendPGMBtn: TButton
      Left = 9
      Top = 6
      Width = 89
      Height = 35
      Caption = 'Send To ICR'
      TabOrder = 1
      OnClick = SendPGMBtnClick
    end
    object GoToEdit: TEdit
      Left = 158
      Top = 13
      Width = 73
      Height = 21
      TabOrder = 2
      OnChange = GoToEditChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 76
    Align = alTop
    TabOrder = 3
    object DataLabel: TLabel
      Left = 23
      Top = 30
      Width = 35
      Height = 15
      Caption = '[Data]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DBNavigator1: TDBNavigator
      Left = 360
      Top = 21
      Width = 368
      Height = 34
      DataSource = ActiveSource
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
      TabOrder = 0
    end
    object TablesCBX: TComboBox
      Left = 118
      Top = 27
      Width = 145
      Height = 23
      DropDownCount = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ReceiveDataBtn: TButton
      Left = 269
      Top = 26
      Width = 75
      Height = 25
      Caption = 'RECEIVE'
      TabOrder = 2
      OnClick = ReceiveDataBtnClick
    end
  end
  object IdTCPClient1: TIdTCPClient
    OnStatus = IdTCPClient1Status
    ConnectTimeout = 5000
    Host = '127.0.0.1'
    IPVersion = Id_IPv4
    Port = 5559
    ReadTimeout = 5000
    Left = 457
    Top = 88
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 513
    Top = 88
  end
  object MainMenu1: TMainMenu
    Left = 569
    Top = 88
    object File1: TMenuItem
      Caption = 'File'
      object Receive1: TMenuItem
        Action = Receive
      end
      object ReceiveSalesXML1: TMenuItem
        Action = ReceiveSalesXML
      end
    end
    object Socket1: TMenuItem
      Caption = 'Socket'
      object Settings1: TMenuItem
        Caption = 'Settings'
        OnClick = Settings1Click
      end
    end
    object emplates1: TMenuItem
      Caption = 'Templates'
      object ClerkTemplate1: TMenuItem
        Action = ClerkTemplate
      end
    end
    object Utils1: TMenuItem
      Caption = 'Utils'
      object GetInfo1: TMenuItem
        Action = GetInfo
      end
      object GetICRDir1: TMenuItem
        Action = GetDirList
      end
      object GetJournal1: TMenuItem
        Action = GetSettings
      end
    end
  end
  object ActiveSource: TDataSource
    Left = 689
    Top = 88
  end
  object OpenDialog1: TOpenDialog
    Left = 633
    Top = 96
  end
  object ActionManager: TActionManager
    Left = 664
    Top = 168
    StyleName = 'Platform Default'
    object ClerkTemplate: TAction
      Caption = 'Clerk'
      OnExecute = ClerkTemplateExecute
    end
    object Receive: TAction
      Category = 'XMLFile'
      Caption = 'Receive XML'
      OnExecute = ReceiveExecute
    end
    object Send: TAction
      Category = 'XMLFile'
      Caption = 'Send'
    end
    object GetInfo: TAction
      Category = 'Utils'
      Caption = 'Get Info'
      OnExecute = GetInfoExecute
    end
    object GetDirList: TAction
      Category = 'Utils'
      Caption = 'Get ICR Dir'
      OnExecute = GetDirListExecute
    end
    object GetSettings: TAction
      Category = 'Utils'
      Caption = 'Get Settings'
      OnExecute = GetSettingsExecute
    end
    object ReceiveSalesXML: TAction
      Category = 'XMLFile'
      Caption = 'Receive Sales XML'
      OnExecute = ReceiveSalesXMLExecute
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xml'
    Filter = 'XML Files|*.xml'
    Left = 504
    Top = 160
  end
  object IdLogFile1: TIdLogFile
    Filename = 'log.txt'
    Left = 288
    Top = 152
  end
end
