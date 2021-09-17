unit Utils.Enumerators;

interface

uses
  Attributes.Enumerators, System.Rtti;

type
//  TEnumerator<T:record> = class
//  public
//    class function GetIndex(const eEnum:T): Integer;
//  end;

  [TEnumAttribute(0,'Inteiro',0)]
  [TEnumAttribute(1,'Texto',1)]
  [TEnumAttribute(2,'Decimal',2)]
  [TEnumAttribute(3,'Data',3)]
  [TEnumAttribute(4,'Estrangeiro',4)]
  [TEnumAttribute(5,'Listagem',5)]
  [TEnumAttribute(6,'Lógico',6)]
  [TEnumAttribute(7,'Blob',7)]
  [TEnumAttribute(8,'Custom property',8)]
  TTiposDeCampo = (ftINTEIRO, ftTEXTO, ftDECIMAL, ftDATA, ftESTRANGEIRO,
    ftLISTAGEM, ftLOGICO, ftBLOBT, ftCUSTOMPROPERTY);

  [TEnumAttribute(0,'Obrigatório','S')]
  [TEnumAttribute(1,'Não obrigatório','N')]
  TCampoObrigatorio = (coObrigatorio, coNaoObrigatorio);

  [TEnumAttribute(0,'Principal',0)]
  [TEnumAttribute(1,'Residêncial',1)]
  [TEnumAttribute(2,'Comercial',2)]
  [TEnumAttribute(3,'Entrega',3)]
  TTipoEndereco = (tePrincipal, teResidencial, teComercial, teEntrega);

  [TEnumAttribute(0,'Ativo','S')]
  [TEnumAttribute(1,'Inativo','N')]
  TRegistroAtivo = (raAtivo, raInativo);

implementation

end.

