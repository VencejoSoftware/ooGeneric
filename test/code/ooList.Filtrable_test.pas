{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Filtrable_test;

interface

uses
  SysUtils,
  ooList.Filtrable,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListFiltrableTest = class(TTestCase)
  private
    _List: TListFiltrable<String>;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFilter;
  end;

implementation

function TestCriteria(const aItem: String): Boolean;
begin
  Result := CharInSet(aItem[1], ['0', '2', '4', '6', '8']) or (aItem = '10');
end;

procedure TListFiltrableTest.TestFilter;
var
  i: Integer;
  StringItem: String;
begin
  for i := 0 to 10 do
    _List.Add(IntToStr(i));
  i := 0;
  for StringItem in _List.Filter(TestCriteria) do
  begin
    CheckEquals(IntToStr(i), StringItem);
    i := i + 2;
  end;
end;

procedure TListFiltrableTest.SetUp;
begin
  inherited;
  _List := TListFiltrable<String>.Create(False);
end;

procedure TListFiltrableTest.TearDown;
begin
  inherited;
  _List.Free;
end;

initialization

RegisterTest(TListFiltrableTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
