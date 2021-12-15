unit Entidade.Telefone;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Telefone, Utils.Enumerators, Objeto.CustomSelect,
  Utils.Constants;

type
  [TNomeTabela('TELEFONE')]
  TTelefone = class(TEntidade<TTelefone>, iTelefone)
  private
    FGUID: string;
    FNumero: string;
    FTipoTelefone: TTipoTelefone;
    FObservacao: string;
    function GetGUID: string;
    procedure SetGUID(const Value: string);
    procedure SetNumero(const Value: string);
    function GetNumero: string;
    function GetTipoEndereco: TTipoTelefone;
    procedure SetTipoEndereco(const Value: TTipoTelefone);
    procedure SetObservacao(const Value: string);
    function GetObservacao: string;
  public
    [TCampoTexto('GUID', TConstantsInteger.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('NUMERO', 20,[NOTNULL], 'Número', True)]
    property Numero: string read GetNumero write SetNumero;
    [TCampoInteiro('TIPO_TELEFONE', [NOTNULL], TCustomSelectTipoTelefone, 'Tipo')]
    property TipoTelefone: TTipoTelefone read GetTipoEndereco write SetTipoEndereco;
    [TCampoTexto('OBSERVACAO', 200, [NOTNULL], 'Observação', True)]
    property Observacao: string read GetObservacao write SetObservacao;

    class function New : iTelefone;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.GUID;

{ TTelefone }

function TTelefone.EstaVazia: Boolean;
begin
  Result := (FNumero = string.Empty);
end;

function TTelefone.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TTelefone.GetNumero: string;
begin
  Result := FNumero;
end;

function TTelefone.GetObservacao: string;
begin
  Result := FObservacao;
end;

function TTelefone.GetTipoEndereco: TTipoTelefone;
begin
  Result := FTipoTelefone;
end;

class function TTelefone.New: iTelefone;
begin
  Result := Self.Create;
end;

procedure TTelefone.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TTelefone.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TTelefone.SetObservacao(const Value: string);
begin
  FObservacao := Value;
end;

procedure TTelefone.SetTipoEndereco(const Value: TTipoTelefone);
begin
  FTipoTelefone := Value;
end;

initialization
  RegisterClass(TTelefone);

end.
