unit Interfaces.Entidade.Cidade;

interface

uses
   System.Classes, Entidade.Estado;

type

  iCidade = interface
    ['{D06017CB-AA15-4153-965E-97BB58091B50}']
    procedure SetGUID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetCodigoIBGE(const Value: Integer);
    procedure SetCodigoMunicipio(const Value: string);
    procedure SetCodigoDistrito(const Value: string);
    procedure SetEstado(const Value: TEstado);
    function GetGUID: string;
    function GetNome: string;
    function GetCodigoIBGE: Integer;
    function GetCodigoMunicipio: string;
    function GetCodigoDistrito: string;
    function GetEstado: TEstado;
    property GUID: string read GetGUID write SetGUID;
    property Nome: string read GetNome write SetNome;
    property CodigoIBGE: Integer read GetCodigoIBGE write SetCodigoIBGE;
    property CodigoMunicipio: string read GetCodigoMunicipio write SetCodigoMunicipio;
    property CodigoDistrito: string read GetCodigoDistrito write SetCodigoDistrito;
    property Estado: TEstado read GetEstado write SetEstado;
  end;

implementation

end.
