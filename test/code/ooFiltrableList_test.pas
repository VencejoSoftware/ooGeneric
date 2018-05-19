{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFiltrableList_test;

interface

uses
  SysUtils,
  ooFiltrableList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFiltrableListTest = class sealed(TTestCase)
  strict private
    _List: IFiltrableList<String>;
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

procedure TFiltrableListTest.FilterMultipleOfTwo;
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

procedure TFiltrableListTest.SetUp;
var
  i: Byte;
begin
  inherited;
  _List := TFiltrableList<String>.New;
  for i := 0 to 10 do
    _List.Add(IntToStr(i));
end;

initialization

RegisterTest(TFiltrableListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
