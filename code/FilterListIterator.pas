{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Iterator with filter condition for generic lists
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit FilterListIterator;

interface

uses
  Iterator,
  ListIterator,
  List;

type
{$REGION 'documentation'}
{
  @abstract(Callback to evaluate filter condition)
  @param(Item Value item)
  @return(@true if can use item, @false if item was filtered)
}
{$ENDREGION}
{$IFDEF FPC}
  TConditionCallback<T> = function(const Item: T): boolean;
  TConditionCallbackOfObject<T> = function(const Item: T): boolean of object;
{$ELSE}
  TConditionCallback<T> = reference to function(const Item: T): boolean;
{$ENDIF}
{$REGION 'documentation'}
{
  @abstract(Interface for iterator with filter condition for generic lists)
  @member(
    GetEnumerator Return a items iterator
  )
  @member(
    IsValidItem Execute the condition callback to validate or filter item
    @param(Item Value item)
    @return(@true if can use item, @false if item was filtered)
  )
}
{$ENDREGION}

  IFilterListIterator<T> = interface(IIterator<T>)
    ['{BE08A393-0574-4437-9046-FA3EE0C350F8}']
    function GetEnumerator: IIterator<T>;
    function IsValidItem(const Item: T): boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IFilterListIterator))
  @member(GetEnumerator @seealso(IFilterListIterator.GetEnumerator))
  @member(IsValidItem @seealso(IFilterListIterator.IsValidItem))
  @member(
    MoveNext Override MoveNext to use condition callback
  )
  @member(
    Create Object constructor
    @param(List Generic list to iterate)
    @param(Condition Condition callback to evaluate item)
  )
  @member(
    New Create a new @classname as interface
    @param(List Generic list to iterate)
    @param(Condition Condition callback to evaluate item)
  )
}
{$ENDREGION}

  TFilterListIterator<T> = class sealed(TInterfacedObject, IFilterListIterator<T>, IIterator<T>)
  strict private
    _ConditionCallback: TConditionCallback<T>;
{$IFDEF FPC}
    _ConditionCallbackOfObject: TConditionCallbackOfObject<T>;
{$ENDIF}
    _Iterator: IIterator<T>;
  public
    function MoveNext: boolean;
    function GetCurrent: T;
    procedure Reset;
    function IsValidItem(const Item: T): boolean;
    function GetEnumerator: IIterator<T>;
    property Current: T read GetCurrent;
    constructor Create(const List: IList<T>; const Condition: TConditionCallback<T>
{$IFDEF FPC}
      ; const ConditionCallbackOfObject: TConditionCallbackOfObject<T>
{$ENDIF});
    class function New(const List: IList<T>; const Condition: TConditionCallback<T>): IFilterListIterator<T>;
{$IFDEF FPC}
    class function NewOfObjec(const List: IList<T>; const Condition: TConditionCallbackOfObject<T>)
      : IFilterListIterator<T>;
{$ENDIF}
  end;

implementation

function TFilterListIterator<T>.MoveNext: boolean;
begin
  Result := False;
  while _Iterator.MoveNext do
    if IsValidItem(Current) then
      Exit(True);
end;

function TFilterListIterator<T>.GetCurrent: T;
begin
  Result := _Iterator.Current;
end;

procedure TFilterListIterator<T>.Reset;
begin
  _Iterator.Reset;
end;

function TFilterListIterator<T>.IsValidItem(const Item: T): boolean;
begin
  if Assigned(_ConditionCallback) then
    Result := _ConditionCallback(Item)
{$IFDEF FPC}
  else
    if Assigned(_ConditionCallbackOfObject) then
      Result := _ConditionCallbackOfObject(Item)
{$ENDIF}
    else
      Result := False;
end;

function TFilterListIterator<T>.GetEnumerator: IIterator<T>;
begin
  Result := Self;
end;

constructor TFilterListIterator<T>.Create(const List: IList<T>; const Condition: TConditionCallback<T>
{$IFDEF FPC}
  ; const ConditionCallbackOfObject: TConditionCallbackOfObject<T>
{$ENDIF});
begin
  inherited Create;
  _Iterator := TListIterator<T>.New(List);
  _ConditionCallback := Condition;
{$IFDEF FPC}
  _ConditionCallbackOfObject := ConditionCallbackOfObject;
{$ENDIF}
end;

class function TFilterListIterator<T>.New(const List: IList<T>; const Condition: TConditionCallback<T>)
  : IFilterListIterator<T>;
begin
  Result := TFilterListIterator<T>.Create(List, Condition{$IFDEF FPC}, nil{$ENDIF});
end;

{$IFDEF FPC}

class function TFilterListIterator<T>.NewOfObjec(const List: IList<T>; const Condition: TConditionCallbackOfObject<T>)
  : IFilterListIterator<T>;
begin
  Result := TFilterListIterator<T>.Create(List, nil, Condition);
end;
{$ENDIF}

end.
