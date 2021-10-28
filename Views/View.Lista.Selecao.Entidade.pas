unit View.Lista.Selecao.Entidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Controller.Lista.Selecao.Entidade, Datasnap.DBClient;

type
  TFrmListaSelecaoEntidade = class(TFrmPadrao)
    grdLista: TDBGrid;
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    procedure SpeedButton6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FClasseEntidade: TClass;
    FObject: TObject;
    FClientDataSet : TClientDataSet;
    FDataSource: TDataSource;
    procedure ApresentarDadosNaGrid;
    procedure ObterDataSetPreenchido;
    procedure CriarDataSource;
    procedure AjustarColunasDaGride;
  public
    { Public declarations }
    function ObterObjeto: TObject;
    procedure InformarClasseDaEntidade(ClasseEntidade: TClass);
  end;

var
  FrmListaSelecaoEntidade: TFrmListaSelecaoEntidade;

implementation

uses
  Utils.DBGrid;

{$R *.dfm}

function TFrmListaSelecaoEntidade.ObterObjeto: TObject;
begin
  Result := FObject;
end;

procedure TFrmListaSelecaoEntidade.SpeedButton5Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmListaSelecaoEntidade.SpeedButton6Click(Sender: TObject);
begin
  var Controller := TControllerListaSelecaoEntidade.New(FClasseEntidade);
  var ID := FClientDataSet.FieldByName('ID').AsInteger;
  FObject := Controller.ObterObjetoSelecionado(ID);
  Close;
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


end.
