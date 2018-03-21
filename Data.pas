<<<<<<< HEAD
unit Data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, dbisamtb, Vcl.Dialogs;


type
  TDataMod = class(TDataModule)
    PLUGROUP: TDBISAMTable;
    DBISAMQuery1: TDBISAMQuery;
    DataSource1: TDataSource;
    PLU: TDBISAMTable;
    DBISAMDatabase1: TDBISAMDatabase;
    DEPT: TDBISAMTable;
    LEVELS: TDBISAMTable;
    KPCAT: TDBISAMTable;
    KPMESSAGE: TDBISAMTable;
    CLERK: TDBISAMTable;
    CLERKRECORD: TIntegerField;
    CLERKNAME: TStringField;
    CLERKSECRETNUMBER: TIntegerField;
    CLERKCOMPULSIONS: TLargeintField;
    CLERKChangedData: TBooleanField;
    TEMPLATETable: TDBISAMTable;
    TEMPLATETableRECORD: TAutoIncField;
    TEMPLATETableNAME: TStringField;
    TEMPLATETableCOMPULSIONS: TLargeintField;
    CLERKTYPE: TIntegerField;
    TemplateDS: TDataSource;
    TEMPLATETableRESTRICTIONS1: TLargeintField;
    CLERKRESTRICTIONS1: TLargeintField;
    TEMPLATETableRESTRICTIONS2: TLargeintField;
    CLERKRESTRICTIONS2: TLargeintField;
    CLERKRESTRICTIONS3: TLargeintField;
    CLERKOPERATION: TLargeintField;
    CLERKMODECONTROL: TLargeintField;
    TEMPLATETableRESTRICTIONS3: TLargeintField;
    TEMPLATETableOPERATION: TLargeintField;
    TEMPLATETableMODECONTROL: TLargeintField;
    FIXEDCHAR: TDBISAMTable;
    LISTPLU: TDBISAMTable;
    procedure OpenTables;
    procedure PLUBeforePost(DataSet: TDataSet);
    procedure DEPTBeforePost(DataSet: TDataSet);
    procedure PLUGROUPBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure LEVELSBeforePost(DataSet: TDataSet);
    procedure KPCATBeforePost(DataSet: TDataSet);
    procedure KPMESSAGEBeforePost(DataSet: TDataSet);
    procedure CLERKBeforePost(DataSet: TDataSet);
    procedure CLERKTYPEChange(Sender: TField);
    procedure FIXEDCHARBeforePost(DataSet: TDataSet);
    procedure LISTPLUBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    DataPath: String;
  public
    { Public declarations }
  end;

var
  DataMod: TDataMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Main;

{$R *.dfm}
procedure TDataMod.OpenTables;
var
i: Integer;
begin
  try
      { open the tables }
      for i := 0 to DataMod.ComponentCount - 1 do
      begin
        if DataMod.Components[i] is TDBISAMTable then
          (DataMod.Components[i] as TDBISAMTable).Open;
      end;
    except
      on E: Exception do
        ShowMessage(E.ClassName + ' error raised, with message : ' + E.Message);
    end;
end;


procedure TDataMod.CLERKBeforePost(DataSet: TDataSet);
begin
CLERK.FieldByName('ChangedData').Value := True;

end;

procedure TDataMod.CLERKTYPEChange(Sender: TField);
begin
  if not MainForm.FileLoading then
  begin
    TEMPLATETable.Locate('RECORD', CLERKTYPE.Value, []);
    CLERKCOMPULSIONS.Value := TEMPLATETableCOMPULSIONS.Value;
    CLERKRESTRICTIONS1.Value := TEMPLATETableRESTRICTIONS1.Value;
    CLERKRESTRICTIONS2.Value := TEMPLATETableRESTRICTIONS2.Value;
    CLERKRESTRICTIONS3.Value := TEMPLATETableRESTRICTIONS3.Value;
    CLERKOPERATION.Value := TEMPLATETableOPERATION.Value;
    CLERKMODECONTROL.Value := TEMPLATETableMODECONTROL.Value;
  end;
end;

procedure TDataMod.DataModuleCreate(Sender: TObject);
begin
DataPath := GetEnvironmentVariable('ALLUSERSPROFILE');
{$IFNDEF DEBUG}
DBISAMDatabase1.Directory := DataPath + DATABASEPATH;
{$ELSE}
DBISAMDatabase1.Directory := 'C:\Users\Public\Documents\Embarcadero\MyData\ICR';
{$ENDIF}
DBISAMDatabase1.Connected := True;
OpenTables;

end;

procedure TDataMod.DEPTBeforePost(DataSet: TDataSet);
begin
DEPT.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.FIXEDCHARBeforePost(DataSet: TDataSet);
begin
FIXEDCHAR.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.KPCATBeforePost(DataSet: TDataSet);
begin
KPCAT.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.KPMESSAGEBeforePost(DataSet: TDataSet);
begin
KPMESSAGE.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.LEVELSBeforePost(DataSet: TDataSet);
begin
LEVELS.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.LISTPLUBeforePost(DataSet: TDataSet);
begin
DataSet.FieldByName('ChangedData').Value := True;
//LISTPLU.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.PLUGROUPBeforePost(DataSet: TDataSet);
begin
PLUGroup.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.PLUBeforePost(DataSet: TDataSet);
begin
PLU.FieldByName('ChangedData').Value := True;
end;

end.
=======
unit Data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, dbisamtb, Vcl.Dialogs;


type
  TDataMod = class(TDataModule)
    PLUGROUP: TDBISAMTable;
    DBISAMQuery1: TDBISAMQuery;
    DataSource1: TDataSource;
    PLU: TDBISAMTable;
    DBISAMDatabase1: TDBISAMDatabase;
    DEPT: TDBISAMTable;
    LEVELS: TDBISAMTable;
    KPCAT: TDBISAMTable;
    KPMESSAGE: TDBISAMTable;
    CLERK: TDBISAMTable;
    CLERKRECORD: TIntegerField;
    CLERKNAME: TStringField;
    CLERKSECRETNUMBER: TIntegerField;
    CLERKCOMPULSIONS: TLargeintField;
    CLERKChangedData: TBooleanField;
    TEMPLATETable: TDBISAMTable;
    TEMPLATETableRECORD: TAutoIncField;
    TEMPLATETableNAME: TStringField;
    TEMPLATETableCOMPULSIONS: TLargeintField;
    CLERKTYPE: TIntegerField;
    TemplateDS: TDataSource;
    TEMPLATETableRESTRICTIONS1: TLargeintField;
    CLERKRESTRICTIONS1: TLargeintField;
    TEMPLATETableRESTRICTIONS2: TLargeintField;
    CLERKRESTRICTIONS2: TLargeintField;
    CLERKRESTRICTIONS3: TLargeintField;
    CLERKOPERATION: TLargeintField;
    CLERKMODECONTROL: TLargeintField;
    TEMPLATETableRESTRICTIONS3: TLargeintField;
    TEMPLATETableOPERATION: TLargeintField;
    TEMPLATETableMODECONTROL: TLargeintField;
    FIXEDCHAR: TDBISAMTable;
    LISTPLU: TDBISAMTable;
    procedure OpenTables;
    procedure PLUBeforePost(DataSet: TDataSet);
    procedure DEPTBeforePost(DataSet: TDataSet);
    procedure PLUGROUPBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure LEVELSBeforePost(DataSet: TDataSet);
    procedure KPCATBeforePost(DataSet: TDataSet);
    procedure KPMESSAGEBeforePost(DataSet: TDataSet);
    procedure CLERKBeforePost(DataSet: TDataSet);
    procedure CLERKTYPEChange(Sender: TField);
    procedure FIXEDCHARBeforePost(DataSet: TDataSet);
    procedure LISTPLUBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    DataPath: String;
  public
    { Public declarations }
  end;

var
  DataMod: TDataMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Main;

{$R *.dfm}
procedure TDataMod.OpenTables;
var
i: Integer;
begin
  try
      { open the tables }
      for i := 0 to DataMod.ComponentCount - 1 do
      begin
        if DataMod.Components[i] is TDBISAMTable then
          (DataMod.Components[i] as TDBISAMTable).Open;
      end;
    except
      on E: Exception do
        ShowMessage(E.ClassName + ' error raised, with message : ' + E.Message);
    end;
end;


procedure TDataMod.CLERKBeforePost(DataSet: TDataSet);
begin
CLERK.FieldByName('ChangedData').Value := True;

end;

procedure TDataMod.CLERKTYPEChange(Sender: TField);
begin
  if not MainForm.FileLoading then
  begin
    TEMPLATETable.Locate('RECORD', CLERKTYPE.Value, []);
    CLERKCOMPULSIONS.Value := TEMPLATETableCOMPULSIONS.Value;
    CLERKRESTRICTIONS1.Value := TEMPLATETableRESTRICTIONS1.Value;
    CLERKRESTRICTIONS2.Value := TEMPLATETableRESTRICTIONS2.Value;
    CLERKRESTRICTIONS3.Value := TEMPLATETableRESTRICTIONS3.Value;
    CLERKOPERATION.Value := TEMPLATETableOPERATION.Value;
    CLERKMODECONTROL.Value := TEMPLATETableMODECONTROL.Value;
  end;
end;

procedure TDataMod.DataModuleCreate(Sender: TObject);
begin
DataPath := GetEnvironmentVariable('ALLUSERSPROFILE');
{$IFNDEF DEBUG}
DBISAMDatabase1.Directory := DataPath + DATABASEPATH;
{$ELSE}
DBISAMDatabase1.Directory := 'C:\Users\Public\Documents\Embarcadero\MyData\ICR';
{$ENDIF}
DBISAMDatabase1.Connected := True;
OpenTables;

end;

procedure TDataMod.DEPTBeforePost(DataSet: TDataSet);
begin
DEPT.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.FIXEDCHARBeforePost(DataSet: TDataSet);
begin
FIXEDCHAR.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.KPCATBeforePost(DataSet: TDataSet);
begin
KPCAT.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.KPMESSAGEBeforePost(DataSet: TDataSet);
begin
KPMESSAGE.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.LEVELSBeforePost(DataSet: TDataSet);
begin
LEVELS.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.LISTPLUBeforePost(DataSet: TDataSet);
begin
DataSet.FieldByName('ChangedData').Value := True;
//LISTPLU.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.PLUGROUPBeforePost(DataSet: TDataSet);
begin
PLUGroup.FieldByName('ChangedData').Value := True;
end;

procedure TDataMod.PLUBeforePost(DataSet: TDataSet);
begin
PLU.FieldByName('ChangedData').Value := True;
end;

end.
>>>>>>> 4148bbb85db1c17d396f71a759fd5423c9215d05
