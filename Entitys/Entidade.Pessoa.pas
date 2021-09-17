unit Entidade.Pessoa;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.Pessoa,
  Attributes.Entidades, System.SysUtils, Objeto.CustomSelect,
  Entidade.Endereco, Componente.TObjectList, Utils.Enumerators;

type
  [TNomeTabela('PESSOA')]
  TPessoa = class(TEntidade<TPessoa>, iPessoa)
  private
    FId: integer;
    FNome: string;
    FAtivo: TRegistroAtivo;
    FCPF: string;
    FEmail: string;
    FEnderecos: TObjectListFuck<TEndereco>;
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetAtivo(const Value: TRegistroAtivo);
    procedure SetCPF(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEnderecos(const Value: TObjectListFuck<TEndereco>);
    function GetId: Integer;
    function GetNome: string;
    function GetAtivo: TRegistroAtivo;
    function GetCPF: string;
    function GetEmail: string;
    function GetEnderecos: TObjectListFuck<TEndereco>;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID',False)]
    property Id: Integer read GetId write SetId;
    [TCampoTexto('NOME', 200, [NOTNULL], 'Nome')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('CPF', 11, [], 'CPF')]
    property CPF: string read GetCPF write SetCPF;
    [TCampoTexto('EMAIL', 200, [], 'E-mail', False)]
    property Email: string read GetEmail write SetEmail;
    [TCampoTexto('ATIVO', 1, [NOTNULL], TCustomSelectAtivo,'Situação')]
    property Ativo: TRegistroAtivo read GetAtivo write SetAtivo default raAtivo;
    [TCampoListagem(taManyToMany, ctCascade, 'PESSOA_FK', 'ENDERECO_FK', 'ENDERECO_PESSOA')]
    Property Enderecos: TObjectListFuck<TEndereco> read GetEnderecos write SetEnderecos;

    class function New : iPessoa;
    function EstaVazia: Boolean; override;
  end;

implementation

uses
  Utils.Constants, Utils.Entidade;

{ TPessoa }

function TPessoa.GetId: Integer;
begin
  Result := FId;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;

function TPessoa.GetAtivo: TRegistroAtivo;
begin
  Result := FAtivo
end;

function TPessoa.GetCPF: string;
begin
  Result := FCPF;
end;

function TPessoa.GetEmail: string;
begin
  Result := FEmail;
end;

function TPessoa.GetEnderecos: TObjectListFuck<TEndereco>;
begin
   If not Assigned(FEnderecos) Then
      FEnderecos := TUtilsEntidade.ObterListaComTabelaRelacional<TEndereco>(Self.id,
        'PESSOA_FK', 'ENDERECO_FK', 'ENDERECO_PESSOA', TEndereco);

   Result := FEnderecos;
end;

procedure TPessoa.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetAtivo(const Value: TRegistroAtivo);
begin
  FAtivo := Value;
end;

procedure TPessoa.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

procedure TPessoa.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TPessoa.SetEnderecos(const Value: TObjectListFuck<TEndereco>);
begin
  FEnderecos := Value;
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

