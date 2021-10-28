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
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6MouseEnter(Sender: TObject);
    procedure SpeedButton6MouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFrmCadastroPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  var ControllerView := TControllerCadastroPadrao.New(Self);
//  ControllerView.DestruirEntidadesPosCadastro;
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

procedure TFrmCadastroPadrao.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  GravarEntidade;
  Close;
end;

procedure TFrmCadastroPadrao.SpeedButton6MouseEnter(Sender: TObject);
begin
  inherited;
   AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroPadrao.SpeedButton6MouseLeave(Sender: TObject);
begin
  inherited;
   OcultarBarraLateralDoBotao;
end;

end.
