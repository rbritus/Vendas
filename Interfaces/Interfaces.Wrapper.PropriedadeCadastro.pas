unit Interfaces.Wrapper.PropriedadeCadastro;

interface

uses
   System.Classes, Attributes.Forms, System.Rtti, Utils.Enumerators;

type

  iWrapperPropriedadeCadastro = interface
    ['{0BC5CF11-31D7-4B3A-B124-65C8A9225D2E}']
    procedure PreencherObjetoDoForm(var pEntidade: TPersistent);
    procedure PreencherFormComEntidade(pEntidade: TPersistent);
    procedure InicializarCamposEditaveisDoForm;
  end;

implementation

end.
