unit Entidade.SKU;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.SKU,
  Attributes.Entidades, System.SysUtils, Utils.Constants, Utils.GUID,
  Utils.Entidade, Componente.TObjectList, Entidade.Tamanho, Entidade.Produto;

type
  [TNomeTabela('SKU')]
  TSKU = class(TEntidade<TSKU>, iSKU)
  private
    FGUID: string;
    FTamanho: TTamanho;
    FNome: string;
    FProduto: TProduto;
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    procedure SetTamanho(const Value: TTamanho);
    function GetTamanho: TTamanho;
    procedure SetProduto(const Value: TProduto);
    function GetProduto: TProduto;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoEstrangeiro('PRODUTO_FK', [NOTNULL], 'PRODUTO', 'Nome', 'Produto')]
    property Produto: TProduto read GetProduto write SetProduto;
    [TCampoTexto('NOME', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'Nome')]
    property Nome: string read GetNome write SetNome;
    [TCampoEstrangeiro('TAMANHO_FK', [NOTNULL], 'TAMANHO', 'ABREVIACAO', 'Tamanho')]
    property Tamanho: TTamanho read GetTamanho write SetTamanho;

    class function New : iSKU;
    function EstaVazia: Boolean; override;
  end;

implementation

{ TSKU }

function TSKU.EstaVazia: Boolean;
begin
  Result := (FNome = EmptyStr);
end;

function TSKU.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TSKU.GetNome: string;
begin
  Result := FNome;
end;

function TSKU.GetProduto: TProduto;
begin
  if not Assigned(FProduto) then
    FProduto := TUtilsEntidade.ObterObjetoChaveEstrangeira(Self as TObject, TProduto) as TProduto;

  Result := FProduto;
end;

function TSKU.GetTamanho: TTamanho;
begin
  if not Assigned(FTamanho) then
    FTamanho := TUtilsEntidade.ObterObjetoChaveEstrangeira(Self as TObject, TTamanho) as TTamanho;

  Result := FTamanho;
end;

class function TSKU.New: iSKU;
begin
  Result := Self.Create;
end;

procedure TSKU.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TSKU.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TSKU.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TSKU.SetTamanho(const Value: TTamanho);
begin
  FTamanho := Value;
end;

initialization
  RegisterClass(TSKU);

end.
