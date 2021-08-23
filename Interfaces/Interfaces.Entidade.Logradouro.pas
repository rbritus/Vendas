unit Interfaces.Entidade.Logradouro;

interface

uses
   System.Classes;

type

  iLogradouro = interface
    ['{47CD4EE7-2D8C-4714-BE25-7E7CAB0D9249}']
    procedure SetId(const Value: integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetAbreviacao(const Value: string);
    procedure SetDescricao(const Value: string);
    function GetId: Integer;
    function GetCodigo: Integer;
    function GetAbreviacao: string;
    function GetDescricao: string;
    property Id: Integer read GetId write SetId;
    property Codigo: Integer read GetCodigo write SetCodigo;
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    property Descricao: string read GetDescricao write SetDescricao;
  end;

implementation

end.
