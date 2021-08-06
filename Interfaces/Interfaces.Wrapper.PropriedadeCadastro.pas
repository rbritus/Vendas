unit Interfaces.Wrapper.PropriedadeCadastro;

interface

uses
   System.Classes, Attributes.Forms, System.Rtti, Utils.Enumerators;

type

  iWrapperPropriedadeCadastro = interface
    ['{0BC5CF11-31D7-4B3A-B124-65C8A9225D2E}']
    function ObtemValorComponenteForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
    function ObtemValorEntidadeForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
    procedure SetarValorParaComponenteForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Componente: TComponent);
  end;

implementation

end.
