unit Interfaces.Entidade.Estado;

interface

uses
   System.Classes, Interfaces.Entidade.Pais;

type

  iEstado = interface
    ['{D27319EB-5D68-4AA0-ADAC-27CC2C0EE5CD}']
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetAbreviacao(const Value: string);
    procedure SetCodigoUF(const Value: Integer);
    procedure SetPais(const Value: iPais);
    function GetId: Integer;
    function GetNome: string;
    function GetAbreviacao: string;
    function GetCodigoUF: Integer;
    function GetPais: iPais;
    property Id: Integer read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    property CodigoUF: Integer read GetCodigoUF write SetCodigoUF;
    property Pais: iPais read GetPais write SetPais;
  end;

implementation

end.
