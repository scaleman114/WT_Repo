object ClerkForm: TClerkForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ClerkForm'
  ClientHeight = 430
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 430
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 407
    ExplicitHeight = 420
    object Label1: TLabel
      Left = 23
      Top = 61
      Width = 42
      Height = 13
      Caption = 'RECORD'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 23
      Top = 101
      Width = 28
      Height = 13
      Caption = 'NAME'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 23
      Top = 141
      Width = 79
      Height = 13
      Caption = 'SECRETNUMBER'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 23
      Top = 203
      Width = 72
      Height = 13
      Caption = 'COMPULSIONS'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 241
      Top = 203
      Width = 80
      Height = 13
      Caption = 'RESTRICTIONS1'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 241
      Top = 244
      Width = 80
      Height = 13
      Caption = 'RESTRICTIONS2'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 241
      Top = 284
      Width = 80
      Height = 13
      Caption = 'RESTRICTIONS3'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 23
      Top = 244
      Width = 59
      Height = 13
      Caption = 'OPERATION'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 23
      Top = 284
      Width = 77
      Height = 13
      Caption = 'MODECONTROL'
      FocusControl = DBEdit9
    end
    object Label10: TLabel
      Left = 143
      Top = 61
      Width = 24
      Height = 13
      Caption = 'TYPE'
      FocusControl = DBEdit1
    end
    object Panel2: TPanel
      Left = 1
      Top = 370
      Width = 415
      Height = 59
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 360
      ExplicitWidth = 405
      object SaveBtn: TBitBtn
        Left = 22
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Change'
        Default = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FF823909
          8239098239096046296C6C6C6D6D6D6666667B7B7B6D6D6D6464645353536046
          297E2801652803652803FF00FF843A09B6510DB7510E6046296969697E28017E
          2801A4A4A4AAAAAA9090906D6D6D6046297E28017D2F03782C04FF00FF90410A
          BB560FBC560F6046296464647E28017E2801B6B6B6C1C1C1A1A1A17979796046
          297E28017D3004782C04FF00FF93440CC05B11C15C116046295E5E5E7E28017E
          2801C6C6C6DADADAB8B8B88686866046297E28017F3204792D04FF00FF97480D
          C56215C66416604629595959595959595959C9C9C9F3F3F3D0D0D09696966046
          297E28018033047B2E05FF00FF9A5016CA6E23CB702692561F60462960462960
          46296046296046296046296046296A3711772E03893A077D2F05FF00FF9E5920
          BB6A2CC4956FC1926DBF8F6ABC8C67BA8862B6835CB5815AB48059B27F59B17E
          58B07D58A3460F7E3005FF00FFA1632DC48653EBEBEBE7E7E7E2E2E2DDDDDDD9
          D9D9D4D4D4D0D0D0CBCBCBCACACACACACACACACAA95D2B7F3205FF00FFA56B38
          C2885ADCDCDCD8D8D8D4D4D4D1D1D1CECECECACACAC7C7C7C4C4C4C0C0C0BDBD
          BDBBBBBBA65B287F3306FF00FFA97343CC966AFEFEFEFBFBFBF7F7F7F2F2F2EE
          EEEEE9E9E9E5E5E5E0E0E0DADADAD7D7D7D1D1D1AB5F2D803306FF00FFAA784C
          C7936BE1E1E1E1E1E1E1E1E1E0E0E0DDDDDDD9D9D9D7D7D7D3D3D3CFCFCFCCCC
          CCC9C9C9AA5E2B803306FF00FFAB7A50CF9D75FEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFCFCFCF8F8F8F4F4F4EFEFEFEBEBEBE6E6E6B16530813406FF00FFAB794D
          C7956CE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1DEDEDEDCDC
          DCD8D8D8AD622D803406FF00FFAB794DBB835AFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFAFAFAAA6030762D04FF00FFAB794D
          BB835A2A16792A16792A16792A16792A16792A16792A16792A16792A16792A16
          792A1679AA6030762D04FF00FF9D66427F412D340D59340D59340D59340D5934
          0D59340D59340D59340D59340D59340D59340D596B26146D2903}
        ModalResult = 1
        TabOrder = 0
        OnClick = SaveBtnClick
      end
      object CancelBtn: TBitBtn
        Left = 142
        Top = 16
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFDAAA62
          DAAA62DAAA62DAAA62DAAA62DAAA62DAAA62DAAA62DAAA62DAAA62DAAA62DAAA
          62DAAA62DAAA62FF00FFD99632FEC23AFEBF34FEBF34FEBF34FEBF34FEBF34FE
          BF34FEBF34FEBF34FEBF34FEBF34FEBF34FEBF34FEC23AD99632CF7F1EEA9C1A
          EA9714EA9714EA9714EA9714EA9714EA9714EA9714EA9714EA9714EA9714EA97
          14EA9714EA9C1ACF7F1EBF6814D17A11D0760DD0760D993706B04F08B04F08B0
          4F08B04F08B04F08B65609CC720DD0760DD0760DD17A11BF6814AC500CB85A0A
          B75707B75707902D04B87447EFE6E0EFE6E0EFE6E0F0E7E0BF7E55A03E06B555
          07B75707B85A0AAC500C9A3A05A14004A03E03A03E038A2803AA5A31D4BCB0D0
          B4A5C9A38CCBA995C7C7C7BB7E5B973303A03E03A140049A3A058B28018F2A01
          8F2A018F2A018F29018A2702B65E2A8925018B2801892501D1B4A5DAD3CF8925
          018F2A018F2A018B2801831F0091330D91330D90320D8B2B09D4B19FEDEDED8A
          28078A2A078A2907EBE3E0E3DCD88A290790310C90310C831F009E4A27A55431
          A45431963B19DCBBABF7F7F7FBFBFBDDBDADCA9881FFFFFFFAFAFABF83699135
          12973D18963C17983F1A9C4623A1502CA3512D963B18E9D4CAFEFEFEFEFEFEF8
          F0EDE2C5B8D5AD9AAA5E3D8F300E9237139134108E2F0C90330F9E4A27A65735
          A75835A5543298401DEDDCD4F8F0EE953917953916933715973E1A99411D973E
          18933914913510923511A55634B16A49B26B4BB26C4BB066459D4725DEBFB09C
          4523AB603FA95C3AA65835A45330A14F2C9F4A279D452298411CAD6544BC7F62
          BF8266BF8367BF8266BA795CA14F2EA35231B87759B67454B46F4FB16B4AAF67
          45AC6241AA5C3AA1502DB77455CB9982CB977FCC9C83CB9A82CB9880C58E74C7
          9279C68F75C48B70C1886CC08368BD8063BA795CB87859AB6240BF8369D8B19F
          D8B4A0D9B4A1D8B2A0D7B09ED7AD9AD4AB97D3A793D0A58FCFA18BCE9E87CB9A
          83CA977FC7937AB67355FF00FFC7957BC7967DC9967DC7957DC7937AC79279C6
          9178C59076C58E74C58C73C48B72C28A6FC1896EC1876CFF00FF}
        ModalResult = 2
        TabOrder = 1
        OnClick = CancelBtnClick
      end
      object CloseBtn: TBitBtn
        Left = 263
        Top = 16
        Width = 75
        Height = 25
        Caption = '&Close'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF818080818080818080818080818080818080FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF81808081808095583E9037148E
          2D098E2D09913815985C41818080818080FF00FFFF00FFFF00FFFF00FFFF00FF
          81808093604A90350FA3400DD38643EEC181EFC689D48A4BA3410F9639139362
          4A818080FF00FFFF00FFFF00FF81808095624B933209C45A0DEF992AF7BB47FB
          CF5DFBD162F8C04DF09D30C2560B97340A95644C818080FF00FFFF00FF818080
          90340FBF520ACB6613933815933815933815933815933815933815CE6812BB48
          06963813818080FF00FF81808095563A9F3505C5580C933815D8C0B5FFFFFFFF
          FFFFFFFFFFFFFFFFD8C0B5933815C552099C2E039A5E43818080818080903814
          C153099E3808933815FFFFFFB6B6B6B6B6B6B6B6B6B6B6B6FFFFFF933815A43D
          09B53901923A168180808180808E2D07C2560B872404933815FFFFFFBDBDBDBD
          BDBDBDBDBDBDBDBDFFFFFF9338158B2804B236018E2C078180808180808E2D08
          E3AD7EB16237933815FFFFFFEEEEEEEEEEEEEEEEEEEEEEEEFFFFFF933815B163
          38DC9A6A8E2C07818080818080923916D79F75B8744E933815FFFFFFFEFEFEFE
          FEFEFEFEFEFEFEFEFFFFFF933815BA7652D39066913815818080818080995D42
          A6522AD5A380933815D8C0B5FFFFFFFFFFFFFFFFFFFFFFFFD8C0B5933815D398
          73A54D25985C41818080FF00FF818080973D18D09876BF805F93381593381593
          3815933815933815933815BC7D5ACC8B63913713818080FF00FFFF00FF818080
          95634C993F19D09C7BDCB59DC99781C6957DC6957DC99882DAAF93CE9069963B
          1695624B818080FF00FFFF00FFFF00FF81808093624A963C17A7542ED9AA8BE6
          C5ABE6C2A6D7A581A6522A913713905E47818080FF00FFFF00FFFF00FFFF00FF
          FF00FF81808081808096573B9138158E2D098E2D098F371393583E8180808180
          80FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF81808081808081
          8080818080818080818080FF00FFFF00FFFF00FFFF00FFFF00FF}
        ModalResult = 8
        TabOrder = 2
        OnClick = CloseBtnClick
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 415
      Height = 41
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 405
      object DBNavigator1: TDBNavigator
        Left = 88
        Top = 8
        Width = 232
        Height = 25
        DataSource = ActiveSource
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
        TabOrder = 0
      end
    end
    object DBEdit1: TDBEdit
      Left = 23
      Top = 77
      Width = 79
      Height = 21
      DataField = 'RECORD'
      DataSource = ActiveSource
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 23
      Top = 117
      Width = 186
      Height = 21
      DataField = 'NAME'
      DataSource = ActiveSource
      TabOrder = 3
    end
    object DBEdit3: TDBEdit
      Left = 23
      Top = 157
      Width = 79
      Height = 21
      DataField = 'SECRETNUMBER'
      DataSource = ActiveSource
      TabOrder = 4
    end
    object DBEdit4: TDBEdit
      Left = 23
      Top = 218
      Width = 80
      Height = 21
      DataField = 'COMPULSIONS'
      DataSource = ActiveSource
      TabOrder = 5
    end
    object TypeCB: TDBLookupComboBox
      Left = 143
      Top = 77
      Width = 185
      Height = 21
      DataField = 'TYPE'
      DataSource = ActiveSource
      KeyField = 'RECORD'
      ListField = 'NAME'
      ListSource = DataMod.TemplateDS
      TabOrder = 6
    end
    object DBEdit5: TDBEdit
      Left = 241
      Top = 218
      Width = 80
      Height = 21
      DataField = 'RESTRICTIONS1'
      DataSource = ActiveSource
      TabOrder = 7
    end
    object DBEdit6: TDBEdit
      Left = 241
      Top = 260
      Width = 80
      Height = 21
      DataField = 'RESTRICTIONS2'
      DataSource = ActiveSource
      TabOrder = 8
    end
    object DBEdit7: TDBEdit
      Left = 241
      Top = 300
      Width = 80
      Height = 21
      DataField = 'RESTRICTIONS3'
      DataSource = ActiveSource
      TabOrder = 9
    end
    object DBEdit8: TDBEdit
      Left = 23
      Top = 260
      Width = 80
      Height = 21
      DataField = 'OPERATION'
      DataSource = ActiveSource
      TabOrder = 10
    end
    object DBEdit9: TDBEdit
      Left = 23
      Top = 300
      Width = 80
      Height = 21
      DataField = 'MODECONTROL'
      DataSource = ActiveSource
      TabOrder = 11
    end
  end
  object ActiveSource: TDataSource
    DataSet = DataMod.CLERK
    OnStateChange = ActiveSourceStateChange
    Left = 360
    Top = 72
  end
end
