unit Interfaces.Entidade.Pessoa;

interface

uses
   System.Classes, Entidade.Endereco, System.Generics.Collections;

type

  iPessoa = interface
    ['{DB8B4886-9F55-42A7-996E-4540795F3F57}']
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetAtivo(const Value: string);
    procedure SetCPF(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEnderecos(const Value: TObjectList<TEndereco>);
    function GetId: Integer;
    function GetNome: string;
    function GetAtivo: string;
    function GetCPF: string;
    function GetEmail: string;
    function GetEnderecos: TObjectList<TEndereco>;
    property Id: Integer read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property CPF: string read GetCPF write SetCPF;
    property Email: string read GetEmail write SetEmail;
    property Ativo: string read GetAtivo write SetAtivo;
    Property Enderecos: TObjectList<TEndereco> read GetEnderecos write SetEnderecos;
  end;

implementation

end.
