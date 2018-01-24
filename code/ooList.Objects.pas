{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic list of objects
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooList.Objects;

interface

uses
  SysUtils, TypInfo,
{$IFNDEF FPC}{$IF CompilerVersion > 21}
  RTTI,
{$ENDIF}{$ENDIF}
  ooList.Filtrable;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(TListFiltrable))
  @member(
    IsTypeOfObject Checks if the generic type if a class
    @return(@true if generic = Class object, @false if not)
  )
  @member(
    FreeGenericItem Destroy item object
    @param(Item object)
  )
  @member(FreeObjects Destroy all items in list)
  @member(Clear Override clear method to destroy all objects if need)
  @member(
    Create Object constructor
    @param(DestroyItems If setted to @true the list objects is owner of all items and autodestroy)
    @param(UseReferenceCount Use list in interface mode)
  )
}
{$ENDREGION}
  TListObjects<T> = class(TListFiltrable<T>)
  strict private
    _DestroyItems: Boolean;
  private
    function IsClassObject: Boolean;
{$IFNDEF FPC}{$IF CompilerVersion > 21}
    procedure FreeGenericItem(Some: T);
{$ENDIF}{$ENDIF}
    procedure FreeObjects;
  public
    procedure Clear; override;
    constructor Create(const DestroyItems, UseReferenceCount: Boolean); reintroduce; virtual;
  end;

implementation

{$IFNDEF FPC}{$IF CompilerVersion > 21}

procedure TListObjects<T>.FreeGenericItem(Some: T);
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
{$ENDIF}{$ENDIF}

procedure TListObjects<T>.FreeObjects;
var
  i: Integer;
  ObjectItem: TObject;
begin
  if IsEmpty then
    Exit;
  for i := 0 to Pred(Count) do
  begin
{$IFNDEF FPC}{$IF CompilerVersion > 21}
    FreeGenericItem(Items[i])
{$ELSE}
    ObjectItem := TObject(Items[i]);
    FreeAndNil(ObjectItem);
{$ENDIF}{$ENDIF}
  end;
end;

function TListObjects<T>.IsClassObject: Boolean;
begin
  Result := (PTypeInfo(TypeInfo(T)).Kind = tkClass);
end;

procedure TListObjects<T>.Clear;
begin
  if _DestroyItems and IsClassObject then
    FreeObjects;
  inherited;
end;

constructor TListObjects<T>.Create(const DestroyItems, UseReferenceCount: Boolean);
begin
  inherited Create(UseReferenceCount);
  _DestroyItems := DestroyItems;
end;

end.
