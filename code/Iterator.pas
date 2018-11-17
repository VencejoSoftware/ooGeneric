{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Items iterator definition
  @created(14/08/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit Iterator;

interface

type
{$REGION 'documentation'}
{
  @abstract(Interface for items iterator)
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
  IIterator<T> = interface
    ['{FE1693FD-015C-4F18-B000-588D1EC1B641}']
    function GetCurrent: T;
    function MoveNext: Boolean;
    procedure Reset;
    property Current: T read GetCurrent;
  end;

{$REGION 'documentation'}
{
  @abstract(Interface of iterable object)
  @member(
    GetEnumerator Return a @link(IIterator iterator object)
    @return(Iterator object)
  )
  @member(Current Property to return iterator)
}
{$ENDREGION}

  IIterable<T> = interface
    ['{5E8253A9-345B-4438-92D7-4BC260739CAC}']
    function GetEnumerator: IIterator<T>;
    property Iterator: IIterator<T> read GetEnumerator;
  end;

{$REGION 'documentation'}
// @abstract(String iterator pre declaration)
{$ENDREGION}

  IStringEnumerator = IIterator<String>;

{$REGION 'documentation'}
// @abstract(String enumerable object declaration)
{$ENDREGION}
  IStringEnumerable = IIterable<String>;

implementation

end.
