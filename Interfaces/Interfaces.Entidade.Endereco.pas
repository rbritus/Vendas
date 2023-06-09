unit Interfaces.Entidade.Endereco;

interface

uses
   System.Classes, Entidade.Cidade, Utils.Enumerators;

type

  iEndereco = interface
    ['{C1064C58-E9BC-4D6C-A9E4-8C5C6BB44C5E}']
    procedure SetGUID(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNumero(const Value: Integer);
    procedure SetBairro(const Value: string);
    procedure SetCidade(const Value: TCidade);
    procedure SetTipoEndereco(const Value: TTipoEndereco);
    procedure SetComplemento(const Value: string);
    function GetGUID: string;
    function GetCEP: string;
    function GetLogradouro: string;
    function GetNumero: Integer;
    function GetBairro: string;
    function GetCidade: TCidade;
    function GetTipoEndereco: TTipoEndereco;
    function GetComplemento: string;
    property GUID: string read GetGUID write SetGUID;
    property CEP: string read GetCEP write SetCEP;
    property Logradouro: string read GetLogradouro write SetLogradouro;
    property Numero: Integer read GetNumero write SetNumero;
    property Bairro: string read GetBairro write SetBairro;
    property Complemento: string read GetComplemento write SetComplemento;
    property Cidade: TCidade read GetCidade write SetCidade;
    property TipoEndereco: TTipoEndereco read GetTipoEndereco write SetTipoEndereco;
  end;

implementation

end.
