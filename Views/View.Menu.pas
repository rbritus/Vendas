unit View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CategoryButtons,
  Vcl.WinXCtrls, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,
  Vcl.Menus, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Controller.View, Vcl.Buttons;

type
  TFrmMenu = class(TForm)
    PanelFundoDisponivel: TPanel;
    PanelTitulo: TPanel;
    pnlMainForm: TPanel;
    imgLista1: TImageList;
    pnlMenuLateral: TPanel;
    pnlTopo: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    btnMenu: TSpeedButton;
    pnlBarraSuperiorBotao: TPanel;
    pnlBarraLateralBotao: TPanel;
    procedure SplitViewMenuOpened(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure pnlMainFormResize(Sender: TObject);
    procedure SpeedButton6MouseEnter(Sender: TObject);
    procedure SpeedButton6MouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton4MouseEnter(Sender: TObject);
    procedure SpeedButton3MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure SpeedButton4MouseLeave(Sender: TObject);
    procedure SpeedButton3MouseLeave(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FMenuExpandido: Boolean;
    procedure ExpansaoDoMenu;
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses
  Connection.Controller.SqLite, View.Cadastro.Lista.Pessoa,
  Connection.Scripter.SqLite, Entidade.Pessoa;

procedure TFrmMenu.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.Top := Botao.Top;
end;

procedure TFrmMenu.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
end;

procedure TFrmMenu.ExpansaoDoMenu;
begin
  if FMenuExpandido then
    pnlMenuLateral.Width := 50
  else
    pnlMenuLateral.Width := 160;
  btnMenu.Width := pnlMenuLateral.Width;
  FMenuExpandido := not FMenuExpandido;
end;

procedure TFrmMenu.btnMenuClick(Sender: TObject);
begin
  ExpansaoDoMenu;
end;

procedure TFrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   TConexao.GetInstance.FecharConexao;
end;

procedure TFrmMenu.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
//  TScriptSQL.RegistrarEntidadeNoBanco(TPessoa);
  FMenuExpandido := True;
  ControllerView.MainForm := Self;
  ControllerView.Parent := pnlMainForm;
  ControllerView.Title := PanelTitulo;
end;

procedure TFrmMenu.pnlMainFormResize(Sender: TObject);
begin
//  ControllerView.Arredondarcantos(pnlMainForm);
end;

procedure TFrmMenu.SpeedButton3MouseEnter(Sender: TObject);
begin
   AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmMenu.SpeedButton3MouseLeave(Sender: TObject);
begin
   OcultarBarraLateralDoBotao;
end;

procedure TFrmMenu.SpeedButton4MouseEnter(Sender: TObject);
begin
   AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmMenu.SpeedButton4MouseLeave(Sender: TObject);
begin
   OcultarBarraLateralDoBotao;
end;

procedure TFrmMenu.SpeedButton5MouseEnter(Sender: TObject);
begin
   AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmMenu.SpeedButton5MouseLeave(Sender: TObject);
begin
   OcultarBarraLateralDoBotao;
end;

procedure TFrmMenu.SpeedButton6Click(Sender: TObject);
begin
   ControllerView.ShowForm(TFrmCadastroListaPessoa);
end;

procedure TFrmMenu.SpeedButton6MouseEnter(Sender: TObject);
begin
   AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmMenu.SpeedButton6MouseLeave(Sender: TObject);
begin
   OcultarBarraLateralDoBotao;
end;

procedure TFrmMenu.SplitViewMenuOpened(Sender: TObject);
begin
  ControllerView.ReRenderForms;
end;

initialization
  RegisterClass(TFrmMenu);

finalization
  UnRegisterClass(TFrmMenu);

end.
