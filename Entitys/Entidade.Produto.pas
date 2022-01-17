unit Entidade.Produto;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.Produto,
  Attributes.Entidades, System.SysUtils, Utils.Constants, Utils.GUID,
  Entidade.Imagem, Utils.Entidade, Componente.TObjectList;

type
  [TNomeTabela('PRODUTO')]
  TProduto = class(TEntidade<TProduto>, iProduto)
  private
    FGUID: string;
    FCodigo: string;
    FNome: string;
    FImagens: TObjectListFuck<TImagem>;
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetCodigo(const Value: string);
    function GetCodigo: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    procedure SetImagens(const Value: TObjectListFuck<TImagem>);
    function GetImagens: TObjectListFuck<TImagem>;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('CODIGO', TConstantsEntidade.TAMANHO_CODIGO_PRODUTO, [NOTNULL], 'Código')]
    property Codigo: string read GetCodigo write SetCodigo;
    [TCampoTexto('NOME', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'Nome')]
    property Nome: string read GetNome write SetNome;
    [TCampoListagem(taManyToMany, ctCascade, 'PRODUTO_FK', 'IMAGEM_FK', 'IMAGEM_PESSOA')]
    Property Imagens: TObjectListFuck<TImagem> read GetImagens write SetImagens;

    class function New : iProduto;
    function EstaVazia: Boolean; override;
  end;

implementation

{ TProduto }

function TProduto.EstaVazia: Boolean;
begin
  Result := (FCodigo = EmptyStr) and (FNome = EmptyStr);
end;

function TProduto.GetNome: string;
begin
  Result := FNome;
end;

function TProduto.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TProduto.GetImagens: TObjectListFuck<TImagem>;
begin
   If not Assigned(FImagens) Then
      FImagens := TUtilsEntidade.ObterListaComTabelaRelacional<TImagem>(Self.GUID,
        'PRODUTO_FK', 'IMAGEM_FK', 'IMAGEM_PESSOA', TImagem);

   Result := FImagens;
end;

function TProduto.GetCodigo: string;
begin
  Result := FCodigo;
end;

class function TProduto.New: iProduto;
begin
  Result := Self.Create;
end;

procedure TProduto.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TProduto.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TProduto.SetImagens(const Value: TObjectListFuck<TImagem>);
begin
  FImagens := Value;
end;

procedure TProduto.SetCodigo(const Value: string);
begin
  FCodigo := Value;
end;

initialization
  RegisterClass(TProduto);

end.
