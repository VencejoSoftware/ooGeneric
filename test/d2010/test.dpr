{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooNullable_test in '..\code\ooNullable_test.pas',
  ooList.Enumerable_test in '..\code\ooList.Enumerable_test.pas',
  ooList.Filtrable_test in '..\code\ooList.Filtrable_test.pas',
  ooList.Objects_test in '..\code\ooList.Objects_test.pas',
  ooList_test in '..\code\ooList_test.pas';

{$R *.RES}

begin
  Run;

end.
