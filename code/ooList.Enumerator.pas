{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Enumerator;

interface

uses
  ooList,
  ooEnumerator;

type
  IGenericListEnumerator<T> = interface(IEnumerator<T>)
    ['{B6075068-EE19-493E-AC79-75F6ED1872EB}']
    function GetList: IGenericList<T>;
  end;

  TListEnumerator<T> = class(TInterfacedObject, IGenericListEnumerator<T>)
  strict private
    _CurrentIndex: Integer;
    _List: IGenericList<T>;
  private
    function GetList: IGenericList<T>;
  public
    function MoveNext: Boolean; virtual;
    function GetCurrent: T;

    procedure Reset;

    constructor Create(const List: IGenericList<T>); virtual;

    property Current: T read GetCurrent;
  end;

implementation

function TListEnumerator<T>.GetList: IGenericList<T>;
begin
  Result := _List;
end;

function TListEnumerator<T>.GetCurrent: T;
begin
  Result := GetList.Items[_CurrentIndex];
end;

function TListEnumerator<T>.MoveNext: Boolean;
begin
  Result := _CurrentIndex < Pred(GetList.Count);
  if Result then
    Inc(_CurrentIndex);
end;

procedure TListEnumerator<T>.Reset;
begin
  _CurrentIndex := - 1;
end;

constructor TListEnumerator<T>.Create(const List: IGenericList<T>);
begin
  inherited Create;
  _CurrentIndex := - 1;
  _List := List;
end;

end.
