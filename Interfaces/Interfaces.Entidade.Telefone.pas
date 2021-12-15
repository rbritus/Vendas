unit Interfaces.Entidade.Telefone;

interface

uses
   System.Classes, Utils.Enumerators;

type

  iTelefone = interface
    ['{C10B7708-E94E-403E-91E8-6A1F02ABCC65}']
    function GetGUID: string;
    procedure SetGUID(const Value: string);
    procedure SetNumero(const Value: string);
    function GetNumero: string;
    function GetTipoEndereco: TTipoTelefone;
    procedure SetTipoEndereco(const Value: TTipoTelefone);
    procedure SetObservacao(const Value: string);
    function GetObservacao: string;
    property GUID: string read GetGUID write SetGUID;
    property Numero: string read GetNumero write SetNumero;
    property TipoTelefone: TTipoTelefone read GetTipoEndereco write SetTipoEndereco;
    property Observacao: string read GetObservacao write SetObservacao;
  end;

implementation

end.
