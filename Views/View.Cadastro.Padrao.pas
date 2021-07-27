unit View.Cadastro.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Padrao, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls;

type
  TFrmCadastroPadrao = class(TFrmPadrao)
    pnlMenuLateral: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6MouseEnter(Sender: TObject);
    procedure SpeedButton6MouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
  private
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroPadrao: TFrmCadastroPadrao;

implementation

uses
  Controller.View;

{$R *.dfm}

procedure TFrmCadastroPadrao.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.Top := Botao.Top;
end;

procedure TFrmCadastroPadrao.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
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
