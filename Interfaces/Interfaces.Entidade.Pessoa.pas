unit Interfaces.Entidade.Pessoa;

interface

uses
   System.Classes, Entidade.Endereco, System.Generics.Collections,
   Componente.TObjectList, Utils.Enumerators;

type

  iPessoa = interface
    ['{DB8B4886-9F55-42A7-996E-4540795F3F57}']
    procedure SetGUID(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetAtivo(const Value: TRegistroAtivo);
    procedure SetCPF(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEnderecos(const Value: TObjectListFuck<TEndereco>);
    function GetGUID: string;
    function GetNome: string;
    function GetAtivo: TRegistroAtivo;
    function GetCPF: string;
    function GetEmail: string;
    function GetEnderecos: TObjectListFuck<TEndereco>;
    property GUID: string read GetGUID write SetGUID;
    property Nome: string read GetNome write SetNome;
    property CPF: string read GetCPF write SetCPF;
    property Email: string read GetEmail write SetEmail;
    property Ativo: TRegistroAtivo read GetAtivo write SetAtivo;
    Property Enderecos: TObjectListFuck<TEndereco> read GetEnderecos write SetEnderecos;
  end;

implementation

end.
