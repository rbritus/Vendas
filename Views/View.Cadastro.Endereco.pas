unit View.Cadastro.Endereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Entidade.Endereco,
  Attributes.Forms, Frame.Padrao, Frame.Pesquisa.Entidade.Padrao, Vcl.StdCtrls,
  Utils.Enumerators, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Interfaces.Controller.Objeto.ConsultaCEP, Interfaces.Objeto.ConsultaCEP,
  Entidade.Cidade, Vcl.Mask, Utils.Constants, System.Actions, Vcl.ActnList;

type
  [TClasseCadastro(TEndereco)]
  TFrmCadastroEndereco = class(TFrmCadastroPadrao)
    Label1: TLabel;
    [TMascaraCampo(TConstantsMasks.CEP)]
    [TCadastroEdit('CEP',ftTEXTO,coObrigatorio)]
    edtCEP: TMaskEdit;
    btnConsultaCEP: TSpeedButton;
    Label2: TLabel;
    [TCadastroEdit('Logradouro',ftTEXTO,coObrigatorio)]
    edtLogradouro: TEdit;
    Label3: TLabel;
    [TCadastroEdit('Numero',ftINTEIRO,coObrigatorio)]
    edtNumero: TEdit;
    Label4: TLabel;
    [TCadastroEdit('Complemento',ftTEXTO,coNaoObrigatorio)]
    edtComplemento: TEdit;
    Label5: TLabel;
    [TCadastroEdit('Bairro',ftTEXTO,coNaoObrigatorio)]
    edtBairro: TEdit;
    [TCampoExibicao('NOME')]
    [TClassePesquisa(TCidade)]
    FramePesquisaCidade: TFramePesquisaEntidadePadrao;
    Label6: TLabel;
    edtEstado: TEdit;
    [TCadastroComboBox('TipoEndereco',ftENUMERATOR,coObrigatorio)]
    cmbTipoEndereco: TComboBox;
    Label7: TLabel;
    procedure btnConsultaCEPClick(Sender: TObject);
    procedure FramePesquisaCidadeEdit1Change(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    [TCadastroVariavel('Cidade',ftESTRANGEIRO,coObrigatorio,'FramePesquisaCidade')]
    FCidade: TCidade;
    procedure ConsultarCEP;
    procedure PreencherDadosDaTela(ConsultaCEP: iConsultaCEP);
    procedure PreencherFrameCidade(ACidade: TCidade);
    procedure PreencherCidadePeloCodigoIBGE(IBGE: string);
    function ObterCEPSemMascara: string;
    function CEPValido: Boolean;
  public
    { Public declarations }
    function ValidacoesEspecificasAtendidas: Boolean; override;
  end;

var
  FrmCadastroEndereco: TFrmCadastroEndereco;

implementation

uses
  Controller.Objeto.ConsultaCEP, Utils.Entidade, Utils.Validacoes,
  Controller.Componente.TImagemValidacao;

{$R *.dfm}

function TFrmCadastroEndereco.ValidacoesEspecificasAtendidas: Boolean;
begin
  inherited;
  Result := CEPValido;
end;

function TFrmCadastroEndereco.CEPValido: Boolean;
begin
  Result := TUtilsValidacoes.CEPValido(ObterCEPSemMascara);
  if not Result then
  begin
    var Mensagem := 'CEP inválido.';
    var ControllerTImagemValidacao := TControllerTImagemValidacao.New(Self);
    ControllerTImagemValidacao.CriarImagemDeValidacao(edtCEP, Mensagem);
  end;
end;

procedure TFrmCadastroEndereco.PreencherFrameCidade(ACidade: TCidade);
begin
  if not Assigned(ACidade) then
    Exit;

  FramePesquisaCidade.CarregarEntidade(ACidade.Id);
end;

procedure TFrmCadastroEndereco.PreencherCidadePeloCodigoIBGE(IBGE: string);
const
  PRIMEIRO = 0;
begin
  var ListaCidade := TCidade.PesquisarPorCondicao('CODIGO_IBGE = ' + IBGE.QuotedString);
  try
    var Cidade := TCidade(TUtilsEntidade.ObterCloneObjeto(ListaCidade.Items[PRIMEIRO]));
    PreencherFrameCidade(Cidade);
    Cidade.Free;
  finally
    ListaCidade.Free;
  end;
end;

procedure TFrmCadastroEndereco.PreencherDadosDaTela(ConsultaCEP: iConsultaCEP);
begin
  if not Assigned(ConsultaCEP) then
    Exit;

  edtLogradouro.Text := ConsultaCEP.Logradouro;
  edtComplemento.Text := ConsultaCEP.Complemento;
  edtBairro.Text := ConsultaCEP.Bairro;
  PreencherCidadePeloCodigoIBGE(ConsultaCEP.IBGE);
end;

procedure TFrmCadastroEndereco.ConsultarCEP;
begin
  var ControllerConsultaCEP := TControllerObjetoConsultaCEP.New;
  var ConsultaCEP := ControllerConsultaCEP.Get(ObterCEPSemMascara);
  PreencherDadosDaTela(ConsultaCEP);
end;

procedure TFrmCadastroEndereco.btnCadastrarClick(Sender: TObject);
begin
  FCidade := TCidade(FramePesquisaCidade.ObterEntidade);
  inherited;
end;

procedure TFrmCadastroEndereco.btnConsultaCEPClick(Sender: TObject);
begin
  inherited;
  if not CEPValido then
    Exit;

  ConsultarCEP;
  cmbTipoEndereco.SetFocus;
end;

procedure TFrmCadastroEndereco.FormShow(Sender: TObject);
begin
  inherited;
  PreencherFrameCidade(FCidade);
  edtCEP.SetFocus;
end;

procedure TFrmCadastroEndereco.FramePesquisaCidadeEdit1Change(Sender: TObject);
begin
  inherited;
  if Trim(FramePesquisaCidade.Edit1.Text) = EmptyStr then
  begin
    edtEstado.Clear;
    Exit;
  end;

  var Cidade := TCidade(FramePesquisaCidade.ObterEntidade);
  try
    edtEstado.Text := Cidade.Estado.Abreviacao;
  finally
    Cidade.Free;
  end;
end;

function TFrmCadastroEndereco.ObterCEPSemMascara: string;
begin
  edtCEP.EditMask := String.Empty;
  Result := edtCEP.Text;
  edtCEP.EditMask := TConstantsMasks.CEP;
end;

end.
