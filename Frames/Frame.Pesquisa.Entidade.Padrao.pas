unit Frame.Pesquisa.Entidade.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frame.Padrao, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Buttons, Interfaces.Padrao.Observer,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFramePesquisaEntidadePadrao = class(TFramePadrao, iObservador)
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
    FGUIDObjeto: string;
    procedure AplicarDescricaoDoObjetoNoEdit;
    procedure UpdateItem(Value : TObject);
  public
    { Public declarations }
    function ObterEntidade: TObject;
    procedure CarregarEntidade(AGUID: string);
    procedure LimparEdit;
  end;

var
  FramePesquisaEntidadePadrao: TFramePesquisaEntidadePadrao;

implementation

uses
  Controller.Frame.Pesquisa.Entidade.Padrao, Utils.Constants, Utils.Entidade;

{$R *.dfm}

procedure TFramePesquisaEntidadePadrao.AplicarDescricaoDoObjetoNoEdit;
begin
  var Controller := TControllerFrameAdicaoPadrao.New(Self);
  Edit1.Text := Controller.ObterValorDoCampoDeExibicao(FGUIDObjeto);
end;

procedure TFramePesquisaEntidadePadrao.btnExcluirClick(Sender: TObject);
begin
  inherited;
  LimparEdit;
end;

procedure TFramePesquisaEntidadePadrao.btnInserirClick(Sender: TObject);
begin
  inherited;
  var Controller := TControllerFrameAdicaoPadrao.New(Self);
  Controller.ExibirListaDeRegistrosParaSelecao();
end;

procedure TFramePesquisaEntidadePadrao.CarregarEntidade(AGUID: string);
begin
  if AGUID = string.Empty then
    Exit;

  FGUIDObjeto := AGUID;
  AplicarDescricaoDoObjetoNoEdit;
end;

procedure TFramePesquisaEntidadePadrao.LimparEdit;
begin
  Edit1.Clear;
end;

function TFramePesquisaEntidadePadrao.ObterEntidade: TObject;
begin
  var Controller := TControllerFrameAdicaoPadrao.New(Self);
  Result := Controller.ObterEntidade(FGUIDObjeto);
end;

procedure TFramePesquisaEntidadePadrao.UpdateItem(Value: TObject);
begin
  if not Assigned(Value) then
    Exit;

  FGUIDObjeto := TUtilsEntidade.ObterValorPropriedade(Value,'GUID').AsString;
  Value.Free;
  AplicarDescricaoDoObjetoNoEdit;
end;

end.
