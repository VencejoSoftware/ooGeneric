{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Objects;

interface

uses
  SysUtils, TypInfo,
{$IFNDEF FPC}{$IF CompilerVersion > 21}
  RTTI,
{$IFEND}{$IFEND}
  ooList.Filtrable;

type
  TListObjects<T> = class(TListFiltrable<T>)
  strict private
    _DestroyItems: Boolean;
  private
    function IsTypeOfObject: Boolean;
{$IFNDEF FPC}{$IF CompilerVersion > 21}
    procedure FreeGeneric(Some: T);
{$IFEND}{$IFEND}
    procedure FreeObjects;
  public
    procedure Clear; override;
    constructor Create(const DestroyItems, UseReferenceCount: Boolean); reintroduce; virtual;
    class function New(const DestroyItems, UseReferenceCount: Boolean): IGenericListFiltrable<T>;
  end;

implementation

{$IFNDEF FPC}{$IF CompilerVersion > 21}
procedure TListObjects<T>.FreeGeneric(Some: T);
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  FreeMethod: TRttiMethod;
begin
  if not (PTypeInfo(TypeInfo(T)).Kind = tkClass) then
    Exit;
  RttiContext := TRttiContext.Create;
  RttiType := RttiContext.GetType(TypeInfo(T));
  FreeMethod := RttiType.GetMethod('Free');
  if (FreeMethod <> nil) then
    FreeMethod.Invoke(TValue.From<T>(Some), []);
end;
{$IFEND}{$IFEND}

procedure TListObjects<T>.FreeObjects;
var
  i: Integer;
  ObjectItem: TObject;
begin
  for i := 0 to Pred(Count) do
  begin
{$IFNDEF FPC}{$IF CompilerVersion > 21}
    FreeGeneric(Items[i])
{$ELSE}
    ObjectItem := TObject(Items[i]);
    FreeAndNil(ObjectItem);
{$IFEND}{$IFEND}
  end;
end;

function TListObjects<T>.IsTypeOfObject: Boolean;
begin
  Result := (PTypeInfo(TypeInfo(T)).Kind = tkClass);
end;

procedure TListObjects<T>.Clear;
begin
  if _DestroyItems and IsTypeOfObject then
    FreeObjects;
  inherited;
end;

constructor TListObjects<T>.Create(const DestroyItems, UseReferenceCount: Boolean);
begin
  inherited Create(UseReferenceCount);
  _DestroyItems := DestroyItems;
end;

class function TListObjects<T>.New(const DestroyItems, UseReferenceCount: Boolean): IGenericListFiltrable<T>;
begin
  Result := Create(DestroyItems, UseReferenceCount);
end;

end.
