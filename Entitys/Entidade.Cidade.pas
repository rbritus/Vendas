unit Entidade.Cidade;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Cidade, Entidade.Estado;

type
  [TNomeTabela('CIDADE')]
  TCidade = class(TEntidade<TCidade>, iCidade)
  private
    FId: Integer;
    FNome: string;
    FCodigoIBGE: Integer;
    FCodigoMunicipio: string;
    FCodigoDistrito: string;
    FEstado: TEstado;
    FCodigoSubdistrito: string;
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetCodigoIBGE(const Value: Integer);
    procedure SetCodigoMunicipio(const Value: string);
    procedure SetCodigoDistrito(const Value: string);
    procedure SetEstado(const Value: TEstado);
    function GetId: Integer;
    function GetNome: string;
    function GetCodigoIBGE: Integer;
    function GetCodigoMunicipio: string;
    function GetCodigoDistrito: string;
    function GetEstado: TEstado;
    procedure SetCodigoSubdistrito(const Value: string);
    function GetCodigoSubdistrito: string;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID')]
    property Id: Integer read GetId write SetId;
    [TCampoTexto('NOME', 200, [NOTNULL], 'Cidade')]
    property Nome: string read GetNome write SetNome;
    [TCampoInteiro('CODIGO_IBGE', [NOTNULL], 'Cód. IBGE')]
    property CodigoIBGE: Integer read GetCodigoIBGE write SetCodigoIBGE;
    [TCampoTexto('CODIGO_MUNICIPIO', 10, [], 'Cód. Município', False)]
    property CodigoMunicipio: string read GetCodigoMunicipio write SetCodigoMunicipio;
    [TCampoTexto('CODIGO_DISTRITO', 10, [], 'Cód. Distrito', False)]
    property CodigoDistrito: string read GetCodigoDistrito write SetCodigoDistrito;
    [TCampoTexto('CODIGO_SUBDISTRITO', 10, [], 'Cód. Subdistrito', False)]
    property CodigoSubdistrito: string read GetCodigoSubdistrito write SetCodigoSubdistrito;
    [TCampoEstrangeiro('ESTADO_FK', [NOTNULL], 'ESTADO', 'Abreviacao')]
    property Estado: TEstado read GetEstado write SetEstado;

    class function New : iCidade;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.Entidade;

{ TCidade }

function TCidade.EstaVazia: Boolean;
begin
  Result := (FId = 0);
end;

function TCidade.GetCodigoDistrito: string;
begin
  Result := FCodigoDistrito;
end;

function TCidade.GetCodigoIBGE: Integer;
begin
  Result := FCodigoIBGE;
end;

function TCidade.GetCodigoMunicipio: string;
begin
  Result := FCodigoMunicipio;
end;

function TCidade.GetCodigoSubdistrito: string;
begin
  Result := FCodigoSubdistrito;
end;

function TCidade.GetEstado: TEstado;
begin
   If Not Assigned(FEstado) Then
      FEstado := TUtilsEntidade.ObterObjetoChaveEstrangeira(Self as TObject, TEstado) as TEstado;

   Result := FEstado;
end;

function TCidade.GetId: Integer;
begin
  Result := FId;
end;

function TCidade.GetNome: string;
begin
  Result := FNome;
end;

class function TCidade.New: iCidade;
begin
  Result := Self.Create;
end;

procedure TCidade.SetCodigoDistrito(const Value: string);
begin
  FCodigoDistrito := Value;
end;

procedure TCidade.SetCodigoIBGE(const Value: Integer);
begin
  FCodigoIBGE := Value;
end;

procedure TCidade.SetCodigoMunicipio(const Value: string);
begin
  FCodigoMunicipio := Value;
end;

procedure TCidade.SetCodigoSubdistrito(const Value: string);
begin
  FCodigoSubdistrito := Value;
end;

procedure TCidade.SetEstado(const Value: TEstado);
begin
  FEstado := Value;
end;

procedure TCidade.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCidade.SetNome(const Value: string);
begin
  FNome := Value;
end;

initialization
  RegisterClass(TCidade);

end.
