{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic list object
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit List;

interface

uses
  SysUtils,
  Generics.Collections;

type
{$REGION 'documentation'}
// @abstract(Define thist type to override TList name)
{$ENDREGION}
  TNativeGenericList<T> = class sealed(Generics.Collections.TList<T>);
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

  IList<T> = interface
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
    procedure FromTList(const List: TNativeGenericList<T>);
    procedure ChangeItemByIndex(const Index: TIntegerIndex; const Item: T);
    procedure Clear;
    property Items[const Index: TIntegerIndex]: T read ItemByIndex write ChangeItemByIndex; default;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IList))
  @member(ItemByIndex @seealso(IList.ItemByIndex))
  @member(Add @seealso(IList.Add))
  @member(Remove @seealso(IList.Remove))
  @member(IsEmpty @seealso(IList.IsEmpty))
  @member(Count @seealso(IList.Count))
  @member(IndexOf @seealso(IList.IndexOf))
  @member(Exists @seealso(IList.Exists))
  @member(First @seealso(IList.First))
  @member(Last @seealso(IList.Last))
  @member(FromArray @seealso(IList.FromArray))
  @member(FromTList @seealso(IList.FromTList))
  @member(ChangeItemByIndex @seealso(IList.ChangeItemByIndex))
  @member(Clear @seealso(IList.Clear))
  @member(Items @seealso(IList.Items))
  @member(
    IsValidIndex Checks if a index is valid for current items in list
    @param(Index Item index in list)
    @return(@true if is valid, @false if not)
  )
  @member(Items @seealso(IList.Items))
  @member(QueryInterface Used for interface mode)
  @member(SupportsInterface Used for interface mode)
  @member(_AddRef Used for interface mode)
  @member(_Release Used for interface mode)
  @member(
    Create Object constructor
  )
  @member(
    Destroy Object destructor
  )
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TListGeneric<T> = class(TInterfacedObject, IList<T>)
  strict private
    _List: TNativeGenericList<T>;
  protected
    function IsValidIndex(const Index: TIntegerIndex): Boolean;
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
    procedure FromTList(const List: TNativeGenericList<T>);
    constructor Create; virtual;
    destructor Destroy; override;
    property Items[const Index: TIntegerIndex]: T read ItemByIndex write ChangeItemByIndex; default;
    class function New: IList<T>;
  end;

implementation

function TListGeneric<T>.ItemByIndex(const Index: TIntegerIndex): T;
begin
  if not IsValidIndex(Index) then
    raise EList.Create('Invalid index')
  else
    Result := T(_List.Items[Index]);
end;

procedure TListGeneric<T>.ChangeItemByIndex(const Index: TIntegerIndex; const Item: T);
begin
  if not IsValidIndex(Index) then
    raise EList.Create('Invalid index')
  else
    _List.Items[Index] := Item;
end;

function TListGeneric<T>.Add(const Item: T): TIntegerIndex;
begin
  Result := _List.Add(Item);
end;

function TListGeneric<T>.Remove(const Item: T): TIntegerIndex;
begin
  Result := _List.Remove(Item);
end;

function TListGeneric<T>.Count: TIntegerIndex;
begin
  Result := _List.Count;
end;

function TListGeneric<T>.IsValidIndex(const Index: TIntegerIndex): Boolean;
begin
  Result := (Index < Count);
end;

function TListGeneric<T>.First: T;
begin
  if IsEmpty then
    Result := default (T)
  else
    Result := ItemByIndex(0);
end;

function TListGeneric<T>.Last: T;
begin
  if IsEmpty then
    Result := default (T)
  else
    Result := ItemByIndex(Pred(Count));
end;

function TListGeneric<T>.IsEmpty: Boolean;
begin
  Result := (Count = 0);
end;

function TListGeneric<T>.IndexOf(const Item: T): TIntegerIndex;
begin
  Result := _List.IndexOf(Item);
end;

function TListGeneric<T>.Exists(const Item: T): Boolean;
begin
  Result := _List.Contains(Item);
end;

procedure TListGeneric<T>.FromArray(const ArrayItems: array of T);
var
  i: TIntegerIndex;
begin
  for i := 0 to High(ArrayItems) do
    Add(ArrayItems[i]);
end;

procedure TListGeneric<T>.FromTList(const List: TNativeGenericList<T>);
var
  Item: T;
begin
  for Item in List do
    Self.Add(Item);
end;

procedure TListGeneric<T>.Clear;
begin
  _List.Clear;
end;

constructor TListGeneric<T>.Create;
begin
  _List := TNativeGenericList<T>.Create;
end;

destructor TListGeneric<T>.Destroy;
begin
  Clear;
  _List.Free;
  inherited;
end;

class function TListGeneric<T>.New: IList<T>;
begin
  Result := TListGeneric<T>.Create;
end;

end.
