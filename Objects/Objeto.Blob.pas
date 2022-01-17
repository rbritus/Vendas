unit Objeto.Blob;

interface

uses
  System.Generics.Collections, RTTI, Componente.TObjectList, System.Classes,
  Utils.Constants, Attributes.Blob, Utils.Enumerators;

type
  TBlob = class(TMemoryStream)
  public
    function IsEmpty: Boolean;
  end;

  [TExtensoes([extJPEG,extPNG,extBMP])]
  TBlobImagem = class(TBlob)

  end;

implementation

{ TBlob }

function TBlob.IsEmpty: Boolean;
begin
  Result := Self.Size = TConstantsInteger.ZERO;
end;

end.
