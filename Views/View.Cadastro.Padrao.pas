unit View.Cadastro.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Padrao, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Controller.Cadastro.Padrao;

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
  private
    { Private declarations }
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
  public
    { Public declarations }
    procedure CarregarEntidadeParaEdicao(pId: Integer);
  end;

var
  FrmCadastroPadrao: TFrmCadastroPadrao;

implementation

uses
  Controller.View, Interfaces.Controller.Cadastro.Padrao;

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

procedure TFrmCadastroPadrao.CarregarEntidadeParaEdicao(pId: Integer);
begin

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

procedure TFrmCadastroPadrao.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  var ControllerView := TControllerCadastroPadrao.New(Self);
  ControllerView.GravarEntidade;
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
