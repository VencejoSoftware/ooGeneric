{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Enumeratable generic list object
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooList.Enumerable;

interface

uses
  ooList.Enumerator, ooList;

type
{$REGION 'documentation'}
{
  @abstract(Interface of enumerable generic list object)
  @member(
    GetEnumerator Makes a enumerator for object
    @return(Enumerator object)
  )
}
{$ENDREGION}
  IGenericListEnumerable<T> = interface(IGenericList<T>)
    ['{F9307C24-C39E-4D8F-868B-0C42CBC457D6}']
    function GetEnumerator: IGenericListEnumerator<T>;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IGenericListEnumerable))
  @member(GetEnumerator @seealso(IGenericListEnumerable.GetEnumerator))
}
{$ENDREGION}

  TListEnumerable<T> = class(TGenericList<T>, IGenericListEnumerable<T>)
  public
    function GetEnumerator: IGenericListEnumerator<T>;
  end;

implementation

function TListEnumerable<T>.GetEnumerator: IGenericListEnumerator<T>;
begin
  Result := TListEnumerator<T>.Create(Self);
end;

end.
