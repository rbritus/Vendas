unit Entidade.Pessoa;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.Pessoa,
  Attributes.Entidades, System.SysUtils, Objeto.CustomSelect,
  Entidade.Endereco, Componente.TObjectList, Utils.Enumerators,
  Entidade.Telefone, Utils.Constants;

type
  [TNomeTabela('PESSOA')]
  TPessoa = class(TEntidade<TPessoa>, iPessoa)
  private
    FGUID: string;
    FNome: string;
    FAtivo: TRegistroAtivo;
    FCPF: string;
    FEmail: string;
    FEnderecos: TObjectListFuck<TEndereco>;
    FTelefones: TObjectListFuck<TTelefone>;
    procedure SetGUID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetAtivo(const Value: TRegistroAtivo);
    procedure SetCPF(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEnderecos(const Value: TObjectListFuck<TEndereco>);
    function GetGUID: string;
    function GetNome: string;
    function GetAtivo: TRegistroAtivo;
    function GetCPF: string;
    function GetEmail: string;
    function GetEnderecos: TObjectListFuck<TEndereco>;
    procedure SetTelefones(const Value: TObjectListFuck<TTelefone>);
    function GetTelefones: TObjectListFuck<TTelefone>;
  public
    [TCampoTexto('GUID', TConstantsInteger.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('NOME', 200, [NOTNULL], 'Nome')]
    property Nome: string read GetNome write SetNome;
    [TAtributoMascara(TConstantsMasks.CPF)]
    [TCampoTexto('CPF', 11, [], 'CPF')]
    property CPF: string read GetCPF write SetCPF;
    [TCampoTexto('EMAIL', 200, [], 'E-mail', False)]
    property Email: string read GetEmail write SetEmail;
    [TCampoTexto('ATIVO', 1, [NOTNULL], TCustomSelectAtivo,'Situação')]
    property Ativo: TRegistroAtivo read GetAtivo write SetAtivo default raAtivo;
    [TCampoListagem(taManyToMany, ctCascade, 'PESSOA_FK', 'ENDERECO_FK', 'ENDERECO_PESSOA')]
    Property Enderecos: TObjectListFuck<TEndereco> read GetEnderecos write SetEnderecos;
    [TCampoListagem(taManyToMany, ctCascade, 'PESSOA_FK', 'TELEFONE_FK', 'TELEFONE_PESSOA')]
    Property Telefones: TObjectListFuck<TTelefone> read GetTelefones write SetTelefones;

    class function New : iPessoa;
    function EstaVazia: Boolean; override;
  end;

implementation

uses
  Utils.Entidade, Utils.GUID;

{ TPessoa }

function TPessoa.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TPessoa.GetNome: string;
begin
  Result := FNome;
end;

function TPessoa.GetTelefones: TObjectListFuck<TTelefone>;
begin
   If not Assigned(FTelefones) Then
      FTelefones := TUtilsEntidade.ObterListaComTabelaRelacional<TTelefone>(Self.GUID,
        'PESSOA_FK', 'TELEFONE_FK', 'TELEFONE_PESSOA', TTelefone);

   Result := FTelefones;
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
      FEnderecos := TUtilsEntidade.ObterListaComTabelaRelacional<TEndereco>(Self.GUID,
        'PESSOA_FK', 'ENDERECO_FK', 'ENDERECO_PESSOA', TEndereco);

   Result := FEnderecos;
end;

procedure TPessoa.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetTelefones(const Value: TObjectListFuck<TTelefone>);
begin
  FTelefones := Value;
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
  Result := (FNome = EmptyStr);
end;

initialization
  RegisterClass(TPessoa);

end.

