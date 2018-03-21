unit FlagsTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst;

  const

  FLAG1 = 1;
  FLAG2 = 2;
  FLAG3 = 4;
  FLAG4 = 8;
  FLAG5 = 16;
  FLAG6 = 32;
  FLAG7 = 64;
  FLAG8 = 128;
  FLAG9 = 256;
  FLAG10 = 512;
  FLAG11 = 1024;
  FLAG12 = 2048;
  FLAG13 = 4096;
  FLAG14 = 8192;
  FLAG15 = 16384;
  FLAG16 = 32768;


 { const

  FLAG1 = $1;
  FLAG2 = $2;
  FLAG3 = $4;
  FLAG4 = $8;
  FLAG5 = $10;
  FLAG6 = $20;
  FLAG7 = $40;
  FLAG8 = $80;
  FLAG9 = $100;  }



type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    CheckListBox1: TCheckListBox;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
function IntToOct(Value: Longint; digits: Integer): string;
var
  rest: Longint;
  oct: string;
  i: Integer;
begin
  oct := '';
  while Value <> 0 do
  begin
    rest  := Value mod 8;
    Value := Value div 8;
    oct := IntToStr(rest) + oct;
  end;
  for i := Length(oct) + 1 to digits do
    oct := '0' + oct;
  Result := oct;
end;

function OctToInt(Value: string): Longint;
var
  i: Integer;
  int: Integer;
begin
  int := 0;
  for i := 1 to Length(Value) do
  begin
    int := int * 8 + StrToInt(Copy(Value, i, 1));
  end;
  Result := int;
end;

function HexStrToInt(const str: string): Integer;
begin
  Result := StrToInt('$' + str);
end;

function StrToHex(S: String): string;
var I: Integer;
begin
  Result:= '';
  for I := 1 to length (S) do
    Result:= Result+IntToHex(ord(S[i]),2);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
   Label1.Caption := IntToStr(OctToInt(Edit1.Text));
{if FLAG1 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[0] := cbChecked;
if FLAG2 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[1] := cbChecked;
if FLAG3 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[2] := cbChecked;
if FLAG4 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[3] := cbChecked;
if FLAG5 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[4] := cbChecked;
if FLAG6 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[5] := cbChecked;
if FLAG7 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[6] := cbChecked;
if FLAG8 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[7] := cbChecked;
if FLAG9 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[8] := cbChecked;}

end;


procedure TForm3.Button2Click(Sender: TObject);
var
int: Integer;
oct: Integer;
begin
oct := OctToInt(Edit1.Text);

{if FLAG1 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[0] := cbChecked;
if FLAG2 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[1] := cbChecked;
if FLAG3 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[2] := cbChecked;
if FLAG4 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[3] := cbChecked;
if FLAG5 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[4] := cbChecked;
if FLAG6 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[5] := cbChecked;
if FLAG7 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[6] := cbChecked;
if FLAG8 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[7] := cbChecked;
if FLAG9 and HexStrToInt(Edit1.Text) <> 0 then
CheckListBox1.State[8] := cbChecked;}

if FLAG1 and oct <> 0 then
CheckListBox1.State[0] := cbChecked;
if FLAG2 and oct <> 0 then
CheckListBox1.State[1] := cbChecked;
if FLAG3 and oct <> 0 then
CheckListBox1.State[2] := cbChecked;
if FLAG4 and oct <> 0 then
CheckListBox1.State[3] := cbChecked;
if FLAG5 and oct <> 0 then
CheckListBox1.State[4] := cbChecked;
if FLAG6 and oct <> 0 then
CheckListBox1.State[5] := cbChecked;
if FLAG7 and oct <> 0 then
CheckListBox1.State[6] := cbChecked;
if FLAG8 and oct <> 0 then
CheckListBox1.State[7] := cbChecked;
if FLAG9 and oct <> 0 then
CheckListBox1.State[8] := cbChecked;
if FLAG10 and oct <> 0 then
CheckListBox1.State[9] := cbChecked;
if FLAG11 and oct <> 0 then
CheckListBox1.State[10] := cbChecked;
if FLAG12 and oct <> 0 then
CheckListBox1.State[11] := cbChecked;
if FLAG13 and oct <> 0 then
CheckListBox1.State[12] := cbChecked;
if FLAG14 and oct <> 0 then
CheckListBox1.State[13] := cbChecked;
if FLAG15 and oct <> 0 then
CheckListBox1.State[14] := cbChecked;
if FLAG16 and oct <> 0 then
CheckListBox1.State[15] := cbChecked;

    //Label1.Caption := IntToStr(OctToInt(Edit1.Text));
    int := HexStrToInt(Edit1.Text);
    Label2.Caption := Format('HexToInt:%d',[int]);
end;

end.
