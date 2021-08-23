unit Entidade.Logradouro;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Logradouro;

type
  [TNomeTabela('LOGRADOURO')]
  TLogradouro = class(TEntidade<TLogradouro>, iLogradouro)
  private
    FId: Integer;
    FCodigo: Integer;
    FAbreviacao: string;
    FDescricao: string;
    procedure SetId(const Value: integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetAbreviacao(const Value: string);
    procedure SetDescricao(const Value: string);
    function GetId: Integer;
    function GetCodigo: Integer;
    function GetAbreviacao: string;
    function GetDescricao: string;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID')]
    property Id: Integer read GetId write SetId;
    [TCampoInteiro('CODIGO', [NOTNULL], 'Código')]
    property Codigo: Integer read GetCodigo write SetCodigo;
    [TCampoTexto('ABREVIACAO', 20, [], 'Abreviação')]
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    [TCampoTexto('DESCRICAO', 100, [], 'Descrição')]
    property Descricao: string read GetDescricao write SetDescricao;

    class function New : iLogradouro;
    function EstaVazia(): Boolean; override;
  end;

implementation

{ TLOGRADOURO }

function TLogradouro.EstaVazia: Boolean;
begin
  Result := (FId = 0) and (FCodigo = 0);
end;

function TLogradouro.GetAbreviacao: string;
begin
  Result := FAbreviacao;
end;

function TLogradouro.GetCodigo: Integer;
begin
  Result := FCodigo;
end;

function TLogradouro.GetDescricao: string;
begin
  Result := FDescricao;
end;

function TLogradouro.GetId: Integer;
begin
  Result := FId;
end;

class function TLogradouro.New: iLogradouro;
begin
  Result := Self.Create;
end;

procedure TLogradouro.SetAbreviacao(const Value: string);
begin
  FAbreviacao := Value;
end;

procedure TLogradouro.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TLogradouro.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TLogradouro.SetId(const Value: integer);
begin
  FId := Value;
end;

initialization
  RegisterClass(TLogradouro);

end.
