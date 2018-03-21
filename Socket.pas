unit Socket;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  XML.XMLDoc, XML.XMLIntf, Vcl.Buttons;

type
  TSocketForm = class(TForm)
    PasswdEdit: TLabeledEdit;
    HostIPEdit: TLabeledEdit;
    TimeoutEdit: TLabeledEdit;
    PortEdit: TLabeledEdit;
    SocketSaveBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure SocketSaveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SocketForm: TSocketForm;

implementation

{$R *.dfm}

uses Main;

procedure TSocketForm.SocketSaveBtnClick(Sender: TObject);

var
  RootNode, ValueNode: Xml.XMLIntf.IXMLNode;
  XMLDoc: IXMLDocument;
  DataPath: String;
  begin
  with XMLdoc do
begin
    DataPath := GetEnvironmentVariable('ALLUSERSPROFILE');
  try
    XMLDoc := TXMLDocument.Create(nil);
    Active := True;
    RootNode := DocumentElement;
    RootNode := AddChild('Settings');
    ValueNode := RootNode.AddChild('Port');
    ValueNode.Text := PortEdit.Text;
    ValueNode := RootNode.AddChild('Host');
    ValueNode.Text := HostIPEdit.Text;
    ValueNode := RootNode.AddChild('Password');
    ValueNode.Text := PasswdEdit.Text;
    ValueNode := RootNode.AddChild('Timeout');
    ValueNode.Text := TimeoutEdit.Text;

    SaveToFile(DataPath + UTILSPATH + MainForm.SettingsFileName);
    MainForm.SetSocket;
  finally
    Active := False;
    XMLDoc := nil;
  end;
  end;

end;

end.
