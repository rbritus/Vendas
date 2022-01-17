unit Entidade.Pais;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Pais, Utils.Constants;

type
  [TNomeTabela('PAIS')]
  TPais = class(TEntidade<TPais>, iPais)
  private
    FGUID: string;
    FAbreviacao: string;
    FNome: string;
    FCodigoSISCOMEX: string;
    FCodigoBACEN: string;
    procedure SetAbreviacao(const Value: string);
    procedure SetGUID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetCodigoBACEN(const Value: string);
    procedure SetCodigoSISCOMEX(const Value: string);
    function GetAbreviacao: string;
    function GetGUID: string;
    function GetNome: string;
    function GetCodigoBACEN: string;
    function GetCodigoSISCOMEX: string;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('NOME', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'País')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('ABREVIACAO', 5, [NOTNULL], 'Abreviação', False)]
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    [TCampoTexto('CODIGO_BACEN', 10, [], 'Cód. BACEN', False)]
    property CodigoBACEN: string read GetCodigoBACEN write SetCodigoBACEN;
    [TCampoTexto('CODIGO_SISCOMEX', 10, [], 'Cód. SISCOMEX', False)]
    property CodigoSISCOMEX: string read GetCodigoSISCOMEX write SetCodigoSISCOMEX;

    class function New : iPais;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.GUID;

{ TPais }

function TPais.EstaVazia: Boolean;
begin
  Result := (FGUID = string.Empty);
end;

function TPais.GetAbreviacao: string;
begin
  Result := FAbreviacao;
end;

function TPais.GetCodigoBACEN: string;
begin
  Result := FCodigoBACEN;
end;

function TPais.GetCodigoSISCOMEX: string;
begin
  Result := FCodigoSISCOMEX;
end;

function TPais.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TPais.GetNome: string;
begin
  Result := FNome;
end;

class function TPais.New: iPais;
begin
  Result := Self.Create;
end;

procedure TPais.SetAbreviacao(const Value: string);
begin
  FAbreviacao := Value;
end;

procedure TPais.SetCodigoBACEN(const Value: string);
begin
  FCodigoBACEN := Value;
end;

procedure TPais.SetCodigoSISCOMEX(const Value: string);
begin
  FCodigoSISCOMEX := Value;
end;

procedure TPais.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TPais.SetNome(const Value: string);
begin
  FNome := Value;
end;

initialization
  RegisterClass(TPais);

end.
