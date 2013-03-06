unit aca_types;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics;

type
  TColourRec = record
    Colour: TColor;
    r, g, b: Integer;
    h, s, l: Extended;
    x, y, z: Extended;
    ll, aa, bb: Extended;
  end;
  TColorRecArray = array of TColourRec;
  PColourRec = ^TColourRec;

  TCheckType = record
    RGBRange,HSLRange,XYZRange,SpiralSearch: boolean;
  end;

  { TColorItem }

  TColorItem = class(TCollectionItem)
    public
      aColor: TColourRec;
      constructor Create(Col: TCollection); override;
      destructor Destroy; override;
  end;

  { TColorItemList }

  TColorItemList = class(TCollection)
  private
    function GetItems(Index: Integer): TColorItem;
  public
    function AddItem: TColorItem;

    constructor Create;

    property Items[Index: Integer]: TColorItem read GetItems; default;
 end;

  { TColorProfile }

  TColorProfile = class(TCollectionItem)
    public
      Name: string;
      ColorList: TColorItemList;
      constructor Create(Col: TCollection); override;
      destructor Destroy; override;
  end;

  { TProfiles }

  TProfiles = class(TCollection)
    private
    function GetItems(Index: Integer): TColorProfile;
  public
    function AddItem: TColorProfile;

    constructor Create;

    property Items[Index: Integer]: TColorProfile read GetItems; default;
 end;

implementation

{ TColorProfile }

constructor TColorProfile.Create(Col: TCollection);
begin
  inherited Create(Col);
  ColorList:=TColorItemList.Create;
end;

destructor TColorProfile.Destroy;
begin
  inherited Destroy;
end;

{ TColorItemList }

function TColorItemList.GetItems(Index: Integer): TColorItem;
begin
   Result := TColorItem(inherited Items[Index]);
end;

function TColorItemList.AddItem: TColorItem;
begin
  Result := TColorItem(inherited Add());
end;

constructor TColorItemList.Create;
begin
  inherited Create(TColorItem);
end;

{ TProfiles }

function TProfiles.GetItems(Index: Integer): TColorProfile;
begin
  Result := TColorProfile(inherited Items[Index]);
end;

function TProfiles.AddItem: TColorProfile;
begin
  Result := TColorProfile(inherited Add());
end;

constructor TProfiles.Create;
begin
  inherited Create(TColorProfile);
end;

{ TColorItem }

constructor TColorItem.Create(Col: TCollection);
begin
  inherited Create(Col);
end;

destructor TColorItem.Destroy;
begin
  inherited Destroy;
end;

end.

