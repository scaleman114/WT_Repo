unit PLU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, Vcl.Mask, Vcl.Buttons, Vcl.CheckLst, Vcl.ExtCtrls;

type
  TPLUForm = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    PLUSource: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    SaveBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CloseBtn: TBitBtn;
    Flag2CB: TCheckListBox;
    Flag2DBEdit: TDBEdit;
    Label5: TLabel;
    DBNavigator1: TDBNavigator;
    KPFlagCB: TCheckListBox;
    KPFlagDBEdit: TDBEdit;
    Label6: TLabel;
    procedure PLUSourceStateChange(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure PLUSourceDataChange(Sender: TObject; Field: TField);
    procedure Flag2CBClickCheck(Sender: TObject);
    procedure KPFlagCBClickCheck(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PLUForm: TPLUForm;

implementation

{$R *.dfm}

uses Data, Flags;

procedure TPLUForm.CancelBtnClick(Sender: TObject);
begin
DataMod.PLU.Cancel
end;

procedure TPLUForm.Flag2CBClickCheck(Sender: TObject);
begin
DataMod.PLU.Edit;
Flag2DBEdit.Text := GetTotalOct(Flag2CB);
end;

procedure TPLUForm.KPFlagCBClickCheck(Sender: TObject);
begin
DataMod.PLU.Edit;
KPFlagDBEdit.Text := GetTotalOct(KPFlagCB);
end;

procedure TPLUForm.PLUSourceDataChange(Sender: TObject; Field: TField);
var
flag2,kpflag: String;

begin
flag2 := DataMod.PLU.FieldByName('FLAG2').AsString;
SetFlags(flag2,Flag2CB);
kpflag := DataMod.PLU.FieldByName('KPFLAG').AsString;
SetFlags(kpflag,KPFlagCB);
end;

procedure TPLUForm.PLUSourceStateChange(Sender: TObject);
begin
  with PLUSource do
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

procedure TPLUForm.SaveBtnClick(Sender: TObject);
begin
DataMod.PLU.Post;
end;

end.
