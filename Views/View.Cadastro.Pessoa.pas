unit View.Cadastro.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, Vcl.Buttons, Interfaces.Entidade.Pessoa, Vcl.ExtCtrls,
  Entidade.Pessoa, Attributes.Forms, Vcl.StdCtrls, Vcl.WinXCtrls,
  Utils.Enumerators, Frame.Padrao, Frame.Adicao.Padrao, Frame.Adicao.Endereco,
  Entidade.Endereco, Componente.TObjectList, Frame.Pesquisa.Entidade.Padrao,
  System.ImageList, Vcl.ImgList, Vcl.Mask, Utils.Constants,
  Frame.Adicao.Telefone, Entidade.Telefone, System.Actions, Vcl.ActnList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  [TClasseCadastro(TPessoa)]
  TFrmCadastroPessoa = class(TFrmCadastroPadrao)
    Label2: TLabel;
    [TCadastroEdit('Nome',ftTEXTO,coObrigatorio)]
    edtNome: TEdit;
    [TCadastroToggleSwitch('Ativo',ftTEXTO,coObrigatorio)]
    tswAtivo: TToggleSwitch;
    Label3: TLabel;
    FrameAdicaoEndereco: TFrameAdicaoEndereco;
    [TMascaraCampo(TConstantsMasks.CPF)]
    [TCadastroEdit('CPF',ftTEXTO,coObrigatorio)]
    edtCPF: TMaskEdit;
    Label1: TLabel;
    FrameAdicaoTelefone: TFrameAdicaoTelefone;
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    [TCadastroVariavel('Enderecos',ftLISTAGEM,coObrigatorio,'FrameAdicaoEndereco')]
    FEnderecos: TObjectListFuck<TEndereco>;
    [TCadastroVariavel('Telefones',ftLISTAGEM,coNaoObrigatorio,'FrameAdicaoTelefone')]
    FTelefones: TObjectListFuck<TTelefone>;
    function CPFValido: Boolean;
    const DUAS_LINHAS = 2;
    procedure LimparEntidades;
    { Private declarations }
  public
    { Public declarations }
    function ValidacoesEspecificasAtendidas: Boolean; override;
  end;

var
  FrmCadastroPessoa: TFrmCadastroPessoa;

implementation

uses
  Utils.Validacoes, Controller.Componente.TImagemValidacao;

{$R *.dfm}

function TFrmCadastroPessoa.CPFValido: Boolean;
begin
  Result := TUtilsValidacoes.CPFValido(edtCPF.Text);
  if not Result then
  begin
    var Mensagem := 'CPF inválido.';
    CriarImagemDeValidacaoParaCampo(edtCPF, Mensagem);
  end;
end;

procedure TFrmCadastroPessoa.btnCadastrarClick(Sender: TObject);
begin
  LimparEntidades;
  FEnderecos := FrameAdicaoEndereco.ObterLista;
  FTelefones := FrameAdicaoTelefone.ObterLista;
  inherited;
end;

procedure TFrmCadastroPessoa.FormShow(Sender: TObject);
begin
  inherited;
  FrameAdicaoEndereco.QuantidadeMaximaDeLinhas := DUAS_LINHAS;
  FrameAdicaoEndereco.CarregarFrame(Self.FGUID);
  FrameAdicaoTelefone.QuantidadeMaximaDeLinhas := DUAS_LINHAS;
  FrameAdicaoTelefone.CarregarFrame(Self.FGUID);
  edtCPF.SetFocus;
end;

procedure TFrmCadastroPessoa.LimparEntidades;
begin
  if Assigned(FEnderecos) then
    FEnderecos.Free;

  if Assigned(FTelefones) then
    FTelefones.Free;
end;

function TFrmCadastroPessoa.ValidacoesEspecificasAtendidas: Boolean;
begin
  inherited;
  Result := CPFValido;
end;

end.
