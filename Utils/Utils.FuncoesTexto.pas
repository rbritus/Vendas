unit Utils.FuncoesTexto;

interface

uses
  Classes, System.SysUtils;

type
  TUtilsFuncoesTexto = class
  public
    class function RemoveAcento(const pText: string): string;
  end;

implementation

{ TUtilsFuncoesTexto }

class function TUtilsFuncoesTexto.RemoveAcento(const pText: string): string;
type
  USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));

end;

end.
