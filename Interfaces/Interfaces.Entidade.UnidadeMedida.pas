unit Interfaces.Entidade.UnidadeMedida;

interface

uses
   System.Classes, System.Generics.Collections;

type
  iUnidadeMedida = interface
    ['{ED19719E-83B8-437D-9E95-B40EDF9BB323}']
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    function GetAbreviacao: string;
    procedure SetAbreviacao(const Value: string);
    procedure SetDescricao(const Value: string);
    function GetDescricao: string;
    property GUID: string read GetGUID write SetGUID;
    property Abreviacao: string read GetAbreviacao write SetAbreviacao;
    property Descricao: string read GetDescricao write SetDescricao;
  end;

implementation

end.
