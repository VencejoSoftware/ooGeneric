{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ObjectList_test;

interface

uses
  SysUtils,
  ObjectList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TObjectListTest = class sealed(TTestCase)
  published
    procedure DestroyObjectsClearAll;
  end;

implementation

procedure TObjectListTest.DestroyObjectsClearAll;
var
  List: TObjectList<TObject>;
begin
  List := TObjectList<TObject>.Create(True);
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

RegisterTest(TObjectListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
