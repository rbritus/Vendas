unit Componente.TObjectList;

interface

uses
  System.Generics.Collections, RTTI;

type
  TObjectListFuck<T: class> = class(TObjectList<T>);

  TListFuck<T: class> = class(TList<T>);

implementation

{ TObjectListFuck<T> }

end.
