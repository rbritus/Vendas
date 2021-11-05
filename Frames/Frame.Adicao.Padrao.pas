unit Frame.Adicao.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.DBCGrids, Data.DB, Datasnap.DBClient,
  Componente.TObjectList, Interfaces.Padrao.Observer, dxGDIPlusClasses;

type
  TFrameAdicaoPadrao = class(TFramePadrao, iObservador)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    btnAdicionar: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel3: TPanel;
    imgBtnExcluir: TImage;
    imgBtnAlterar: TImage;
    Panel4: TPanel;
    cdsDados: TClientDataSet;
    dscDados: TDataSource;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    Label4: TLabel;
    procedure imgBtnExcluirClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure imgBtnAlterarClick(Sender: TObject);
    procedure btnAdicionarMouseEnter(Sender: TObject);
    procedure btnAdicionarMouseLeave(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
  private
    { Private declarations }
    FIdObjRelacional: Integer;
    procedure CarregarDataSet;
    procedure AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
    procedure OcultarBarraLateralDoBotao;
    procedure AtribuirVisibilidadeAGride;
    function DataSetGridEstaVazio: Boolean;
    function ObterQuantidadeDeRegistrosDoDataSetGrid: Integer;
  protected
    procedure ObterListaPreenchida(var Lista: TObjectListFuck<TObject>);
    function ObterSqlParaDatSet: string; virtual; Abstract;
    function ObterSqlDeTabelaRelacional: string;
    function ObterObjetoDoFrame: TObject;
    procedure CriarDataSet; virtual; Abstract;
    procedure PreencherDataSet(Obj: TObject); virtual; Abstract;
    procedure UpdateItem(Value : TObject); virtual;
  public
    { Public declarations }
    procedure CarregarFrame(IdEntidade: Integer);
  end;

var
  FrameAdicaoPadrao: TFrameAdicaoPadrao;

implementation

uses
  Controller.Frame.Adicao.Padrao, Controller.Padrao.Observer;

{$R *.dfm}

{ TFrameAdicaoPadrao }

procedure TFrameAdicaoPadrao.CarregarDataSet;
var
  Obj: TObject;
begin
  CriarDataSet;
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  var Lista := ControllerFrame.CarregarListaDeObjetosParaFrame(FIdObjRelacional);

  if not Assigned(Lista) then
  begin
    AtribuirVisibilidadeAGride;
    Exit;
  end;

  try
    for Obj in Lista do
      PreencherDataSet(Obj);
  finally
    Lista.Free;
  end;
  AtribuirVisibilidadeAGride;
end;

procedure TFrameAdicaoPadrao.imgBtnExcluirClick(Sender: TObject);
begin
  inherited;
  if cdsDados.IsEmpty then
    Exit;

  cdsDados.Delete;
end;

procedure TFrameAdicaoPadrao.imgBtnAlterarClick(Sender: TObject);
begin
  if DataSetGridEstaVazio then
    Exit;

  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  ControllerFrame.ApresentarFormParaEdicao(cdsDados.FieldByName('id').AsInteger);
end;

procedure TFrameAdicaoPadrao.ObterListaPreenchida(var Lista: TObjectListFuck<TObject>);
begin
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  ControllerFrame.ObterListaPreenchidaDoFrame(cdsDados,Lista);
end;

function TFrameAdicaoPadrao.ObterObjetoDoFrame: TObject;
begin
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  Result := ControllerFrame.ObterObjetoDoFrame;
end;

function TFrameAdicaoPadrao.ObterQuantidadeDeRegistrosDoDataSetGrid: Integer;
begin
  Result := cdsDados.RecordCount;
end;

function TFrameAdicaoPadrao.ObterSqlDeTabelaRelacional: string;
begin
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  Result := ControllerFrame.ObterSqlDeTabelaRelacional(FIdObjRelacional);
end;

procedure TFrameAdicaoPadrao.SpeedButton5MouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrameAdicaoPadrao.SpeedButton5MouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrameAdicaoPadrao.UpdateItem(Value: TObject);
begin
  AtribuirVisibilidadeAGride;
end;

function TFrameAdicaoPadrao.DataSetGridEstaVazio: Boolean;
begin
  Result := cdsDados.IsEmpty;
end;

procedure TFrameAdicaoPadrao.AtribuirVisibilidadeAGride;
begin
  DBCtrlGrid1.Visible := not DataSetGridEstaVazio;
  DBCtrlGrid1.RowCount := ObterQuantidadeDeRegistrosDoDataSetGrid;
end;

procedure TFrameAdicaoPadrao.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  ControllerFrame.ApresentarFormParaCadastro;
end;

procedure TFrameAdicaoPadrao.btnAdicionarMouseEnter(Sender: TObject);
begin
  inherited;
  AjustarPosicaoBarraLateralAoBotao(TButton(Sender));
end;

procedure TFrameAdicaoPadrao.btnAdicionarMouseLeave(Sender: TObject);
begin
  inherited;
  OcultarBarraLateralDoBotao;
end;

procedure TFrameAdicaoPadrao.CarregarFrame(IdEntidade: Integer);
begin
  FIdObjRelacional := IdEntidade;
  CarregarDataSet;
end;

procedure TFrameAdicaoPadrao.AjustarPosicaoBarraLateralAoBotao(Botao: TButton);
begin
  pnlBarraLateralBotao.Visible := True;
  pnlBarraLateralBotao.left := Botao.left;
end;

procedure TFrameAdicaoPadrao.OcultarBarraLateralDoBotao;
begin
  pnlBarraLateralBotao.Visible := False;
end;

end.
