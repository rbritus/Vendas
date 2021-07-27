unit Interfaces.Pessoa;

interface
uses
   System.Classes;

type

  iPessoa = interface
    ['{DB8B4886-9F55-42A7-996E-4540795F3F57}']
    procedure SetId(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetAtivo(const Value: string);
    function GetId: Integer;
    function GetNome: string;
    function GetAtivo: string;
    property Id: Integer read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Ativo: string read GetAtivo write SetAtivo;
  end;

implementation

end.
