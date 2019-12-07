{$REGION 'documentation'}
{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic filterable data list definition
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit FilterableList;

interface

uses
  Iterator,
  IterableList,
  FilterListIterator;

type
{$REGION 'documentation'}
{
  @abstract(Interface for filterable item list)
  @member(
    Filter Filter the list with some Condition
    @param(Condition Filter condition to apply)
    @return(Filtered list)
  )
}
{$ENDREGION}
  IFilterableList<T> = interface(IIterableList<T>)
    ['{55E41190-7830-405F-A585-33BCA2BBE78E}']
    function Filter(const Condition: TConditionCallback<T>): IFilterListIterator<T>;
{$IFDEF FPC}
    function FilterOfObjec(const Condition: TConditionCallbackOfObject<T>): IFilterListIterator<T>;
{$ENDIF}
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IFilterableList))
  @member(Filter @seealso(IFilterableList.Filter))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TFilterableList<T> = class(TIterableList<T>, IFilterableList<T>)
  public
    function Filter(const Condition: TConditionCallback<T>): IFilterListIterator<T>;
{$IFDEF FPC}
    function FilterOfObjec(const Condition: TConditionCallbackOfObject<T>): IFilterListIterator<T>;
{$ENDIF}
    class function New: IFilterableList<T>; static;
  end;

implementation

function TFilterableList<T>.Filter(const Condition: TConditionCallback<T>): IFilterListIterator<T>;
begin
  Result := TFilterListIterator<T>.New(Self, Condition);
end;

{$IFDEF FPC}

function TFilterableList<T>.FilterOfObjec(const Condition: TConditionCallbackOfObject<T>): IFilterListIterator<T>;
begin
  Result := TFilterListIterator<T>.NewOfObjec(Self, Condition);
end;
{$ENDIF}

class function TFilterableList<T>.New: IFilterableList<T>;
begin
  Result := TFilterableList<T>.Create;
end;

end.
