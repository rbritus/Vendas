unit View.Cadastro.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Controller.Cadastro.Padrao, Attributes.Forms, Utils.Enumerators,
  System.ImageList, Vcl.ImgList;

type
  TFrmCadastroPadrao = class(TFrmPadrao)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    btnCadastrar: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    procedure SpeedButton5Click(Sender: TObject);
    procedure btnCadastrarMouseEnter(Sender: TObject);
    procedure btnCadastrarMouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure GravarEntidade;
    procedure InicializarID;
    procedure CarregarLayoutDinamico;
    procedure LimparCampos;
    procedure PrepararComboBoxComEnumerators;
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
  LimparCampos;
  PrepararComboBoxComEnumerators;
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarEntidadeParaEdicao(pId);
end;

procedure TFrmCadastroPadrao.CarregarFormParaCadastro;
begin
  InicializarID;
  LimparCampos;
  PrepararComboBoxComEnumerators;
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

procedure TFrmCadastroPadrao.CarregarLayoutDinamico;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.CarregarLayoutDeCamposEditaveis;
end;

procedure TFrmCadastroPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  CarregarLayoutDinamico;
end;

procedure TFrmCadastroPadrao.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadastroPadrao.SpeedButton5MouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroPadrao.SpeedButton5MouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroPadrao.GravarEntidade;
begin
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.GravarEntidade;
end;

procedure TFrmCadastroPadrao.btnCadastrarClick(Sender: TObject);
begin
  inherited;
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
