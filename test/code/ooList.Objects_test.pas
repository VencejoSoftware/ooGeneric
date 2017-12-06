{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Objects_test;

interface

uses
  SysUtils,
  ooList.Objects,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListObjectsTest = class(TTestCase)
  published
    procedure TestDestroyObjects;
  end;

implementation

procedure TListObjectsTest.TestDestroyObjects;
var
  ListObjects: TListObjects<TObject>;
begin
  ListObjects := TListObjects<TObject>.Create(True, False);
  try
    ListObjects.Add(TObject.Create);
    ListObjects.Add(TObject.Create);
    ListObjects.Add(TObject.Create);
    ListObjects.Add(TObject.Create);
    CheckEquals(4, ListObjects.Count);
    ListObjects.Clear;
    CheckEquals(0, ListObjects.Count);
  finally
    ListObjects.Free;
  end;
end;

initialization

RegisterTest(TListObjectsTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
