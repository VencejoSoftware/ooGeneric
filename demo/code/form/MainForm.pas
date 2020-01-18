{
  Copyright (c) 2020 Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  FilterableList;

type
  TMainForm = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    List: IFilterableList<String>;
    procedure UpdateList;
    function FilterCondition(const Item: String): Boolean;
  end;

var
  NewMainForm: TMainForm;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

function TMainForm.FilterCondition(const Item: String): Boolean;
begin
  Result := (Edit1.Text = EmptyStr) or (Pos(UpperCase(Edit1.Text), UpperCase(Item)) > 0);
end;

procedure TMainForm.UpdateList;
var
  Item: String;
begin
  Memo1.Clear;
  for Item in List.{$IFDEF FPC}FilterOfObjec{$ELSE}Filter{$ENDIF}(FilterCondition) do
    Memo1.Lines.Add(Item);
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
  UpdateList;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  List := TFilterableList<String>.New;
  List.Add('A');
  List.Add('Words');
  List.Add('B');
  List.Add('Word');
  List.Add('C');
  List.Add('word');
  List.Add('D');
  List.Add('World');
  List.Add('E');
  List.Add('Text of worlds');
  UpdateList;
end;

end.
