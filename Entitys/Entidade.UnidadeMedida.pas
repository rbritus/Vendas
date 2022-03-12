unit Entidade.UnidadeMedida;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.UnidadeMedida,
  Attributes.Entidades, System.SysUtils, Utils.Constants, Utils.GUID,
  Utils.Enumerators, Objeto.CustomSelect;

type
  [TNomeTabela('UNIDADE_MEDIDA')]
  TUnidadeMedida = class(TEntidade<TUnidadeMedida>, iUnidadeMedida)
  private
    FGUID: string;
    FAbreviacao: string;
    FDescricao: string;
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    function GetAbreviacao: string;
    procedure SetAbreviacao(const Value: string);
    procedure SetDescricao(const Value: string);
    function GetDescricao: string;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('ABREVIACAO', TConstantsEntidade.TAMANHO_ABREVIACAO, [NOTNULL], 'Abreviação')]
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    [TCampoTexto('DESCRICAO', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'Descricao')]
    property Descricao: string read GetDescricao write SetDescricao;

    class function New : iUnidadeMedida;
    function EstaVazia: Boolean; override;
  end;

implementation

{ TUnidadeMedida }

function TUnidadeMedida.EstaVazia: Boolean;
begin
  Result := (FAbreviacao = EmptyStr);
end;

function TUnidadeMedida.GetAbreviacao: string;
begin
  Result := FAbreviacao;
end;

function TUnidadeMedida.GetDescricao: string;
begin
  Result := FDescricao;
end;

function TUnidadeMedida.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

class function TUnidadeMedida.New: iUnidadeMedida;
begin
  Result := Self.Create;
end;

procedure TUnidadeMedida.SetAbreviacao(const Value: string);
begin
  FAbreviacao := Value;
end;

procedure TUnidadeMedida.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TUnidadeMedida.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

initialization
  RegisterClass(TUnidadeMedida);

end.
