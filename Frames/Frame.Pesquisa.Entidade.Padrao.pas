unit Frame.Pesquisa.Entidade.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frame.Padrao, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Buttons;

type
  TFramePesquisaEntidadePadrao = class(TFramePadrao)
    cds: TClientDataSet;
    dsc: TDataSource;
    Label1: TLabel;
    Edit1: TEdit;
    btnInserir: TBitBtn;
    btnExcluir: TBitBtn;
    procedure btnInserirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    FIdObjeto: Integer;
    procedure AplicarDescricaoDoObjetoNoEdit;
  public
    { Public declarations }
    function ObterEntidade: TObject;
    procedure CarregarEntidade(AID: Integer);
  end;

var
  FramePesquisaEntidadePadrao: TFramePesquisaEntidadePadrao;

implementation

uses
  Controller.Frame.Pesquisa.Entidade.Padrao, Utils.Constants;

{$R *.dfm}

procedure TFramePesquisaEntidadePadrao.AplicarDescricaoDoObjetoNoEdit;
begin
  var Controller := TControllerFrameAdicaoPadrao.New(Self);
  Edit1.Text := Controller.ObterValorDoCampoDeExibicao(FIdObjeto);
end;

procedure TFramePesquisaEntidadePadrao.btnExcluirClick(Sender: TObject);
begin
  inherited;
  Edit1.Clear;
end;

procedure TFramePesquisaEntidadePadrao.btnInserirClick(Sender: TObject);
begin
  inherited;
  var Controller := TControllerFrameAdicaoPadrao.New(Self);
  Controller.ExibirListaDeRegistrosParaSelecao();
  var Id := Controller.ObterIdDaEntidadeDoRegistroSelecionado;

  if Id = TConstantsInteger.ZERO  then
    Exit;

  FIdObjeto := Id;
  AplicarDescricaoDoObjetoNoEdit;
end;

procedure TFramePesquisaEntidadePadrao.CarregarEntidade(AID: Integer);
begin
  if AID = TConstantsInteger.ZERO then
    Exit;

  FIdObjeto := AID;
  AplicarDescricaoDoObjetoNoEdit;
end;

function TFramePesquisaEntidadePadrao.ObterEntidade: TObject;
begin
  var Controller := TControllerFrameAdicaoPadrao.New(Self);
  Result := Controller.ObterEntidade(FIdObjeto);
end;

end.
