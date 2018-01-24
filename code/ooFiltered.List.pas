{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to filter a generic list
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooFiltered.List;

interface

uses
  Generics.Collections;

type
{$REGION 'documentation'}
{
  @abstract(Callback to evaluate filter condition)
  @param(List Item list owner)
  @param(Item Value item)
  @param(Index Index of item into the list)
  @return(@true if can use item, @false if item was filtered)
}
{$ENDREGION}
  TFilterListConditionCallback<T> = reference to function(const List: TList<T>; const Item: T;
    const Index: Integer): Boolean;

{$REGION 'documentation'}
{
  @abstract(Interface to apply filter to list)
  @member(
    GetCurrent Return current item list
    @return(Item value)
  )
  @member(
    MoveNext Increase position index
    @return(@true if is not the last item, @false if es EOL)
  )
  @member(Reset Reset the index position)
  @member(GetEnumerator Return object enumerator)
  @member(Current Property to return current item)
}
{$ENDREGION}

  IFilteredList<T> = interface
    ['{6FF06392-3668-46F9-87C6-628C9F391B9D}']
    function GetCurrent: T;
    function MoveNext: Boolean;
    function GetEnumerator: IFilteredList<T>;
    procedure Reset;
    property Current: T read GetCurrent;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IFilteredList))
  @member(GetCurrent @seealso(IFilteredList.GetCurrent))
  @member(MoveNext @seealso(IFilteredList.MoveNext))
  @member(GetEnumerator @seealso(IFilteredList.GetEnumerator))
  @member(Reset @seealso(IFilteredList.Reset))
  @member(Current @seealso(IFilteredList.Current))
  @member(
    IsValidItem Call the filter callback with item to validate or filter
    @param(Item Value item)
    @return(@true if can use item, @false if item was filtered)
  )
  @member(
    Create Object constructor
    @param(List List to filter)
    @param(ConditionCallback Condition callback to evaluate item)
  )
  @member(
    New Create a new @classname as interface
    @param(List List to filter)
    @param(ConditionCallback Condition callback to evaluate item)
  )

}
{$ENDREGION}

  TFilteredList<T> = class sealed(TInterfacedObject, IFilteredList<T>)
  strict private
    _Index: Integer;
    _List: TList<T>;
    _ConditionCallback: TFilterListConditionCallback<T>;
  private
    function GetCurrent: T;
    function GetEnumerator: IFilteredList<T>;
    function IsValidItem(const Item: T): Boolean;
  public
    function MoveNext: Boolean;
    procedure Reset;
    constructor Create(const List: TList<T>; const ConditionCallback: TFilterListConditionCallback<T>); virtual;
    class function New(const List: TList<T>; const ConditionCallback: TFilterListConditionCallback<T>)
      : IFilteredList<T>;
  end;

implementation

function TFilteredList<T>.GetCurrent: T;
begin
  Result := _List.Items[_Index];
end;

function TFilteredList<T>.GetEnumerator: IFilteredList<T>;
begin
  Result := Self;
end;

function TFilteredList<T>.IsValidItem(const Item: T): Boolean;
begin
  if Assigned(_ConditionCallback) then
    Result := _ConditionCallback(_List, Item, _Index)
  else
    Result := False;
end;

function TFilteredList<T>.MoveNext: Boolean;
begin
  Result := False;
  while _Index < Pred(_List.Count) do
  begin
    Inc(_Index);
    Result := IsValidItem(GetCurrent);
    if Result then
      Break;
  end;
end;

procedure TFilteredList<T>.Reset;
begin
  _Index := - 1;
end;

constructor TFilteredList<T>.Create(const List: TList<T>; const ConditionCallback: TFilterListConditionCallback<T>);
begin
  inherited Create;
  _Index := - 1;
  _List := List;
  _ConditionCallback := ConditionCallback;
end;

class function TFilteredList<T>.New(const List: TList<T>; const ConditionCallback: TFilterListConditionCallback<T>)
  : IFilteredList<T>;
begin
  Result := TFilteredList<T>.Create(List, ConditionCallback);
end;

end.
