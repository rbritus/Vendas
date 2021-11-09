unit Entidade.Pais;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Pais;

type
  [TNomeTabela('PAIS')]
  TPais = class(TEntidade<TPais>, iPais)
  private
    FId: Integer;
    FAbreviacao: string;
    FNome: string;
    FCodigoSISCOMEX: string;
    FCodigoBACEN: string;
    procedure SetAbreviacao(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetCodigoBACEN(const Value: string);
    procedure SetCodigoSISCOMEX(const Value: string);
    function GetAbreviacao: string;
    function GetId: Integer;
    function GetNome: string;
    function GetCodigoBACEN: string;
    function GetCodigoSISCOMEX: string;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID', False)]
    property Id: Integer read GetId write SetId;
    [TCampoTexto('NOME', 200, [NOTNULL], 'País')]
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

{ TPais }

function TPais.EstaVazia: Boolean;
begin
  Result := (FId = 0);
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

function TPais.GetId: Integer;
begin
  Result := FId;
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

procedure TPais.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TPais.SetNome(const Value: string);
begin
  FNome := Value;
end;

initialization
  RegisterClass(TPais);

end.
