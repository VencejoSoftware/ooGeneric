{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit List_test;

interface

uses
  SysUtils,
  List,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListTest = class sealed(TTestCase)
  strict private
    _List: IList<String>;
  protected
    procedure SetUp; override;
  published
    procedure ItemByIndex2IsLine3;
    procedure AddTwoItemsReturnCount7;
    procedure RemoveLine2ReturnCount4;
    procedure IsEmptyWithInitialIsFalse;
    procedure IsEmptyWithClearIsTrue;
    procedure CountOfInitialIs5;
    procedure IndexOfLine4Is3;
    procedure ExistsLine2IsTrue;
    procedure ExistsLine99IsFalse;
    procedure FirstItemIsLine1;
    procedure LastItemIsLine5;
    procedure FromArrayWithClearAdd4Items;
    procedure FromTListAdd123Items;
    procedure ChangeItemByIndex1ReturnExistLine2False;
    procedure ClearOfInitialReturnCount0;
    procedure Item0IsLine1;
    procedure Item99RaiseError;
    procedure ChangeItemByIndex99RaiseError;
  end;

implementation

procedure TListTest.ItemByIndex2IsLine3;
begin
  CheckEquals('Line3', _List.ItemByIndex(2));
end;

procedure TListTest.AddTwoItemsReturnCount7;
begin
  _List.Add('TestIndex1');
  _List.Add('TestIndex2');
  CheckEquals(7, _List.Count);
end;

procedure TListTest.RemoveLine2ReturnCount4;
begin
  _List.Remove('Line2');
  CheckEquals(4, _List.Count);
end;

procedure TListTest.IsEmptyWithInitialIsFalse;
begin
  CheckFalse(_List.IsEmpty);
end;

procedure TListTest.IsEmptyWithClearIsTrue;
begin
  _List.Clear;
  CheckTrue(_List.IsEmpty);
end;

procedure TListTest.CountOfInitialIs5;
begin
  CheckEquals(5, _List.Count);
end;

procedure TListTest.IndexOfLine4Is3;
begin
  CheckEquals(3, _List.IndexOf('Line4'));
end;

procedure TListTest.ExistsLine2IsTrue;
begin
  CheckTrue(_List.Exists('Line2'));
end;

procedure TListTest.ExistsLine99IsFalse;
begin
  CheckFalse(_List.Exists('Line99'));
end;

procedure TListTest.FirstItemIsLine1;
begin
  CheckEquals('Line1', _List.First);
end;

procedure TListTest.LastItemIsLine5;
begin
  CheckEquals('Line5', _List.Last);
end;

procedure TListTest.FromArrayWithClearAdd4Items;
begin
  _List.Clear;
  _List.FromArray(['a', 'b', 'c', 'd']);
  CheckEquals(4, _List.Count);
  CheckTrue(_List.Exists('a'));
  CheckTrue(_List.Exists('b'));
  CheckTrue(_List.Exists('c'));
  CheckTrue(_List.Exists('d'));
end;

procedure TListTest.FromTListAdd123Items;
var
  GenericList: TNativeGenericList<String>;
begin
  GenericList := TNativeGenericList<String>.Create;
  try
    GenericList.Add('1');
    GenericList.Add('2');
    GenericList.Add('3');
    _List.Clear;
    _List.FromTList(GenericList);
    CheckEquals(3, _List.Count);
    CheckTrue(_List.Exists('1'));
    CheckTrue(_List.Exists('2'));
    CheckTrue(_List.Exists('3'));
  finally
    GenericList.Free;
  end;
end;

procedure TListTest.ClearOfInitialReturnCount0;
begin
  _List.Clear;
  CheckEquals(0, _List.Count);
end;

procedure TListTest.ChangeItemByIndex1ReturnExistLine2False;
begin
  _List.ChangeItemByIndex(1, 'NewLine');
  CheckFalse(_List.Exists('Line2'));
end;

procedure TListTest.Item0IsLine1;
begin
  CheckEquals('Line1', _List.Items[0]);
end;

procedure TListTest.Item99RaiseError;
var
  Failed: Boolean;
begin
  Failed := False;
  try
    CheckEquals('Line99', _List.Items[99]);
  except
    on E: EList do
    begin
      CheckEquals('Invalid index', E.Message);
      Failed := True;
    end;
  end;
  CheckTrue(Failed);
end;

procedure TListTest.ChangeItemByIndex99RaiseError;
var
  Failed: Boolean;
begin
  Failed := False;
  try
    _List.ChangeItemByIndex(99, 'a');
  except
    on E: EList do
    begin
      CheckEquals('Invalid index', E.Message);
      Failed := True;
    end;
  end;
  CheckTrue(Failed);
end;

procedure TListTest.SetUp;
begin
  inherited;
  _List := TListGeneric<String>.New;
  _List.Add('Line1');
  _List.Add('Line2');
  _List.Add('Line3');
  _List.Add('Line4');
  _List.Add('Line5');
end;

initialization

RegisterTest(TListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
