unit Interfaces.Entidade.Imagem;

interface

uses
   System.Classes, System.Generics.Collections, Objeto.Blob, Utils.Enumerators;

type
  iImagem = interface
    ['{943A5D5E-7805-4924-BEE3-5AB95030538E}']
    procedure SetGUID(const Value: string);
    function GetGUID: string;
    procedure SetNome(const Value: string);
    function GetNome: string;
    procedure SetExtensao(const Value: TTipoExtensao);
    function GetExtensao: TTipoExtensao;
    function GetArquivo: TBlobImagem;
    property GUID: string read GetGUID write SetGUID;
    property Nome: string read GetNome write SetNome;
    property Extensao: TTipoExtensao read GetExtensao write SetExtensao;
    property Arquivo: TBlobImagem read GetArquivo;
  end;

implementation

end.
