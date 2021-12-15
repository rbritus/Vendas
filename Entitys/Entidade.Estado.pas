unit Entidade.Estado;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Estado, Entidade.Pais, Utils.Constants;

type
  [TNomeTabela('ESTADO')]
  TEstado = class(TEntidade<TEstado>, iEstado)
  private
    FGUID: string;
    FNome: string;
    FAbreviacao: string;
    FCodigoUF: Integer;
    FPais: TPais;
    procedure SetGUID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetAbreviacao(const Value: string);
    procedure SetCodigoUF(const Value: Integer);
    procedure SetPais(const Value: TPais);
    function GetGUID: string;
    function GetNome: string;
    function GetAbreviacao: string;
    function GetCodigoUF: Integer;
    function GetPais: TPais;
  public
    [TCampoTexto('GUID', TConstantsInteger.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('NOME', 100, [NOTNULL], 'Estado')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('ABREVIACAO', 2, [NOTNULL], 'UF')]
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    [TCampoInteiro('CODIGO_UF', [], 'Código',False)]
    property CodigoUF: Integer read GetCodigoUF write SetCodigoUF;
    [TCampoEstrangeiro('PAIS_FK', [NOTNULL], 'PAIS', 'Abreviacao', 'País')]
    property Pais: TPais read GetPais write SetPais;

    class function New : iEstado;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.Entidade, Utils.GUID;

{ TEstado }

function TEstado.EstaVazia: Boolean;
begin
  Result := (FGUID = string.Empty);
end;

function TEstado.GetAbreviacao: string;
begin
  Result := FAbreviacao;
end;

function TEstado.GetCodigoUF: Integer;
begin
  Result := FCodigoUF;
end;

function TEstado.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TEstado.GetNome: string;
begin
  Result := FNome;
end;

function TEstado.GetPais: TPais;
begin
   If Not Assigned(FPais) Then
      FPais := TUtilsEntidade.ObterObjetoChaveEstrangeira(Self as TObject, TPais) as TPais;

   Result := FPais;
end;

class function TEstado.New: iEstado;
begin
  Result := Self.Create;
end;

procedure TEstado.SetAbreviacao(const Value: string);
begin
  FAbreviacao := Value;
end;

procedure TEstado.SetCodigoUF(const Value: Integer);
begin
  FCodigoUF := Value;
end;

procedure TEstado.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TEstado.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TEstado.SetPais(const Value: TPais);
begin
  FPais := Value;
end;

initialization
  RegisterClass(TEstado);

end.
