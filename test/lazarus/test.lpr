{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  RunTest,
  FilterableList in '..\..\code\FilterableList.pas',
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
  FilterableList_test in '..\code\FilterableList_test.pas',
  List_test in '..\code\List_test.pas',
  ObjectList_test in '..\code\ObjectList_test.pas',
  Nullable_test in '..\code\Nullable_test.pas',
  Attribute in '..\..\code\Attribute.pas',
  Attribute_test in '..\code\Attribute_test.pas',
  PlainStream in '..\..\code\PlainStream.pas',
  PlainStream_test in '..\code\PlainStream_test.pas';

{R *.RES}

begin
  Run;

end.
