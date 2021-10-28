unit Objeto.ConsultaCEP;

interface

uses
  REST.Json.Types, Interfaces.Objeto.ConsultaCEP;

type
  TConsultaCEP = class(TInterfacedObject, iConsultaCEP)
  private
    FLogradouro: string;
    [JSONNameAttribute('ibge')]
    FIBGE: string;
    FBairro: string;
    [JSONNameAttribute('uf')]
    FUF: string;
    [JSONNameAttribute('cep')]
    FCEP: string;
    FLocalidade: string;
    FComplemento: string;
    [JSONNameAttribute('gia')]
    FGIA: string;
    [JSONNameAttribute('ddd')]
    FDDD: string;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetGIA(const Value: string);
    procedure SetIBGE(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetDDD(const Value: string);
    function GetBairro: string;
    function GetCEP: string;
    function GetComplemento: string;
    function GetDDD: string;
    function GetGIA: string;
    function GetIBGE: string;
    function GetLocalidade: string;
    function GetLogradouro: string;
    function GetUF: string;
  public
    property CEP: string read GetCEP write SetCEP;
    property Logradouro: string read GetLogradouro write SetLogradouro;
    property Complemento: string read GetComplemento write SetComplemento;
    property Bairro: string read GetBairro write SetBairro;
    property Localidade: string read GetLocalidade write SetLocalidade;
    property UF: string read GetUF write SetUF;
    property IBGE: string read GetIBGE write SetIBGE;
    property GIA: string read GetGIA write SetGIA;
    property DDD: string read GetDDD write SetDDD;
    function ToJSONString: string;
    class function FromJSONString(const AJSONString: string): iConsultaCEP;
  end;

implementation

uses REST.Json;

{ TViaCEPClass }

class function TConsultaCEP.FromJSONString(const AJSONString: string): iConsultaCEP;
begin
  Result := TJson.JsonToObject<TConsultaCEP>(AJSONString);
end;

function TConsultaCEP.GetBairro: string;
begin
  Result := FBairro;
end;

function TConsultaCEP.GetCEP: string;
begin
  Result := FCEP;
end;

function TConsultaCEP.GetComplemento: string;
begin
  Result := FComplemento;
end;

function TConsultaCEP.GetDDD: string;
begin
  Result := FDDD;
end;

function TConsultaCEP.GetGIA: string;
begin
  Result := FGIA;
end;

function TConsultaCEP.GetIBGE: string;
begin
  Result := FIBGE;
end;

function TConsultaCEP.GetLocalidade: string;
begin
  Result := FLocalidade;
end;

function TConsultaCEP.GetLogradouro: string;
begin
  Result := FLogradouro;
end;

function TConsultaCEP.GetUF: string;
begin
  Result := FUF;
end;

procedure TConsultaCEP.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TConsultaCEP.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TConsultaCEP.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TConsultaCEP.SetDDD(const Value: string);
begin
  FDDD := Value;
end;

procedure TConsultaCEP.SetGIA(const Value: string);
begin
  FGIA := Value;
end;

procedure TConsultaCEP.SetIBGE(const Value: string);
begin
  FIBGE := Value;
end;

procedure TConsultaCEP.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TConsultaCEP.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TConsultaCEP.SetUF(const Value: string);
begin
  FUF := Value;
end;

function TConsultaCEP.ToJSONString: string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.
