unit MyClasses.ICRSocket;

interface
uses System.SysUtils,System.Classes, XML.XMLDoc, XML.XMLIntf, FMX.Dialogs, IdBaseComponent,
IdComponent, IdTCPConnection, IdTCPClient, Data.DB;

//==============================================================================
type
 EICRSocketException = class(Exception)
 private
   FErrorCode: integer;
 public
   constructor CreateErrCode(const Msg: string; const ErrCode: integer);
   property ErrorCode: integer read FErrorCode write FErrorCode;
 end;

type
  TICRSocket = class
  private
  FTCPClient: TIdTCPClient;
  FSocketPort: Word;
  FSocketPassword: String;
  FConnectionTimeout:Integer;
  procedure SetTCPClient(const Value:TIdTCPClient);
  procedure SetSocketPort(const Value:Word);
  procedure SetSocketPass(const Value:String);
  procedure SetConnectionTimeout(const Value:Integer);

  public
  constructor Create(TCPClient:TIdTCPClient;SocketPass:String);
  property SocketPort :Word read FSocketPort write SetSocketPort;
  property SocketPass :String read FSocketPassword write SetSocketPass;
  property Timeout :Integer read FConnectionTimeout write SetConnectionTimeout;
  property TCPClient :TIdTCPClient read FTCPClient write SetTCPClient;
  function GetFailedError(ICRResponse:String):Integer;
  procedure SendDeviceInfo(ProtocolVersion:String);
  //function FileSize(fileName : wideString) : Int64;
  function GetVersionInfo: String;
  function GetICRDirList: String;
  function GetSettings: String;
  function GetJournal: String;
  function SendPassword(Password:String):String;
{  function SendFile(FileName:String):String;  }
  function SendCommand(Command :String):String;
  function GetProgramData(FileNo:Integer):String;
  function GetSalesData(FileNo:Integer):String;         overload;
  function GetSalesData(FileNo,Period:Integer):String;  overload;
  function GetProductByPLU(PLUNo:Integer):String;
  function GetProductByGroup(GroupNo:Integer):String;
  function DatasetToICRXML(DataSet: TDataSet;TableName: String): String;
  function XMLToStrings(RawXML: String): TStrings;
  function XMLToStringsA(RawXML: String;FieldLst:TStrings=nil): TStrings;
  //function GetVersionInfo(RawXML: String): TStrings;
  procedure XMLToDataset(DataSet: TDataSet;ICRXML: String;
                         FieldsToImport:TStrings=nil);
  function DatasetToICRXMLA(DataSet: TDataSet;TableNo: Integer;
                         FieldsToExport:TStrings=nil):String;
  function DataFieldToXMLString(DataSet: TDataSet;
                                FieldsToExport:TStrings=nil):String;
end;

{ DONE 1 :  Write Exception Class for FAILEDERROR }

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
implementation
//------------------------------------------------------------------------------


uses Main;constructor EICRSocketException.CreateErrCode(const Msg: string; const ErrCode:
integer);
begin
  inherited Create(Msg);
  ErrorCode := ErrCode;
end;
//------------------------------------------------------------------------------
constructor TICRSocket.Create(TCPClient:TIdTCPClient;SocketPass:String);
begin
  SetTCPClient(TCPClient);
  SetSocketPass(SocketPass);
end;
procedure TICRSocket.SetTCPClient(const Value:TIdTCPClient);
begin
  FTCPClient := Value;
end;
procedure TICRSocket.SetSocketPort;
begin
  FSocketPort := Value;
  FTCPClient.Port := FSocketPort;
end;
procedure TICRSocket.SetSocketPass(const Value:String);
begin
  FSocketPassword := Value;
end;
procedure TICRSocket.SetConnectionTimeout(const Value:Integer);
begin
  FConnectionTimeout := Value;
  FTCPClient.ConnectTimeout := FConnectionTimeout;
end;

//------------------------------------------------------------------------------
{Parses ICRSocket response for error codes also checks if ok}
function TICRSocket.GetFailedError(ICRResponse: String): integer;
var
  i: integer;
  ErrorType: String;
  XMLDoc: IXMLDocument;
  RootNode, AttributeNode: IXMLNode;
begin
  i := -1;
  with XMLDoc do
  begin
    try
      XMLDoc := TXMLDocument.Create(nil);
      XML.Text := ICRResponse;
      Active := True;
      { Get the root node and see if it is failederror }
      RootNode := DocumentElement;
      if RootNode.NodeName = 'FAILEDERROR' then
      begin
        { If the error attributes text = any of the E messages return
          an Integer if no error return -1 }
        if RootNode.AttributeNodes.Count > 0 then // check for attributes
        begin
          AttributeNode := RootNode.AttributeNodes[0];
          ErrorType := AttributeNode.Text;

          if ErrorType = 'ECMD' then
            i := 1001;
          if ErrorType = 'EBUSY' then
            i := 1002;
          if ErrorType = 'EFORMAT' then
            i := 1003;
          if ErrorType = 'EDOESNOTEXIST' then
            i := 1004;
          if ErrorType = 'EINUSE' then
            i := 1005;
          if ErrorType = 'EINVFILE' then
            i := 1006;
          if ErrorType = 'EDATALYTENTRY' then
            i := 1007;
          if ErrorType = 'EBADPARM' then
            i := 1008;
          if ErrorType = 'EFILE' then
            i := 1009;
          if ErrorType = 'EPASSWORD' then
            i := 1010;
        end;
      end
      else if RootNode.NodeName = 'RESPONSE' then
      begin
        ErrorType := RootNode.Text;
        if (ErrorType.ToUpper) = 'OK' then   //everything ok
        i := -2;
      end;

    finally
      Active := False;
      FileName := '';
      XML.Clear;
      XMLDoc := nil;
      Result := i;
    end;
  end;

end;

function TICRSocket.GetICRDirList: String;
var
sCommand: String;
begin
  sCommand := '<GETDIRLIST/>';
  Result := SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
{Todo 1: Look  at this needs  an open socket}
function TICRSocket.GetJournal: String;
var
sCommand: String;
begin
  sCommand := '<GETJOURNAL />';
  Result := SendCommand(sCommand);
end;

//------------------------------------------------------------------------------
function TICRSocket.GetSalesData(FileNo, Period: Integer): String;
var
sCommand: String;
begin
  sCommand := Format('<GETSALESDATA file=''%d'' period=''%d''/>', [FileNo,Period]);
  Result := SendCommand(sCommand);
end;

function TICRSocket.GetSettings: String;
var
sCommand: String;
begin
  sCommand := '<GETSETTINGS />';
  Result := SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
function TICRSocket.SendCommand(Command: String): String;
var
  ErrorMessage, sResponse, sPassResponse: String;
  ErrorCode: integer;
begin
  with TCPClient do
  begin
    try
      // connect
      if not connected then
        Connect;
      // SendPassword
      sPassResponse := SendPassword(SocketPass);
      // Send a command
      Socket.WriteLn(Command);
      // get a response
      //sResponse := Socket.ReadLnWait(100,nil);
       sResponse := Socket.ReadLn(#13, -1, 5000000, nil);
      { about 385kb for 30000 PLUs }

      if sResponse <> '' then { ensure there is a response to check and check for an error }
        ErrorCode := GetFailedError(sResponse)
      else
        ErrorCode := 1099;
      //<RESPONSE>OK</RESPONSE>
      if (ErrorCode = -2) then ShowMessage('Socket response - OK');
      //if not ok
      if (ErrorCode > -1) then
      begin
        case ErrorCode of
          1001:
            ErrorMessage := 'UNKNOWN COMMAND';
          1002:
            ErrorMessage := 'SERVER BUSY';
          1003:
            ErrorMessage := 'REQUEST FORMAT ERROR';
          1004:
            ErrorMessage := 'CHECK OR TABLE DOES NOT EXIST';
          1005:
            ErrorMessage := 'CHECK OR TABLE IN USE';
          1006:
            ErrorMessage := 'REQUSTED FILE INVALID';
          1007:
            ErrorMessage := 'NO ENTRY IN DATALYT.INI';
          1008:
            ErrorMessage := 'BAD PARAMETER';
          1009:
            ErrorMessage := 'FILE ERROR';
          1010:
            ErrorMessage := 'SERVER PASSWORD ERROR';
          1099:
            ErrorMessage := 'NO ANSWER FROM SERVER';
        end;
        raise EICRSocketException.CreateErrCode(ErrorMessage,ErrorCode);
      end;
      // clear buffer stops 'connection closed gracefully' exception from server
      IOHandler.InputBuffer.Clear;
      Disconnect;

      Result := sResponse;

    except
       // on E:Exception do
      on E: EICRSocketException do
      begin
        Result := 'ERROR';
        ShowMessage(Format('%s - Error: %d', [E.Message, E.ErrorCode]));
        IOHandler.InputBuffer.Clear;
        if connected then
          Disconnect;
      end;

    end;
  end;

end;

//------------------------------------------------------------------------------
function TICRSocket.SendPassword(Password:String):String;
var
  sCommand: String;
begin
  if Password <> '' then
  begin
    sCommand := Format('<SETPASSWORD>%s</SETPASSWORD>' + #13, [Password]);
    TCPClient.Socket.WriteLn(sCommand);
    // read the buffer to clear it
    Result := TCPClient.Socket.ReadLn(#13, -1, -1, nil);
  end;
end;
//------------------------------------------------------------------------------
procedure TICRSocket.SendDeviceInfo(ProtocolVersion:String);
var
sCommand: String;
begin
  sCommand := Format('<DEVICEINFO><PROTOCOLVERSION>%s</PROTOCOLVERSION></DEVICEINFO>' + #13,
   [ProtocolVersion]);
  SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
function TICRSocket.GetProgramData(FileNo:Integer):String;
var
sCommand: String;
begin
  sCommand := Format('<GETPROGRAMDATA file=''%d''/>', [FileNo]);
  Result := SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
function TICRSocket.GetSalesData(FileNo:Integer):String;
var
sCommand: String;
begin
  sCommand := Format('<GETSALESDATA file=''%d''/>', [FileNo]);
  Result := SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
function TICRSocket.GetVersionInfo: String;
var
sCommand: String;
begin
  sCommand := '<GETVERSIONINFO/>';
  Result := SendCommand(sCommand);
end;

//------------------------------------------------------------------------------
function TICRSocket.GetProductByPLU(PLUNo:Integer):String;
var
sCommand: String;
begin
  sCommand := Format('<GETPRODUCT Number=''%d''/>', [PLUNo]);
  Result := SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
function TICRSocket.GetProductByGroup(GroupNo:Integer):String;
var
sCommand: String;
begin
  sCommand := Format('<GETPRODUCT Group=''%d''/>', [GroupNo]);
  Result := SendCommand(sCommand);
end;
//------------------------------------------------------------------------------
{ TODO : Need to look at this as requires raw data after the filename  which is the target
filename  }
{function TICRSocket.SendFile(FileName:String):String;
var
  f: file of Byte;
  sCommand: String;
  size: LongInt;
begin
 Assign(f,FileName);
 Reset(F);
 size := FileSize(F);
 sCommand := Format('<SENDFILE filename=''%s'' size=''%d''/>',[FileName,size]);
 Result := SendCommand(sCommand);
end; }
//------------------------------------------------------------------------------
{Function that converts a whole Dataset missing the last field which is changeddata
 to an XML string suitable for  sending to ICR using the SENDPROGRAMDATA command.}
function TICRSocket.DatasetToICRXML(DataSet: TDataSet;TableName: String):String;
var
  I: Integer;
  XMLDoc: IXMLDocument;
  RootNode, DataNode, ValueNode: IXMLNode;
begin
  DataSet.First; { Start from first record in set }
  with XMLDoc do
  begin
    try
      XMLDoc := TXMLDocument.Create(nil); { Create the xml }
      Active := True;
      RootNode := DocumentElement;
      RootNode := AddChild('SENDPROGRAMDATA'); { Set the root node }
      RootNode.Attributes['File'] := TableName; { Set the root attribute }
      while not DataSet.Eof do { Iterate through records }
      begin
        DataNode := RootNode.AddChild('DATA'); { Add the data node }
        for I := 0 to DataSet.FieldCount - 2 do { Iterate the fields missing last 2 fields }
        begin
          if (DataSet.Fields.Fields[I].AsString) <> '' then { Only add if record not empty }
          begin  { Add fieldname then record, fieldnames must equal ICR fieldnames }
            ValueNode := DataNode.AddChild(DataSet.Fields.Fields[I].FieldName);
            ValueNode.Text := DataSet.Fields.Fields[I].AsString;
          end;
        end;
        DataSet.Next;  {Next record}
      end;
    finally
      Result := XML.Text;
      Active := False;
      FileName := '';
      XML.Clear;
    end;
  end;
end;
//------------------------------------------------------------------------------
{Function that converts selected Dataset Fields to an XML string suitable for  sending
to ICR using the SENDPROGRAMDATA command.}
function TICRSocket.DatasetToICRXMLA(DataSet: TDataSet;TableNo: Integer;
                                 FieldsToExport:TStrings=nil):String;
var
  I: Integer;
  XMLDoc: IXMLDocument;
  RootNode, DataNode, ValueNode: IXMLNode;
begin
  DataSet.First; { Start from first record in set }
  with XMLDoc do
  begin
    try
      XMLDoc := TXMLDocument.Create(nil); { Create the xml }
      Active := True;
      RootNode := DocumentElement;
      RootNode := AddChild('SENDPROGRAMDATA'); { Set the root node }
      RootNode.Attributes['File'] := TableNo; { Set the root attribute }
      while not DataSet.Eof do { Iterate through records }
      begin
        DataNode := RootNode.AddChild('DATA'); { Add the data node }
        for I := 0 to FieldsToExport.Count - 1 do { Iterate the fieldlist }
        begin
          if (DataSet.Fields.FieldByName(FieldsToExport[I]).AsString) <> '' then { Only add if record not empty }
          begin  { Add fieldname then record, fieldnames must equal ICR fieldnames }
            ValueNode := DataNode.AddChild(FieldsToExport[I]);
            ValueNode.Text := DataSet.Fields.FieldByName(FieldsToExport[I]).AsString;
          end;
        end;
        DataSet.Next;  {Next record}
      end;
    finally
      Result := XML.Text;
      Active := False;
      FileName := '';
      XML.Clear;
    end;
  end;
end;

{function TICRSocket.FileSize(fileName: wideString): Int64;
var
  sr : TSearchRec;
begin
  if FindFirst(fileName, faAnyFile, sr ) = 0 then
     result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow)
  else
     result := -1;
  FindClose(sr);
end; }

//------------------------------------------------------------------------------
{Procedure that picks XML data based on fields and enters it in a dataset.
Use to overwrite a dataset by emptying it first}
procedure TICRSocket.XMLToDataset(DataSet: TDataSet;ICRXML: String;FieldsToImport:TStrings=nil);
var
  i,j: Integer;
  XMLDoc: IXMLDocument;
  RootNode, DataNode: IXMLNode;
begin
  DataSet.First; { Start from first record in set }
  with XMLDoc do
  begin
    try
      XMLDoc := TXMLDocument.Create(nil); { Create the xml }
      // Active := True;
      LoadFromXML(ICRXML);
      RootNode := DocumentElement;

      if RootNode.HasChildNodes then
        for i := 0 to RootNode.ChildNodes.Count - 1 do {iterate through the records}
        begin
          DataNode := RootNode.ChildNodes[i];
          //MainForm.Memo1.Lines.Add(DataNode.NodeName);
          if DataNode.HasChildNodes then
          begin
          DataSet.Insert;
            for j := 0 to FieldsToImport.Count - 1 do
            begin
            // AddToTable
            DataSet.FieldByName(FieldsToImport[j]).AsString :=
            DataNode.ChildNodes[FieldsToImport[j]].Text;
          //  if (DataNode.ChildNodes[j].NodeType = ntElement) then
          //  MainForm.Memo1.Lines.Add(DataNode.ChildNodes[j].NodeName);
            end;
          Dataset.Post;
          end;
        end;

    finally

      Active := False;
      XML.Clear;
    end;
  end;
end;
//------------------------------------------------------------------------------
function RecursiveFindNode(ANode: IXMLNode; const SearchNodeName: string): String;
var
  I: Integer;
begin
  if CompareText(ANode.NodeName, SearchNodeName) = 0 then
    begin
      if (Assigned(ANode)) and (ANode.IsTextElement) then
       result := ANode.Text;
    end
  else if not Assigned(ANode.ChildNodes) then Result := ''
  else begin
    for I := 0 to ANode.ChildNodes.Count - 1 do
    begin
      Result := RecursiveFindNode(ANode.ChildNodes[I], SearchNodeName);
      if Result  <> '' then Exit;
    end;
  end;
end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
{returns xml as string list. Does not work if xml has many layers }
function TICRSocket.XMLToStrings(RawXML: String): TStrings;
var
  i: Integer;
  XMLDoc: IXMLDocument;
  RootNode, DataNode: IXMLNode;
begin
  Result := TStringList.Create; { SCreate stringlist }
  with XMLDoc do
  begin
    try
      XMLDoc := TXMLDocument.Create(nil); { Create the xml }
      // Active := True;
      LoadFromXML(RawXML);
      RootNode := DocumentElement;
      Result.Add(RootNode.NodeName);
      Result.Add(#13);
      Result.Add(#13);
      if RootNode.HasChildNodes then
        for i := 0 to RootNode.ChildNodes.Count - 1 do {iterate through the records}
        begin
        {  DataNode := RootNode.ChildNodes[i];
          Result.Add((DataNode.NodeName) + ':' +
          RecursiveFindNode(DataNode,DataNode.NodeName)); }

          {Result.Add(DataNode.NodeName);
          if not(DataNode.NodeValue='') then
          Result.Add(DataNode.NodeValue); }

          DataNode := RootNode.ChildNodes[i];
          if Assigned(DataNode) then
          Result.Add((DataNode.NodeName) + ':' +  (DataNode.NodeValue));
        {  if DataNode.HasChildNodes then
          begin
            for j := 0 to DataNode.ChildNodes.Count - 1 do
            begin
            // AddToList
         DataChildNode := DataNode.ChildNodes[j];
          if Assigned(DataChildNode) then
            Result.Add(DataChildNode.NodeName +':' + DataChildNode.NodeValue);

            end;
          end;  }
        end;

    finally

      Active := False;
      XML.Clear;
    end;
  end;
end;
//------------------------------------------------------------------------------
function TICRSocket.XMLToStringsA(RawXML: String; FieldLst: TStrings): TStrings;
var
  i,j: Integer;
  XMLDoc: IXMLDocument;
  RootNode, DataNode: IXMLNode;
begin
  Result := TStringList.Create; { Start from first record in set }
  with XMLDoc do
  begin
    try
      XMLDoc := TXMLDocument.Create(nil); { Create the xml }
      // Active := True;
      LoadFromXML(RawXML);
      RootNode := DocumentElement;

      if RootNode.HasChildNodes then
        for i := 0 to RootNode.ChildNodes.Count - 1 do {iterate through the records}
        begin
          DataNode := RootNode.ChildNodes[i];
          //MainForm.Memo1.Lines.Add(DataNode.NodeName);
          if DataNode.HasChildNodes then
          begin
            for j := 0 to FieldLst.Count - 1 do
            begin
            // AddToTable
            if DataNode.ChildNodes[FieldLst[j]].Text<>'' then

            Result.Add(DataNode.NodeName+':'+DataNode.ChildNodes[FieldLst[j]].Text);
            //Result.Add(DataNode.ChildNodes[FieldLst[j]].Text);
        {    DataSet.FieldByName(FieldLst[j]).AsString :=
            DataNode.ChildNodes[FieldLst[j]].Text; }
          //  if (DataNode.ChildNodes[j].NodeType = ntElement) then
          //  MainForm.Memo1.Lines.Add(DataNode.ChildNodes[j].NodeName);
            end;
        //  Dataset.Post;
          end;
        end;

    finally

      Active := False;
      XML.Clear;
    end;
  end;
end;

//------------------------------------------------------------------------------
{Function that converts Dataset Fields to an XML string which can be saved
if required. Best used with a dataset query}
function TICRSocket.DataFieldToXMLString(DataSet: TDataSet;FieldsToExport:TStrings=nil):String;
Var
  XML : IXMLDOCUMENT;
  RootNode,PLUNode, ValueNode : IXMLNODE;
  I: Integer;
begin
  XML := NewXMLDocument;
  XML.Encoding := 'utf-8';
  XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
  DataSet.First; { Start from first record in set }
  try
 RootNode := XML.AddChild('XML');
  while not DataSet.Eof do { Iterate through records }
      begin
       PLUNode := RootNode.AddChild('PLU'); { TODO 1 :  Make this dataset name }
       for I := 0 to FieldsToExport.Count - 1 do { Iterate the fieldlist }
        begin
          if (DataSet.Fields.FieldByName(FieldsToExport[I]).AsString) <> '' then { Only add if record not empty }
          begin  { Add fieldname then record, fieldnames must equal ICR fieldnames }
            ValueNode := PLUNode.AddChild(FieldsToExport[I]);
            ValueNode.Text := DataSet.Fields.FieldByName(FieldsToExport[I]).AsString;
          end;

        end;
        DataSet.Next;  {Next record}
      end;
  finally
   Result := XML.XML.Text;
   XML.Active := False;
   XML.FileName := '';
   XML.XML.Clear;
  end;

end;
//------------------------------------------------------------------------------
end.
