unit View.Cadastro.Lista.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  View.Cadastro.Padrao, Datasnap.DBClient, Controller.Cadastro.Lista.Padrao,
  Interfaces.Padrao.Observer, System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
  TFrmCadastroListaPadrao = class(TFrmPadrao, iObservador)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    btnAdicionar: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    grdLista: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure grdListaDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarMouseEnter(Sender: TObject);
    procedure btnAdicionarMouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
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
  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FClientDataSet;
  grdLista.DataSource := FDataSource;
end;

procedure TFrmCadastroListaPadrao.ObterDataSetPreenchido;
begin
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  FClientDataSet := TClientDataSet(ControllerListaView.ObterDataSetComDadosParaGride);
end;

procedure TFrmCadastroListaPadrao.AjustarColunasDaGride;
begin
  TUtilsDBGrid.DimensionarGrid(grdLista);
end;

procedure TFrmCadastroListaPadrao.ApresentarDadosNaGrid;
begin
  ObterDataSetPreenchido;
  CriarDataSource;
end;

procedure TFrmCadastroListaPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  ObservarEntidadeDeCadastro;
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
end;

procedure TFrmCadastroListaPadrao.grdListaDblClick(Sender: TObject);
begin
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  ControllerListaView.ApresentarFormParaEdicao(grdLista.DataSource.DataSet.FieldByName('id').AsInteger);
  inherited;
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
  var ID := TUtilsEntidade.ObterValorPropriedade(Value,'Id').AsInteger;
  if FClientDataSet.Locate('ID',ID,[]) then
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
