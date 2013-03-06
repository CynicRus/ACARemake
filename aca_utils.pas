unit aca_utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics,aca_types,colour_conv;

function RoundTo(x: Extended; n: Integer): Extended;
function InvertColour(Colour: Integer; ForeGround: Boolean): Integer;
function ColourRec(AColour: Integer): TColourRec;
function CheckType(RGBRange,HSLRange,XYZRange,SpiralSearch: boolean):TCheckType;
function ColourToString(Colour: TColourRec;ColFormat: integer): string;
function Eq(aValue1, aValue2: string): boolean;
function GenSpaces(cnt: integer): string;

implementation
uses math;
function RoundTo(x: Extended; n: Integer): Extended;
var
  p: Extended;
begin
  p := Power(10, n);
  Result := Ceil(x * p) / p;
end;

function InvertColour(Colour: Integer; ForeGround: Boolean): Integer;
var
  h, s, l: Extended;
  r, g, b: Integer;
begin
  ColorToHSL(Colour, h, s, l);
  ColorToRGB(Colour, r, g, b);

  //http://www.nbdtech.com/Blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx
  b := Round(Sqrt(r*r*0.241 + g*g*0.691 + b*b*0.068));
  s := Abs(l - 50);
  if ((s <= 35) and (b >= 130)) or ((s > 35) and (l > 65))then
    Result := clBlack
  else
    Result := clYellow;

  if (not ForeGround) then
    Result := clYellow - Result;
end;

function ColourRec(AColour: Integer): TColourRec;
begin
  with Result do
  begin
    Colour := AColour;
    ColorToRGB(AColour, r, g, b);
    ColorToHSL(AColour, h, s, l);
    ColorToXYZ(AColour, x, y, z);
    ColorToCIELab(AColour, ll, aa, bb);
  end;
end;

function CheckType(RGBRange, HSLRange, XYZRange, SpiralSearch: boolean
  ): TCheckType;
begin
  With result do
   begin
     RgbRange:=RGBRange;
     HSLRange:=HSLRange;
     XYZRange:=XYZRange;
     SpiralSearch:=SpiralSearch;
   end;
end;

function ColourToString(Colour: TColourRec;ColFormat: integer): string;
begin
  with Colour do
    case ColFormat of
      1: Result := Format('(%3d,%3d,%3d)', [r, g, b]);
      2: Result := Format('(%.0f,%.0f,%.0f)', [h, s, l]);
      3: Result := Format('(%.0f,%.0f,%.0f)', [x, y, z]);
      4: Result := Format('(%.0f,%.0f,%.0f)', [ll, aa, bb]);
      else Result := IntToStr(Colour);
    end;
end;

function Eq(aValue1, aValue2: string): boolean;
begin
  Result := AnsiCompareText(Trim(aValue1),Trim(aValue2))=0;
end;

function GenSpaces(cnt: integer): string;
var
  i: integer;
  s: string;
begin
 s:='';
 for i := 0 to cnt -1 do
  begin
     s:=s+#32;
    end;
  result:=s;
end;

end.

