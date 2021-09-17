unit Interfaces.Entidade.Endereco;

interface

uses
   System.Classes, Interfaces.Entidade.Logradouro, Interfaces.Entidade.Cidade,
   Utils.Enumerators;

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
    procedure SetTipoEndereco(const Value: Integer);
    procedure SetComplemento(const Value: string);
    function GetId: Integer;
    function GetCEP: string;
    function GetEndereco: string;
    function GetNumero: Integer;
    function GetBairro: string;
    function GetLogradouro: iLogradouro;
    function GetCidade: iCidade;
    function GetTipoEndereco: Integer;
    function GetComplemento: string;
    property Id: Integer read GetId write SetId;
    property CEP: string read GetCEP write SetCEP;
    property Logradouro: iLogradouro read GetLogradouro write SetLogradouro;
    property Endereco: string read GetEndereco write SetEndereco;
    property Numero: Integer read GetNumero write SetNumero;
    property Bairro: string read GetBairro write SetBairro;
    property Complemento: string read GetComplemento write SetComplemento;
    property Cidade: iCidade read GetCidade write SetCidade;
    property TipoEndereco: Integer read GetTipoEndereco write SetTipoEndereco;
  end;

implementation

end.
