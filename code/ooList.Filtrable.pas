{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Filtrable;

interface

uses
  ooList.Enumerable, ooList.ConditionFilter;

type
  IGenericListFiltrable<T> = interface(IGenericListEnumerable<T>)
    ['{55E41190-7830-405F-A585-33BCA2BBE78E}']
    function Filter(const ListFilterCriteria: TListFilterCriteria<T>): IGenericListFilter<T>;
  end;

  TListFiltrable<T> = class(TListEnumerable<T>, IGenericListFiltrable<T>)
  public
    function Filter(const ListFilterCriteria: TListFilterCriteria<T>): IGenericListFilter<T>;
  end;

implementation

function TListFiltrable<T>.Filter(const ListFilterCriteria: TListFilterCriteria<T>): IGenericListFilter<T>;
begin
  Result := TListFilter<T>.Create(Self, ListFilterCriteria);
end;

end.
