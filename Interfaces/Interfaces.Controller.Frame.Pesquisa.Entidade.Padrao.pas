unit Interfaces.Controller.Frame.Pesquisa.Entidade.Padrao;

interface

uses
   System.Classes;

type

  iControllerFramePesquisaEntidadePadrao = interface
    ['{A39AE8C8-C9FA-4839-9566-43FA72B0FA3C}']
    procedure ExibirListaDeRegistrosParaSelecao;
    function ObterIdDaEntidadeDoRegistroSelecionado: Integer;
    function ObterValorDoCampoDeExibicao(ID: Integer): string;
    function ObterEntidade(ID: Integer): TObject;
  end;

implementation

end.
