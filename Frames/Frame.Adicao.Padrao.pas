unit Frame.Adicao.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.DBCGrids, Data.DB, Datasnap.DBClient,
  Componente.TObjectList;

type
  TFrameAdicaoPadrao = class(TFramePadrao)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    Panel3: TPanel;
    Image1: TImage;
    Image2: TImage;
    Panel4: TPanel;
    cdsDados: TClientDataSet;
    dscDados: TDataSource;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    FIdObjRelacional: Integer;
    procedure CarregarDataSet;
  protected
    procedure ObterListaPreenchida(var Lista: TObjectListFuck<TObject>);
    function ObterSqlParaDatSet: string; virtual; Abstract;
    function ObterSqlDeTabelaRelacional: string;
    function ObterObjetoDoFrame: TObject;
    procedure CriarDataSet; virtual; Abstract;
    procedure PreencherDataSet(Obj: TObject); virtual; Abstract;
  public
    { Public declarations }
    procedure CarregarFrame(IdEntidade: Integer);
  end;

var
  FrameAdicaoPadrao: TFrameAdicaoPadrao;

implementation

uses
  Controller.Frame.Adicao.Padrao;

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

//  var cSql := ObterSqlParaDatSet;
//  var ControllerFrame := TControllerFrameAdicaoPadrao.New(Self);
//  var cds := ControllerFrame.CarregarDataSet(cSql);
//  try
//    cdsDados.Data := TClientDataSet(cds).Data;
//  finally
//    FreeAndNil(cds);
//  end;
end;

procedure TFrameAdicaoPadrao.Image1Click(Sender: TObject);
begin
  inherited;
  cdsDados.Delete;
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

procedure TFrameAdicaoPadrao.CarregarFrame(IdEntidade: Integer);
begin
  FIdObjRelacional := IdEntidade;
  CarregarDataSet;
end;

end.
