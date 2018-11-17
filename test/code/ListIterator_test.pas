{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ListIterator_test;

interface

uses
  SysUtils,
  List,
  Iterator, ListIterator,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListIteratorTest = class sealed(TTestCase)
  published
    procedure CurrentValueIsA;
    procedure NextWithEmptyListIsFalse;
    procedure IterateFiveItems;
    procedure ResetAfterNextReturnA;
  end;

implementation

procedure TListIteratorTest.NextWithEmptyListIsFalse;
var
  List: IList<Byte>;
  Iterator: IIterator<Byte>;
begin
  List := TListGeneric<Byte>.New;
  Iterator := TListIterator<Byte>.New(List);
  CheckFalse(Iterator.MoveNext);
end;

procedure TListIteratorTest.CurrentValueIsA;
var
  List: IList<Char>;
  Iterator: IIterator<Char>;
begin
  List := TListGeneric<Char>.New;
  List.Add('A');
  Iterator := TListIterator<Char>.New(List);
  CheckEquals('A', Iterator.Current);
end;

procedure TListIteratorTest.IterateFiveItems;
var
  List: IList<Byte>;
  Iterator: IIterator<Byte>;
  i: Byte;
begin
  List := TListGeneric<Byte>.New;
  for i := 0 to 5 do
    List.Add(i);
  Iterator := TListIterator<Byte>.New(List);
  i := 0;
  while Iterator.MoveNext do
  begin
    CheckEquals(i, Iterator.Current);
    inc(i);
  end;
end;

procedure TListIteratorTest.ResetAfterNextReturnA;
var
  List: IList<Char>;
  Iterator: IIterator<Char>;
begin
  List := TListGeneric<Char>.New;
  List.Add('A');
  List.Add('B');
  List.Add('C');
  List.Add('D');
  Iterator := TListIterator<Char>.New(List);
  Iterator.MoveNext;
  Iterator.MoveNext;
  Iterator.Reset;
  CheckEquals('A', Iterator.Current);
end;

initialization

RegisterTest(TListIteratorTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
