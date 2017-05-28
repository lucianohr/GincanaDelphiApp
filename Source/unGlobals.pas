unit unGlobals;

interface

const
  APP_ID = 'C5B7B5E3-5AEA-4589-AF35-77C5629F806B';

function HashMD5(source: string): string;
function GenerateUUID: string;
function GenerateSerial(clientId: string): string;
function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): string;
function GetComputerName: string;
function GetClientId: string;
function ValidateLicence: Byte;
procedure SaveSerialNumber(serial: string);

implementation

uses
  System.SysUtils, System.Classes, IdGlobal, IdHash, IdHashMessageDigest, ShlObj, Windows;

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

function GenerateUUID: string;
var
  Uid: TGuid;
  res: HResult;
begin
  res := CreateGuid(Uid);
  if res = S_OK then
  begin
    result := GuidToString(Uid);
    result := Copy(result, 2, result.Length - 2);
  end
  else
    result := ''
end;

function GenerateSerial(clientId: string): string;
begin
  Result := HashMD5(clientId + APP_ID);
end;

// Gets path of special system folders
// Call this routine as follows:
// GetSpecialFolderPath (CSIDL_PERSONAL, false)
//        returns folder as result
function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): string;
var
  FilePath: array [0..255] of char;
begin
  SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
  Result := FilePath;
end;

function GetComputerName: string;
var
  dwLength: dword;
begin
  dwLength := 253;
  SetLength(result, dwLength+1);
  if not Windows.GetComputerName(pchar(result), dwLength) then
    raise exception.create('Computer name not detected');
  result := pchar(result);
end;

function GetClientId: string;
var
  licenceFile: TStringList;
  localAppFolder, uuid, computerName: string;
begin
  licenceFile := TStringList.Create;
  try
    localAppFolder := GetSpecialFolderPath(CSIDL_LOCAL_APPDATA, false);
    if FileExists(localAppFolder+'\.appgincana') then
      licenceFile.LoadFromFile(localAppFolder+'\.appgincana');
    if licenceFile.Count >= 2 then
      Result := licenceFile[1]
    else
    begin
      computerName := HashMD5(GetComputerName);
      uuid := GenerateUUID;
      licenceFile.Clear;
      licenceFile.Add(computerName);
      licenceFile.Add(uuid);
      licenceFile.SaveToFile(localAppFolder+'\.appgincana');
      Result := uuid;
    end;
  finally
    FreeAndNil(licenceFile);
  end;
end;

// REALIZA VERIFICAÇÃO DE VALIDADE DA LICENÇA
// RETORNOS
//  0: OK
//  1: INVALID_COMPUTER
//  2: WITHOUT_SERIAL_NUMBER
//  3: INVALID_SERIAL_NUMBER
function ValidateLicence: byte;
var
  localAppFolder, uuid, computerName, serialNumber: string;
  licenceFile: TStringList;
begin
  Result := 0;
  localAppFolder := GetSpecialFolderPath(CSIDL_LOCAL_APPDATA, false);
  if not FileExists(localAppFolder+'\.appgincana') then
    Result := 2
  else
  begin
    computerName := HashMD5(GetComputerName);
    licenceFile := TStringList.Create;
    try
      licenceFile.LoadFromFile(localAppFolder+'\.appgincana');
      try
        if licenceFile[0] <> computerName then
          Result := 1
        else
        begin
          case licenceFile.Count of
            // possui somente identificação do computador
            // cria client_id
            1: begin
              uuid := GenerateUUID;
              licenceFile.Add(uuid);
              licenceFile.SaveToFile(localAppFolder+'\.appgincana');
              Result := 2;
            end;
            // possui somente id do computador e client_id
            2: begin
              Result := 2;
            end;
            // possui também número de série
            // verifica se é válido
            3: begin
              serialNumber := GenerateSerial(licenceFile[1]);
              if licenceFile[2] <> serialNumber then
                Result := 3;
            end;
          end;
        end;
      except
        Result := 2;
      end;
    finally
      FreeAndNil(licenceFile);
    end;
  end;

end;

procedure SaveSerialNumber(serial: string);
var
  licenceFile: TStringList;
  localAppFolder: string;
begin
  licenceFile := TStringList.Create;
  try
    localAppFolder := GetSpecialFolderPath(CSIDL_LOCAL_APPDATA, false);
    licenceFile.LoadFromFile(localAppFolder+'\.appgincana');
    case licenceFile.Count of
      2: licenceFile.Add(serial);
      3: licenceFile[2] := serial;
    end;
    licenceFile.SaveToFile(localAppFolder+'\.appgincana');
  finally
    FreeAndNil(licenceFile);
  end;
end;

end.
