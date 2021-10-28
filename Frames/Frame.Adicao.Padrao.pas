unit Frame.Adicao.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.DBCGrids, Data.DB, Datasnap.DBClient,
  Componente.TObjectList, Interfaces.Padrao.Observer;

type
  TFrameAdicaoPadrao = class(TFramePadrao, iObservador)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel3: TPanel;
    imgBtnExcluir: TImage;
    imgBtnAlterar: TImage;
    Panel4: TPanel;
    cdsDados: TClientDataSet;
    dscDados: TDataSource;
    procedure imgBtnExcluirClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure imgBtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    FIdObjRelacional: Integer;
    procedure CarregarDataSet;
    procedure ObservarEntidadeDeCadastro;
    procedure PararDeObservarEntidadeDeCadastro;
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
    procedure FinalizarFrame;
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
    Exit;

  try
    for Obj in Lista do
      PreencherDataSet(Obj);
  finally
    Lista.Free;
  end;
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
  if cdsDados.IsEmpty then
    Exit;

  ObservarEntidadeDeCadastro;
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

function TFrameAdicaoPadrao.ObterSqlDeTabelaRelacional: string;
begin
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  Result := ControllerFrame.ObterSqlDeTabelaRelacional(FIdObjRelacional);
end;

procedure TFrameAdicaoPadrao.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  ObservarEntidadeDeCadastro;
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  ControllerFrame.ApresentarFormParaCadastro;
end;

procedure TFrameAdicaoPadrao.UpdateItem(Value: TObject);
begin
  PararDeObservarEntidadeDeCadastro;
end;

procedure TFrameAdicaoPadrao.CarregarFrame(IdEntidade: Integer);
begin
  FIdObjRelacional := IdEntidade;
  CarregarDataSet;
end;

procedure TFrameAdicaoPadrao.FinalizarFrame;
begin
  PararDeObservarEntidadeDeCadastro;
end;

procedure TFrameAdicaoPadrao.ObservarEntidadeDeCadastro;
begin
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  var ClasseEntidade := ControllerFrame.ObterClasseDaEntidadeDeCadastro;
  ControllerObserverEntidade.ObservarEntidade(Self,ClasseEntidade);
end;

procedure TFrameAdicaoPadrao.PararDeObservarEntidadeDeCadastro;
begin
  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
  var ClasseEntidade := ControllerFrame.ObterClasseDaEntidadeDeCadastro;
  ControllerObserverEntidade.PararDeObservarEntidade(Self,ClasseEntidade);
end;

end.
