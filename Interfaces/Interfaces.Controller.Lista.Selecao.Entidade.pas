unit Interfaces.Controller.Lista.Selecao.Entidade;

interface

uses
   System.Classes, Data.DB;

type

  iControllerListaSelecaoEntidade = interface
    ['{F29FE33D-3608-454C-9D56-01DD9717FF55}']
    function ObterObjetoSelecionado(pId: Integer): TObject;
    function ObterDataSetPreenchido: TDataSet;
  end;

implementation

end.
