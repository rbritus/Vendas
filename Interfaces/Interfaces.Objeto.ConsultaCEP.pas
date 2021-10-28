unit Interfaces.Objeto.ConsultaCEP;

interface

uses
   System.Classes;

type

  iConsultaCEP = interface
    ['{D06017CB-AA15-4153-965E-97BB58091B50}']
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetGIA(const Value: string);
    procedure SetIBGE(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetDDD(const Value: string);
    function GetBairro: string;
    function GetCEP: string;
    function GetComplemento: string;
    function GetDDD: string;
    function GetGIA: string;
    function GetIBGE: string;
    function GetLocalidade: string;
    function GetLogradouro: string;
    function GetUF: string;
    property CEP: string read GetCEP write SetCEP;
    property Logradouro: string read GetLogradouro write SetLogradouro;
    property Complemento: string read GetComplemento write SetComplemento;
    property Bairro: string read GetBairro write SetBairro;
    property Localidade: string read GetLocalidade write SetLocalidade;
    property UF: string read GetUF write SetUF;
    property IBGE: string read GetIBGE write SetIBGE;
    property GIA: string read GetGIA write SetGIA;
    property DDD: string read GetDDD write SetDDD;
    function ToJSONString: string;
  end;

implementation

end.
