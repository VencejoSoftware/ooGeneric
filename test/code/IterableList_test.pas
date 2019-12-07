{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit IterableList_test;

interface

uses
  SysUtils,
  IterableList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListEnumerableTest = class sealed(TTestCase)
  strict private
    _List: IIterableList<Integer>;
  protected
    procedure SetUp; override;
  published
    procedure IterateFiveItems;
    procedure IterateOnlyOneItem;
    procedure IteratorIsEmpty;
  end;

implementation

procedure TListEnumerableTest.IterateFiveItems;
var
  i: Integer;
  IntegerItem: Integer;
begin
  for i := 0 to 5 do
    _List.Add(i);
  i := 0;
  for IntegerItem in _List do
  begin
    CheckEquals(i, IntegerItem);
    inc(i);
  end;
end;

procedure TListEnumerableTest.IteratorIsEmpty;
var
  IntegerItem: Integer;
begin
  for IntegerItem in _List do
    CheckEquals(0, IntegerItem);
end;

procedure TListEnumerableTest.IterateOnlyOneItem;
var
  Value, IntegerItem: Integer;
begin
  Value := - 1;
  _List.Add(10);
  for IntegerItem in _List do
    Value := IntegerItem;
  CheckEquals(10, Value);
end;

procedure TListEnumerableTest.SetUp;
begin
  inherited;
  _List := TIterableList<Integer>.New;
end;

initialization

RegisterTest(TListEnumerableTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
