unit Interfaces.Controller.Cadastro.Lista.Padrao;

interface

uses
   System.Classes, Data.DB;

type

  iControllerCadastroListaPadrao = interface
    ['{E53FF557-9668-4463-BF94-95D7333E7B13}']
    function ObterDataSetComDadosParaGride: TDataSet;
    procedure ApresentarFormParaCadastro(ID: Integer);
  end;

implementation

end.
