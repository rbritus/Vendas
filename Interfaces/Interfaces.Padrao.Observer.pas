unit Interfaces.Padrao.Observer;

interface

type
  iObservador = interface
    ['{A04A5DA1-5648-4E14-BF8B-BD5FF5E5699E}']
    procedure UpdateItem(Value : TObject);
  end;

  iObservavel = interface
    ['{9F801546-806A-4295-93A7-4AFA5E1FF43F}']
    procedure Add(Value : iObservador);
    procedure Notify(Value : TObject);
  end;

implementation

end.
