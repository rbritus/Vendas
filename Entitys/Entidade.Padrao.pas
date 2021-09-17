Unit Entidade.Padrao;

Interface

uses
  System.Classes, System.Generics.Collections, Services.Padrao, Rtti,
  Datasnap.DBClient, System.SysUtils, Interfaces.Services.Padrao, Utils.Entidade,
  Componente.TObjectList;

Type
  TEntidade<T: class> = class(TInterfacedPersistent)
  public
    procedure Gravar;
    procedure Excluir;
    procedure Limpar;
    function EstaVazia: Boolean; virtual; abstract;
    class function ListarTodos: TObjectListFuck<T>;
    class function ListarTodosCDS: TClientDataSet;
    class function PesquisarPorId(Id: Integer): T;
    class function PesquisarPorCondicao(cSql: string): TObjectListFuck<T>;
  end;

Implementation

{ TEntidade }

procedure TEntidade<T>.Excluir;
begin
  var iServico := TServico<T>.New;
  iServico.Excluir(Self);
end;

procedure TEntidade<T>.Gravar;
begin
  var iServico := TServico<T>.New;
  iServico.Gravar(Self);
end;

procedure TEntidade<T>.Limpar;
begin
  TUtilsEntidade.Limpar(Self)
end;

class function TEntidade<T>.ListarTodos(): TObjectListFuck<T>;
begin
  var iServico := TServico<T>.New;
  Result := iServico.ListarTodos();
end;

class function TEntidade<T>.ListarTodosCDS: TClientDataSet;
begin
  var iServico := TServico<T>.New;
  Result := TClientDataSet(iServico.ListarTodosCDS);
end;

class function TEntidade<T>.PesquisarPorCondicao(cSql: string): TObjectListFuck<T>;
begin
  var iServico := TServico<T>.New;
  Result := iServico.PesquisarPorCondicao(cSql);
end;

class function TEntidade<T>.PesquisarPorId(Id: Integer): T;
begin
  var iServico := TServico<T>.New;
  Result := iServico.PesquisarPorId(Id);
end;

end.
