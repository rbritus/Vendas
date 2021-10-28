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
    btnConfiguracoes: TSpeedButton;
    btnRelatorios: TSpeedButton;
    btnProcessos: TSpeedButton;
    btnCadastros: TSpeedButton;
    btnMenu: TSpeedButton;
    pnlBarraSuperiorBotao: TPanel;
    pnlBarraLateralBotao: TPanel;
    pnlCadastros: TPanel;
    pnlRelatorios: TPanel;
    pnlConfiguracoes: TPanel;
    btnCadastroPessoas: TSpeedButton;
    pnlProcessos: TPanel;
    ActionList1: TActionList;
    actMouseEnter: TAction;
    actMouseLeave: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
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
  private
    { Private declarations }
    FMenuExpandido: Boolean;
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
  Connection.Scripter.SqLite, FireDAC.Comp.Client, View.Cadastro.Endereco,
  Utils.Entidade;

procedure TFrmMenu.actMouseEnterExecute(Sender: TObject);
begin
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmMenu.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Parent := Botao.Parent;
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
    pnlMenuLateral.Width := 200;
  btnMenu.Width := pnlMenuLateral.Width;
  FMenuExpandido := not FMenuExpandido;
end;

procedure TFrmMenu.btnCadastroPessoasClick(Sender: TObject);
begin
//  var qry: TFdquery := TConexao.GetInstance.ObterQuery;
//  qry.SQL.add('insert into pessoa (nome, ativo) values (''Teste multi2'',''S'');');
//  qry.SQL.add('SELECT last_insert_rowid() result_id;');
//  qry.OpenOrExecute;
//  var ctext := qry.FieldByName('result_id').AsString;
//
//exit;


//  var Form : TForm := nil;
//  ControllerView.AdicionarFormNalista(TFrmCadastroEndereco, Form);
//  TUtilsEntidade.ExecutarMetodoObjeto(Form,'CarregarEntidadeParaEdicao',[9]);
//  ControllerView.ShowForm(TFrmCadastroEndereco);

  ControllerView.ShowForm(TFrmCadastroListaPessoa);

//  var Pessoa := TPessoa.PesquisarPorId(37);
//  try
//    Pessoa.Enderecos;
//  finally
//    Pessoa.Free;
//  end;
//  ShowMessage(Pessoa.Nome);
//  Pessoa.Free;
//  var Pessoa := TPessoa.Create;
//  Pessoa.Nome := 'Teste gravacao 14/09 2';
//
//  var Endereco := TEndereco.Create;
//  Endereco.CEP := '87053268';
//  Endereco.Logradouro := 'Teste 02';
//  Endereco.Numero := 275;
//  Endereco.Bairro := 'Zona2';
//  Pessoa.Enderecos.Add(Endereco);
//
//  Pessoa.Gravar;
//  FreeAndNil(Pessoa);
////
//  Pessoa.Enderecos.Add(Endereco);
//  Pessoa.Gravar;
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
  FMenuExpandido := True;
  ControllerView.MainForm := Self;
  ControllerView.Parent := pnlMainForm;
  ControllerView.Title := PanelTitulo;
end;

procedure TFrmMenu.pnlMainFormResize(Sender: TObject);
begin
//  ControllerView.Arredondarcantos(pnlMainForm);
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
  pPanel.Visible := True;
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
