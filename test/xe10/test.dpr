{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooFiltrableList in '..\..\code\ooFiltrableList.pas',
  ooIterableList in '..\..\code\ooIterableList.pas',
  ooIterator.FilterList in '..\..\code\ooIterator.FilterList.pas',
  ooIterator.List in '..\..\code\ooIterator.List.pas',
  ooIterator in '..\..\code\ooIterator.pas',
  ooList in '..\..\code\ooList.pas',
  ooNullable in '..\..\code\ooNullable.pas',
  ooObjectList in '..\..\code\ooObjectList.pas',
  ooIterator.List_test in '..\code\ooIterator.List_test.pas',
  ooIterator.FilterList_test in '..\code\ooIterator.FilterList_test.pas',
  ooIterableList_test in '..\code\ooIterableList_test.pas',
  ooFiltrableList_test in '..\code\ooFiltrableList_test.pas',
  ooList_test in '..\code\ooList_test.pas',
  ooObjectList_test in '..\code\ooObjectList_test.pas',
  ooNullable_test in '..\code\ooNullable_test.pas' {R *.RES};

{ R *.RES }

begin
  Run;

end.
