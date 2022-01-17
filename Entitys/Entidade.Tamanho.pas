unit Entidade.Tamanho;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.Tamanho,
  Attributes.Entidades, System.SysUtils, Utils.Constants, Utils.GUID,
  Utils.Enumerators, Objeto.CustomSelect;

type
  [TNomeTabela('TAMANHO')]
  TTamanho = class(TEntidade<TTamanho>, iTamanho)
  private
    FGUID: string;
    FAbreviacao: string;
    FNome: string;
    FAtivo: TRegistroAtivo;
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetAbreviacao(const Value: string);
    function GetAbreviacao: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    procedure SetAtivo(const Value: TRegistroAtivo);
    function GetAtivo: TRegistroAtivo;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('NOME', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'Tamanho')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('ABREVIACAO', TConstantsEntidade.TAMANHO_ABREVIACAO, [NOTNULL], 'Abreviação')]
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    [TCampoTexto('ATIVO', 1, [NOTNULL], TCustomSelectAtivo, 'Ativo')]
    property Ativo: TRegistroAtivo read GetAtivo write SetAtivo;

    class function New : iTamanho;
    function EstaVazia: Boolean; override;
  end;

implementation

{ TTamanho }

function TTamanho.EstaVazia: Boolean;
begin
  Result := (FAbreviacao = EmptyStr) and (FNome = EmptyStr);
end;

function TTamanho.GetAbreviacao: string;
begin
  Result := FAbreviacao;
end;

function TTamanho.GetAtivo: TRegistroAtivo;
begin
  Result := FAtivo;
end;

function TTamanho.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TTamanho.GetNome: string;
begin
  Result := FNome;
end;

class function TTamanho.New: iTamanho;
begin
  Result := Self.Create;
end;

procedure TTamanho.SetAbreviacao(const Value: string);
begin
  FAbreviacao := Value;
end;

procedure TTamanho.SetAtivo(const Value: TRegistroAtivo);
begin
  FAtivo := Value;
end;

procedure TTamanho.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TTamanho.SetNome(const Value: string);
begin
  FNome := Value;
end;

initialization
  RegisterClass(TTamanho);

end.
