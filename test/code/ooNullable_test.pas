{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooNullable_test;

interface

uses
  SysUtils,
  ooNullable,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TNullableTest = class(TTestCase)
  published
    procedure TestIsEmpty;
    procedure TestIsNotEmpty;
    procedure TestEqual;
    procedure TestNotEqual;
    procedure TestComparator;
    procedure TestGreaterThan;
    procedure TestGreaterOrEqual;
    procedure TestLessThan;
    procedure TestLessOrEqual;
    procedure TestIntegerGreaterThan;
    procedure TestClear;
  end;

implementation

procedure TNullableTest.TestClear;
var
  Nullable: TNullable<String>;
begin
  Nullable := 'test';
  CheckFalse(Nullable.IsEmpty);
  Nullable.Clear;
  CheckTrue(Nullable.IsEmpty);
end;

procedure TNullableTest.TestComparator;
var
  Nullable: TNullable<String>;
begin
  Nullable := 'test';
  CheckTrue('test' = Nullable);
end;

procedure TNullableTest.TestEqual;
var
  Nullable: TNullable<String>;
begin
  Nullable := 'test';
{$IFDEF FPC}
  CheckEquals('test', Nullable);
{$ELSE}
  CheckEqualsString('test', Nullable);
{$ENDIF}
end;

procedure TNullableTest.TestNotEqual;
var
  Nullable: TNullable<String>;
begin
  Nullable := 'test';
  CheckTrue('123' <> Nullable);
end;

procedure TNullableTest.TestGreaterOrEqual;
var
  Nullable: TNullable<Integer>;
begin
  Nullable := 22;
  CheckTrue(Nullable >= 22);
  CheckTrue(Nullable >= 20);
end;

procedure TNullableTest.TestGreaterThan;
var
  Nullable: TNullable<Integer>;
begin
  Nullable := 22;
  CheckTrue(Nullable > 10);
  CheckFalse(Nullable > 30);
end;

procedure TNullableTest.TestIntegerGreaterThan;
var
  NullableInteger: TNullableInteger;
begin
  NullableInteger := TNullableInteger(20);
  CheckTrue(NullableInteger > 10);
  CheckFalse(NullableInteger > 30);
end;

procedure TNullableTest.TestIsEmpty;
var
  Nullable: TNullable<String>;
begin
  CheckTrue(Nullable.IsEmpty);
end;

procedure TNullableTest.TestIsNotEmpty;
var
  Nullable: TNullable<String>;
begin
  Nullable := 'test';
  CheckFalse(Nullable.IsEmpty);
end;

procedure TNullableTest.TestLessOrEqual;
var
  Nullable: TNullable<Integer>;
begin
  Nullable := 22;
  CheckTrue(Nullable <= 22);
  CheckTrue(Nullable <= 30);
end;

procedure TNullableTest.TestLessThan;
var
  Nullable: TNullable<Integer>;
begin
  Nullable := 22;
  CheckTrue(Nullable < 30);
  CheckFalse(Nullable < 1);
end;

initialization

RegisterTest(TNullableTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
