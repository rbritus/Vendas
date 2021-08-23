unit Interfaces.Entidade.Endereco;

interface

uses
   System.Classes, Interfaces.Entidade.Logradouro, Interfaces.Entidade.Cidade;

type

  iEndereco = interface
    ['{C1064C58-E9BC-4D6C-A9E4-8C5C6BB44C5E}']
    procedure SetId(const Value: integer);
    procedure SetCEP(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetNumero(const Value: Integer);
    procedure SetBairro(const Value: string);
    procedure SetLogradouro(const Value: iLogradouro);
    procedure SetCidade(const Value: iCidade);
    function GetId: Integer;
    function GetCEP: string;
    function GetEndereco: string;
    function GetNumero: Integer;
    function GetBairro: string;
    function GetLogradouro: iLogradouro;
    function GetCidade: iCidade;
    property Id: Integer read GetId write SetId;
    property CEP: string read GetCEP write SetCEP;
    property Logradouro: iLogradouro read GetLogradouro write SetLogradouro;
    property Endereco: string read GetEndereco write SetEndereco;
    property Numero: Integer read GetNumero write SetNumero;
    property Bairro: string read GetBairro write SetBairro;
    property Cidade: iCidade read GetCidade write SetCidade;
  end;

implementation

end.
