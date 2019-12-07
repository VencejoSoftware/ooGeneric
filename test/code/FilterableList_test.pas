{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit FilterableList_test;

interface

uses
  SysUtils,
  FilterableList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFilterableListTest = class sealed(TTestCase)
  strict private
    _List: IFilterableList<String>;
  protected
    procedure SetUp; override;
  published
    procedure FilterMultipleOfTwo;
  end;

implementation

function ConditionTest(const Value: String): Boolean;
begin
  Result := CharInSet(Value[1], ['0', '2', '4', '6', '8']) or (Value = '10');
end;

procedure TFilterableListTest.FilterMultipleOfTwo;
var
  i: Byte;
  Item: String;
begin
  i := 0;
  for Item in _List.Filter(ConditionTest) do
  begin
    CheckEquals(IntToStr(i), Item);
    i := i + 2;
  end;
end;

procedure TFilterableListTest.SetUp;
var
  i: Byte;
begin
  inherited;
  _List := TFilterableList<String>.New;
  for i := 0 to 10 do
    _List.Add(IntToStr(i));
end;

initialization

RegisterTest(TFilterableListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
