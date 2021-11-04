unit View.Lista.Selecao.Entidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Controller.Lista.Selecao.Entidade, Datasnap.DBClient,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
  TFrmListaSelecaoEntidade = class(TFrmPadrao)
    grdLista: TDBGrid;
    pnlMenu: TPanel;
    btnCancelar: TSpeedButton;
    btnConfirmar: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarMouseEnter(Sender: TObject);
    procedure btnConfirmarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseEnter(Sender: TObject);
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

procedure TFrmListaSelecaoEntidade.btnConfirmarClick(Sender: TObject);
begin
  var Controller := TControllerListaSelecaoEntidade.New(FClasseEntidade);
  var ID := FClientDataSet.FieldByName('ID').AsInteger;
  var Obj := Controller.ObterObjetoSelecionado(ID);
  InformarObservador(Obj);
  Close;
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
  ObterDataSetPreenchido;
  CriarDataSource;
end;

procedure TFrmListaSelecaoEntidade.ObterDataSetPreenchido;
begin
  var Controller := TControllerListaSelecaoEntidade.New(FClasseEntidade);
  FClientDataSet := TClientDataSet(Controller.ObterDataSetPreenchido);
end;

procedure TFrmListaSelecaoEntidade.CriarDataSource;
begin
  if not Assigned(FDataSource) then
    FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FClientDataSet;
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
