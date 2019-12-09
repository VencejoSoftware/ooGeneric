{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit Attribute_test;

interface

uses
  SysUtils,
  Attribute,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TAttributeTest = class sealed(TTestCase)
  published
    procedure KeyIsID;
    procedure ValueIsSomething;
  end;

  TAttributeListTest = class sealed(TTestCase)
  strict private
    _List: IAttributeList;
  public
    procedure SetUp; override;
  published
    procedure ItemByKeyIDExist;
    procedure ItemByKey666ReturnNil;
    procedure CountReturn3;
  end;

implementation

{ TAttributeTest }

procedure TAttributeTest.KeyIsID;
begin
  CheckEquals('ID', TAttribute.New('ID', 'Something').Key);
end;

procedure TAttributeTest.ValueIsSomething;
begin
  CheckEquals('Something', TAttribute.New('ID', 'Something').Value);
end;

{ TAttributeListTest }

procedure TAttributeListTest.ItemByKey666ReturnNil;
begin
  CheckFalse(Assigned(_List.ItemByKey('666')));
end;

procedure TAttributeListTest.ItemByKeyIDExist;
begin
  CheckTrue(Assigned(_List.ItemByKey('ID')));
end;

procedure TAttributeListTest.CountReturn3;
begin
  CheckEquals(3, _List.Count);
end;

procedure TAttributeListTest.SetUp;
begin
  inherited;
  _List := TAttributeList.NewByContent('ID=1234;Name=SomeName;Birthday=12/12/2112', ';', '=');
end;

initialization

RegisterTests([TAttributeTest {$IFNDEF FPC}.Suite {$ENDIF}, TAttributeListTest {$IFNDEF FPC}.Suite {$ENDIF}]);

end.
