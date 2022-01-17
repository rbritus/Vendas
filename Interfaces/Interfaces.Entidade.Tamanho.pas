unit Interfaces.Entidade.Tamanho;

interface

uses
   System.Classes, System.Generics.Collections;

type
  iTamanho = interface
    ['{32C7F267-9D14-432A-8EA1-D5E131E34796}']
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetAbreviacao(const Value: string);
    function GetAbreviacao: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    property GUID: string read GetGUID write SetGUID;
    property Nome: string read GetNome write SetNome;
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
  end;

implementation

end.
