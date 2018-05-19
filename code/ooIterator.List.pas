{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Iterator for generic lists
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooIterator.List;

interface

uses
  ooList,
  ooIterator;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IIteratorList))
  Iterator definition for generic lists
  @member(MoveNext @seealso(IIterator.MoveNext))
  @member(GetCurrent @seealso(IIterator.GetCurrent))
  @member(Reset @seealso(IIterator.Reset))
  @member(Current @seealso(IIterator.Current))
  @member(
    Create Object constructor
    @param(List Generic list to iterate)
  )
  @member(
    New Create a new @classname as interface
    @param(List Generic list to iterate)
  )
}
{$ENDREGION}
  TIteratorList<T> = class sealed(TInterfacedObject, IIterator<T>)
  strict private
    _Reseted: Boolean;
    _Index: TIntegerIndex;
    _List: IList<T>;
  public
    function MoveNext: Boolean;
    function GetCurrent: T;
    procedure Reset;
    constructor Create(const List: IList<T>);
    property Current: T read GetCurrent;
    class function New(const List: IList<T>): IIterator<T>;
  end;

implementation

function TIteratorList<T>.GetCurrent: T;
begin
  Result := _List.ItemByIndex(_Index);
end;

function TIteratorList<T>.MoveNext: Boolean;
begin
  if _Reseted then
    _Reseted := False
  else
    Inc(_Index);
  Result := _Index < _List.Count;
end;

procedure TIteratorList<T>.Reset;
begin
  _Index := 0;
  _Reseted := True;
end;

constructor TIteratorList<T>.Create(const List: IList<T>);
begin
  inherited Create;
  _List := List;
  Reset;
end;

class function TIteratorList<T>.New(const List: IList<T>): IIterator<T>;
begin
  Result := TIteratorList<T>.Create(List);
end;

end.
