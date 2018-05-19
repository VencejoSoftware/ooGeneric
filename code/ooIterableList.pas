{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Iterable generic list definition
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooIterableList;

interface

uses
  ooList,
  ooIterator,
  ooIterator.List;

type
{$REGION 'documentation'}
{
  @abstract(Interface of iterable generic list object)
  @member(
    GetEnumerator Makes a enumerator for object
    @return(Enumerator object)
  )
}
{$ENDREGION}
  IIterableList<T> = interface(IList<T>)
    ['{F9307C24-C39E-4D8F-868B-0C42CBC457D6}']
    function GetEnumerator: IIterator<T>;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IIterableList))
  @member(GetEnumerator @seealso(IIterableList.GetEnumerator))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TIterableList<T> = class(TListGeneric<T>, IIterableList<T>)
  public
    function GetEnumerator: IIterator<T>;
    class function New: IIterableList<T>; static;
  end;

implementation

function TIterableList<T>.GetEnumerator: IIterator<T>;
begin
  Result := TIteratorList<T>.New(Self);
end;

class function TIterableList<T>.New: IIterableList<T>;
begin
  Result := TIterableList<T>.Create;
end;

end.
