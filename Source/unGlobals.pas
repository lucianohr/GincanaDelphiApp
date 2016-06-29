unit unGlobals;

interface

const
  APP_ID = 'C5B7B5E3-5AEA-4589-AF35-77C5629F806B';

function HashMD5(source: string): string;

implementation

uses
  System.SysUtils, IdGlobal, IdHash, IdHashMessageDigest;

function HashMD5(source: string): string;
var
  md5: TIdHashMessageDigest5;
begin
  md5 := TIdHashMessageDigest5.Create;
  try
    Result := md5.HashStringAsHex(source);
  finally
    FreeAndNil(md5);
  end;
end;

end.
