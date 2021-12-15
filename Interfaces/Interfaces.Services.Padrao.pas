unit Interfaces.Services.Padrao;

interface

uses
   System.Classes, System.Generics.Collections, generics.collections, Data.DB,
   Componente.TObjectList;

type

 iServico<T: class> = interface
   ['{B7828FB5-ADD1-4745-8029-AF82D261905F}']
      procedure Gravar(Objeto: TObject);
      procedure Excluir(Objeto: TObject);
      function ListarTodos(): TObjectListFuck<T>;
      function ListarTodosCDS(): TDataSet;
      function PesquisarPorGUID(GUID: string): T;
      function PesquisarPorCondicao(cSql: string): TObjectListFuck<T>;
 end;

implementation

end.
