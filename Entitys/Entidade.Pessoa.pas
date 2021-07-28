unit Entidade.Pessoa;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.Pessoa, Attributes.Entidades,
  System.SysUtils;

type
  [TNomeTabela('PESSOA')]
  TPessoa = class(TEntidade<TPessoa>, iPessoa)
  private
    FId: integer;
    FNome: string;
    FAtivo: string;
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetAtivo(const Value: string);
    function GetId: Integer;
    function GetNome: string;
    function GetAtivo: string;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'Id')]
    property Id: Integer read GetId write SetId;
    [TCampoTexto('NOME', 200, [NOTNULL], 'Nome')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('ATIVO', 1, [], 'Ativo')]
    property Ativo: string read GetAtivo write SetAtivo;

    class function New : iPessoa;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.Constants;

{ TPessoa }

function TPessoa.GetId: Integer;
begin
  Result := FId;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;

function TPessoa.GetAtivo: string;
begin
   if (FAtivo).IsEmpty then
      FAtivo := REGISTROATIVO;

   Result := FAtivo
end;

procedure TPessoa.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetAtivo(const Value: string);
begin
  FAtivo := Value;
end;

class function TPessoa.New: iPessoa;
begin
    Result := Self.Create;
end;

function TPessoa.EstaVazia: Boolean;
begin
  Result := (FId = 0) and (FNome = EmptyStr);
end;

initialization
   RegisterClass(TPessoa);

end.

