unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, MyClasses.ICRSocket, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, dbisamtb, Vcl.DBCtrls, Vcl.ComCtrls,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, Vcl.Menus, XML.XMLDoc, XML.XMLIntf,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, IdIntercept, IdLogBase, IdLogFile, IdIOHandler;

Const
//Paths
DATABASEPATH =  '\Weigh-Till\CaxtonTP\Data\';
UTILSPATH = '\Weigh-Till\CaxtonTP\Utils\';
DATALYTPATH = '\Weigh-Till\CaxtonTP\DataLyt\';

type
  TMainForm = class(TForm)
    IdTCPClient1: TIdTCPClient;
    DBGrid1: TDBGrid;
    IdAntiFreeze1: TIdAntiFreeze;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Socket1: TMenuItem;
    Settings1: TMenuItem;
    ActiveSource: TDataSource;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    DataLabel: TLabel;
    DBNavigator1: TDBNavigator;
    SendAllChk: TCheckBox;
    ActionManager: TActionManager;
    ClerkTemplate: TAction;
    emplates1: TMenuItem;
    ClerkTemplate1: TMenuItem;
    SendPGMBtn: TButton;
    GoToEdit: TEdit;
    TablesCBX: TComboBox;
    ReceiveDataBtn: TButton;
    Label1: TLabel;
    Receive: TAction;
    Send: TAction;
    Receive1: TMenuItem;
    GetInfo: TAction;
    Utils1: TMenuItem;
    GetInfo1: TMenuItem;
    GetDirList: TAction;
    GetICRDir1: TMenuItem;
    SaveDialog1: TSaveDialog;
    GetSettings: TAction;
    GetJournal1: TMenuItem;
    ReceiveSalesXML: TAction;
    ReceiveSalesXML1: TMenuItem;
    IdLogFile1: TIdLogFile;
    procedure SendPGMFile(DataTable:TDBISAMTable);
    procedure SendWholePGMFile(DataTable:TDBISAMTable);
    procedure ReceivePGMFile(DataTable:TDBISAMTable);
    procedure FormCreate(Sender: TObject);
    procedure PLUTableBeforePost(DataSet: TDataSet);
    procedure IdTCPClient1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
  {  procedure SendFileBtnClick(Sender: TObject); }
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Settings1Click(Sender: TObject);
    procedure SendDeptBtnClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure GoToEditChange(Sender: TObject);
    procedure ClerkTemplateExecute(Sender: TObject);
    procedure SendPGMBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReceiveDataBtnClick(Sender: TObject);
    procedure ReceiveExecute(Sender: TObject);
    procedure GetInfoExecute(Sender: TObject);
    procedure GetDirListExecute(Sender: TObject);
    procedure GetSettingsExecute(Sender: TObject);
    procedure ReceiveSalesXMLExecute(Sender: TObject);
  private
    DataPath: String;
    procedure RecallSettings;

  public
    FileLoading: Boolean;
    SocketPass: String;
    const SettingsFileName = 'Socket.xml';
    procedure SetSocket;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses Data, PLU, Socket, Wait, CLERK, Template, Info, LISTPLU;

procedure TMainForm.RecallSettings;
var
  RootNode: IXMLNode;
  XMLDoc: IXMLDocument;
begin

  if FileExists(DataPath + UTILSPATH + SettingsFileName) then
  begin
    with XMLDoc do
    begin
      try

        XMLDoc := TXMLDocument.Create(nil);
        LoadFromFile(DataPath + UTILSPATH + SettingsFileName);
        Active := True;
        RootNode := DocumentElement;
        SocketForm.PortEdit.Text := RootNode.ChildNodes['Port'].Text;
        SocketForm.HostIPEdit.Text := RootNode.ChildNodes['Host'].Text;
        SocketForm.PasswdEdit.Text := RootNode.ChildNodes['Password'].Text;
        SocketForm.TimeoutEdit.Text := RootNode.ChildNodes['Timeout'].Text;

      finally
        Active := False;
        FileName := '';
        XMLDoc := nil;
      end;
    end;
  end;
end;


procedure TMainForm.SetSocket;
var
  RootNode: IXMLNode;
  XMLDoc: IXMLDocument;
begin
  if FileExists(DataPath + UTILSPATH + SettingsFileName) then
  begin
    with XMLDoc do
    begin
      try

        XMLDoc := TXMLDocument.Create(nil);
        LoadFromFile(DataPath+UTILSPATH+SettingsFileName);
        Active := True;
        RootNode := DocumentElement;
        IdTCPClient1.Port := StrToInt(RootNode.ChildNodes['Port'].Text);
        IdTCPClient1.Host := RootNode.ChildNodes['Host'].Text;
        SocketPass := RootNode.ChildNodes['Password'].Text;
        IdTCPClient1.ConnectTimeout :=
          StrToInt(RootNode.ChildNodes['Timeout'].Text);

      finally
        Active := False;
        FileName := '';
        XMLDoc := nil;
      end;
    end;
  end
  else
  ShowMessage('File not found ' + SettingsFileName);
end;


procedure TMainForm.PLUTableBeforePost(DataSet: TDataSet);
begin
  DataMod.PLU.FieldByName('ChangedData').Value := True;
end;

procedure TMainForm.ClerkTemplateExecute(Sender: TObject);
begin
DataMod.TEMPLATETable.Open;
ClerkTForm.ShowModal;
end;

procedure TMainForm.DBGrid1DblClick(Sender: TObject);
begin
  if ActiveSource.DataSet = DataMod.PLU then
  PLUForm.ShowModal;
  if ActiveSource.DataSet = DataMod.LISTPLU then
  ListPLUForm.ShowModal;
   if ActiveSource.DataSet = DataMod.PLU then
  PLUForm.ShowModal;
end;

procedure TMainForm.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (ActiveSource.DataSet.FieldByName('ChangedData').AsBoolean = True) then
  begin

 // if (DataMod.PLUTable.FieldByName('ChangedData').AsBoolean = True)
      //or (DataMod.PLUGROUPTable.FieldByName('ChangedData').AsBoolean = True)
     // or (DataMod.DEPTTable.FieldByName('ChangedData').AsBoolean = True)
 //     then
    DBGrid1.Canvas.Font.Color := clRed;
  end;
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TMainForm.DBGrid1TitleClick(Column: TColumn);
begin
{(ActiveSource.DataSet as TDBISAMTable).IndexFieldNames := Column.FieldName;
  ActiveSource.DataSet.First;}
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DataPath := GetEnvironmentVariable('ALLUSERSPROFILE');
  SetSocket;
  //set up the log file for debugging
  {$IFDEF DEBUG}
   idTCPClient1.IOHandler := TIdIOHandler.MakeDefaultIOHandler(idTCPClient1);
   idTCPClient1.IOHandler.Intercept := IdLogFile1;
   idTCPClient1.IOHandler.OnStatus  := idTCPClient1.OnStatus;
  {$ENDIF}
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  try
    { Load the list box with the table names to receive, only eligible
      tables with a tag > 0 allowed. }
    for i := 0 to DataMod.ComponentCount - 1 do
    begin
      if (DataMod.Components[i] is TDBISAMTable) and
        (DataMod.Components[i].Tag > 0) then
        TablesCBX.Items.Add(DataMod.Components[i].Name);

    end;
  except
    on E: Exception do
      ShowMessage(E.ClassName + ' error raised, with message : ' + E.Message);
  end;
end;


procedure TMainForm.GetDirListExecute(Sender: TObject);
var
  ICRSock: TICRSocket;
  sResponse: String;
  sFields: TStrings;
begin

    sFields := TStringList.Create;
    ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);

    try
      //sResponse := ICRSock.GetProgramData(1);
      sFields.Add('FOLDER');
      sFields.Add('NAME');
      sFields.Add('FILE');

      sResponse := ICRSock.GetICRDirList;
      if sResponse <> 'ERROR' then { if no response don't continue }
      begin
      InfoForm.Memo1.Clear;
      InfoForm.Memo1.Lines := ICRSock.XMLToStringsA(sResponse,sFields);
      //InfoForm.Memo1.Text := sResponse;
      InfoForm.Show;
      end;
    finally
      ICRSock.Free;
      sFields.Free;
    end;
end;

procedure TMainForm.GetInfoExecute(Sender: TObject);
var
  ICRSock: TICRSocket;
  sResponse: String;
begin

    ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);

    try


      sResponse := ICRSock.GetVersionInfo;
      if sResponse <> 'ERROR' then { if no response don't continue }
      begin
      InfoForm.Memo1.Clear;
      //InfoForm.Memo1.Text := sResponse;
      InfoForm.Memo1.Lines := ICRSock.XMLToStrings(sResponse);
      InfoForm.Show;
      end;
    finally
      ICRSock.Free;

    end;
end;

procedure TMainForm.GetSettingsExecute(Sender: TObject);
var
  ICRSock: TICRSocket;
  sResponse: String;
begin

  ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
{$IFDEF DEBUG}
  IdLogFile1.Active := True;
{$ENDIF}
  try
    sResponse := ICRSock.GetSettings;
    if sResponse <> 'ERROR' then { if no response don't continue }
    begin
      InfoForm.Memo1.Clear;
      // InfoForm.Memo1.Text := sResponse;
      InfoForm.Memo1.Lines := ICRSock.XMLToStrings(sResponse);
      InfoForm.Show;
    end;
  finally
    ICRSock.Free;
{$IFDEF DEBUG}
    IdLogFile1.Active := True;
{$ENDIF}
  end;
end;

procedure TMainForm.GoToEditChange(Sender: TObject);
var
  Value: Integer;
begin
  Value := 0;
  { check it's an integer if not look for description }
  if (TryStrToInt(GotoEdit.Text, Value)) then
  begin

    if  ActiveSource.DataSet <> nil then //check something is loaded
    ActiveSource.DataSet.Locate('RECORD', Value, []); //first field always'RECORD'?

  end
//below ok with those that have name as desc field but not text as desc field
//would need to make statement for each table to get it to work properly
  else if ActiveSource.DataSet.Fields[1].DisplayName = 'NAME' then
  begin
    ActiveSource.DataSet.Locate('NAME', GotoEdit.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;


procedure TMainForm.IdTCPClient1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
  StatusBar1.Panels[0].Text := AStatusText;
  Application.ProcessMessages;
end;

procedure TMainForm.ReceiveDataBtnClick(Sender: TObject);
begin
  if (TablesCBX.ItemIndex) > -1 then
  begin
    ReceivePGMFile(DataMod.FindComponent(TablesCBX.Items[TablesCBX.ItemIndex])
      as TDBISAMTable);
  end
  else
    ShowMessage('Nothing selected');
end;

procedure TMainForm.ReceiveExecute(Sender: TObject);
var
  ICRSock: TICRSocket;
  sResponse, FileNo: String;
  XMLDoc: IXMLDocument;
begin
  FileNo := '2'; // Ensure it has a value
  StatusBar1.Panels[1].Text := 'PLEASE WAIT';
  if InputQuery('Receive File No.', 'File:', FileNo) then
  begin
    // FileNo := InputBox('Receive File No.','File:','2');
    ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
    try

      XMLDoc := TXMLDocument.Create(nil);
      sResponse := ICRSock.GetProgramData(StrToInt(FileNo));
      if sResponse <> 'ERROR' then { if no response don't continue }
      begin
        XMLDoc.LoadFromXML(sResponse);
        if SaveDialog1.Execute then
          XMLDoc.SaveToFile(SaveDialog1.FileName)
        else
          XMLDoc.SaveToFile(DataPath + UTILSPATH + 'File_' + FileNo + '.xml');
      end;
    finally
      ICRSock.Free;
      StatusBar1.Panels[1].Text := 'Completed';
      XMLDoc := nil;
    end;
  end;

end;

{procedure TMainForm.ReceiveFilebtnClick(Sender: TObject);

var
  ICRSock: TICRSocket;
  sResponse, sResponse2: String;
  XMLDoc, XMLDoc2: IXMLDocument;
begin
  Label2.Caption := 'PLEASE WAIT';

  ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
  try

    XMLDoc := TXMLDocument.Create(nil);
    sResponse := ICRSock.GetSalesData(298);
    if sResponse <> 'ERROR' then // if no response don't continue
    XMLDoc.LoadFromXML(sResponse);
    XMLDoc.SaveToFile('IDCHeader.xml');

    XMLDoc2 := TXMLDocument.Create(nil);
    sResponse2 := ICRSock.GetSalesData(299);
    if sResponse2 <> 'ERROR' then // if no response don't continue
    XMLDoc2.LoadFromXML(sResponse2);
    XMLDoc2.SaveToFile('IDCDetail.xml');


  finally
    ICRSock.Free;
    //WaitForm.Close;
   // Cursor := crDefault;
   // DataMod.PLUTable.EnableControls;
    Label2.Caption := 'Completed';
    XMLDoc := nil;
  end;

end;  }

procedure TMainForm.ReceivePGMFile(DataTable: TDBISAMTable);
var
  ICRSock: TICRSocket;
  sResponse: String;
  FieldsImport: TStrings;
begin
  {$IFDEF DEBUG}
  IdLogFile1.Active := True;
  {$ENDIF}
  FileLoading := True;
  ActiveSource.DataSet := DataTable;
  DataLabel.Caption := DataTable.TableName;
  ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
  FieldsImport := TStringList.Create;
  try
    StatusBar1.Panels[1].Text := 'PLEASE WAIT';
    sResponse := ICRSock.GetProgramData(DataTable.Tag);
    if sResponse <> 'ERROR' then { if no response don't continue }
    begin
      FieldsImport.LoadFromFile(DataPath +DATALYTPATH+DataTable.TableName+'fields.txt');
    {  FieldsImport.Add('RECORD');
      FieldsImport.Add('NAME'); }
      DataTable.Close;
      DataTable.EmptyTable;
      DataTable.DisableControls;
      DataTable.Open;
      ICRSock.XMLToDataset(DataTable, sResponse, FieldsImport);
      DataMod.DBISAMQuery1.SQL.Text :=
        'Update '+DataTable.TableName+' set ChangedData = false';
      DataMod.DBISAMQuery1.ExecSQL;
      DataMod.DBISAMQuery1.Close;
    end;
  finally
    begin
      ICRSock.Free;
      FieldsImport.Free;
      DataTable.EnableControls;
      DataTable.First;
      StatusBar1.Panels[1].Text := 'Completed';
      FileLoading := False;
     {$IFDEF DEBUG}
      IdLogFile1.Active := False;
      {$ENDIF}
    end;

  end;
end;

procedure TMainForm.ReceiveSalesXMLExecute(Sender: TObject);
var
  ICRSock: TICRSocket;
  sResponse, FileNo: String;
  XMLDoc: IXMLDocument;
begin
  FileNo := '2'; // Ensure it has a value
  StatusBar1.Panels[1].Text := 'PLEASE WAIT';
  if InputQuery('Receive Sales File No.', 'File:', FileNo) then
  begin
    // FileNo := InputBox('Receive File No.','File:','2');
    ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
    try

      XMLDoc := TXMLDocument.Create(nil);
      sResponse := ICRSock.GetSalesData(StrToInt(FileNo));
      if sResponse <> 'ERROR' then { if no response don't continue }
      begin
        XMLDoc.LoadFromXML(sResponse);
        if SaveDialog1.Execute then
          XMLDoc.SaveToFile(SaveDialog1.FileName)
        else
          XMLDoc.SaveToFile(DataPath + UTILSPATH + 'File_' + FileNo + '.xml');
      end;
    finally
      ICRSock.Free;
      StatusBar1.Panels[1].Text := 'Completed';
      XMLDoc := nil;
    end;
  end;

end;

procedure TMainForm.SendDeptBtnClick(Sender: TObject);
begin

end;


{ Send file to ICRTouch folder  on host see TODO!!! }
{procedure TMainForm.SendFileBtnClick(Sender: TObject);
var
  ICRSock: TICRSocket;
  S, sResponse: String;
begin
  if OpenDialog1.Execute then
  begin

    try
      ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
      sResponse := ICRSock.SendFile(OpenDialog1.FileName);
    finally
      ICRSock.Free;
    end;
  end;

end; }

procedure TMainForm.SendPGMBtnClick(Sender: TObject);
begin
  if not(ActiveSource.DataSet = nil) then
  begin
    if SendAllChk.Checked then
      SendWholePGMFile(ActiveSource.DataSet as TDBISAMTable)
    else
      SendPGMFile(ActiveSource.DataSet as TDBISAMTable);
  end
  else
    ShowMessage('Nothing to send!');
end;

procedure TMainForm.SendPGMFile(DataTable: TDBISAMTable);
var
  ICRSock: TICRSocket;
  S, sResponse: String;
  FieldsExport: TStrings;
begin
  DataMod.DBISAMQuery1.SQL.Text := 'Select * from ' +DataTable.TableName+' where ChangedData = true';
  DataMod.DBISAMQuery1.Open;
  if DataMod.DBISAMQuery1.RecordCount > 0
  then { make sure there is something to send }
  begin
    // ProgressBar1.Max = DBISAMQuery1.RecordCount;
    ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
    FieldsExport := TStringList.Create;
    try
      FieldsExport.LoadFromFile(DataPath + DATALYTPATH+DataTable.TableName+'fields.txt');
   {   FieldsExport.Add('RECORD');
      FieldsExport.Add('NAME');
      FieldsExport.Add('RANDOMCODE');
      FieldsExport.Add('PRICE1L1');   }
      // S := ICRSock.DatasetToXML(PLUTable,PLUTable.TableName);
      // S := ICRSock.DatasetToXML(DBISAMQuery1, PLUTable.TableName);

      S := ICRSock.DatasetToICRXMLA(DataMod.DBISAMQuery1,
        DataTable.Tag, FieldsExport);
      sResponse := ICRSock.SendCommand(S);
      if sResponse <> 'ERROR' then { if no response don't continue }
      begin

        DataMod.DBISAMQuery1.Close;
        DataMod.DBISAMQuery1.SQL.Text := 'Update '+DataTable.TableName+' set ChangedData = false';
        DataMod.DBISAMQuery1.ExecSQL;
      end;
    finally
      ICRSock.Free;
      FieldsExport.Free;
      DataTable.Refresh;
    end;
  end
  else
    ShowMessage('No changes to send!');
  DataMod.DBISAMQuery1.Close;

end;

procedure TMainForm.SendWholePGMFile(DataTable: TDBISAMTable);
var
  ICRSock: TICRSocket;
  S, sResponse: String;
  FieldsExport: TStrings;
begin
  if DataTable.RecordCount > 0
  then { make sure there is something to send }
  begin
    ICRSock := TICRSocket.Create(IdTCPClient1, SocketPass);
    FieldsExport := TStringList.Create;
    try
      FieldsExport.LoadFromFile(DataPath+DATALYTPATH+DataTable.TableName+'fields.txt');

      S := ICRSock.DatasetToICRXMLA(DataTable, DataTable.Tag, FieldsExport);
      sResponse := ICRSock.SendCommand(S);
      if sResponse <> 'ERROR' then { if no response don't continue }
      begin

        DataMod.DBISAMQuery1.Close;
        DataMod.DBISAMQuery1.SQL.Text := 'Update '+DataTable.TableName+' set ChangedData = false';
        DataMod.DBISAMQuery1.ExecSQL;
      end;
    finally
      ICRSock.Free;
      FieldsExport.Free;
      DataTable.Refresh;
    end;
  end
  else
    ShowMessage('Nothing to send');
  DataMod.DBISAMQuery1.Close;

end;

procedure TMainForm.Settings1Click(Sender: TObject);
begin
RecallSettings;
SocketForm.ShowModal;
end;

end.
