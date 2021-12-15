unit Componente.TObjectList;

interface

uses
  System.Generics.Collections, RTTI;

type
  TObjectListFuck<T: class> = class(TObjectList<T>)
  private
    function Clone(ObjetoClone: TObject): TObject;
  public
    function GetCloneLista: TObjectListFuck<T>;
  end;

  TListFuck<T> = class(TList<T>);

implementation

uses
  Utils.Entidade;

{ TObjectListFuck<T> }

function TObjectListFuck<T>.GetCloneLista: TObjectListFuck<T>;
begin
  var Lista := TObjectListFuck<T>.Create;

  for var Obj in Self do
    Lista.Add(Lista.Clone(Obj));

  Result := Lista;
end;

function TObjectListFuck<T>.Clone(ObjetoClone: TObject): TObject;
begin
  Result := TUtilsEntidade.ObterCloneObjeto(ObjetoClone);
end;

end.
