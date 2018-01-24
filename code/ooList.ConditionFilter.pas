{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Enumerator with filter capabilities
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooList.ConditionFilter;

interface

uses
  ooList.Enumerator,
  ooList;

type
{$REGION 'documentation'}
{
  @abstract(Callback to evaluate filter condition)
  @param(Item Value item)
  @return(@true if can use item, @false if item was filtered)
}
{$ENDREGION}
{$IFDEF FPC}
  TListFilterConditionCallback<T> = function(const Item: T): Boolean;
{$ELSE}
  TListFilterConditionCallback<T> = reference to function(const Item: T): Boolean;
{$ENDIF}
{$REGION 'documentation'}
{
  @abstract(Interface for filter list enumerator)
  @member(
    GetEnumerator Return a list enumerator
  )
  @member(
    IsValidItem Call the filter callback with item to validate or filter
    @param(Item Value item)
    @return(@true if can use item, @false if item was filtered)
  )
}
{$ENDREGION}

  IGenericListFilter<T> = interface(IGenericListEnumerator<T>)
    ['{BE08A393-0574-4437-9046-FA3EE0C350F8}']
    function GetEnumerator: IGenericListEnumerator<T>;
    function IsValidItem(const Item: T): Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IGenericListFilter))
  @member(GetEnumerator @seealso(IGenericListFilter.GetEnumerator))
  @member(IsValidItem @seealso(IGenericListFilter.IsValidItem))
  @member(
    MoveNext Override MoveNext to use condition callback
  )
  @member(
    Create Object constructor
    @param(List List to filter)
    @param(ConditionCallback Condition callback to evaluate item)
  )
}
{$ENDREGION}

  TListFilter<T> = class(TListEnumerator<T>, IGenericListFilter<T>)
  strict private
    _ConditionCallback: TListFilterConditionCallback<T>;
  public
    function IsValidItem(const Item: T): Boolean;
    function MoveNext: Boolean; override;
    function GetEnumerator: IGenericListEnumerator<T>;
    constructor Create(const List: IGenericList<T>; const ConditionCallback: TListFilterConditionCallback<T>);
      reintroduce;
  end;

implementation

function TListFilter<T>.IsValidItem(const Item: T): Boolean;
begin
  if Assigned(_ConditionCallback) then
    Result := _ConditionCallback(Item)
  else
    Result := False;
end;

function TListFilter<T>.GetEnumerator: IGenericListEnumerator<T>;
begin
  Result := Self;
end;

function TListFilter<T>.MoveNext: Boolean;
begin
  Result := False;
  while inherited do
  begin
    Result := IsValidItem(Current);
    if Result then
      Break;
  end;
end;

constructor TListFilter<T>.Create(const List: IGenericList<T>;
  const ConditionCallback: TListFilterConditionCallback<T>);
begin
  inherited Create(List);
  _ConditionCallback := ConditionCallback;
end;

end.
