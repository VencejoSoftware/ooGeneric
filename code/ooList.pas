{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList;

interface

uses
  Classes, SysUtils,
  Generics.Collections;

type
  EList = class(Exception)
  end;

  IGenericList<T> = interface
    ['{F9307C24-C39E-4D8F-868B-0C42CBC457D6}']
    function GetItem(const Index: Integer): T;
    function Add(Item: T): Integer;
    function IsEmpty: Boolean;
    function Count: Integer;
    function IndexOf(const Item: T): Integer;
    function Exists(const Item: T): Boolean;
    function First: T;
    function Last: T;

    procedure FromArray(const ArrayItems: array of T);
    procedure SetItem(const Index: Integer; Item: T);
    procedure Clear;

    property Items[const Index: Integer]: T read GetItem write SetItem; default;
  end;

  TGenericList<T> = class(TInterfacedObject, IGenericList<T>)
  strict private
    _List: TList<T>;
    _UseReferenceCount: Boolean;
  private
    function GetItem(const Index: Integer): T;

    procedure SetItem(const Index: Integer; Item: T);
  protected
    function QueryInterface(const GUID: TGUID; out Obj): HResult; stdcall;
    function SupportsInterface(const GUID: TGUID): Boolean;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    function IsValidIndex(const Index: Integer): Boolean;
    function IsEmpty: Boolean; virtual;
    function Add(Item: T): Integer; virtual;
    function IndexOf(const Item: T): Integer;
    function Exists(const Item: T): Boolean; virtual;
    function First: T;
    function Last: T;
    function Count: Integer;

    procedure Clear; virtual;
    procedure FromArray(const ArrayItems: array of T);

    constructor Create(const UseReferenceCount: Boolean); virtual;
    destructor Destroy; override;

    class function New(const UseReferenceCount: Boolean): IGenericList<T>;

    property Items[const Index: Integer]: T read GetItem write SetItem; default;
  end;

implementation

function TGenericList<T>.SupportsInterface(const GUID: TGUID): Boolean;
var
  P: TObject;
begin
  Result := QueryInterface(GUID, P) = S_OK;
end;

function TGenericList<T>._AddRef: Integer;
begin
  If _UseReferenceCount then
    Result := inherited _AddRef
  else
    Result := - 1;
end;

function TGenericList<T>._Release: Integer;
begin
  If _UseReferenceCount then
    Result := inherited _Release
  else
    Result := - 1
end;

function TGenericList<T>.QueryInterface(const GUID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  If _UseReferenceCount then
    Result := inherited QueryInterface(GUID, Obj)
  else
    if GetInterface(GUID, Obj) then
      Result := 0
    else
      Result := E_NOINTERFACE;
end;

function TGenericList<T>.GetItem(const Index: Integer): T;
begin
  if not IsValidIndex(Index) then
    raise EList.Create('Invalid index');
  Result := T(_List.Items[Index]);
end;

procedure TGenericList<T>.SetItem(const Index: Integer; Item: T);
begin
  if not IsValidIndex(Index) then
    raise EList.Create('Invalid index');
  _List.Items[Index] := Item;
end;

function TGenericList<T>.Add(Item: T): Integer;
begin
  Result := _List.Add(Item);
end;

function TGenericList<T>.Count: Integer;
begin
  Result := _List.Count;
end;

function TGenericList<T>.IsValidIndex(const Index: Integer): Boolean;
begin
  Result := (Index >= 0) and (Index < Count);
end;

function TGenericList<T>.First: T;
begin
  if IsEmpty then
    Result := default(T)
  else
    Result := GetItem(0);
end;

function TGenericList<T>.Last: T;
begin
  if IsEmpty then
    Result := default(T)
  else
    Result := GetItem(Pred(Count));
end;

function TGenericList<T>.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

function TGenericList<T>.IndexOf(const Item: T): Integer;
begin
  Result := _List.IndexOf(Item);
end;

function TGenericList<T>.Exists(const Item: T): Boolean;
begin
  Result := _List.Contains(Item);
end;

procedure TGenericList<T>.FromArray(const ArrayItems: array of T);
var
  i: Integer;
begin
  for i := 0 to High(ArrayItems) do
    Add(ArrayItems[i]);
end;

procedure TGenericList<T>.Clear;
begin
  _List.Clear;
end;

constructor TGenericList<T>.Create(const UseReferenceCount: Boolean);
begin
  _List := TList<T>.Create;
  _UseReferenceCount := UseReferenceCount;
end;

destructor TGenericList<T>.Destroy;
begin
  Clear;
  _List.Free;
  inherited;
end;

class function TGenericList<T>.New(const UseReferenceCount: Boolean): IGenericList<T>;
begin
  Result := Create(UseReferenceCount);
end;

end.
