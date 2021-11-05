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
  Entidade.Cidade;

type
  [TClasseCadastro(TEndereco)]
  TFrmCadastroEndereco = class(TFrmCadastroPadrao)
    Label1: TLabel;
    [TCadastroEdit('CEP',ftTEXTO,coObrigatorio)]
    edtCEP: TEdit;
    btnConsultaCEP: TBitBtn;
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
    [TCadastroEdit('Bairro',ftTEXTO,coObrigatorio)]
    edtBairro: TEdit;
    [TCampoExibicao('NOME')]
    [TClassePesquisa(TCidade)]
    FramePesquisaCidade: TFramePesquisaEntidadePadrao;
    Label6: TLabel;
    edtEstado: TEdit;
    [TCadastroComboBox('TipoEndereco',ftENUMERATOR,coObrigatorio)]
    cmbTipoEndereco: TComboBox;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConsultaCEPClick(Sender: TObject);
    procedure FramePesquisaCidadeEdit1Change(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
  private
    { Private declarations }
    [TCadastroVariavel('Cidade',ftESTRANGEIRO,coObrigatorio)]
    FCidade: TCidade;
    procedure ConsultarCEP;
    procedure PreencherDadosDaTela(ConsultaCEP: iConsultaCEP);
    procedure PreencherFrameCidade(ACidade: TCidade);
    procedure PreencherCidadePeloCodigoIBGE(IBGE: string);
  public
    { Public declarations }
  end;

var
  FrmCadastroEndereco: TFrmCadastroEndereco;

implementation

uses
  Controller.Objeto.ConsultaCEP, Utils.Entidade;

{$R *.dfm}

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
  var ConsultaCEP := ControllerConsultaCEP.Get(edtCEP.Text);
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

end.
