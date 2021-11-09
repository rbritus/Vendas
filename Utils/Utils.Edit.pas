unit Utils.Edit;

interface

uses
  Classes, System.SysUtils;

type
  TUtilsEdit = class
  public
    class function SomenteNumeros(Key: Char; CharSet: TSysCharSet): Boolean;
  end;

implementation

{ TUtilsEdit }

class function TUtilsEdit.SomenteNumeros(Key: Char;
  CharSet: TSysCharSet): Boolean;
begin
  Result := CharInSet(key,CharSet);
end;

end.
