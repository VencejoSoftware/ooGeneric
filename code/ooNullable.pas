{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooNullable;

interface

uses
  SysUtils, Classes,
  Generics.Defaults,
  Generics.Collections,
{$IFDEF FPC}
  TypInfo
{$ELSE}
  RTTI
{$ENDIF};

type
  TValueState = (vsEmpty, vsSetted);
  TValueType = (vtUnknown, vtString, vtInteger, vtBoolean, vtDateTime, vtExtended);

  TNullable<T> = record
  strict private
    _Value: T;
    _State: TValueState;
  private
    function IsString: Boolean;
    function IsInteger: Boolean;
    function IsBoolean: Boolean;
    function IsExtended: Boolean;
    function IsDateTime: Boolean;
  public
    function IsEmpty: Boolean;
    function ValueType: TValueType;
{$IFNDEF FPC}
    function ToType<T1>: T1;
{$ENDIF}

    procedure Clear;

    class operator NotEqual(ValueOne, ValueTwo: TNullable<T>): Boolean; inline;
    class operator Equal(ValueOne, ValueTwo: TNullable<T>): Boolean; inline;
    class operator GreaterThan(ValueOne, ValueTwo: TNullable<T>): Boolean; inline;
    class operator GreaterThanOrEqual(ValueOne, ValueTwo: TNullable<T>): Boolean; inline;
    class operator LessThan(ValueOne, ValueTwo: TNullable<T>): Boolean; inline;
    class operator LessThanOrEqual(ValueOne, ValueTwo: TNullable<T>): Boolean; inline;
    class operator Implicit(Value: TNullable<T>): T; inline;
    class operator Implicit(Value: T): TNullable<T>; inline;
    class operator Explicit(Value: TNullable<T>): T; inline;
    class operator Explicit(Value: T): TNullable<T>; inline;

    class function Null: TNullable<T>; static;

    property Value: T read _Value;
  end;

  TNullableString = TNullable<String>;
  TNullableInteger = TNullable<Integer>;
  TNullableDouble = TNullable<Double>;
  TNullableDate = TNullable<TDateTime>;
  TNullableBoolean = TNullable<Boolean>;

implementation

class operator TNullable<T>.NotEqual(ValueOne, ValueTwo: TNullable<T>): Boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  Result := not (ValueOne.IsEmpty and ValueTwo.IsEmpty);
  if not Result then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := not Comparer.Equals(ValueOne, ValueTwo);
  end;
end;

class operator TNullable<T>.Equal(ValueOne, ValueTwo: TNullable<T>): Boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  Result := ValueOne.IsEmpty and ValueTwo.IsEmpty;
  if not Result then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := Comparer.Equals(ValueOne, ValueTwo);
  end;
end;

class operator TNullable<T>.Explicit(Value: T): TNullable<T>;
begin
  Result._Value := Value;
  Result._State := vsSetted;
end;

class operator TNullable<T>.Explicit(Value: TNullable<T>): T;
begin
  Result := Value._Value;
end;

class operator TNullable<T>.GreaterThan(ValueOne, ValueTwo: TNullable<T>): Boolean;
var
  Comparer: IComparer<T>;
begin
  Comparer := TComparer<T>.Default;
  Result := Comparer.Compare(ValueOne, ValueTwo) = 1;
end;

class operator TNullable<T>.GreaterThanOrEqual(ValueOne, ValueTwo: TNullable<T>): Boolean;
var
  Comparer: IComparer<T>;
begin
  Comparer := TComparer<T>.Default;
  Result := Comparer.Compare(ValueOne, ValueTwo) in [0, 1];
end;

class operator TNullable<T>.LessThan(ValueOne, ValueTwo: TNullable<T>): Boolean;
var
  Comparer: IComparer<T>;
begin
  Comparer := TComparer<T>.Default;
  Result := Comparer.Compare(ValueOne, ValueTwo) = - 1;
end;

class operator TNullable<T>.LessThanOrEqual(ValueOne, ValueTwo: TNullable<T>): Boolean;
var
  Comparer: IComparer<T>;
begin
  Comparer := TComparer<T>.Default;
  case Comparer.Compare(ValueOne, ValueTwo) of
    - 1, 0:
      Result := True;
    else
      Result := False;
  end;
end;

class operator TNullable<T>.Implicit(Value: TNullable<T>): T;
begin
  Result := Value._Value;
end;

class operator TNullable<T>.Implicit(Value: T): TNullable<T>;
begin
  Result._State := vsSetted;
  Result._Value := Value;
end;

procedure TNullable<T>.Clear;
begin
  Self := TNullable<T>.Null;
end;

function TNullable<T>.IsEmpty: Boolean;
begin
  Result := (_State <> vsSetted);
end;

class function TNullable<T>.Null: TNullable<T>;
begin
  Result := default (T);
  Result._State := vsEmpty;
end;

{$IFNDEF FPC}
function TNullable<T>.ToType<T1>: T1;
var
  utTemp: TValue;
begin
  utTemp := TValue.From<T>(_Value);
  Result := utTemp.AsType<T1>;
end;
{$ENDIF}

function TNullable<T>.IsString: Boolean;
begin
  Result := (TypeInfo(T) = TypeInfo(string)) or (TypeInfo(T) = TypeInfo(char)) or (TypeInfo(T) = TypeInfo(WideChar)) or
    (TypeInfo(T) = TypeInfo(AnsiChar)) or (TypeInfo(T) = TypeInfo(ShortString)) or (TypeInfo(T) = TypeInfo(WideString))
    or (TypeInfo(T) = TypeInfo(AnsiString));
end;

function TNullable<T>.IsInteger: Boolean;
begin
  Result := (TypeInfo(T) = TypeInfo(Integer)) or (TypeInfo(T) = TypeInfo(SmallInt)) or (TypeInfo(T) = TypeInfo(Byte)) or
    (TypeInfo(T) = TypeInfo(shortint)) or (TypeInfo(T) = TypeInfo(LongInt)) or (TypeInfo(T) = TypeInfo(Word)) or
    (TypeInfo(T) = TypeInfo(Cardinal)) or (TypeInfo(T) = TypeInfo(LongWord)) or (TypeInfo(T) = TypeInfo(Int64));
end;

function TNullable<T>.IsBoolean: Boolean;
begin
  Result := TypeInfo(T) = TypeInfo(Boolean);
end;

function TNullable<T>.IsExtended: Boolean;
begin
  Result := (TypeInfo(T) = TypeInfo(Extended)) or (TypeInfo(T) = TypeInfo(Currency)) or (TypeInfo(T) = TypeInfo(Double))
    or (TypeInfo(T) = TypeInfo(Single));
end;

function TNullable<T>.IsDateTime: Boolean;
begin
  Result := (TypeInfo(T) = TypeInfo(TDateTime)) or (TypeInfo(T) = TypeInfo(TDate)) or (TypeInfo(T) = TypeInfo(TTime));
end;

function TNullable<T>.ValueType: TValueType;
begin
  if IsString then
    Result := vtString
  else
    if IsInteger then
      Result := vtInteger
    else
      if IsBoolean then
        Result := vtBoolean
      else
        if IsExtended then
          Result := vtExtended
        else
          if IsDateTime then
            Result := vtDateTime
          else
            Result := vtUnknown;
end;

end.
