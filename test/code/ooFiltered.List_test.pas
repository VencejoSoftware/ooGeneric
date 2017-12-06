{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFiltered.List_test;

interface

uses
  SysUtils,
  Generics.Collections,
  ooFiltered.List,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFilteredListTest = class(TTestCase)
  private
    _List: TList<String>;
    function OddCriteria(const List: TList<String>; const Item: String; const Index: Integer): Boolean;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure AllItemsStartingWithA;
    procedure OnlyOddItems;
  end;

implementation

procedure TFilteredListTest.AllItemsStartingWithA;
var
  Item: String;
  ItemCount: Integer;
begin
  ItemCount := 0;
  for Item in TFilteredList<String>.New(_List, //
    function(const List: TList<String>; const Item: String; const Index: Integer): Boolean
    begin
      Result := Item[1] = 'a';
    end) do
    Inc(ItemCount);
  CheckEquals(3, ItemCount);
end;

function TFilteredListTest.OddCriteria(const List: TList<String>; const Item: String; const Index: Integer): Boolean;
begin
  Result := Odd(Index);
end;

procedure TFilteredListTest.OnlyOddItems;
var
  Item: String;
begin
  for Item in TFilteredList<String>.New(_List, OddCriteria) do
    CheckTrue((Item = 'cab') or (Item = 'b') or (Item = 'ABC'));
end;

procedure TFilteredListTest.SetUp;
begin
  inherited;
  _List := TList<String>.Create;
  _List.Add('abc');
  _List.Add('cab');
  _List.Add('a');
  _List.Add('b');
  _List.Add('abD');
  _List.Add('ABC');
  _List.Add('bac');
end;

procedure TFilteredListTest.TearDown;
begin
  inherited;
  _List.Free;
end;

initialization

RegisterTest(TFilteredListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
