unit Interfaces.Entidade.Estado;

interface

uses
   System.Classes, Entidade.Pais;

type

  iEstado = interface
    ['{D27319EB-5D68-4AA0-ADAC-27CC2C0EE5CD}']
    procedure SetGUID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetAbreviacao(const Value: string);
    procedure SetCodigoUF(const Value: Integer);
    procedure SetPais(const Value: TPais);
    function GetGUID: string;
    function GetNome: string;
    function GetAbreviacao: string;
    function GetCodigoUF: Integer;
    function GetPais: TPais;
    property GUID: string read GetGUID write SetGUID;
    property Nome: string read GetNome write SetNome;
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    property CodigoUF: Integer read GetCodigoUF write SetCodigoUF;
    property Pais: TPais read GetPais write SetPais;
  end;

implementation

end.
