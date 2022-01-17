unit Entidade.Imagem;

interface

uses
  System.Classes, Entidade.Padrao, Interfaces.Entidade.Imagem,
  Attributes.Entidades, System.SysUtils, Utils.Constants, Utils.GUID,
  Utils.Enumerators, Objeto.Blob;

type
  [TNomeTabela('IMAGEM')]
  TImagem = class(TEntidade<TImagem>, iImagem)
  private
    FGUID: string;
    FNome: string;
    FArquivo: TBlobImagem;
    FExtensao: TTipoExtensao;
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    function GetArquivo: TBlobImagem;
    procedure SetExtensao(const Value: TTipoExtensao);
    function GetExtensao: TTipoExtensao;
  public
    [TCampoTexto('GUID', TConstantsEntidade.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID', False)]
    property GUID: string read GetGUID write SetGUID;
    [TCampoTexto('NOME', TConstantsEntidade.TAMANHO_NOME, [NOTNULL], 'Nome')]
    property Nome: string read GetNome write SetNome;
    [TCampoTexto('EXTENSAO', TConstantsEntidade.TAMANHO_EXTENSAO, [NOTNULL], 'Extensão')]
    property Extensao: TTipoExtensao read GetExtensao write SetExtensao;
    [TCampoBlob('ARQUIVO', [NOTNULL], 'Arquivo')]
    property Arquivo: TBlobImagem read GetArquivo;

    class function New : iImagem;
    function EstaVazia: Boolean; override;
  end;

implementation

{ TProduto }

function TImagem.EstaVazia: Boolean;
begin
  Result := (FNome.Trim.IsEmpty) and Arquivo.IsEmpty;
end;

function TImagem.GetArquivo: TBlobImagem;
begin
  if not Assigned(FArquivo) then
    FArquivo := TBlobImagem.Create;

  Result := FArquivo;
end;

function TImagem.GetExtensao: TTipoExtensao;
begin
  Result := FExtensao;
end;

function TImagem.GetGUID: string;
begin
  if FGUID.Trim.IsEmpty then
    FGUID := TUtilsGUID.CreateClassGUID;

  Result := FGUID;
end;

function TImagem.GetNome: string;
begin
  Result := FNome;
end;

class function TImagem.New: iImagem;
begin
  Result := Self.Create;
end;

procedure TImagem.SetExtensao(const Value: TTipoExtensao);
begin
  FExtensao := Value;
end;

procedure TImagem.SetGUID(const Value: string);
begin
  FGUID := Value;
end;

procedure TImagem.SetNome(const Value: string);
begin
  FNome := Value;
end;

initialization
  RegisterClass(TImagem);

end.
