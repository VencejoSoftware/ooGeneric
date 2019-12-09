{$REGION 'documentation'}
{
  Copyright (c) 2019, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Simple attribute object
  @created(21/11/2019)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit Attribute;

interface

uses
  SysUtils, StrUtils,
  IterableList;

type
{$REGION 'documentation'}
{
  @abstract(Interface of attribute object)
  @member(Key Attribute identifier)
  @member(Value Attribute content value)
}
{$ENDREGION}
  IAttribute = interface
    ['{07D701CF-944B-45F8-A755-12D5C3735C29}']
    function Key: String;
    function Value: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IAttribute))
  @member(Key @seealso(IAttribute.Key))
  @member(Value @seealso(IAttribute.Value))
  @member(
    Create Object constructor
    @param(Key Attribute identifier)
    @param(Value Attribute content value)
  )
  @member(
    New Create a new @classname as interface
    @param(Key Attribute identifier)
    @param(Value Attribute content value)
  )
}
{$ENDREGION}

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

{$REGION 'documentation'}
{
  @abstract(Interface of attribute list object)
  @member(ItemByKey Find item by his key
  @param(Key Key identifier)
  @return(@link(IAttribute Attribute object) if its exists, nil if not)
}
{$ENDREGION}

  IAttributeList = interface(IIterableList<IAttribute>)
    ['{EBF63EAA-266F-47D0-8355-4D47DB974A0A}']
    function ItemByKey(const Key: String): IAttribute;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IAttributeList))
  @member(ItemByKey @seealso(IAttributeList.ItemByKey))
  @member(
    Create Object constructor
  )
  @member(
    New Create a new @classname as interface
  )
  @member(
    NewByContent Create a new @classname as interface parsing a content string
    @param(Content Content string)
    @param(ItemSeparator Item character separator)
    @param(ValueSeparator Item value/assign character separator)
  )
}
{$ENDREGION}

  TAttributeList = class sealed(TIterableList<IAttribute>, IAttributeList)
  private
    procedure ParseContent(const Content: String; const ItemSeparator, ValueSeparator: Char);
  public
    function ItemByKey(const Key: String): IAttribute;
    class function New: TAttributeList;
    class function NewByContent(const Content: String; const ItemSeparator, ValueSeparator: Char): IAttributeList;
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
  : IAttributeList;
begin
  Result := TAttributeList.New;
  (Result as TAttributeList).ParseContent(Content, ItemSeparator, ValueSeparator);
end;

end.
