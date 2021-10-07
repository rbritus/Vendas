unit Interfaces.Controller.Cadastro.Padrao;

interface

uses
   System.Classes;

type

  iControllerCadastroPadrao = interface
    ['{83B6B9DB-59B8-4277-9F36-1A4BC300EB05}']
    procedure GravarEntidade;
    procedure CarregarEntidadeParaEdicao(pId: Integer);
    procedure CarregarLayoutDeCamposEditaveis;
    procedure LimparCamposEditaveis;
  end;

implementation

end.
