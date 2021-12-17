unit View.Cadastro.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Controller.Cadastro.Padrao, Attributes.Forms, Utils.Enumerators,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFrmCadastroPadrao = class(TFrmPadrao)
    pnlMenu: TPanel;
    btnCancelar: TButton;
    btnCadastrar: TButton;
    pnlBarraLateralBotao: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCadastrarMouseEnter(Sender: TObject);
    procedure btnCadastrarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarEnter(Sender: TObject);
    procedure btnCadastrarExit(Sender: TObject);
    procedure btnCancelarEnter(Sender: TObject);
    procedure btnCancelarExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure GravarEntidade;
    procedure InicializarID;
    procedure CarregarLayoutDinamico;
    procedure LimparCampos;
    procedure LimparEntidadesMapeadas;
    procedure PrepararComboBoxComEnumerators;
    function CamposObrigatoriosEstaoPreenchidos: Boolean;
    procedure CarregarMascaraNosCampos;
    function CamposObrigatoriosPreenchidos: Boolean;
    procedure DestruirComponentesTImagemValidacao;
  protected
    [TCadastroVariavel('GUID',ftTEXTO,coNaoObrigatorio)]
    FGUID: string;
    [TCadastroVariavel('DATA_INSERCAO',ftDATA,coNaoObrigatorio)]
    FDATA_INSERCAO: TDateTime;
  public
    { Public declarations }
    function ValidacoesEspecificasAtendidas: Boolean; virtual;
    procedure CarregarEntidadeParaEdicao(AGUID: string);
    procedure CarregarFormParaCadastro;
    procedure CriarImagemDeValidacaoParaCampo(AComponente: TWinControl; Mensagem: string);
  end;

var
  FrmCadastroPadrao: TFrmCadastroPadrao;

implementation

uses
  Interfaces.Controller.Cadastro.Padrao, Controller.Componente.TImagemValidacao;

{$R *.dfm}

procedure TFrmCadastroPadrao.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.left := Botao.left;
end;

procedure TFrmCadastroPadrao.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
end;

procedure TFrmCadastroPadrao.PrepararComboBoxComEnumerators;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarComboBoxComEnumerators;
end;

procedure TFrmCadastroPadrao.DestruirComponentesTImagemValidacao;
begin
  var ControllerTImagemValidacao := TControllerTImagemValidacao.New(Self);
  ControllerTImagemValidacao.DestruirTImagemValidacaoDoForm;
end;

function TFrmCadastroPadrao.ValidacoesEspecificasAtendidas: Boolean;
begin
  DestruirComponentesTImagemValidacao;
  Result := True;
end;

procedure TFrmCadastroPadrao.CarregarEntidadeParaEdicao(AGUID: string);
begin
  FGUID := AGUID;
  PrepararComboBoxComEnumerators;
  LimparCampos;
  LimparEntidadesMapeadas;
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarEntidadeParaEdicao(AGUID);
end;

procedure TFrmCadastroPadrao.CarregarFormParaCadastro;
begin
  InicializarID;
  PrepararComboBoxComEnumerators;
  LimparCampos;
  LimparEntidadesMapeadas;
end;

procedure TFrmCadastroPadrao.InicializarID;
begin
  FGUID := string.Empty;
  FDATA_INSERCAO := 0;
end;

procedure TFrmCadastroPadrao.LimparCampos;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.LimparCamposEditaveis;
end;

procedure TFrmCadastroPadrao.LimparEntidadesMapeadas;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.LimparEntidadesMapeadas;
end;

procedure TFrmCadastroPadrao.CarregarLayoutDinamico;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarLayoutDeCamposEditaveis;
end;

procedure TFrmCadastroPadrao.CarregarMascaraNosCampos;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarMascarasNosCampos;
end;

procedure TFrmCadastroPadrao.CriarImagemDeValidacaoParaCampo(
  AComponente: TWinControl; Mensagem: string);
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CriarImagemDeValidacaoDeCampo(AComponente,Mensagem);
end;

procedure TFrmCadastroPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.LimparEntidadesMapeadas;
end;

procedure TFrmCadastroPadrao.FormShow(Sender: TObject);
begin
  inherited;
  CarregarLayoutDinamico;
  CarregarMascaraNosCampos;
end;

procedure TFrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadastroPadrao.btnCancelarEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroPadrao.btnCancelarExit(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroPadrao.btnCancelarMouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroPadrao.btnCancelarMouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroPadrao.GravarEntidade;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.GravarEntidade;
end;

function TFrmCadastroPadrao.CamposObrigatoriosEstaoPreenchidos: Boolean;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  Result := ControllerView.CamposObrigatoriosEstaoPreenchidos;
end;

procedure TFrmCadastroPadrao.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  if not CamposObrigatoriosPreenchidos then
    Exit;

  if not ValidacoesEspecificasAtendidas then
    Exit;

  GravarEntidade;
  Close;
end;

procedure TFrmCadastroPadrao.btnCadastrarEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroPadrao.btnCadastrarExit(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

function TFrmCadastroPadrao.CamposObrigatoriosPreenchidos: Boolean;
begin
  Result := True;
  if not CamposObrigatoriosEstaoPreenchidos then
  begin
    LimparEntidadesMapeadas;
    Result := False;
  end;
end;

procedure TFrmCadastroPadrao.btnCadastrarMouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroPadrao.btnCadastrarMouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

end.
