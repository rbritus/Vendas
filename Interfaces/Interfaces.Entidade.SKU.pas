unit Interfaces.Entidade.SKU;

interface

uses
   System.Classes, System.Generics.Collections, Componente.TObjectList,
   Entidade.Tamanho;

type
  iSKU = interface
    ['{7A817432-BDDE-45D5-8086-3247E6D40C5D}']
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    procedure SetTamanho(const Value: TTamanho);
    function GetTamanho: TTamanho;
    property GUID: string read GetGUID write SetGUID;
    property Nome: string read GetNome write SetNome;
    property Tamanho: TTamanho read GetTamanho write SetTamanho;
  end;

implementation

end.
