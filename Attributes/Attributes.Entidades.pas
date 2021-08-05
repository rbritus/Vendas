unit Attributes.Entidades;

interface

Uses
   System.SysUtils, Utils.Enumerators;

type
  TNomeTabela = class(TCustomAttribute)
  private
    FNome: String;
  public
    property Nome: String read FNome write FNome;
    constructor Create(const AValue: String);
  end;

  TTipoAssociacaoEntreTabelas = (taOneToOne, taOneToMany, taManyToOne, taManyToMany);

  TTipoCascata = (ctNoAction, ctCascade, ctSetNull, ctRestrict);

  TAtributosCampo = (CHAVE_PRIMARIA, NOTNULL);

  TConfiguracaoCampo = Set Of TAtributosCampo;

  TAtributoBanco = Class(TCustomAttribute)
   Private
      Fnome        : String;
      FTipo        : TTiposDeCampo;
      Fpropriedades: TConfiguracaoCampo;
      Fcaption     : String;
   Public
      Property nome        : String Read Fnome Write Fnome;
      Property caption     : String Read Fcaption Write Fcaption;
      Property tipo        : TTiposDeCampo Read FTipo Write FTipo;
      Property propriedades: TConfiguracaoCampo Read Fpropriedades
         Write Fpropriedades;
      Function getScriptCampo: String; Virtual;
   End;

   TCampoTexto = Class(TAtributoBanco)
   Private
      fTamanho: Integer;
   Public
      Property tamanho: Integer Read fTamanho Write fTamanho;
      Constructor create(pNome: String; pTamanho: Integer;
         pConfig: TConfiguracaoCampo; pCaption: String = '');
      Function getScriptCampo: String; Override;
   End;

   TCampoInteiro = Class(TAtributoBanco)
   Public
      Constructor create(pNome: String; pConfig: TConfiguracaoCampo;
         pCaption: String = '');
      Function getScriptCampo: String; Override;
   End;

   TCampoDecimal = Class(TAtributoBanco)
   Private
      fTamanho : Integer;
      fPrecisao: Integer;
   Public
      Property tamanho : Integer Read fTamanho Write fTamanho;
      Property precisao: Integer Read fPrecisao Write fPrecisao;
      Constructor create(pNome: String; pTamanho, pPrecisao: Integer;
         pConfig: TConfiguracaoCampo; pCaption: String = '');
      Function getScriptCampo: String; Override;
   End;

   TCampoData = Class(TAtributoBanco)
   Public
      Constructor create(pNome: String; pConfig: TConfiguracaoCampo;
         pCaption: String = '');
      Function getScriptCampo: String; Override;
   End;

   TCampoLogico = Class(TAtributoBanco)
      Constructor create(pNome: String; pConfig: TConfiguracaoCampo;
         pCaption: String = '');
      Function getScriptCampo: String; Override;
   End;

   TCampoEstrangeiro = Class(TCampoInteiro)
   Private
      FCampoDescricaoConsulta: string;
   Public
      Constructor create(pNome: String; pConfig: TConfiguracaoCampo;
         pCaption: String = ''; pCampoDescricaoConsulta: String = '');
      //Propriedade utilizada na consulta da entidade, ela aponta qual é a
      //propriedade que serve como descrição da entidade relacionada
      property CampoDescricaoConsulta: string Read FCampoDescricaoConsulta
         Write FCampoDescricaoConsulta;
   End;

   TCampoListagem = Class(TAtributoBanco)
   Private
      FTipoCascata     : TTipoCascata;
      FTipoAssociacao  : TTipoAssociacaoEntreTabelas;
      FCampoFilho      : String;
      FCampoPai        : String;
      FTabelaRelacional: String;
   Public
      Property TipoAssociacao  : TTipoAssociacaoEntreTabelas Read FTipoAssociacao Write FTipoAssociacao;
      Property TipoCascata     : TTipoCascata Read FTipoCascata Write FTipoCascata;
      Property CampoPai        : String Read FCampoPai Write FCampoPai;
      Property CampoFilho      : String Read FCampoFilho Write FCampoFilho;
      Property TabelaRelacional: String Read FTabelaRelacional Write FTabelaRelacional;
      Constructor create(pTipoAssociacao: TTipoAssociacaoEntreTabelas;
         pTipoCascata: TTipoCascata; pCampoPai, pCampoFilho,
         pTabelaRelacional: String);
      Function getScriptCampo: String; Override;
   End;

   TCampoBlob = Class(TAtributoBanco)
   Public
      Constructor create(pNome: String; pConfig: TConfiguracaoCampo;
        pCaption: String = '');
      Function getScriptCampo: String; Override;
   End;

implementation

{ TableName }

constructor TNomeTabela.Create(const AValue: String);
begin
   Self.Nome := AValue;
end;

{ TCampoTexto }

Constructor TCampoTexto.create(pNome: String; pTamanho: Integer;
   pConfig: TConfiguracaoCampo; pCaption: String = '');
Begin
   self.nome         := pNome;
   self.tipo         := ftTEXTO;
   self.tamanho      := pTamanho;
   self.propriedades := pConfig;
   self.caption      := pCaption;
End;

Function TCampoTexto.getScriptCampo: String;
Var
   cRetorno: String;
Begin
//   cRetorno := self.nome + ' character varying(' + IntToStr(self.tamanho) + ')';
   cRetorno := self.nome + ' TEXT';

   If NOTNULL In self.propriedades Then
      cRetorno := cRetorno + ' not null';

   Result := cRetorno;
End;

{ TCampoInteiro }

Constructor TCampoInteiro.create(pNome: String; pConfig: TConfiguracaoCampo;
   pCaption: String = '');
Begin
   self.nome         := pNome;
   self.tipo         := ftINTEIRO;
   self.propriedades := pConfig;
   self.caption      := pCaption;
End;

Function TCampoInteiro.getScriptCampo: String;
Var
   cRetorno: String;
Begin
   cRetorno := self.nome + ' integer';

   If NOTNULL In self.propriedades Then
      cRetorno := cRetorno + ' not null';

   Result := cRetorno;
End;

{ TAtributoBanco }

Function TAtributoBanco.getScriptCampo: String;
Begin
   Raise EAccessViolation.create('Método não pode ser chamado da classe pai');
End;

{ TCampoData }

Constructor TCampoData.create(pNome: String; pConfig: TConfiguracaoCampo;
   pCaption: String = '');
Begin
   self.nome         := pNome;
   self.tipo         := ftDATA;
   self.propriedades := pConfig;
   self.caption      := pCaption;
End;

Function TCampoData.getScriptCampo: String;
Var
   cRetorno: String;
Begin
   cRetorno := self.nome + ' date';

   If NOTNULL In self.propriedades Then
      cRetorno := cRetorno + ' not null';

   Result := cRetorno;
End;

{ TCampoEstrangeiro }

Constructor TCampoEstrangeiro.create(pNome: String; pConfig: TConfiguracaoCampo;
   pCaption: String = ''; pCampoDescricaoConsulta: String = '');
Begin
   self.nome         := pNome;
   self.tipo         := ftESTRANGEIRO;
   self.propriedades := pConfig;
   self.caption      := pCaption;
   Self.CampoDescricaoConsulta := pCampoDescricaoConsulta;
End;

{ TCampoListagem }

Constructor TCampoListagem.create(pTipoAssociacao: TTipoAssociacaoEntreTabelas;
   pTipoCascata: TTipoCascata; pCampoPai, pCampoFilho, pTabelaRelacional
   : String);
Begin
   self.tipo             := ftLISTAGEM;
   self.TipoAssociacao   := pTipoAssociacao;
   self.TipoCascata      := pTipoCascata;
   self.CampoPai         := pCampoPai;
   self.CampoFilho       := pCampoFilho;
   self.TabelaRelacional := pTabelaRelacional;
End;

Function TCampoListagem.getScriptCampo: String;
Begin
   getScriptCampo := '';
End;

{ TCampoDecimal }

Constructor TCampoDecimal.create(pNome: String; pTamanho, pPrecisao: Integer;
   pConfig: TConfiguracaoCampo; pCaption: String = '');
Begin
   self.nome         := pNome;
   self.tipo         := ftDECIMAL;
   self.propriedades := pConfig;
   self.caption      := pCaption;
   self.tamanho      := pTamanho;
   self.precisao     := pPrecisao;
End;

Function TCampoDecimal.getScriptCampo: String;
Var
   cRetorno: String;
Begin
   cRetorno := Format(' %s numeric(%d, %d)', [self.nome, self.tamanho, self.precisao]);

   If NOTNULL In self.propriedades Then
      cRetorno := cRetorno + ' not null';

   Result := cRetorno;
End;

{ TCampoLogico }

Constructor TCampoLogico.create(pNome: String; pConfig: TConfiguracaoCampo;
   pCaption: String);
Begin
   self.nome         := pNome;
   self.tipo         := ftLOGICO;
   self.propriedades := pConfig;
   self.caption      := pCaption;
End;

Function TCampoLogico.getScriptCampo: String;
Var
   cRetorno: String;
Begin
   cRetorno := self.nome + ' boolean';

   If NOTNULL In self.propriedades Then
      cRetorno := cRetorno + ' not null';

   Result := cRetorno;
End;

{ TCampoBlob }

constructor TCampoBlob.create(pNome: String; pConfig: TConfiguracaoCampo;
  pCaption: String);
begin
   self.nome         := pNome;
   self.tipo         := ftBLOBT;
   self.propriedades := pConfig;
   self.caption      := pCaption;
end;

Function TCampoBlob.getScriptCampo: String;
Var
   cRetorno: String;
Begin
   cRetorno := self.nome + ' bytea';

   If NOTNULL In self.propriedades Then
      cRetorno := cRetorno + ' not null';

   Result := cRetorno;
End;

end.
