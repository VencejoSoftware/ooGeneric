{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList_test;

interface

uses
  SysUtils,
  ooList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListTest = class(TTestCase)
  private
    _List: TGenericList<String>;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsEmpty;
    procedure TestCount;
    procedure TestItems;
    procedure TestIsValidIndex;
    procedure TestClear;
    procedure TestIndexOf;
    procedure TestExists;
    procedure TestFromArray;
  end;

implementation

procedure TListTest.TestIsValidIndex;
begin
  _List.Add('TestIndex1');
  _List.Add('TestIndex2');
  CheckTrue(_List.IsValidIndex(0));
  CheckTrue(_List.IsValidIndex(1));
  CheckFalse(_List.IsValidIndex(2));
end;

procedure TListTest.TestClear;
begin
  _List.Add('TestIndex1');
  _List.Add('TestIndex2');
  _List.Add('TestIndex3');
  CheckEquals(3, _List.Count);
  _List.Clear;
  CheckTrue(_List.IsEmpty);
end;

procedure TListTest.TestCount;
begin
  CheckEquals(0, _List.Count);
  _List.Add('TestIndex1');
  _List.Add('TestIndex2');
  _List.Add('TestIndex3');
  CheckEquals(3, _List.Count);
end;

procedure TListTest.TestExists;
begin
  _List.Add('aa');
  _List.Add('bbb');
  _List.Add('cccc');
  CheckTrue(_List.Exists('cccc'));
  CheckFalse(_List.Exists('none'));
end;

procedure TListTest.TestFromArray;
begin
  _List.FromArray(['a', 'b', 'c', 'd']);
  CheckEquals(4, _List.Count);
  CheckTrue(_List.Exists('a'));
  CheckTrue(_List.Exists('b'));
  CheckTrue(_List.Exists('c'));
  CheckTrue(_List.Exists('d'));
end;

procedure TListTest.TestIndexOf;
begin
  _List.Add('Line1');
  _List.Add('Line2');
  _List.Add('Line3');
  _List.Add('Line4');
  _List.Add('Line5');
  CheckEquals(2, _List.IndexOf('Line3'));
end;

procedure TListTest.TestIsEmpty;
begin
  CheckTrue(_List.IsEmpty);
  _List.Add('Test');
  CheckFalse(_List.IsEmpty);
  _List.Clear;
  CheckTrue(_List.IsEmpty);
end;

procedure TListTest.TestItems;
begin
  _List.Add('TestIndex1');
  _List.Add('TestIndex2');
  _List.Add('TestIndex3');
  CheckEquals('TestIndex1', _List.Items[0]);
  CheckEquals('TestIndex2', _List.Items[1]);
  CheckEquals('TestIndex3', _List.Items[2]);
end;

procedure TListTest.SetUp;
begin
  inherited;
  _List := TGenericList<String>.Create(False);
end;

procedure TListTest.TearDown;
begin
  inherited;
  _List.Free;
end;

initialization

RegisterTest(TListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
