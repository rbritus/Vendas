unit Attributes.Entidades;

interface

uses
  System.SysUtils, Utils.Enumerators, Objeto.CustomSelect;

type
  TNomeTabela = class(TCustomAttribute)
  private
    FNome: string;
  public
    property Nome: string read FNome write FNome;
    constructor Create(const AValue: string);
  end;

  TTipoAssociacaoEntreTabelas = (taOneToOne, taOneToMany, taManyToOne, taManyToMany);

  TTipoCascata = (ctNoAction, ctCascade, ctSetNull, ctRestrict);

  TAtributosCampo = (CHAVE_PRIMARIA, NOTNULL);

  TConfiguracaoCampo = set of TAtributosCampo;

  TAtributoBanco = class(TCustomAttribute)
  private
    Fnome: string;
    FTipo: TTiposDeCampo;
    Fpropriedades: TConfiguracaoCampo;
    Fcaption: string;
    FVisivel: Boolean;
    FCustomSelect: TClasseCustom;
  public
    property nome: string read Fnome write Fnome;
    property caption: string read Fcaption write Fcaption;
    property tipo: TTiposDeCampo read FTipo write FTipo;
    property propriedades: TConfiguracaoCampo read Fpropriedades write Fpropriedades;
    property Visivel: Boolean read FVisivel write FVisivel;
    property CustomSelect: TClasseCustom read FCustomSelect write FCustomSelect;
    function getScriptCampo: string; virtual;
  end;

  TCampoTexto = class(TAtributoBanco)
  private
    fTamanho: Integer;
  public
    property tamanho: Integer read fTamanho write fTamanho;
    constructor create(pNome: string; pTamanho: Integer; pConfig: TConfiguracaoCampo;
      pCaption: string = ''; pVisivel: Boolean = True); overload;
    constructor create(pNome: string; pTamanho: Integer; pConfig: TConfiguracaoCampo;
      pTCustomSelect: TClasseCustom; pCaption: string = ''); overload;
    function getScriptCampo: string; override;
  end;

  TCampoInteiro = class(TAtributoBanco)
  public
    constructor create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string = '';
      pVisivel: Boolean = True); overload;
    constructor create(pNome: string; pConfig: TConfiguracaoCampo; pTCustomSelect: TClasseCustom;
      pCaption: string = ''; pVisivel: Boolean = True); overload;
    function getScriptCampo: string; override;
  end;

  TCampoDecimal = class(TAtributoBanco)
  private
    fTamanho: Integer;
    fPrecisao: Integer;
  public
    property tamanho: Integer read fTamanho write fTamanho;
    property precisao: Integer read fPrecisao write fPrecisao;
    constructor create(pNome: string; pTamanho, pPrecisao: Integer; pConfig:
      TConfiguracaoCampo; pCaption: string = ''; pVisivel: Boolean = True);
    function getScriptCampo: string; override;
  end;

  TCampoData = class(TAtributoBanco)
  public
    constructor create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string = '';
      pVisivel: Boolean = True);
    function getScriptCampo: string; override;
  end;

  TCampoLogico = class(TAtributoBanco)
    constructor create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string = '';
      pVisivel: Boolean = True);
    function getScriptCampo: string; override;
  end;

  TCampoEstrangeiro = class(TCampoInteiro)
  private
    FCampoDescricaoConsulta: string;
  public
    constructor create(pNome: string; pConfig: TConfiguracaoCampo; pTabela: string = '';
      pCampoDescricaoConsulta: string = ''; pVisivel: Boolean = True);
      //Propriedade utilizada na consulta da entidade, ela aponta qual é a
      //propriedade que serve como descrição da entidade relacionada
    property CampoDescricaoConsulta: string read FCampoDescricaoConsulta write FCampoDescricaoConsulta;
  end;

  TCampoListagem = class(TAtributoBanco)
  private
    FTipoCascata: TTipoCascata;
    FTipoAssociacao: TTipoAssociacaoEntreTabelas;
    FCampoFilho: string;
    FCampoPai: string;
    FTabelaRelacional: string;
  public
    property TipoAssociacao: TTipoAssociacaoEntreTabelas read FTipoAssociacao write FTipoAssociacao;
    property TipoCascata: TTipoCascata read FTipoCascata write FTipoCascata;
    property CampoPai: string read FCampoPai write FCampoPai;
    property CampoFilho: string read FCampoFilho write FCampoFilho;
    property TabelaRelacional: string read FTabelaRelacional write FTabelaRelacional;
    constructor create(pTipoAssociacao: TTipoAssociacaoEntreTabelas; pTipoCascata: TTipoCascata; pCampoPai, pCampoFilho, pTabelaRelacional: string);
    function getScriptCampo: string; override;
  end;

  TCampoBlob = class(TAtributoBanco)
  public
    constructor create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string = '');
    function getScriptCampo: string; override;
  end;

implementation

{ TableName }

constructor TNomeTabela.Create(const AValue: string);
begin
  Self.Nome := AValue;
end;

{ TCampoTexto }

constructor TCampoTexto.create(pNome: string; pTamanho: Integer; pConfig: TConfiguracaoCampo;
  pCaption: string = ''; pVisivel: Boolean = True);
begin
  self.nome := pNome;
  self.tipo := ftTEXTO;
  self.tamanho := pTamanho;
  self.propriedades := pConfig;
  self.caption := pCaption;
  Self.Visivel := pVisivel;
  Self.CustomSelect := nil;
end;

constructor TCampoTexto.create(pNome: string; pTamanho: Integer;
  pConfig: TConfiguracaoCampo; pTCustomSelect: TClasseCustom; pCaption: string = '');
begin
  self.nome := pNome;
  self.tipo := ftTEXTO;
  self.tamanho := pTamanho;
  self.propriedades := pConfig;
  self.caption := pCaption;
  Self.Visivel := True;
  Self.CustomSelect := pTCustomSelect;
end;

function TCampoTexto.getScriptCampo: string;
var
  cRetorno: string;
begin
//   cRetorno := self.nome + ' character varying(' + IntToStr(self.tamanho) + ')';
  cRetorno := self.nome + ' TEXT';

  if NOTNULL in self.propriedades then
    cRetorno := cRetorno + ' not null';

  Result := cRetorno;
end;

{ TCampoInteiro }

constructor TCampoInteiro.create(pNome: string; pConfig: TConfiguracaoCampo;
  pCaption: string = ''; pVisivel: Boolean = True);
begin
  self.nome := pNome;
  self.tipo := ftINTEIRO;
  self.propriedades := pConfig;
  self.caption := pCaption;
  Self.Visivel := pVisivel;
  Self.CustomSelect := nil;
end;

constructor TCampoInteiro.create(pNome: string; pConfig: TConfiguracaoCampo;
  pTCustomSelect: TClasseCustom; pCaption: string; pVisivel: Boolean);
begin
  self.nome := pNome;
  self.tipo := ftINTEIRO;
  self.propriedades := pConfig;
  self.caption := pCaption;
  Self.Visivel := pVisivel;
  Self.CustomSelect := pTCustomSelect;
end;

function TCampoInteiro.getScriptCampo: string;
var
  cRetorno: string;
begin
  cRetorno := self.nome + ' integer';

  if NOTNULL in self.propriedades then
    cRetorno := cRetorno + ' not null';

  Result := cRetorno;
end;

{ TAtributoBanco }

function TAtributoBanco.getScriptCampo: string;
begin
  raise EAccessViolation.create('Método não pode ser chamado da classe pai');
end;

{ TCampoData }

constructor TCampoData.create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string = '';
  pVisivel: Boolean = True);
begin
  self.nome := pNome;
  self.tipo := ftDATA;
  self.propriedades := pConfig;
  self.caption := pCaption;
  self.Visivel := pVisivel;
  Self.CustomSelect := nil;
end;

function TCampoData.getScriptCampo: string;
var
  cRetorno: string;
begin
  cRetorno := self.nome + ' date';

  if NOTNULL in self.propriedades then
    cRetorno := cRetorno + ' not null';

  Result := cRetorno;
end;

{ TCampoEstrangeiro }

constructor TCampoEstrangeiro.create(pNome: string; pConfig: TConfiguracaoCampo;
  pTabela: string = ''; pCampoDescricaoConsulta: string = ''; pVisivel: Boolean = True);
begin
  self.nome := pNome;
  self.tipo := ftESTRANGEIRO;
  self.propriedades := pConfig;
  self.caption := pTabela;
  Self.CampoDescricaoConsulta := pCampoDescricaoConsulta;
  self.Visivel := pVisivel;
  Self.CustomSelect := nil;
end;

{ TCampoListagem }

constructor TCampoListagem.create(pTipoAssociacao: TTipoAssociacaoEntreTabelas;
  pTipoCascata: TTipoCascata; pCampoPai, pCampoFilho, pTabelaRelacional: string);
begin
  self.tipo := ftLISTAGEM;
  self.TipoAssociacao := pTipoAssociacao;
  self.TipoCascata := pTipoCascata;
  self.CampoPai := pCampoPai;
  self.CampoFilho := pCampoFilho;
  self.TabelaRelacional := pTabelaRelacional;
  self.Visivel := False;
  Self.CustomSelect := nil;
end;

function TCampoListagem.getScriptCampo: string;
begin
  Result := EmptyStr;
  if self.TipoAssociacao <> taManyToMany then
    Exit;

  var cRetorno := 'Create Table ' + self.TabelaRelacional + '(' + sLineBreak;
  cRetorno := cRetorno + 'ID integer not null primary key AUTOINCREMENT,';
  cRetorno := cRetorno + self.CampoPai + ' integer not null, ';
  cRetorno := cRetorno + self.CampoFilho + ' integer not null, ';
  cRetorno := cRetorno + 'FOREIGN KEY(' + self.CampoPai + ') REFERENCES ' +
    StringReplace(self.CampoPai, '_FK', '', [rfReplaceAll]) + '(ID),';
  cRetorno := cRetorno + 'FOREIGN KEY(' + self.CampoFilho + ') REFERENCES ' +
    StringReplace(self.CampoFilho, '_FK', '', [rfReplaceAll]) + '(ID));';
  Result := cRetorno;
end;

{ TCampoDecimal }

constructor TCampoDecimal.create(pNome: string; pTamanho, pPrecisao: Integer;
  pConfig: TConfiguracaoCampo; pCaption: string = ''; pVisivel: Boolean = True);
begin
  self.nome := pNome;
  self.tipo := ftDECIMAL;
  self.propriedades := pConfig;
  self.caption := pCaption;
  self.tamanho := pTamanho;
  self.precisao := pPrecisao;
  self.Visivel := pVisivel;
  Self.CustomSelect := nil;
end;

function TCampoDecimal.getScriptCampo: string;
var
  cRetorno: string;
begin
  cRetorno := Format(' %s numeric(%d, %d)', [self.nome, self.tamanho, self.precisao]);

  if NOTNULL in self.propriedades then
    cRetorno := cRetorno + ' not null';

  Result := cRetorno;
end;

{ TCampoLogico }

constructor TCampoLogico.create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string = '';
  pVisivel: Boolean = True);
begin
  self.nome := pNome;
  self.tipo := ftLOGICO;
  self.propriedades := pConfig;
  self.caption := pCaption;
  self.Visivel := pVisivel;
  Self.CustomSelect := nil;
end;

function TCampoLogico.getScriptCampo: string;
var
  cRetorno: string;
begin
  cRetorno := self.nome + ' boolean';

  if NOTNULL in self.propriedades then
    cRetorno := cRetorno + ' not null';

  Result := cRetorno;
end;

{ TCampoBlob }

constructor TCampoBlob.create(pNome: string; pConfig: TConfiguracaoCampo; pCaption: string);
begin
  self.nome := pNome;
  self.tipo := ftBLOBT;
  self.propriedades := pConfig;
  self.caption := pCaption;
  self.Visivel := False;
  Self.CustomSelect := nil;
end;

function TCampoBlob.getScriptCampo: string;
var
  cRetorno: string;
begin
  cRetorno := self.nome + ' bytea';

  if NOTNULL in self.propriedades then
    cRetorno := cRetorno + ' not null';

  Result := cRetorno;
end;

end.

