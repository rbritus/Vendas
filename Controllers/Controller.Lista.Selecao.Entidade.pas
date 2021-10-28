unit Controller.Lista.Selecao.Entidade;

interface

uses
  Vcl.Forms, System.Classes, Data.DB, RTTI, Vcl.Controls,
  Interfaces.Controller.Lista.Selecao.Entidade, System.SysUtils;

type
  TControllerListaSelecaoEntidade = class(TInterfacedObject, iControllerListaSelecaoEntidade)
  strict private
    FClasseEntidade: TClass;
  protected
    constructor Create(pClasseEntidade: TClass);
  public
    class function New(pClasseEntidade: TClass): iControllerListaSelecaoEntidade;
    function ObterObjetoSelecionado(pId: Integer): TObject;
    function ObterDataSetPreenchido: TDataSet;
  end;

implementation

uses
  Utils.Entidade;

{ TControllerFrameAdicaoPadrao }

constructor TControllerListaSelecaoEntidade.Create(pClasseEntidade: TClass);
begin
  FClasseEntidade := pClasseEntidade;
end;

class function TControllerListaSelecaoEntidade.New(pClasseEntidade: TClass): iControllerListaSelecaoEntidade;
begin
  Result := TControllerListaSelecaoEntidade.Create(pClasseEntidade);
end;

function TControllerListaSelecaoEntidade.ObterDataSetPreenchido: TDataSet;
begin
  var FClientDataSet := TDataSet(TUtilsEntidade.ExecutarMetodoClasse(FClasseEntidade,'ListarTodosCDS',[]).AsObject);
  Result := FClientDataSet;
end;

function TControllerListaSelecaoEntidade.ObterObjetoSelecionado(pId: Integer): TObject;
begin
  Result := TUtilsEntidade.ExecutarMetodoClasse(FClasseEntidade,'PesquisarPorId',[pId]).AsObject;
end;

end.
