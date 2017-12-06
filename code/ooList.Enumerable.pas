{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Enumerable;

interface

uses
  ooList.Enumerator, ooList;

type
  IGenericListEnumerable<T> = interface(IGenericList<T>)
    ['{F9307C24-C39E-4D8F-868B-0C42CBC457D6}']
    function GetEnumerator: IGenericListEnumerator<T>;
  end;

  TListEnumerable<T> = class(TGenericList<T>, IGenericListEnumerable<T>)
  public
    function GetEnumerator: IGenericListEnumerator<T>;
  end;

implementation

function TListEnumerable<T>.GetEnumerator: IGenericListEnumerator<T>;
begin
  Result := TListEnumerator<T>.Create(Self);
end;

end.
