unit Attribute;

interface

uses
  SysUtils, StrUtils,
  Generics.Collections;

type
  IAttribute = interface
    ['{07D701CF-944B-45F8-A755-12D5C3735C29}']
    function Key: String;
    function Value: String;
  end;

  TAttribute = class sealed(TInterfacedObject, IAttribute)
  strict private
    _Key, _Value: String;
  public
    function Key: String;
    function Value: String;
    constructor Create(const Key, Value: String);
    class function New(const Key, Value: String): IAttribute;
    class function NewByText(const Text: String; const Separator: Char): IAttribute;
  end;

  TAttributeList = class sealed(TList<IAttribute>)
  private
    procedure ParseContent(const Content: String; const ItemSeparator, ValueSeparator: Char);
  public
    function ItemByKey(const Key: String): IAttribute;
    function IsEmpty: Boolean;
    class function New: TAttributeList;
    class function NewByContent(const Content: String; const ItemSeparator, ValueSeparator: Char): TAttributeList;
  end;

implementation

{ TAttribute }

function TAttribute.Key: String;
begin
  Result := _Key;
end;

function TAttribute.Value: String;
begin
  Result := _Value;
end;

constructor TAttribute.Create(const Key, Value: String);
begin
  _Key := Key;
  _Value := Value;
end;

class function TAttribute.New(const Key, Value: String): IAttribute;
begin
  Result := TAttribute.Create(Key, Value);
end;

class function TAttribute.NewByText(const Text: String; const Separator: Char): IAttribute;
var
  Key, Value: String;
  SeparatorPos: Integer;
begin
  SeparatorPos := Pos(Separator, Text);
  Key := Copy(Text, 1, Pred(SeparatorPos));
  Value := Copy(Text, Succ(SeparatorPos));
  Result := TAttribute.Create(Key, Value);
end;

{ TAttributeList }

function TAttributeList.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

function TAttributeList.ItemByKey(const Key: String): IAttribute;
var
  Item: IAttribute;
begin
  Result := nil;
  for Item in Self do
    if SameText(Key, Item.Key) then
      Exit(Item);
end;

procedure TAttributeList.ParseContent(const Content: String; const ItemSeparator, ValueSeparator: Char);
Var
  SeparatorPos, PosOffset: Integer;
  Text: String;
begin
  PosOffset := 1;
  repeat
    SeparatorPos := PosEx(ItemSeparator, Content, PosOffset);
    if SeparatorPos > 0 then
    begin
      Text := Copy(Content, PosOffset, SeparatorPos - PosOffset);
      if Length(Text) > 0 then
        Add(TAttribute.NewByText(Text, ValueSeparator));
      PosOffset := Succ(SeparatorPos);
    end;
  until SeparatorPos < 1;
  Text := Copy(Content, PosOffset, Succ(Length(Content) - PosOffset));
  if Length(Text) > 0 then
    Add(TAttribute.NewByText(Text, ValueSeparator));
end;

class function TAttributeList.New: TAttributeList;
begin
  Result := TAttributeList.Create;
end;

class function TAttributeList.NewByContent(const Content: String; const ItemSeparator, ValueSeparator: Char)
  : TAttributeList;
begin
  Result := TAttributeList.Create;
  Result.ParseContent(Content, ItemSeparator, ValueSeparator);
end;

end.
