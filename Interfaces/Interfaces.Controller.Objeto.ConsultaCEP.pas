unit Interfaces.Controller.Objeto.ConsultaCEP;

interface

uses
  Interfaces.Objeto.ConsultaCEP;

type
  IControllerConsultaCEP = interface
    ['{202D4AB9-6B89-4CFF-A080-9DBC09D66737}']
    function Get(const ACep: string): iConsultaCEP;
    function Validate(const ACep: string): Boolean;
  end;

implementation

end.

