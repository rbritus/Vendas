unit Frame.Adicao.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.DBCGrids, Data.DB, Datasnap.DBClient,
  Componente.TObjectList, Interfaces.Padrao.Observer, Vcl.BaseImageCollection,
  Vcl.ImageCollection;

type
  TFrameAdicaoPadrao = class(TFramePadrao, iObservador)
    pnlMenu: TPanel;
    SpeedButton5: TButton;
    btnAdicionar: TButton;
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
    function DataSetGridEstaVazio: Boolean;
    function ObterQuantidadeDeRegistrosDoDataSetGrid: Integer;
  protected
    procedure AtribuirVisibilidadeAGride;
    procedure ObterListaPreenchida(var Lista: TObjectListFuck<TObject>);
    function ObterSqlDeTabelaRelacional: string;
    function ObterObjetoDoFrame: TObject;
    procedure CriarDataSet; virtual;
    procedure PreencherDataSet(Obj: TObject); virtual;
    procedure UpdateItem(Value : TObject); virtual;
  public
    { Public declarations }
    procedure CarregarFrame(IdEntidade: Integer);
    procedure LimparDataSet;
  end;

var
  FrameAdicaoPadrao: TFrameAdicaoPadrao;

implementation

uses
  Controller.Frame.Adicao.Padrao, Controller.Padrao.Observer,
  Utils.ClientDataSet, Utils.Entidade;

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
    LimparDataSet;
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
  if DataSetGridEstaVazio then
    Exit;

  cdsDados.Delete;
  AtribuirVisibilidadeAGride;
end;

procedure TFrameAdicaoPadrao.LimparDataSet;
begin
  if not DataSetGridEstaVazio then
  begin
    cdsDados.EmptyDataSet;
    AtribuirVisibilidadeAGride;
  end;
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
  PreencherDataSet(Value);
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

procedure TFrameAdicaoPadrao.CriarDataSet;
begin
  var Obj := ObterObjetoDoFrame;
  try
    TUtilsClientDataSet.PrepararClientDataSet(cdsDados);
    TUtilsClientDataSet.CreateFielsdByEntidade(cdsDados,Obj);
    TUtilsClientDataSet.ConcluirClientDataSet(cdsDados,Obj)
  finally
    Obj.Free
  end;
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

procedure TFrameAdicaoPadrao.PreencherDataSet(Obj: TObject);
begin
  var ID := TUtilsEntidade.ObterValorPropriedade(Obj,'ID').AsInteger;
  if cdsDados.Locate('ID',ID,[]) then
    cdsDados.Delete;

  cdsDados.Append;
  TUtilsClientDataSet.PreencherDataSet(cdsDados,Obj);
  cdsDados.Post;
end;

end.
