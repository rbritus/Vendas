unit Attributes.Blob;

interface

uses
  System.SysUtils, Utils.Enumerators;

type
  TExtensoes = class(TCustomAttribute)
  private
    FExtensoes: TTipoExtensoes;
  public
    property Extensoes: TTipoExtensoes read FExtensoes write FExtensoes;
    constructor Create(const AValue: TTipoExtensoes);
  end;

implementation

{ TExtensoes }

constructor TExtensoes.Create(const AValue: TTipoExtensoes);
begin
  FExtensoes := AValue;
end;

end.
