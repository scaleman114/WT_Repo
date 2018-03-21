object DataMod: TDataMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 365
  Width = 573
  object PLUGROUP: TDBISAMTable
    Tag = 2
    BeforePost = PLUGROUPBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'PLUGROUP'
    Left = 32
    Top = 56
  end
  object DBISAMQuery1: TDBISAMQuery
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    SQL.Strings = (
      'Select * from PLU where ChangedData = true')
    Params = <>
    Left = 504
    Top = 224
  end
  object DataSource1: TDataSource
    DataSet = PLU
    Left = 272
    Top = 16
  end
  object PLU: TDBISAMTable
    Tag = 1
    BeforePost = PLUBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    FieldDefs = <
      item
        Name = 'RECORD'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 24
      end
      item
        Name = 'RANDOMCODE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PRICE1L1'
        DataType = ftFixedChar
        Size = 8
      end
      item
        Name = 'QTY1'
        DataType = ftFixedChar
        Size = 4
      end
      item
        Name = 'DEPT'
        DataType = ftInteger
      end
      item
        Name = 'GROUP'
        DataType = ftInteger
      end
      item
        Name = 'PRICE2L1'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'QTY2'
        DataType = ftFixedChar
        Size = 4
      end
      item
        Name = 'PRICE3L1'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'QTY3'
        DataType = ftFixedChar
        Size = 4
      end
      item
        Name = 'PRICE4L1'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'QTY4'
        DataType = ftFixedChar
        Size = 4
      end
      item
        Name = 'FLAG2'
        DataType = ftLargeint
      end
      item
        Name = 'KPFLAG'
        DataType = ftLargeint
      end
      item
        Name = 'ChangedData'
        DataType = ftBoolean
      end>
    IndexDefs = <
      item
        Name = 'PLUTableDBISA1'
        Fields = 'RecordID'
        Options = [ixPrimary, ixUnique]
      end>
    TableName = 'PLU'
    StoreDefs = True
    Left = 32
    Top = 8
  end
  object DBISAMDatabase1: TDBISAMDatabase
    EngineVersion = '4.40 Build 1'
    DatabaseName = 'DB1'
    Directory = 'C:\Users\Public\Documents\Embarcadero\MyData\ICR'
    SessionName = 'Default'
    Left = 504
    Top = 288
  end
  object DEPT: TDBISAMTable
    Tag = 55
    BeforePost = DEPTBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'DEPARTMENT'
    Left = 32
    Top = 104
  end
  object LEVELS: TDBISAMTable
    Tag = 43
    BeforePost = LEVELSBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'LEVELNAMES'
    Left = 32
    Top = 160
  end
  object KPCAT: TDBISAMTable
    Tag = 47
    BeforePost = KPCATBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'KPCATEGORY'
    Left = 32
    Top = 216
  end
  object KPMESSAGE: TDBISAMTable
    Tag = 48
    BeforePost = KPMESSAGEBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'KPMESSAGE'
    Left = 32
    Top = 272
  end
  object CLERK: TDBISAMTable
    Tag = 5
    BeforePost = CLERKBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    FieldDefs = <
      item
        Name = 'RECORD'
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 24
      end
      item
        Name = 'SECRETNUMBER'
        DataType = ftInteger
      end
      item
        Name = 'COMPULSIONS'
        DataType = ftLargeint
      end
      item
        Name = 'RESTRICTIONS1'
        DataType = ftLargeint
      end
      item
        Name = 'RESTRICTIONS2'
        DataType = ftLargeint
      end
      item
        Name = 'RESTRICTIONS3'
        DataType = ftLargeint
      end
      item
        Name = 'OPERATION'
        DataType = ftLargeint
      end
      item
        Name = 'MODECONTROL'
        DataType = ftLargeint
      end
      item
        Name = 'TYPE'
        DataType = ftInteger
      end
      item
        Name = 'ChangedData'
        DataType = ftBoolean
      end>
    IndexDefs = <
      item
        Name = 'PLUTableDBISA1'
        Fields = 'RecordID'
        Options = [ixPrimary, ixUnique]
      end>
    TableName = 'CLERK'
    StoreDefs = True
    Left = 96
    Top = 8
    object CLERKRECORD: TIntegerField
      FieldName = 'RECORD'
    end
    object CLERKNAME: TStringField
      FieldName = 'NAME'
      Size = 24
    end
    object CLERKSECRETNUMBER: TIntegerField
      FieldName = 'SECRETNUMBER'
    end
    object CLERKTYPE: TIntegerField
      FieldName = 'TYPE'
      OnChange = CLERKTYPEChange
    end
    object CLERKCOMPULSIONS: TLargeintField
      FieldName = 'COMPULSIONS'
    end
    object CLERKRESTRICTIONS1: TLargeintField
      FieldName = 'RESTRICTIONS1'
    end
    object CLERKRESTRICTIONS2: TLargeintField
      FieldName = 'RESTRICTIONS2'
    end
    object CLERKRESTRICTIONS3: TLargeintField
      FieldName = 'RESTRICTIONS3'
    end
    object CLERKOPERATION: TLargeintField
      FieldName = 'OPERATION'
    end
    object CLERKMODECONTROL: TLargeintField
      FieldName = 'MODECONTROL'
    end
    object CLERKChangedData: TBooleanField
      FieldName = 'ChangedData'
    end
  end
  object TEMPLATETable: TDBISAMTable
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    FieldDefs = <
      item
        Name = 'RECORD'
        DataType = ftAutoInc
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 24
      end
      item
        Name = 'COMPULSIONS'
        DataType = ftLargeint
      end
      item
        Name = 'RESTRICTIONS1'
        DataType = ftLargeint
      end
      item
        Name = 'RESTRICTIONS2'
        DataType = ftLargeint
      end
      item
        Name = 'RESTRICTIONS3'
        DataType = ftLargeint
      end
      item
        Name = 'OPERATION'
        DataType = ftLargeint
      end
      item
        Name = 'MODECONTROL'
        DataType = ftLargeint
      end>
    IndexDefs = <
      item
        Name = 'PLUTableDBISA1'
        Fields = 'RecordID'
        Options = [ixPrimary, ixUnique]
      end>
    TableName = 'CLERKTEMPLATE'
    StoreDefs = True
    Left = 400
    Top = 24
    object TEMPLATETableRECORD: TAutoIncField
      FieldName = 'RECORD'
    end
    object TEMPLATETableNAME: TStringField
      FieldName = 'NAME'
      Size = 24
    end
    object TEMPLATETableCOMPULSIONS: TLargeintField
      FieldName = 'COMPULSIONS'
    end
    object TEMPLATETableRESTRICTIONS1: TLargeintField
      FieldName = 'RESTRICTIONS1'
    end
    object TEMPLATETableRESTRICTIONS2: TLargeintField
      FieldName = 'RESTRICTIONS2'
    end
    object TEMPLATETableRESTRICTIONS3: TLargeintField
      FieldName = 'RESTRICTIONS3'
    end
    object TEMPLATETableOPERATION: TLargeintField
      FieldName = 'OPERATION'
    end
    object TEMPLATETableMODECONTROL: TLargeintField
      FieldName = 'MODECONTROL'
    end
  end
  object TemplateDS: TDataSource
    DataSet = TEMPLATETable
    Left = 480
    Top = 24
  end
  object FIXEDCHAR: TDBISAMTable
    Tag = 44
    BeforePost = FIXEDCHARBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'FIXEDCHAR'
    Left = 96
    Top = 56
  end
  object LISTPLU: TDBISAMTable
    Tag = 10
    BeforePost = LISTPLUBeforePost
    DatabaseName = 'DB1'
    EngineVersion = '4.40 Build 1'
    TableName = 'LISTPLU'
    Left = 96
    Top = 104
  end
end
