unit Interfaces.Objeto.PropertyCustom;

interface

uses
  System.Rtti;

type

  iPropertyCustom = interface
  ['{D541C7BA-2296-4284-93E2-CABF2570594B}']
    function GetValue: TValue;
    procedure SetValue(const Value: TValue);
  end;

implementation

end.
