unit Interfaces.Controller.Cadastro.Padrao;

interface

uses
   System.Classes, Vcl.Controls;

type

  iControllerCadastroPadrao = interface
    ['{83B6B9DB-59B8-4277-9F36-1A4BC300EB05}']
    procedure GravarEntidade;
    procedure CarregarEntidadeParaEdicao(AGUID: string);
    procedure CarregarLayoutDeCamposEditaveis;
    procedure LimparCamposEditaveis;
    procedure LimparEntidadesMapeadas;
    procedure DestruirEntidadesPosCadastro;
    procedure CarregarComboBoxComEnumerators;
    procedure CarregarMascarasNosCampos;
    function CamposObrigatoriosEstaoPreenchidos: Boolean;
    procedure CriarImagemDeValidacaoDeCampo(AComponente: TWinControl; Mensagem: string);
  end;

implementation

end.
