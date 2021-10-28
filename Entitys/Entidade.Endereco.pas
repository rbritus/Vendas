unit Entidade.Endereco;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Endereco, Entidade.Cidade, Utils.Enumerators,
  Objeto.CustomSelect;

type
  [TNomeTabela('ENDERECO')]
  TEndereco = class(TEntidade<TEndereco>, iEndereco)
  private
    FId: Integer;
    FCEP: string;
    FLogradouro: string;
    FNumero: Integer;
    FBairro: string;
//    FLogradouro: iLogradouro;
    FCidade: TCidade;
    FTipoEndereco: TTipoEndereco;
    FComplemento: string;
    procedure SetId(const Value: integer);
    procedure SetCEP(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: Integer);
    procedure SetBairro(const Value: string);
//    procedure SetLogradouro(const Value: iLogradouro);
    procedure SetCidade(const Value: TCidade);
    procedure SetTipoEndereco(const Value: TTipoEndereco);
    procedure SetComplemento(const Value: string);
    function GetId: Integer;
    function GetCEP: string;
    function GetLogradouro: string;
    function GetNumero: Integer;
    function GetBairro: string;
//    function GetLogradouro: iLogradouro;
    function GetCidade: TCidade;
    function GetTipoEndereco: TTipoEndereco;
    function GetComplemento: string;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID')]
    property Id: Integer read GetId write SetId;
    [TCampoTexto('CEP', 10, [], 'CEP')]
    property CEP: string read GetCEP write SetCEP;
//    [TCampoEstrangeiro('LOGRADOURO_FK', [NOTNULL], 'LOGRADOURO', 'Abreviacao')]
//    property Logradouro: iLogradouro read GetLogradouro write SetLogradouro;
    [TCampoTexto('LOGRADOURO', 200, [], 'Endereço')]
    property Logradouro: string read GetLogradouro write SetLogradouro;
    [TCampoInteiro('NUMERO', [], 'Número')]
    property Numero: Integer read GetNumero write SetNumero;
    [TCampoTexto('BAIRRO', 100, [], 'Bairro')]
    property Bairro: string read GetBairro write SetBairro;
    [TCampoTexto('COMPLEMENTO', 200, [], 'Complemento',False)]
    property Complemento: string read GetComplemento write SetComplemento;
    [TCampoEstrangeiro('CIDADE_FK', [NOTNULL], 'CIDADE', 'Nome')]
    property Cidade: TCidade read GetCidade write SetCidade;
    [TCampoInteiro('TIPO_ENDERECO', [NOTNULL], TCustomSelectTipoEndereco, 'Tipo')]
    property TipoEndereco: TTipoEndereco read GetTipoEndereco write SetTipoEndereco;

    class function New : iEndereco;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.Entidade;

{ TEndereco }

function TEndereco.EstaVazia: Boolean;
begin
  Result := (FId = 0) and (FCEP = EmptyStr);
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

function TEndereco.GetId: Integer;
begin
  Result := FId;
end;

//function TEndereco.GetLogradouro: iLogradouro;
//begin
//   If Not Assigned(FLogradouro) Then
//      FLogradouro := TUtilsEntidade.ObterObjetoChaveEstrangeira(Self as TObject, TLogradouro) as TLogradouro;
//
//   Result := FLogradouro;
//end;

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

procedure TEndereco.SetId(const Value: integer);
begin
  FId := Value;
end;

//procedure TEndereco.SetLogradouro(const Value: iLogradouro);
//begin
//  FLogradouro := Value;
//end;

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
