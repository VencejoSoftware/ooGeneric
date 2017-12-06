{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooEnumerator;

interface

type
  IEnumerator<T> = interface
    ['{FE1693FD-015C-4F18-B000-588D1EC1B641}']
    function GetCurrent: T;
    function MoveNext: Boolean;
    procedure Reset;
    property Current: T read GetCurrent;
  end;

  IEnumerable<T> = interface
    ['{5E8253A9-345B-4438-92D7-4BC260739CAC}']
    function GetEnumerator: IEnumerator<T>;

    property Enumerator: IEnumerator<T>read GetEnumerator;
  end;

  IStringEnumerator = IEnumerator<String>;
  IStringEnumerable = IEnumerable<String>;

implementation

end.
