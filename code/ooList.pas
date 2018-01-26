{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic list object
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooList;

interface

uses
  SysUtils,
  Generics.Collections;

type
{$REGION 'documentation'}
// @abstract(Error class for generics list)
{$ENDREGION}
  EList = class(Exception)
  end;
{$REGION 'documentation'}
// @abstract(Native type wrap for item index)
{$ENDREGION}

  TIntegerIndex = NativeUInt;
{$REGION 'documentation'}
{
  @abstract(Interface of generic list)
  @member(
    ItemByIndex Return a item by index position
    @param(Index Position of item)
    @return(Generic value item)
  )
  @member(
    Add Append a new item to the list
    @param(Item Value item)
    @return(Index of added item)
  )
  @member(
    Remove Remove a item from list
    @param(Item Value item)
    @return(Index of removed item)
  )
  @member(
    IsEmpty Checks if the list is empty
    @return(@true if the list is empty, @false if the list has at least one item)
  )
  @member(
    Count Return the number of items in list
    @return(Number with the items in list)
  )
  @member(
    IndexOf Return a item index from item value
    @param(Item Value item)
    @return(Index of value item)
  )
  @member(
    Exists Checks if a item value exists in the list
    @param(Item Value item)
    @return(@true if value item exists, @false if not)
  )
  @member(
    First Return the first value item in list
    @return(Value item object or error)
  )
  @member(
    Last Return the last value item in list
    @return(Value item object or error)
  )
  @member(
    FromArray Load the list from an array
    @parm(ArrayItems Array to load)
  )
  @member(
    FromTList Load the list from an generic TList
    @parm(List List to load)
  )
  @member(
    ChangeItemByIndex Change an exist item for another
    @param(Index Item index)
    @param(Item Value item)
  )
  @member(Clear Clear the list removing all items)
  @member(Items Property to access of all items)
}
{$ENDREGION}

  IGenericList<T> = interface
    ['{F9307C24-C39E-4D8F-868B-0C42CBC457D6}']
    function ItemByIndex(const Index: TIntegerIndex): T;
    function Add(const Item: T): TIntegerIndex;
    function Remove(const Item: T): TIntegerIndex;
    function IsEmpty: Boolean;
    function Count: TIntegerIndex;
    function IndexOf(const Item: T): TIntegerIndex;
    function Exists(const Item: T): Boolean;
    function First: T;
    function Last: T;
    procedure FromArray(const ArrayItems: array of T);
    procedure FromTList(const List: TList<T>);
    procedure ChangeItemByIndex(const Index: TIntegerIndex; const Item: T);
    procedure Clear;
    property Items[const Index: TIntegerIndex]: T read ItemByIndex write ChangeItemByIndex; default;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IGenericList))
  @member(ItemByIndex @seealso(IGenericList.ItemByIndex))
  @member(Add @seealso(IGenericList.Add))
  @member(Remove @seealso(IGenericList.Remove))
  @member(IsEmpty @seealso(IGenericList.IsEmpty))
  @member(Count @seealso(IGenericList.Count))
  @member(IndexOf @seealso(IGenericList.IndexOf))
  @member(Exists @seealso(IGenericList.Exists))
  @member(First @seealso(IGenericList.First))
  @member(Last @seealso(IGenericList.Last))
  @member(FromArray @seealso(IGenericList.FromArray))
  @member(FromTList @seealso(IGenericList.FromTList))
  @member(ChangeItemByIndex @seealso(IGenericList.ChangeItemByIndex))
  @member(Clear @seealso(IGenericList.Clear))
  @member(Items @seealso(IGenericList.Items))
  @member(
    IsValidIndex Checks if a index is valid for current items in list
    @param(Index Item index in list)
    @return(@true if is valid, @false if not)
  )
  @member(Items @seealso(IGenericList.Items))
  @member(QueryInterface Used for interface mode)
  @member(SupportsInterface Used for interface mode)
  @member(_AddRef Used for interface mode)
  @member(_Release Used for interface mode)
  @member(
    Create Object constructor
    @param(UseReferenceCount Use list in interface mode)
  )
  @member(
    Destroy Object destructor
  )
}
{$ENDREGION}

  TGenericList<T> = class(TInterfacedObject, IGenericList<T>)
  strict private
    _List: TList<T>;
    _UseReferenceCount: Boolean;
  protected
    function IsValidIndex(const Index: TIntegerIndex): Boolean;
    function QueryInterface(const GUID: TGUID; out Obj): HResult; stdcall;
    function SupportsInterface(const GUID: TGUID): Boolean;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    function IsEmpty: Boolean; virtual;
    function Add(const Item: T): TIntegerIndex; virtual;
    function Remove(const Item: T): TIntegerIndex; virtual;
    function IndexOf(const Item: T): TIntegerIndex;
    function Exists(const Item: T): Boolean; virtual;
    function First: T;
    function Last: T;
    function Count: TIntegerIndex;
    function ItemByIndex(const Index: TIntegerIndex): T;
    procedure ChangeItemByIndex(const Index: TIntegerIndex; const Item: T);
    procedure Clear; virtual;
    procedure FromArray(const ArrayItems: array of T);
    procedure FromTList(const List: TList<T>);
    constructor Create(const UseReferenceCount: Boolean = True); virtual;
    destructor Destroy; override;
    property Items[const Index: TIntegerIndex]: T read ItemByIndex write ChangeItemByIndex; default;
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

function TGenericList<T>.ItemByIndex(const Index: TIntegerIndex): T;
begin
  if not IsValidIndex(Index) then
    raise EList.Create('Invalid index');
  Result := T(_List.Items[Index]);
end;

procedure TGenericList<T>.ChangeItemByIndex(const Index: TIntegerIndex; const Item: T);
begin
  if not IsValidIndex(Index) then
    raise EList.Create('Invalid index');
  _List.Items[Index] := Item;
end;

function TGenericList<T>.Add(const Item: T): TIntegerIndex;
begin
  Result := _List.Add(Item);
end;

function TGenericList<T>.Remove(const Item: T): TIntegerIndex;
begin
  Result := _List.Remove(Item);
end;

function TGenericList<T>.Count: TIntegerIndex;
begin
  Result := _List.Count;
end;

function TGenericList<T>.IsValidIndex(const Index: TIntegerIndex): Boolean;
begin
  Result := (Index < Count);
end;

function TGenericList<T>.First: T;
begin
  if IsEmpty then
    Result := default(T)
  else
    Result := ItemByIndex(0);
end;

function TGenericList<T>.Last: T;
begin
  if IsEmpty then
    Result := default(T)
  else
    Result := ItemByIndex(Pred(Count));
end;

function TGenericList<T>.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

function TGenericList<T>.IndexOf(const Item: T): TIntegerIndex;
begin
  Result := _List.IndexOf(Item);
end;

function TGenericList<T>.Exists(const Item: T): Boolean;
begin
  Result := _List.Contains(Item);
end;

procedure TGenericList<T>.FromArray(const ArrayItems: array of T);
var
  i: TIntegerIndex;
begin
  for i := 0 to High(ArrayItems) do
    Add(ArrayItems[i]);
end;

procedure TGenericList<T>.FromTList(const List: TList<T>);
var
  Item: T;
begin
  for Item in List do
    Self.Add(Item);
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

end.
