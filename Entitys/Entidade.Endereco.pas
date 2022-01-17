unit Entidade.Endereco;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Endereco, Entidade.Cidade, Utils.Enumerators,
  Objeto.CustomSelect, Utils.Constants;

type
  [TNomeTabela('ENDERECO')]
  TEndereco = class(TEntidade<TEndereco>, iEndereco)
  private
    FGUID: string;
    FCEP: string;
    FLogradouro: string;
    FNumero: Integer;
    FBairro: string;
    FCidade: TCidade;
    FTipoEndereco: TTipoEndereco;
    FComplemento: string;
    procedure SetGUID(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: Integer);
    procedure SetBairro(const Value: string);
    procedure SetCidade(const Value: TCidade);
    procedure SetTipoEndereco(const Value: TTipoEndereco);
    procedure SetComplemento(const Value: string);
    function GetGUID: string;
    function GetCEP: string;
    function GetLogradouro: string;
    function GetNumero: Integer;
    function GetBairro: string;
    function GetCidade: TCidade;
    function GetTipoEndereco: TTipoEndereco;
    function GetComplemento: string;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TAtributoMascara(TConstantsMasks.CEP)]
    [TCampoTexto('CEP', TConstantsEntidade.TAMANHO_CEP, [NOTNULL], 'CEP')]
    property CEP: string read GetCEP write SetCEP;
    [TCampoTexto('LOGRADOURO', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'Endereço')]
    property Logradouro: string read GetLogradouro write SetLogradouro;
    [TCampoInteiro('NUMERO', [], 'Número')]
    property Numero: Integer read GetNumero write SetNumero;
    [TCampoTexto('BAIRRO', TConstantsEntidade.TAMANHO_NOME, [], 'Bairro')]
    property Bairro: string read GetBairro write SetBairro;
    [TCampoTexto('COMPLEMENTO', TConstantsEntidade.TAMANHO_COMPLEMENTO, [], 'Complemento',False)]
    property Complemento: string read GetComplemento write SetComplemento;
    [TCampoEstrangeiro('CIDADE_FK', [NOTNULL], 'CIDADE', 'Nome', 'Cidade')]
    property Cidade: TCidade read GetCidade write SetCidade;
    [TCampoInteiro('TIPO_ENDERECO', [NOTNULL], TCustomSelectTipoEndereco, 'Tipo')]
    property TipoEndereco: TTipoEndereco read GetTipoEndereco write SetTipoEndereco;

    class function New : iEndereco;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.Entidade, Utils.GUID;

{ TEndereco }

function TEndereco.EstaVazia: Boolean;
begin
  Result := (FGUID = string.Empty) and (FCEP = string.Empty);
end;

function TEndereco.GetBairro: string;
begin
  Result := FBairro;
end;

function TEndereco.GetCEP: string;
begin
  Result := FCEP;
end;

function TEndereco.GetCidade: TCidade;
begin
   If Not Assigned(FCidade) Then
      FCidade := TUtilsEntidade.ObterObjetoChaveEstrangeira(Self as TObject, TCidade) as TCidade;

   Result := FCidade;
end;

function TEndereco.GetComplemento: string;
begin
  Result := FComplemento;
end;

function TEndereco.GetLogradouro: string;
begin
  Result := FLogradouro;
end;

function TEndereco.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TEndereco.GetNumero: Integer;
begin
  Result := FNumero;
end;

function TEndereco.GetTipoEndereco: TTipoEndereco;
begin
  Result := FTipoEndereco;
end;

class function TEndereco.New: iEndereco;
begin
  Result := Self.Create;
end;

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TEndereco.SetCidade(const Value: TCidade);
begin
  FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TEndereco.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TEndereco.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

procedure TEndereco.SetTipoEndereco(const Value: TTipoEndereco);
begin
  FTipoEndereco := Value;
end;

initialization
  RegisterClass(TEndereco);

end.
