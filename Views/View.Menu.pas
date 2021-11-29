unit View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CategoryButtons,
  Vcl.WinXCtrls, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,
  Vcl.Menus, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Controller.View, Vcl.Buttons,
  Vcl.OleCtrls;

type
  TFrmMenu = class(TForm)
    PanelFundoDisponivel: TPanel;
    PanelTitulo: TPanel;
    pnlMainForm: TPanel;
    imgLista1: TImageList;
    pnlMenuLateral: TPanel;
    pnlTopo: TPanel;
    btnMenu: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    ActionList1: TActionList;
    actMouseEnter: TAction;
    actMouseLeave: TAction;
    pnlDockCadastro: TPanel;
    btnCadastros: TSpeedButton;
    pnlCadastros: TPanel;
    btnCadastroPessoas: TSpeedButton;
    pnlDockProcessos: TPanel;
    btnProcessos: TSpeedButton;
    pnlProcessos: TPanel;
    SpeedButton1: TSpeedButton;
    pnlDockRelatorios: TPanel;
    btnRelatorios: TSpeedButton;
    pnlRelatorios: TPanel;
    SpeedButton2: TSpeedButton;
    pnlDockConfiguracoes: TPanel;
    btnConfiguracoes: TSpeedButton;
    pnlConfiguracoes: TPanel;
    SpeedButton7: TSpeedButton;
    procedure SplitViewMenuOpened(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure pnlMainFormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actMouseEnterExecute(Sender: TObject);
    procedure actMouseLeaveExecute(Sender: TObject);
    procedure btnCadastroPessoasClick(Sender: TObject);
    procedure btnCadastrosClick(Sender: TObject);
    procedure btnProcessosClick(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    { Private declarations }
    procedure ExpansaoDoMenu;
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure AtivarSubMenu(pPanel: TPanel);
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses
  Connection.Controller.SqLite, View.Cadastro.Lista.Pessoa,
  Connection.Scripter.SqLite, FireDAC.Comp.Client,
  Utils.Entidade, Utils.Menssages, Utils.Constants, Controller.Scripter;

procedure TFrmMenu.actMouseEnterExecute(Sender: TObject);
begin
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmMenu.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  const DIFERENCA_TOPO = 1;
  pnlBarraLateralBotao.Parent := Botao.Parent;
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.Top := Botao.Top + DIFERENCA_TOPO;
end;

procedure TFrmMenu.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
end;

procedure TFrmMenu.ExpansaoDoMenu;
begin
  const DIFERENCAO_DE_MARGEM_MENU = 6;
  if ControllerView.MenuExpandido then
  begin
    pnlMenuLateral.Width := TConstantsInteger.LARGURA_MENU_MINIMIZADO;
    btnMenu.Width := pnlMenuLateral.Width - DIFERENCAO_DE_MARGEM_MENU;
  end
  else
  begin
    pnlMenuLateral.Width := TConstantsInteger.LARGURA_MENU_MAXIMIZADO;
    btnMenu.Width := pnlMenuLateral.Width - DIFERENCAO_DE_MARGEM_MENU;
  end;
  ControllerView.MenuExpandido := not ControllerView.MenuExpandido;
end;

procedure TFrmMenu.btnCadastroPessoasClick(Sender: TObject);
begin
  ControllerView.ShowForm(TFrmCadastroListaPessoa);
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
  {$IFDEF  DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  ControllerView.MenuExpandido := True;
  ControllerView.MainForm := Self;
  ControllerView.Parent := pnlMainForm;
  ControllerView.Title := PanelTitulo;
end;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
  TControllerScript.RegistrarEntidadesNoBanco;
end;

procedure TFrmMenu.pnlMainFormResize(Sender: TObject);
begin
  ControllerView.CentralizarHorizontalmenteComOParent(pnlMainForm);
  ControllerView.AjustarLarguraMinimaDaAplicao;
end;

procedure TFrmMenu.actMouseLeaveExecute(Sender: TObject);
begin
  OcultarBarraLateralDoBotao;
end;

procedure TFrmMenu.btnConfiguracoesClick(Sender: TObject);
begin
  AtivarSubMenu(pnlConfiguracoes);
end;

procedure TFrmMenu.btnRelatoriosClick(Sender: TObject);
begin
  AtivarSubMenu(pnlRelatorios);
end;

procedure TFrmMenu.btnProcessosClick(Sender: TObject);
begin
  AtivarSubMenu(pnlProcessos);
end;

procedure TFrmMenu.btnCadastrosClick(Sender: TObject);
begin
  AtivarSubMenu(pnlCadastros);
end;

procedure TFrmMenu.AtivarSubMenu(pPanel: TPanel);
begin
  pPanel.Visible := not pPanel.Visible;
end;

procedure TFrmMenu.SpeedButton1Click(Sender: TObject);
begin
  TUtilsMenssages.ShowMessageDialog('Ferramenta não implementada.');
end;

procedure TFrmMenu.SpeedButton2Click(Sender: TObject);
begin
  TUtilsMenssages.ShowMessageDialog('Ferramenta não implementada.');
end;

procedure TFrmMenu.SpeedButton7Click(Sender: TObject);
begin
  TUtilsMenssages.ShowMessageDialog('Ferramenta não implementada.');
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
