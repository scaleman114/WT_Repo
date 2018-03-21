unit Template;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.CheckLst, Vcl.DBCtrls, Data.DB, Vcl.Buttons, Vcl.Mask;

type
  TClerkTForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ActiveSource: TDataSource;
    DBNavigator1: TDBNavigator;
    CompulsionsCB: TCheckListBox;
    Panel4: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    CompDBEdit: TDBEdit;
    CloseBtn: TBitBtn;
    CancelBtn: TBitBtn;
    SaveBtn: TBitBtn;
    Label4: TLabel;
    RestDBEdit: TDBEdit;
    RestrictionsCB: TCheckListBox;
    Label5: TLabel;
    Rest2DBEdit: TDBEdit;
    Restrictions2CB: TCheckListBox;
    Label6: TLabel;
    Rest3DBEdit: TDBEdit;
    Restrictions3CB: TCheckListBox;
    Label7: TLabel;
    OpDBEdit: TDBEdit;
    OperationCB: TCheckListBox;
    Label8: TLabel;
    ModeDBEdit: TDBEdit;
    ModeCB: TCheckListBox;
    procedure CompulsionsCBClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ActiveSourceStateChange(Sender: TObject);
    procedure RestrictionsCBClickCheck(Sender: TObject);
    procedure Restrictions2CBClickCheck(Sender: TObject);
    procedure Restrictions3CBClickCheck(Sender: TObject);
    procedure OperationCBClickCheck(Sender: TObject);
    procedure ModeCBClickCheck(Sender: TObject);
    procedure ActiveSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClerkTForm: TClerkTForm;

implementation

{$R *.dfm}

uses Data, Flags;

procedure TClerkTForm.ActiveSourceDataChange(Sender: TObject; Field: TField);
var
comp,rest1,rest2,rest3,op,mode: String;

begin
comp := DataMod.TEMPLATETableCOMPULSIONS.AsString;
SetFlags(comp,CompulsionsCB);
rest1 := DataMod.TEMPLATETableRESTRICTIONS1.AsString;
SetFlags(rest1,RestrictionsCB);
rest2 := DataMod.TEMPLATETableRESTRICTIONS2.AsString;
SetFlags(rest2,Restrictions2CB);
rest3 := DataMod.TEMPLATETableRESTRICTIONS3.AsString;
SetFlags(rest3,Restrictions3CB);
op := DataMod.TEMPLATETableOPERATION.AsString;
SetFlags(op,OperationCB);
mode := DataMod.TEMPLATETableMODECONTROL.AsString;
SetFlags(mode,ModeCB);
end;

procedure TClerkTForm.ActiveSourceStateChange(Sender: TObject);
begin
with ActiveSource do
  begin
    if (State = dsEdit) or (State = dsSetKey) or (State = dsInsert) then
    begin
      SaveBtn.Enabled := true;
      CancelBtn.Enabled := true;
      CloseBtn.Enabled := false;
    end
    else
    begin
      CloseBtn.Enabled := true;
      SaveBtn.Enabled := false;
      CancelBtn.Enabled := false;
    end;
  end;
end;

procedure TClerkTForm.CancelBtnClick(Sender: TObject);
begin
DataMod.TEMPLATETable.Cancel;
end;

procedure TClerkTForm.ModeCBClickCheck(Sender: TObject);
begin
DataMod.TEMPLATETable.Edit;
ModeDBEdit.Text := GetTotalOct(ModeCB);
end;

procedure TClerkTForm.CompulsionsCBClickCheck(Sender: TObject);
begin
DataMod.TEMPLATETable.Edit;
CompDBEdit.Text := GetTotalOct(CompulsionsCB);
end;

procedure TClerkTForm.FormShow(Sender: TObject);
//var
//comp,rest1,rest2,rest3,op,mode: String;

begin
//comp := DataMod.TEMPLATETableCOMPULSIONS.AsString;
//SetFlags(comp,CompulsionsCB);
//rest1 := DataMod.TEMPLATETableRESTRICTIONS1.AsString;
//SetFlags(rest1,RestrictionsCB);
//rest2 := DataMod.TEMPLATETableRESTRICTIONS2.AsString;
//SetFlags(rest2,Restrictions2CB);
//rest3 := DataMod.TEMPLATETableRESTRICTIONS3.AsString;
//SetFlags(rest3,Restrictions3CB);
//op := DataMod.TEMPLATETableOPERATION.AsString;
//SetFlags(op,OperationCB);
//mode := DataMod.TEMPLATETableMODECONTROL.AsString;
//SetFlags(mode,ModeCB);
end;


procedure TClerkTForm.OperationCBClickCheck(Sender: TObject);
begin
DataMod.TEMPLATETable.Edit;
OpDBEdit.Text := GetTotalOct(OperationCB);
end;

procedure TClerkTForm.Restrictions2CBClickCheck(Sender: TObject);
begin
DataMod.TEMPLATETable.Edit;
Rest2DBEdit.Text := GetTotalOct(Restrictions2CB);
end;

procedure TClerkTForm.Restrictions3CBClickCheck(Sender: TObject);
begin
DataMod.TEMPLATETable.Edit;
Rest3DBEdit.Text := GetTotalOct(Restrictions3CB);
end;

procedure TClerkTForm.RestrictionsCBClickCheck(Sender: TObject);
begin
DataMod.TEMPLATETable.Edit;
RestDBEdit.Text := GetTotalOct(RestrictionsCB);
end;

procedure TClerkTForm.SaveBtnClick(Sender: TObject);
begin
DataMod.TEMPLATETable.Post;
end;

end.
