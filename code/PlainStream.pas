{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Plain text from stream
  @created(19/12/2019)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit PlainStream;

interface

uses
  Classes, SysUtils;

type
{$REGION 'documentation'}
{
  @abstract(Plain text from stream)
  Tries to convert TStream to text, considering unicode o widestring encoding
  @member(
    Decode Decode stream to plain string
    @param(Stream Stream object to decode)
    @return(String with stream contents)
  )
}
{$ENDREGION}
  IPlainStream = interface
    ['{F7C6FBFD-796A-4BEC-8031-DD9536B78274}']
    function Decode(const Stream: TStream): String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IPlainStream))
  @member(IsUnicode Checks if Stream has unicode content)
  @member(
    AnsiStreamToText Convert stream ansi content to string
    @param(Stream Steam object)
    @returns(String with content)
  )
  @member(
    UnicodeStreamToText Convert stream unicode content to string
    @param(Stream Steam object)
    @returns(String with content)
  )
  @member(Decode @seealso(IPlainStream.Decode))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  TPlainStream = class sealed(TInterfacedObject, IPlainStream)
  strict private
  type
    TSOChar = {$IF (SizeOf(Char) = 1)} WideChar {$ELSE} Char {$IFEND};
  strict private
  const
    BUFFER_SIZE = 1024;
  private
    function IsUnicode(const Stream: TStream): Boolean;
    function AnsiStreamToText(const Stream: TStream): string;
    function UnicodeStreamToText(const Stream: TStream): string;
  public
    function Decode(const Stream: TStream): String;
    class function New: IPlainStream;
  end;

implementation

function TPlainStream.UnicodeStreamToText(const Stream: TStream): string;
var
  BufferChar: array [0 .. BUFFER_SIZE - 1] of TSOChar;
  ReadCount: Integer;
begin
  Result := EmptyStr;
  ReadCount := Stream.Read(BufferChar, BUFFER_SIZE * SizeOf(TSOChar)) div SizeOf(TSOChar);
  while ReadCount > 0 do
  begin
    ReadCount := Stream.Read(BufferChar, BUFFER_SIZE * SizeOf(TSOChar)) div SizeOf(TSOChar);
    Result := Result + BufferChar;
  end;
end;

function TPlainStream.AnsiStreamToText(const Stream: TStream): string;
var
  BufferAnsi: array [0 .. BUFFER_SIZE - 1] of AnsiChar;
  BufferChar: array [0 .. BUFFER_SIZE - 1] of TSOChar;
  i, ReadCount: Integer;
begin
  Result := EmptyStr;
  Stream.Seek(0, soFromBeginning);
  ReadCount := Stream.Read(BufferAnsi, BUFFER_SIZE);
  while ReadCount > 0 do
  begin
    FillChar(BufferChar, BUFFER_SIZE, 0);
    for i := 0 to Pred(ReadCount) do
      BufferChar[i] := TSOChar(BufferAnsi[i]);
    ReadCount := Stream.Read(BufferAnsi, BUFFER_SIZE);
    Result := Result + BufferChar;
  end;
end;

function TPlainStream.IsUnicode(const Stream: TStream): Boolean;
var
  BOM: array [0 .. 1] of byte;
begin
  Result := (Stream.Read(BOM, SizeOf(BOM)) = 2) and (BOM[0] = $FF) and (BOM[1] = $FE);
end;

function TPlainStream.Decode(const Stream: TStream): String;
begin
  if IsUnicode(Stream) then
    Result := UnicodeStreamToText(Stream)
  else
    Result := AnsiStreamToText(Stream);
end;

class function TPlainStream.New: IPlainStream;
begin
  Result := TPlainStream.Create;
end;

end.
