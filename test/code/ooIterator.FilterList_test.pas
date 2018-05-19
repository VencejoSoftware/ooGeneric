{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooIterator.FilterList_test;

interface

uses
  SysUtils,
  ooList,
  ooIterator, ooIterator.FilterList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIteratorFilterListTest = class sealed(TTestCase)
  protected
    _List: IList<String>;
  protected
    procedure SetUp; override;
  published
    procedure CurrentValueIsA;
    procedure NextWithEmptyListIsFalse;
    procedure IterateABC;
    procedure IterateWord;
  end;

implementation

function ABCCondition(const Value: String): Boolean;
begin
  Result := CharInSet(Value[1], ['A', 'B', 'C']);
end;

procedure TIteratorFilterListTest.NextWithEmptyListIsFalse;
var
  Iterator: IIterator<String>;
begin
  Iterator := TIteratorFilterList<String>.New(_List, ABCCondition);
  _List.Clear;
  CheckFalse(Iterator.MoveNext);
end;

procedure TIteratorFilterListTest.CurrentValueIsA;
var
  Iterator: IIterator<String>;
begin
  Iterator := TIteratorFilterList<String>.New(_List, ABCCondition);
  CheckEquals('A', Iterator.Current);
end;

procedure TIteratorFilterListTest.IterateABC;
const
  ITEM_EXPECTED: array [0 .. 2] of string = ('A', 'B', 'C');
var
  Iterator: IIterator<String>;
  i: Byte;
begin
  Iterator := TIteratorFilterList<String>.New(_List, ABCCondition);
  i := 0;
  while Iterator.MoveNext do
  begin
    CheckEquals(ITEM_EXPECTED[i], Iterator.Current);
    inc(i);
  end;
end;

function WordCondition(const Value: String): Boolean;
begin
  Result := Pos('word', LowerCase(Value)) > 0;
end;

procedure TIteratorFilterListTest.IterateWord;
const
  ITEM_EXPECTED: array [0 .. 1] of string = ('Word1', 'Word 1 word 2 word 3');
var
  Iterator: IIterator<String>;
  i: Byte;
begin
  Iterator := TIteratorFilterList<String>.New(_List, WordCondition);
  i := 0;
  while Iterator.MoveNext do
  begin
    CheckEquals(ITEM_EXPECTED[i], Iterator.Current);
    inc(i);
  end;
end;

procedure TIteratorFilterListTest.SetUp;
begin
  inherited;
  _List := TListGeneric<String>.New;
  _List.Add('A');
  _List.Add('Word1');
  _List.Add('B');
  _List.Add('C');
  _List.Add('1234');
  _List.Add('D');
  _List.Add('Finish string');
  _List.Add('Word 1 word 2 word 3');
end;

initialization

RegisterTest(TIteratorFilterListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
