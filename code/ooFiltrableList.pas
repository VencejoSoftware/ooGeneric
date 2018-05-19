{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic filtrable list definition
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooFiltrableList;

interface

uses
  ooIterator,
  ooIterableList,
  ooIterator.FilterList;

type
{$REGION 'documentation'}
{
  @abstract(Interface for filtrable list)
  @member(
    Filter Filter the list with some Condition
    @param(Condition Filter condition to apply)
    @return(Filtered list)
  )
}
{$ENDREGION}
  IFiltrableList<T> = interface(IIterableList<T>)
    ['{55E41190-7830-405F-A585-33BCA2BBE78E}']
    function Filter(const Condition: TConditionCallback<T>): IIteratorFilterList<T>;
{$IFDEF FPC}
    function FilterOfObjec(const Condition: TConditionCallbackOfObject<T>): IIteratorFilterList<T>;
{$ENDIF}
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IFiltrableList))
  @member(Filter @seealso(IFiltrableList.Filter))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TFiltrableList<T> = class(TIterableList<T>, IFiltrableList<T>)
  public
    function Filter(const Condition: TConditionCallback<T>): IIteratorFilterList<T>;
{$IFDEF FPC}
    function FilterOfObjec(const Condition: TConditionCallbackOfObject<T>): IIteratorFilterList<T>;
{$ENDIF}
    class function New: IFiltrableList<T>; static;
  end;

implementation

function TFiltrableList<T>.Filter(const Condition: TConditionCallback<T>): IIteratorFilterList<T>;
begin
  Result := TIteratorFilterList<T>.New(Self, Condition);
end;

{$IFDEF FPC}

function TFiltrableList<T>.FilterOfObjec(const Condition: TConditionCallbackOfObject<T>): IIteratorFilterList<T>;
begin
  Result := TIteratorFilterList<T>.NewOfObjec(Self, Condition);
end;
{$ENDIF}

class function TFiltrableList<T>.New: IFiltrableList<T>;
begin
  Result := TFiltrableList<T>.Create;
end;

end.
