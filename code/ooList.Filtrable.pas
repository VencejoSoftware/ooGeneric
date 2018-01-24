{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic filtrable list object
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooList.Filtrable;

interface

uses
  ooList.Enumerable,
  ooList.ConditionFilter;

type
{$REGION 'documentation'}
{
  @abstract(Interface for filtrable generic lists)
  @member(
    Filter Filter the list with some criteria
    @param(Criteria Filter criteria to apply)
    @return(Filtered list)
  )
}
{$ENDREGION}
  IGenericListFiltrable<T> = interface(IGenericListEnumerable<T>)
    ['{55E41190-7830-405F-A585-33BCA2BBE78E}']
    function Filter(const Criteria: TListFilterConditionCallback<T>): IGenericListFilter<T>;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IGenericListFiltrable))
  @member(Filter @seealso(IGenericListFiltrable.Filter))
}
{$ENDREGION}

  TListFiltrable<T> = class(TListEnumerable<T>, IGenericListFiltrable<T>)
  public
    function Filter(const Criteria: TListFilterConditionCallback<T>): IGenericListFilter<T>;
  end;

implementation

function TListFiltrable<T>.Filter(const Criteria: TListFilterConditionCallback<T>): IGenericListFilter<T>;
begin
  Result := TListFilter<T>.Create(Self, Criteria);
end;

end.
