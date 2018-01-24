{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Enumerator object for generic list
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooList.Enumerator;

interface

uses
  ooList,
  ooEnumerator;

type
{$REGION 'documentation'}
{
  @abstract(Interface for enumerator of generic lists)
  @member(
    GetList Return the list to enumerate
    @return(Generic list)
  )
}
{$ENDREGION}
  IGenericListEnumerator<T> = interface(IEnumerator<T>)
    ['{B6075068-EE19-493E-AC79-75F6ED1872EB}']
    function GetList: IGenericList<T>;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IGenericListEnumerator))
  @member(GetList @seealso(IGenericListEnumerator.GetList))
  @member(MoveNext @seealso(IEnumerator.MoveNext))
  @member(GetCurrent @seealso(IEnumerator.GetCurrent))
  @member(Reset @seealso(IEnumerator.Reset))
  @member(Current @seealso(IEnumerator.Current))
  @member(
    Create Object constructor
    @param(List List to enumerate)
  )
}
{$ENDREGION}

  TListEnumerator<T> = class(TInterfacedObject, IGenericListEnumerator<T>)
  strict private
    _Reseted: Boolean;
    _CurrentIndex: TIntegerIndex;
    _List: IGenericList<T>;
  public
    function GetList: IGenericList<T>;
    function MoveNext: Boolean; virtual;
    function GetCurrent: T;
    procedure Reset;
    constructor Create(const List: IGenericList<T>); virtual;
    property Current: T read GetCurrent;
  end;

implementation

function TListEnumerator<T>.GetList: IGenericList<T>;
begin
  Result := _List;
end;

function TListEnumerator<T>.GetCurrent: T;
begin
  Result := GetList.ItemByIndex(_CurrentIndex);
end;

function TListEnumerator<T>.MoveNext: Boolean;
begin
  if _Reseted then
  begin
    _CurrentIndex := 0;
    _Reseted := False;
  end
  else
    Inc(_CurrentIndex);
  Result := _CurrentIndex < GetList.Count;
end;

procedure TListEnumerator<T>.Reset;
begin
  _Reseted := True;
end;

constructor TListEnumerator<T>.Create(const List: IGenericList<T>);
begin
  inherited Create;
  _Reseted := True;
  _List := List;
end;

end.
