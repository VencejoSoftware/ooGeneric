{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Enumerable_test;

interface

uses
  SysUtils,
  ooList.Enumerable,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListEnumerableTest = class(TTestCase)
  private
    _List: TListEnumerable<Integer>;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetEnumerator;
    procedure TestGetEnumeratorEmpty;
  end;

implementation

procedure TListEnumerableTest.TestGetEnumerator;
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

procedure TListEnumerableTest.TestGetEnumeratorEmpty;
var
  IntegerItem: Integer;
begin
  for IntegerItem in _List do
    CheckEquals(0, IntegerItem);
end;

procedure TListEnumerableTest.SetUp;
begin
  inherited;
  _List := TListEnumerable<Integer>.Create(False);
end;

procedure TListEnumerableTest.TearDown;
begin
  inherited;
  _List.Free;
end;

initialization

RegisterTest(TListEnumerableTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
