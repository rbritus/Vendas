unit View.Cadastro.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Controller.Cadastro.Padrao, Attributes.Forms, Utils.Enumerators,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList;

type
  TFrmCadastroPadrao = class(TFrmPadrao)
    pnlMenu: TPanel;
    btnCancelar: TSpeedButton;
    btnCadastrar: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCadastrarMouseEnter(Sender: TObject);
    procedure btnCadastrarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure GravarEntidade;
    procedure InicializarID;
    procedure CarregarLayoutDinamico;
    procedure LimparCampos;
    procedure LimparEntidades;
    procedure PrepararComboBoxComEnumerators;
    function CamposObrigatoriosEstaoPreenchidos: Boolean;
    procedure CarregarMascaraNosCampos;
  protected
    [TCadastroVariavel('ID',ftINTEIRO,coNaoObrigatorio)]
    FID: Integer;
  public
    { Public declarations }
    procedure CarregarEntidadeParaEdicao(pId: Integer);
    procedure CarregarFormParaCadastro;
  end;

var
  FrmCadastroPadrao: TFrmCadastroPadrao;

implementation

uses
  Interfaces.Controller.Cadastro.Padrao;

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

procedure TFrmCadastroPadrao.CarregarEntidadeParaEdicao(pId: Integer);
begin
  FID := pId;
  PrepararComboBoxComEnumerators;
  LimparCampos;
  LimparEntidades;
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarEntidadeParaEdicao(pId);
end;

procedure TFrmCadastroPadrao.CarregarFormParaCadastro;
begin
  InicializarID;
  PrepararComboBoxComEnumerators;
  LimparCampos;
  LimparEntidades;
end;

procedure TFrmCadastroPadrao.InicializarID;
begin
  FID := 0;
end;

procedure TFrmCadastroPadrao.LimparCampos;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.LimparCamposEditaveis;
end;

procedure TFrmCadastroPadrao.LimparEntidades;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.LimparEntidades;
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
  if not CamposObrigatoriosEstaoPreenchidos then
  begin
    LimparEntidades;
    Exit;
  end;

  GravarEntidade;
  Close;
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
