{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.ConditionFilter;

interface

uses
  ooList.Enumerator,
  ooList;

type
{$IFDEF FPC}
  TListFilterCriteria<T> = function(const Item: T): Boolean;
{$ELSE}
  TListFilterCriteria<T> = reference to function(const Item: T): Boolean;
{$ENDIF}

  IGenericListFilter<T> = interface(IGenericListEnumerator<T>)
    ['{BE08A393-0574-4437-9046-FA3EE0C350F8}']
    function GetEnumerator: IGenericListEnumerator<T>;
    function IsValidItem(const Item: T): Boolean;
  end;

  TListFilter<T> = class(TListEnumerator<T>, IGenericListFilter<T>)
  strict private
    _ListFilterCriteria: TListFilterCriteria<T>;
  public
    function IsValidItem(const Item: T): Boolean;
    function MoveNext: Boolean; override;
    function GetEnumerator: IGenericListEnumerator<T>;

    constructor Create(const List: IGenericList<T>; const ListFilterCriteria: TListFilterCriteria<T>); reintroduce;
  end;

implementation

function TListFilter<T>.IsValidItem(const Item: T): Boolean;
begin
  if Assigned(_ListFilterCriteria) then
    Result := _ListFilterCriteria(Item)
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

constructor TListFilter<T>.Create(const List: IGenericList<T>; const ListFilterCriteria: TListFilterCriteria<T>);
begin
  inherited Create(List);
  _ListFilterCriteria := ListFilterCriteria;
end;

end.
