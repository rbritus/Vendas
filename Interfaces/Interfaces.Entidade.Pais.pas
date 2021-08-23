unit Interfaces.Entidade.Pais;

interface

uses
   System.Classes;

type

  iPais = interface
    ['{7F7AA060-3D0A-4AAA-B4DA-036DB2FFCA31}']
    procedure SetAbreviacao(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetCodigoBACEN(const Value: string);
    procedure SetCodigoSISCOMEX(const Value: string);
    function GetAbreviacao: string;
    function GetId: Integer;
    function GetNome: string;
    function GetCodigoBACEN: string;
    function GetCodigoSISCOMEX: string;
    property Id: Integer read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    property CodigoBACEN: string read GetCodigoBACEN write SetCodigoBACEN;
    property CodigoSISCOMEX: string read GetCodigoSISCOMEX write SetCodigoSISCOMEX;
  end;

implementation

end.
