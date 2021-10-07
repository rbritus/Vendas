unit Componente.TObjectList;

interface

uses
  System.Generics.Collections, RTTI;

type
  TObjectListFuck<T: class> = class(TObjectList<T>)
  private
    function Clone(ObjetoClone: TObject): TObject;
  public
    procedure CopyTo(Lista: TObjectListFuck<T>);
  end;

  TListFuck<T: class> = class(TList<T>);

implementation

uses
  Utils.Entidade;

{ TObjectListFuck<T> }

procedure TObjectListFuck<T>.CopyTo(Lista: TObjectListFuck<T>);
begin
  Self.Clear;
  for var Obj in Lista do
    Self.Add(Self.Clone(Obj));
end;

function TObjectListFuck<T>.Clone(ObjetoClone: TObject): TObject;
begin
  Result := TUtilsEntidade.ObterCloneObjeto(ObjetoClone);
end;

end.
