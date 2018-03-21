unit LISTPLU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons;

const
Item = 'ITEM';
ListItems = 50;
type
  TListPLUForm = class(TForm)
    ActiveSource: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit30: TDBEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit41: TDBEdit;
    DBEdit42: TDBEdit;
    DBEdit43: TDBEdit;
    DBEdit44: TDBEdit;
    DBEdit45: TDBEdit;
    DBEdit46: TDBEdit;
    DBEdit47: TDBEdit;
    DBEdit48: TDBEdit;
    DBEdit49: TDBEdit;
    DBEdit50: TDBEdit;
    DBEdit51: TDBEdit;
    DBEdit52: TDBEdit;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBLookupComboBox8: TDBLookupComboBox;
    DBLookupComboBox9: TDBLookupComboBox;
    DBLookupComboBox10: TDBLookupComboBox;
    DBLookupComboBox11: TDBLookupComboBox;
    DBLookupComboBox12: TDBLookupComboBox;
    DBLookupComboBox13: TDBLookupComboBox;
    DBLookupComboBox14: TDBLookupComboBox;
    DBLookupComboBox15: TDBLookupComboBox;
    DBLookupComboBox16: TDBLookupComboBox;
    DBLookupComboBox17: TDBLookupComboBox;
    DBLookupComboBox18: TDBLookupComboBox;
    DBLookupComboBox19: TDBLookupComboBox;
    DBLookupComboBox20: TDBLookupComboBox;
    DBLookupComboBox21: TDBLookupComboBox;
    DBLookupComboBox22: TDBLookupComboBox;
    DBLookupComboBox23: TDBLookupComboBox;
    DBLookupComboBox24: TDBLookupComboBox;
    DBLookupComboBox25: TDBLookupComboBox;
    DBLookupComboBox26: TDBLookupComboBox;
    DBLookupComboBox27: TDBLookupComboBox;
    DBLookupComboBox28: TDBLookupComboBox;
    DBLookupComboBox29: TDBLookupComboBox;
    DBLookupComboBox30: TDBLookupComboBox;
    DBLookupComboBox31: TDBLookupComboBox;
    DBLookupComboBox32: TDBLookupComboBox;
    DBLookupComboBox33: TDBLookupComboBox;
    DBLookupComboBox34: TDBLookupComboBox;
    DBLookupComboBox35: TDBLookupComboBox;
    DBLookupComboBox36: TDBLookupComboBox;
    DBLookupComboBox37: TDBLookupComboBox;
    DBLookupComboBox38: TDBLookupComboBox;
    DBLookupComboBox39: TDBLookupComboBox;
    DBLookupComboBox40: TDBLookupComboBox;
    DBLookupComboBox41: TDBLookupComboBox;
    DBLookupComboBox42: TDBLookupComboBox;
    DBLookupComboBox43: TDBLookupComboBox;
    DBLookupComboBox44: TDBLookupComboBox;
    DBLookupComboBox45: TDBLookupComboBox;
    DBLookupComboBox46: TDBLookupComboBox;
    DBLookupComboBox47: TDBLookupComboBox;
    DBLookupComboBox48: TDBLookupComboBox;
    DBLookupComboBox49: TDBLookupComboBox;
    DBLookupComboBox50: TDBLookupComboBox;
    SaveBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CloseBtn: TBitBtn;
    RangeBtn: TButton;
    ClearBtn: TButton;
    procedure ActiveSourceStateChange(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure RangeBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure InsertRange(FromPLU,ToPLU:Integer);
    procedure ClearList;
  public
    { Public declarations }
  end;

var
  ListPLUForm: TListPLUForm;

implementation

{$R *.dfm}

uses Data;

procedure TListPLUForm.ActiveSourceStateChange(Sender: TObject);
begin
  with ActiveSource do
  begin
    if (State = dsEdit) or (State = dsSetKey) then
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
procedure TListPLUForm.CancelBtnClick(Sender: TObject);
begin
DataMod.LISTPLU.Cancel;
end;

procedure TListPLUForm.ClearBtnClick(Sender: TObject);
begin
ClearList;
end;

procedure TListPLUForm.ClearList;
var
I: Integer; //Get the difference for count
begin
DataMod.LISTPLU.Edit;
for I := 1 to ListItems do
  begin
  DataMod.LISTPLU.FieldByName(Item + IntToStr(I)).AsInteger := 0;//Alter the field
  end;
end;

procedure TListPLUForm.CloseBtnClick(Sender: TObject);
begin
Close;
end;

{Inserts a range of PLUs}
procedure TListPLUForm.InsertRange(FromPLU, ToPLU: Integer);
var
I,Diff,From: Integer; //Get the difference for count
begin
if FromPLU > ToPLU then
begin
  ShowMessage('From must be less than To!');
  Abort;
end;

From := FromPLU; // Get the start
Diff := ToPLU - FromPLU + 1; //Get the difference for count
if Diff > 50 then
begin
  ShowMessage('Too many, only 50 allowed!');
  Abort;
end;
DataMod.LISTPLU.Edit;
for I := 1 to Diff do
  begin
  DataMod.LISTPLU.FieldByName(Item + IntToStr(I)).AsInteger := From;//Alter the field
  From := From + 1; //Move by one
  end;
end;

procedure TListPLUForm.RangeBtnClick(Sender: TObject);
var
FromPLU, ToPLU: Integer;
begin
FromPLU := StrToInt(InputBox('From PLU No.', 'PLU:', '1'));
ToPLU := StrToInt(InputBox('To PLU No.', 'PLU:', '2'));
InsertRange(FromPLU,ToPLU);
end;

procedure TListPLUForm.SaveBtnClick(Sender: TObject);
begin
DataMod.LISTPLU.Post;
end;

end.
