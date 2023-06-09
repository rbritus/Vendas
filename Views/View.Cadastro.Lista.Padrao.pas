unit View.Cadastro.Lista.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  View.Cadastro.Padrao, Datasnap.DBClient, Controller.Cadastro.Lista.Padrao,
  Interfaces.Padrao.Observer, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  Frame.Padrao, Frame.Filtro.Pesquisa, System.Actions, Vcl.ActnList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFrmCadastroListaPadrao = class(TFrmPadrao, iObservador)
    pnlMenu: TPanel;
    SpeedButton5: TButton;
    btnAdicionar: TButton;
    pnlBarraLateralBotao: TPanel;
    grdLista: TDBGrid;
    FrameFiltroPesquisa1: TFrameFiltroPesquisa;
    procedure grdListaDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarMouseEnter(Sender: TObject);
    procedure btnAdicionarMouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameFiltroPesquisa1edtPesquisaEnter(Sender: TObject);
    procedure FrameFiltroPesquisa1edtPesquisaExit(Sender: TObject);
    procedure grdListaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarEnter(Sender: TObject);
    procedure btnAdicionarExit(Sender: TObject);
    procedure SpeedButton5Exit(Sender: TObject);
    procedure SpeedButton5Enter(Sender: TObject);
  private
    { Private declarations }
    FClientDataSet : TClientDataSet;
    FDataSource: TDataSource;
    procedure ApresentarDadosNaGrid;
    procedure CriarDataSource;
    procedure ObterDataSetPreenchido;
    procedure AjustarColunasDaGride;
    procedure UpdateItem(Value : TObject);
    procedure ObservarEntidadeDeCadastro;
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure InformarGrideParaPesquisa;
  public
    { Public declarations }
  end;

var
  FrmCadastroListaPadrao: TFrmCadastroListaPadrao;

implementation

uses
  Utils.DBGrid, Controller.Padrao.Observer, Utils.ClientDataSet, Utils.Entidade;

{$R *.dfm}

{ TFrmCadastroListaPadrao }

procedure TFrmCadastroListaPadrao.CriarDataSource;
begin
  if not Assigned(FDataSource) then
    FDataSource := TDataSource.Create(Self);
  grdLista.DataSource := FDataSource;
end;

procedure TFrmCadastroListaPadrao.ObterDataSetPreenchido;
begin
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  FClientDataSet := TClientDataSet(ControllerListaView.ObterDataSetComDadosParaGride);
  FDataSource.DataSet := FClientDataSet;
end;

procedure TFrmCadastroListaPadrao.AjustarColunasDaGride;
begin
  TUtilsDBGrid.DimensionarGrid(grdLista);
end;

procedure TFrmCadastroListaPadrao.ApresentarDadosNaGrid;
begin
  CriarDataSource;
  ObterDataSetPreenchido;
end;

procedure TFrmCadastroListaPadrao.InformarGrideParaPesquisa;
begin
  FrameFiltroPesquisa1.SetDbGrid(grdLista);
end;

procedure TFrmCadastroListaPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  ObservarEntidadeDeCadastro;
  InformarGrideParaPesquisa;
end;

procedure TFrmCadastroListaPadrao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDataSource);
  FreeAndNil(FClientDataSet);
end;

procedure TFrmCadastroListaPadrao.FormResize(Sender: TObject);
begin
  inherited;
  AjustarColunasDaGride;
end;

procedure TFrmCadastroListaPadrao.FormShow(Sender: TObject);
begin
  inherited;
  ApresentarDadosNaGrid;
  AjustarColunasDaGride;
  FrameFiltroPesquisa1.edtPesquisa.SetFocus;
end;

procedure TFrmCadastroListaPadrao.FrameFiltroPesquisa1edtPesquisaEnter(
  Sender: TObject);
begin
  inherited;
  KeyPreview := False;
end;

procedure TFrmCadastroListaPadrao.FrameFiltroPesquisa1edtPesquisaExit(
  Sender: TObject);
begin
  inherited;
  KeyPreview := True;
end;

procedure TFrmCadastroListaPadrao.grdListaDblClick(Sender: TObject);
begin
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  ControllerListaView.ApresentarFormParaEdicao(grdLista.DataSource.DataSet.FieldByName('GUID').AsString);
  inherited;
end;

procedure TFrmCadastroListaPadrao.grdListaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  FrameFiltroPesquisa1.SetFocusOnKeyDown(Key);
end;

procedure TFrmCadastroListaPadrao.SpeedButton5Enter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroListaPadrao.SpeedButton5Exit(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroListaPadrao.SpeedButton5MouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroListaPadrao.SpeedButton5MouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroListaPadrao.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  ControllerListaView.ApresentarFormParaCadastro;
end;

procedure TFrmCadastroListaPadrao.btnAdicionarEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroListaPadrao.btnAdicionarExit(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroListaPadrao.btnAdicionarMouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrmCadastroListaPadrao.btnAdicionarMouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrmCadastroListaPadrao.ObservarEntidadeDeCadastro;
begin
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  var ClasseEntidade := ControllerListaView.ObterClasseDaEntidadeDeCadastro;
  ControllerObserverEntidade.ObservarEntidade(Self,ClasseEntidade);
end;

procedure TFrmCadastroListaPadrao.UpdateItem(Value: TObject);
begin
  var GUID := TUtilsEntidade.ObterValorPropriedade(Value,'GUID').AsString;
  if FClientDataSet.Locate('GUID',GUID,[]) then
    FClientDataSet.Edit
  else
    FClientDataSet.Append;

  TUtilsClientDataSet.PreencherDataSet(FClientDataSet,Value);
  FClientDataSet.Post;
end;

procedure TFrmCadastroListaPadrao.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.left := Botao.left;
end;

procedure TFrmCadastroListaPadrao.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
end;

end.
