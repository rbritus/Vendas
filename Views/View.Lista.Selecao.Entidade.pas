unit View.Lista.Selecao.Entidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Controller.Lista.Selecao.Entidade, Datasnap.DBClient,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Frame.Padrao,
  Frame.Filtro.Pesquisa, System.Actions, Vcl.ActnList, Vcl.BaseImageCollection,
  Vcl.ImageCollection;

type
  TFrmListaSelecaoEntidade = class(TFrmPadrao)
    grdLista: TDBGrid;
    pnlMenu: TPanel;
    btnCancelar: TButton;
    btnConfirmar: TButton;
    pnlBarraLateralBotao: TPanel;
    FrameFiltroPesquisa1: TFrameFiltroPesquisa;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarMouseEnter(Sender: TObject);
    procedure btnConfirmarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FrameFiltroPesquisa1edtPesquisaEnter(Sender: TObject);
    procedure FrameFiltroPesquisa1edtPesquisaExit(Sender: TObject);
    procedure grdListaKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarEnter(Sender: TObject);
    procedure btnConfirmarExit(Sender: TObject);
    procedure btnCancelarExit(Sender: TObject);
    procedure btnCancelarEnter(Sender: TObject);
    procedure grdListaDblClick(Sender: TObject);
  private
    { Private declarations }
    FClasseEntidade: TClass;
    FClientDataSet : TClientDataSet;
    FDataSource: TDataSource;
    procedure ApresentarDadosNaGrid;
    procedure ObterDataSetPreenchido;
    procedure CriarDataSource;
    procedure AjustarColunasDaGride;
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure InformarObservador(AObjeto: TObject);
    procedure InformarGrideParaPesquisa;
    procedure RetornarRegistroSelecionado;
  public
    { Public declarations }
    procedure InformarClasseDaEntidade(ClasseEntidade: TClass);
  end;

var
  FrmListaSelecaoEntidade: TFrmListaSelecaoEntidade;

implementation

uses
  Utils.DBGrid;

{$R *.dfm}

procedure TFrmListaSelecaoEntidade.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmListaSelecaoEntidade.btnCancelarEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmListaSelecaoEntidade.btnCancelarExit(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmListaSelecaoEntidade.btnCancelarMouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmListaSelecaoEntidade.btnCancelarMouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmListaSelecaoEntidade.InformarObservador(AObjeto: TObject);
begin
  if not Assigned(Self.FObservador) then
    Exit;

  Self.FObservador.UpdateItem(AObjeto);
  Self.FObservador := nil;
end;

procedure TFrmListaSelecaoEntidade.RetornarRegistroSelecionado;
begin
  if FClientDataSet.IsEmpty then
    Exit;

  var Controller := TControllerListaSelecaoEntidade.New(FClasseEntidade);
  var GUID := FClientDataSet.FieldByName('GUID').AsString;
  var Obj := Controller.ObterObjetoSelecionado(GUID);
  InformarObservador(Obj);
  Close;
end;

procedure TFrmListaSelecaoEntidade.btnConfirmarClick(Sender: TObject);
begin
  RetornarRegistroSelecionado;
end;

procedure TFrmListaSelecaoEntidade.btnConfirmarEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmListaSelecaoEntidade.btnConfirmarExit(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmListaSelecaoEntidade.btnConfirmarMouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmListaSelecaoEntidade.btnConfirmarMouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmListaSelecaoEntidade.ApresentarDadosNaGrid;
begin
  CriarDataSource;
  ObterDataSetPreenchido;
end;

procedure TFrmListaSelecaoEntidade.ObterDataSetPreenchido;
begin
  var Controller := TControllerListaSelecaoEntidade.New(FClasseEntidade);
  FClientDataSet := TClientDataSet(Controller.ObterDataSetPreenchido);
  FDataSource.DataSet := FClientDataSet;
end;

procedure TFrmListaSelecaoEntidade.CriarDataSource;
begin
  if not Assigned(FDataSource) then
    FDataSource := TDataSource.Create(Self);
  grdLista.DataSource := FDataSource;
end;

procedure TFrmListaSelecaoEntidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FClientDataSet) then
    FreeAndNil(FClientDataSet);
  if Assigned(FDataSource) then
    FreeAndNil(FDataSource);
end;

procedure TFrmListaSelecaoEntidade.InformarGrideParaPesquisa;
begin
  FrameFiltroPesquisa1.SetDbGrid(grdLista);
end;

procedure TFrmListaSelecaoEntidade.FormCreate(Sender: TObject);
begin
  inherited;
  InformarGrideParaPesquisa;
end;

procedure TFrmListaSelecaoEntidade.FormResize(Sender: TObject);
begin
  inherited;
  AjustarColunasDaGride;
end;

procedure TFrmListaSelecaoEntidade.FormShow(Sender: TObject);
begin
  inherited;
  ApresentarDadosNaGrid;
  AjustarColunasDaGride;
  FrameFiltroPesquisa1.LimparPesquisa;
  FrameFiltroPesquisa1.edtPesquisa.SetFocus;
end;

procedure TFrmListaSelecaoEntidade.FrameFiltroPesquisa1edtPesquisaEnter(
  Sender: TObject);
begin
  inherited;
  KeyPreview := False;
end;

procedure TFrmListaSelecaoEntidade.FrameFiltroPesquisa1edtPesquisaExit(
  Sender: TObject);
begin
  inherited;
  KeyPreview := False;
end;

procedure TFrmListaSelecaoEntidade.grdListaDblClick(Sender: TObject);
begin
  inherited;
  RetornarRegistroSelecionado;
end;

procedure TFrmListaSelecaoEntidade.grdListaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  FrameFiltroPesquisa1.SetFocusOnKeyDown(Key);
end;

procedure TFrmListaSelecaoEntidade.InformarClasseDaEntidade(
  ClasseEntidade: TClass);
begin
  FClasseEntidade := ClasseEntidade;
end;

procedure TFrmListaSelecaoEntidade.AjustarColunasDaGride;
begin
  TUtilsDBGrid.DimensionarGrid(grdLista);
end;

procedure TFrmListaSelecaoEntidade.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.left := Botao.left;
end;

procedure TFrmListaSelecaoEntidade.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
end;

end.
