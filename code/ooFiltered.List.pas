{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFiltered.List;

interface

uses
  Generics.Collections;

type
  TFilteredListCriteria<T> = reference to function(const List: TList<T>; const Item: T; const Index: Integer): Boolean;

  IFilteredList<T> = interface
    ['{6FF06392-3668-46F9-87C6-628C9F391B9D}']
    function GetCurrent: T;
    function MoveNext: Boolean;
    function GetEnumerator: IFilteredList<T>;
    procedure Reset;
    property Current: T read GetCurrent;
  end;

  TFilteredList<T> = class sealed(TInterfacedObject, IFilteredList<T>)
  strict private
    _Index: Integer;
    _List: TList<T>;
    _Criteria: TFilteredListCriteria<T>;
  private
    function GetCurrent: T;
    function GetEnumerator: IFilteredList<T>;
    function IsValidItem(const Item: T): Boolean;
  public
    function MoveNext: Boolean;
    procedure Reset;
    constructor Create(const List: TList<T>; const Criteria: TFilteredListCriteria<T>); virtual;
    class function New(const List: TList<T>; const Criteria: TFilteredListCriteria<T>): IFilteredList<T>;
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
  if Assigned(_Criteria) then
    Result := _Criteria(_List, Item, _Index)
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

constructor TFilteredList<T>.Create(const List: TList<T>; const Criteria: TFilteredListCriteria<T>);
begin
  inherited Create;
  _Index := - 1;
  _List := List;
  _Criteria := Criteria;
end;

class function TFilteredList<T>.New(const List: TList<T>; const Criteria: TFilteredListCriteria<T>): IFilteredList<T>;
begin
  Result := TFilteredList<T>.Create(List, Criteria);
end;

end.
