unit Interfaces.Entidade.Produto;

interface

uses
   System.Classes, System.Generics.Collections, Componente.TObjectList,
   Entidade.Imagem;

type
  iProduto = interface
    ['{7363BF79-99A2-4C5B-A9BF-3CBED84AC410}']
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetCodigo(const Value: string);
    function GetCodigo: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    procedure SetImagens(const Value: TObjectListFuck<TImagem>);
    function GetImagens: TObjectListFuck<TImagem>;
    property GUID: string read GetGUID write SetGUID;
    property Codigo: string read GetCodigo write SetCodigo;
    property Nome: string read GetNome write SetNome;
    Property Imagens: TObjectListFuck<TImagem> read GetImagens write SetImagens;
  end;

implementation

end.
