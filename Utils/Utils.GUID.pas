unit Utils.GUID;

interface

uses
  Classes, System.SysUtils;

type
  TUtilsGUID = class
  public
   class function CreateClassGUID: string;
  end;

implementation

{ TGUID }

class function TUtilsGUID.CreateClassGUID: string;
var
  newGUID: TGUID;
begin
  CreateGUID(newGUID);
  Result := GUIDToString(newGUID);
end;

end.
