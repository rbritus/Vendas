unit Controller.Lista.Selecao.Entidade;

interface

uses
  Vcl.Forms, System.Classes, Data.DB, RTTI, Vcl.Controls,
  Interfaces.Controller.Lista.Selecao.Entidade, System.SysUtils;

type
  TControllerListaSelecaoEntidade = class(TInterfacedObject, iControllerListaSelecaoEntidade)
  strict private
    FClasseEntidade: TClass;
  private
    procedure SomenteRegistrosAtivos(DataSet: TDataSet);
    function ExistePropriedadeRegistrosAtivos: Boolean;
  protected
    constructor Create(AClasseEntidade: TClass);
  public
    class function New(AClasseEntidade: TClass): iControllerListaSelecaoEntidade;
    function ObterObjetoSelecionado(AGUID: string): TObject;
    function ObterDataSetPreenchido: TDataSet;
  end;

implementation

uses
  Utils.Entidade, Utils.Enumerators;

{ TControllerFrameAdicaoPadrao }

constructor TControllerListaSelecaoEntidade.Create(AClasseEntidade: TClass);
begin
  FClasseEntidade := AClasseEntidade;
end;

function TControllerListaSelecaoEntidade.ExistePropriedadeRegistrosAtivos: Boolean;
begin
  var Objeto := FClasseEntidade.Create;
  try
    Result := TUtilsEntidade.ExistePropriedade(Objeto,'ATIVO');
  finally
    Objeto.DisposeOf;
  end;
end;

class function TControllerListaSelecaoEntidade.New(AClasseEntidade: TClass): iControllerListaSelecaoEntidade;
begin
  Result := TControllerListaSelecaoEntidade.Create(AClasseEntidade);
end;

function TControllerListaSelecaoEntidade.ObterDataSetPreenchido: TDataSet;
begin
  var FClientDataSet := TDataSet(TUtilsEntidade.ExecutarMetodoClasse(FClasseEntidade,'ListarTodosCDS',[]).AsObject);
  SomenteRegistrosAtivos(FClientDataSet);
  Result := FClientDataSet;
end;

function TControllerListaSelecaoEntidade.ObterObjetoSelecionado(AGUID: string): TObject;
begin
  Result := TUtilsEntidade.ExecutarMetodoClasse(FClasseEntidade,'PesquisarPorGUID',[AGUID]).AsObject;
end;

procedure TControllerListaSelecaoEntidade.SomenteRegistrosAtivos(DataSet: TDataSet);
begin
  if not ExistePropriedadeRegistrosAtivos then
    Exit;

  DataSet.Filter := 'ATIVO = ' + TEnumerator<TRegistroAtivo>.GetValueToString(raAtivo).QuotedString;
  DataSet.Filtered := True;
end;

end.
