{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  RunTest,
  FiltrableList in '..\..\code\FiltrableList.pas',
  IterableList in '..\..\code\IterableList.pas',
  FilterListIterator in '..\..\code\FilterListIterator.pas',
  ListIterator in '..\..\code\ListIterator.pas',
  Iterator in '..\..\code\Iterator.pas',
  List in '..\..\code\List.pas',
  Nullable in '..\..\code\Nullable.pas',
  ObjectList in '..\..\code\ObjectList.pas',
  ListIterator_test in '..\code\ListIterator_test.pas',
  FilterListIterator_test in '..\code\FilterListIterator_test.pas',
  IterableList_test in '..\code\IterableList_test.pas',
  FiltrableList_test in '..\code\FiltrableList_test.pas',
  List_test in '..\code\List_test.pas',
  ObjectList_test in '..\code\ObjectList_test.pas',
  Nullable_test in '..\code\Nullable_test.pas';

{R *.RES}

begin
  Run;

end.
