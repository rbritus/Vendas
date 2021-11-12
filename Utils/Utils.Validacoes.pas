unit Utils.Validacoes;

interface

uses
  Classes, System.SysUtils;

type
  TUtilsValidacoes = class
  public
    class function SomenteNumeros(Key: Char): Boolean;
    class function SomenteLetras(Key: Char): Boolean;
  end;

implementation

{ TUtilsEdit }

class function TUtilsValidacoes.SomenteNumeros(Key: Char): Boolean;
begin
  Result := CharInSet(key,['0'..'9']);
end;

class function TUtilsValidacoes.SomenteLetras(Key: Char): Boolean;
begin
  Result := CharInSet(key,['a'..'z','A'..'Z',Chr(8)]);
end;

end.
