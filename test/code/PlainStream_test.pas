{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit PlainStream_test;

interface

uses
  Classes, SysUtils,
  PlainStream,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TPlainStreamTest = class sealed(TTestCase)
  published
    procedure DecodeIsLine1Line2Line3Finish;
  end;

implementation

procedure TPlainStreamTest.DecodeIsLine1Line2Line3Finish;
var
  StringList: TStringList;
  Stream: TStream;
begin
  StringList := TStringList.Create;
  try
    StringList.Append('Line1');
    StringList.Append('Line2');
    StringList.Append('Line3 Finish');
    Stream := TMemoryStream.Create;
    try
      StringList.SaveToStream(Stream);
      CheckEquals('Line1'#13#10'Line2'#13#10'Line3 Finish'#13#10, TPlainStream.New.Decode(Stream));
    finally
      Stream.Free;
    end;
  finally
    StringList.Free;
  end;
end;

initialization

RegisterTests([TPlainStreamTest {$IFNDEF FPC}.Suite {$ENDIF}]);

end.
