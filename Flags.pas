unit Flags;

interface

uses
System.SysUtils, Vcl.CheckLst, Vcl.StdCtrls;

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

//procedure SetFlags(OctStr:String; CB: TCheckListBox);
procedure SetFlags(OctStr:String; CB: TCheckListBox);
function GetTotalOct(CB: TCheckListBox): string;
function IntToOct(Value: Longint; digits: Integer): string;
function OctToInt(Value: string): Longint;
function HexStrToInt(const str: string): Integer;
function StrToHex(S: String): string;

implementation

//Takes an a octal number as a string and decodes it to a checklistbox
{procedure SetFlags(OctStr: String; CB: TCheckListBox);
var
  oct: Integer;
begin
  //convert to an integer
  oct := OctToInt(OctStr);
  //clear the checklistbox
  CB.CheckAll(cbUnchecked, true, false);
  if FLAG1 and oct <> 0 then
    CB.State[0] := cbChecked;
  if FLAG2 and oct <> 0 then
    CB.State[1] := cbChecked;
  if FLAG3 and oct <> 0 then
    CB.State[2] := cbChecked;
  if FLAG4 and oct <> 0 then
    CB.State[3] := cbChecked;
  if FLAG5 and oct <> 0 then
    CB.State[4] := cbChecked;
  if FLAG6 and oct <> 0 then
    CB.State[5] := cbChecked;
  if FLAG7 and oct <> 0 then
    CB.State[6] := cbChecked;
  if FLAG8 and oct <> 0 then
    CB.State[7] := cbChecked;
  if FLAG9 and oct <> 0 then
    CB.State[8] := cbChecked;
  if FLAG10 and oct <> 0 then
    CB.State[9] := cbChecked;
  if FLAG11 and oct <> 0 then
    CB.State[10] := cbChecked;
  if FLAG12 and oct <> 0 then
    CB.State[11] := cbChecked;
  if FLAG13 and oct <> 0 then
    CB.State[12] := cbChecked;
  if FLAG14 and oct <> 0 then
    CB.State[13] := cbChecked;
  if FLAG15 and oct <> 0 then
    CB.State[14] := cbChecked;
  if FLAG16 and oct <> 0 then
    CB.State[15] := cbChecked;
end; }

procedure SetFlags(OctStr: String; CB: TCheckListBox);
var
  I, oct: Integer;
  Flg: Integer;
begin
  Flg := 1;
  // convert to an integer
  oct := OctToInt(OctStr);
  // clear the checklistbox
  CB.CheckAll(cbUnchecked, true, false);
  for I := 0 to CB.Items.Count - 1 do
  begin
    if Flg and oct <> 0 then
      CB.State[I] := cbChecked;
    Flg := Flg * 2;
  end;

end;

function GetTotalOct(CB: TCheckListBox): string;
var
I: Integer;
OctTotal,IntTotal: LongInt;
begin
  OctTotal := 0;
  IntTotal := 1;
  for I := 0 to CB.Items.Count - 1 do
  begin
    if CB.Checked[I] then
    begin
      OctTotal := OctTotal + IntTotal;
    end;
    IntTotal := IntTotal * 2;
  end;
  Result := IntToOct(OctTotal,6);
end;

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

end.
