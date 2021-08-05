unit Interfaces.Services.Padrao;

interface

uses
   System.Classes, System.Generics.Collections, generics.collections, Data.DB;

type

 iServico<T> = interface
   ['{B7828FB5-ADD1-4745-8029-AF82D261905F}']
      procedure Gravar(Objeto: TObject);
      procedure Excluir(Objeto: TObject);
      function ListarTodos(): TList<T>;
      function ListarTodosCDS(): TDataSet;
      function PesquisarPorId(Id: Integer): T;
      function PesquisarPorCondicao(cSql: string): TList<T>;
 end;

implementation

end.
