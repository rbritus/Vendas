unit Controller.Objeto.ConsultaCEP;

interface

uses
  IdHTTP, IdSSLOpenSSL, Interfaces.Controller.Objeto.ConsultaCEP,
  Objeto.ConsultaCEP, Interfaces.Objeto.ConsultaCEP;

type
  TControllerObjetoConsultaCEP = class(TInterfacedObject, IControllerConsultaCEP)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    function Get(const ACep: string): iConsultaCEP;
    function Validate(const ACep: string): Boolean;
    class function New : IControllerConsultaCEP;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TViaCEP }

uses
  System.Classes, REST.Json, System.SysUtils;

constructor TControllerObjetoConsultaCEP.Create;
begin
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

function TControllerObjetoConsultaCEP.Get(const ACep: string): iConsultaCEP;
const
  URL = 'https://viacep.com.br/ws/%s/json';
  INVALID_CEP = '{'#$A'  "erro": true'#$A'}';
var
  LResponse: TStringStream;
begin
  Result := nil;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Get(Format(URL, [ACep.Trim]), LResponse);
    if (FIdHTTP.ResponseCode = 200) and (not (LResponse.DataString).Equals(INVALID_CEP)) then
      Result := TJson.JsonToObject<TConsultaCEP>(UTF8ToString(PAnsiChar(AnsiString(LResponse.DataString))));
  finally
    LResponse.Free;
  end;
end;

class function TControllerObjetoConsultaCEP.New: IControllerConsultaCEP;
begin
  Result := Self.Create;
end;

function TControllerObjetoConsultaCEP.Validate(const ACep: string): Boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if ACep.Trim.Length <> 8 then
    Exit(False);
  if StrToIntDef(ACep, INVALID_CHARACTER) = INVALID_CHARACTER then
    Exit(False);
end;

destructor TControllerObjetoConsultaCEP.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

end.
