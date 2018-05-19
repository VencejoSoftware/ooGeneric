{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooObjectList_test;

interface

uses
  SysUtils,
  ooObjectList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListObjectsTest = class sealed(TTestCase)
  published
    procedure DestroyObjectsClearAll;
  end;

implementation

procedure TListObjectsTest.DestroyObjectsClearAll;
var
  List: TListObjects<TObject>;
begin
  List := TListObjects<TObject>.Create(True);
  try
    List.Add(TObject.Create);
    List.Add(TObject.Create);
    List.Add(TObject.Create);
    List.Add(TObject.Create);
    CheckEquals(4, List.Count);
    List.Clear;
    CheckEquals(0, List.Count);
  finally
    List.Free;
  end;
end;

initialization

RegisterTest(TListObjectsTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
