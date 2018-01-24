{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Enumerator object
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEnumerator;

interface

type
{$REGION 'documentation'}
{
  @abstract(Interface for list enumerator)
  @member(
    GetCurrent Return current item list
    @return(Item value)
  )
  @member(
    MoveNext Increase position index
    @return(@true if is not the last item, @false if es EOL)
  )
  @member(Reset Reset the index position)
  @member(Current Property to return current item)
}
{$ENDREGION}
  IEnumerator<T> = interface
    ['{FE1693FD-015C-4F18-B000-588D1EC1B641}']
    function GetCurrent: T;
    function MoveNext: Boolean;
    procedure Reset;
    property Current: T read GetCurrent;
  end;

{$REGION 'documentation'}
{
  @abstract(Interface of enumerable object)
  @member(
    GetEnumerator Makes a enumerator for object
    @return(Enumerator object)
  )
  @member(Current Property to return enumerator)
}
{$ENDREGION}

  IEnumerable<T> = interface
    ['{5E8253A9-345B-4438-92D7-4BC260739CAC}']
    function GetEnumerator: IEnumerator<T>;
    property Enumerator: IEnumerator<T> read GetEnumerator;
  end;

{$REGION 'documentation'}
// @abstract(String enumerator pre declaration)
{$ENDREGION}

  IStringEnumerator = IEnumerator<String>;

{$REGION 'documentation'}
// @abstract(String enumerable object declaration)
{$ENDREGION}
  IStringEnumerable = IEnumerable<String>;

implementation

end.
