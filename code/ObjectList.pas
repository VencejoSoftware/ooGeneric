{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Generic list of objects
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ObjectList;

interface

{$IFNDEF FPC}
{$IF CompilerVersion > 21}{$DEFINE FreeWithRTTI}{$IFEND}
{$ENDIF}

uses
  SysUtils, TypInfo,
{$IFDEF FreeWithRTTI}
  RTTI,
{$ENDIF}
  FilterableList;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(TFilterableList))
  Generic list with autodestroy items capabilities
  @member(
    IsObject Checks if the generic type if a class
    @return(@true if generic = Class object, @false if not)
  )
  @member(
    FreeGenericItem Destroy object based in RTTI
    @param(Item object)
  )
  @member(FreeObjects Destroy all items in list)
  @member(Clear Override clear method to destroy all objects if need)
  @member(
    Create Object constructor
    @param(DestroyItems If setted to @true the list objects is owner of all items and destroy them)
  )
}
{$ENDREGION}
  TObjectList<T> = class(TFilterableList<T>)
  strict private
    _DestroyItems: Boolean;
  private
    function IsObject: Boolean;
{$IFDEF FreeWithRTTI}
    procedure FreeGenericItem(Item: T);
{$ENDIF}
    procedure FreeObjects;
  public
    procedure Clear; override;
    constructor Create(const DestroyItems: Boolean); reintroduce; virtual;
  end;

implementation

{$IFDEF FreeWithRTTI}

procedure TObjectList<T>.FreeGenericItem(Item: T);
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
    FreeMethod.Invoke(TValue.From<T>(Item), []);
end;
{$ENDIF}

procedure TObjectList<T>.FreeObjects;
var
  i: Integer;
  ObjectItem: TObject;
begin
  if not IsEmpty then
    for i := Pred(Count) downto 0 do
    begin
{$IFDEF FreeWithRTTI}
      FreeGenericItem(Items[i])
{$ELSE}
      ObjectItem := TObject(Items[i]);
      FreeAndNil(ObjectItem);
{$ENDIF}
    end;
end;

function TObjectList<T>.IsObject: Boolean;
begin
  Result := (PTypeInfo(TypeInfo(T)).Kind = tkClass);
end;

procedure TObjectList<T>.Clear;
begin
  if _DestroyItems and IsObject then
    FreeObjects;
  inherited;
end;

constructor TObjectList<T>.Create(const DestroyItems: Boolean);
begin
  inherited Create;
  _DestroyItems := DestroyItems;
end;

end.
