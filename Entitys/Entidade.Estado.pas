unit Entidade.Estado;

interface

uses
  System.Classes, Entidade.Padrao, Attributes.Entidades, System.SysUtils,
  Interfaces.Entidade.Estado, Entidade.Pais;

type
  [TNomeTabela('ESTADO')]
  TEstado = class(TEntidade<TEstado>, iEstado)
  private
    FId: Integer;
    FNome: string;
    FAbreviacao: string;
    FCodigoUF: Integer;
    FPais: TPais;
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetAbreviacao(const Value: string);
    procedure SetCodigoUF(const Value: Integer);
    procedure SetPais(const Value: TPais);
    function GetId: Integer;
    function GetNome: string;
    function GetAbreviacao: string;
    function GetCodigoUF: Integer;
    function GetPais: TPais;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID')]
    property Id: Integer read GetId write SetId;
    [TCampoTexto('NOME', 100, [NOTNULL], 'Estado')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('ABREVIACAO', 2, [NOTNULL], 'UF')]
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    [TCampoInteiro('CODIGO_UF', [], 'Código',False)]
    property CodigoUF: Integer read GetCodigoUF write SetCodigoUF;
    [TCampoEstrangeiro('PAIS_FK', [NOTNULL], 'PAIS', 'Abreviacao')]
    property Pais: TPais read GetPais write SetPais;

    class function New : iEstado;
    function EstaVazia(): Boolean; override;
  end;

implementation

uses
  Utils.Entidade;

{ TEstado }

function TEstado.EstaVazia: Boolean;
begin
  Result := (FId = 0);
end;

function TEstado.GetAbreviacao: string;
begin
  Result := FAbreviacao;
end;

function TEstado.GetCodigoUF: Integer;
begin
  Result := FCodigoUF;
end;

function TEstado.GetId: Integer;
begin
  Result := FId;
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

procedure TEstado.SetId(const Value: Integer);
begin
  FId := Value;
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
