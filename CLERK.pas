unit CLERK;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.CheckLst;




type
  TClerkForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    ActiveSource: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    SaveBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CloseBtn: TBitBtn;
    TypeCB: TDBLookupComboBox;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label10: TLabel;
    procedure CancelBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure ActiveSourceStateChange(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClerkForm: TClerkForm;

implementation

{$R *.dfm}

uses Data, Main, Flags;

procedure TClerkForm.ActiveSourceStateChange(Sender: TObject);
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

procedure TClerkForm.CancelBtnClick(Sender: TObject);
begin
DataMod.CLERK.Cancel;
end;

procedure TClerkForm.CloseBtnClick(Sender: TObject);
begin
Close;
end;

procedure TClerkForm.SaveBtnClick(Sender: TObject);
begin
DataMod.CLERK.Post;
end;

end.
