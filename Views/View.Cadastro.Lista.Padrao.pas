unit View.Cadastro.Lista.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  View.Cadastro.Padrao, Datasnap.DBClient, Controller.Cadastro.Lista.Padrao;

type
  TFrmCadastroListaPadrao = class(TFrmPadrao)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    grdLista: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure grdListaDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FClientDataSet : TClientDataSet;
    FDataSource: TDataSource;
    procedure ApresentarDadosNaGrid;
    procedure CriarDataSource;
    procedure ExecutarConsulta;
    procedure AjustarColunasDaGride;
  public
    { Public declarations }
  end;

var
  FrmCadastroListaPadrao: TFrmCadastroListaPadrao;

implementation

uses
  Utils.DBGrid;

{$R *.dfm}

{ TFrmCadastroListaPadrao }

procedure TFrmCadastroListaPadrao.CriarDataSource;
begin
  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FClientDataSet;
  grdLista.DataSource := FDataSource;
end;

procedure TFrmCadastroListaPadrao.ExecutarConsulta;
begin
  var ControllerListaView := TControllerCadastroListaPadrao.New(Self);
  FClientDataSet := ControllerListaView.ObterDataSetComDadosParaGride as TClientDataSet;
end;

procedure TFrmCadastroListaPadrao.AjustarColunasDaGride;
begin
  TUtilsDBGrid.DimensionarGrid(grdLista);
end;

procedure TFrmCadastroListaPadrao.ApresentarDadosNaGrid;
begin
  ExecutarConsulta;
  CriarDataSource;
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
  ControllerListaView.ApresentarFormParaCadastro(grdLista.DataSource.DataSet.FieldByName('id').AsInteger);
  inherited;
end;

end.
