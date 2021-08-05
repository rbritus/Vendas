Unit Entidade.Padrao;

Interface

uses
  System.Classes, System.Generics.Collections, Services.Padrao, Rtti,
  Datasnap.DBClient, System.SysUtils, Interfaces.Services.Padrao, Utils.Entidade;

Type
   TEntidade<T: class> = Class(TInterfacedPersistent)
   Public
      procedure Gravar;
      procedure Excluir;
      procedure Limpar;
      function EstaVazia: Boolean; virtual; abstract;
      class function ListarTodos: TList<T>;
      class function ListarTodosCDS: TClientDataSet;
      class function PesquisarPorId(Id: Integer): T;
      class function PesquisarPorCondicao(cSql: string): TList<T>;
   End;

Implementation

{ TEntidade }

procedure TEntidade<T>.Excluir;
begin
   var iServico := TServico<T>.Create;
   iServico.Excluir(Self);
end;

procedure TEntidade<T>.Gravar;
begin
   var iServico := TServico<T>.Create;
   iServico.Gravar(Self);
   iServico.Free;
end;

procedure TEntidade<T>.Limpar;
begin
   TUtilsEntidade.Limpar(Self)
end;

class function TEntidade<T>.ListarTodos(): TList<T>;
begin
   var iServico := TServico<T>.Create;
   Result := iServico.ListarTodos();
   iServico.Free;
end;

class function TEntidade<T>.ListarTodosCDS: TClientDataSet;
begin
   var iServico := TServico<T>.Create;
   Result := TClientDataSet(iServico.ListarTodosCDS());
   iServico.Free;
end;

class function TEntidade<T>.PesquisarPorCondicao(cSql: string): TList<T>;
begin
   var iServico := TServico<T>.Create;
   Result := iServico.PesquisarPorCondicao(cSql);
   iServico.Free;
end;

class function TEntidade<T>.PesquisarPorId(Id: Integer): T;
begin
   var iServico := TServico<T>.Create;
   Result := iServico.PesquisarPorId(Id);
   iServico.Free;
end;

end.
