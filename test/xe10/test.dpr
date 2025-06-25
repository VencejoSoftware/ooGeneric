{
  Copyright (c) 2023, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  RunTest,
  ListIterator_test in '..\code\ListIterator_test.pas',
  FilterListIterator_test in '..\code\FilterListIterator_test.pas',
  IterableList_test in '..\code\IterableList_test.pas',
  FilterableList_test in '..\code\FilterableList_test.pas',
  List_test in '..\code\List_test.pas',
  ObjectList_test in '..\code\ObjectList_test.pas',
  Nullable_test in '..\code\Nullable_test.pas' {R *.RES},
  Attribute_test in '..\code\Attribute_test.pas',
  PlainStream_test in '..\code\PlainStream_test.pas',
  Optional_test in '..\code\Optional_test.pas',
  Attribute in '..\..\code\Attribute.pas',
  CrossKey in '..\..\code\CrossKey.pas',
  Either in '..\..\code\Either.pas',
  FilterableList in '..\..\code\FilterableList.pas',
  FilterListIterator in '..\..\code\FilterListIterator.pas',
  GUIDKey in '..\..\code\GUIDKey.pas',
  Identificable in '..\..\code\Identificable.pas',
  IterableList in '..\..\code\IterableList.pas',
  Iterator in '..\..\code\Iterator.pas',
  Key in '..\..\code\Key.pas',
  List in '..\..\code\List.pas',
  ListIterator in '..\..\code\ListIterator.pas',
  Name in '..\..\code\Name.pas',
  Nameable in '..\..\code\Nameable.pas',
  Nullable in '..\..\code\Nullable.pas',
  ObjectList in '..\..\code\ObjectList.pas',
  Optional in '..\..\code\Optional.pas',
  PlainStream in '..\..\code\PlainStream.pas';

{R *.RES}

begin
  Run;

end.
