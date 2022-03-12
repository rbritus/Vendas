unit Controller.Padrao.Observer;

interface

uses
  Interfaces.Padrao.Observer, System.Generics.Collections, System.SysUtils,
  vcl.Forms;

type
  TControllerPadraoObserver = class(TInterfacedObject, iObservavel)
    private
      FList : TList<iObservador>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iObservavel;
      procedure Remove(Value : iObservador);
      procedure Add(Value : iObservador);
      procedure Notify(Value : TObject);
  end;

  TControllerObserverEntidade = class(TObject)
  private
    FLista: TDictionary<TClass, iObservavel>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ObservarEntidade(AForm: TForm; ClasseEntidade: TClass); overload;
    procedure ObservarEntidade(AFrame: TFrame; ClasseEntidade: TClass); overload;
    procedure PararDeObservarEntidade(AForm: TForm; ClasseEntidade: TClass); overload;
    procedure PararDeObservarEntidade(AFrame: TFrame; ClasseEntidade: TClass); overload;
    procedure Notificar(Entidade: TObject);
  end;

var
  ControllerObserverEntidade: TControllerObserverEntidade;

implementation

{ TControllerPadraoObserver }

procedure TControllerPadraoObserver.Add(Value: iObservador);
begin
  FList.Add(Value);
end;

constructor TControllerPadraoObserver.Create;
begin
  FList := TList<iObservador>.Create;
end;

destructor TControllerPadraoObserver.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TControllerPadraoObserver.New: iObservavel;
begin
  Result := Self.Create;
end;

procedure TControllerPadraoObserver.Notify(Value: TObject);
begin
  for var Indice := 0 to Pred(FList.Count) do
    FList[Indice].UpdateItem(Value);
end;

procedure TControllerPadraoObserver.Remove(Value: iObservador);
begin
  Flist.Remove(Value);
//  for var Indice := 0 to Pred(FList.Count) do
//    if TForm(FList[Indice]).Name = TForm(Value).Name then
//      Flist.Remove(Value)
end;

{ TEntidadePadraoObserver }

constructor TControllerObserverEntidade.Create;
begin
  inherited;
  FLista := TDictionary<TClass, iObservavel>.Create;
end;

destructor TControllerObserverEntidade.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

procedure TControllerObserverEntidade.Notificar(Entidade: TObject);
var
  ControllerObserver: iObservavel;
begin
  if FLista.TryGetValue(Entidade.ClassType, ControllerObserver) then
    ControllerObserver.Notify(Entidade);
end;

procedure TControllerObserverEntidade.ObservarEntidade(AFrame: TFrame;
  ClasseEntidade: TClass);
var
  ControllerObserver: iObservavel;
begin
  if not FLista.TryGetValue(ClasseEntidade, ControllerObserver) then
  begin
    ControllerObserver := TControllerPadraoObserver.New as TControllerPadraoObserver;
    FLista.Add(ClasseEntidade, ControllerObserver);
  end;
  ControllerObserver.Add(AFrame as iObservador);
end;

procedure TControllerObserverEntidade.PararDeObservarEntidade(AFrame: TFrame;
  ClasseEntidade: TClass);
var
  ControllerObserver: iObservavel;
begin
  if FLista.TryGetValue(ClasseEntidade, ControllerObserver) then
    ControllerObserver.Remove(AFrame as iObservador);
end;

procedure TControllerObserverEntidade.ObservarEntidade(AForm: TForm;
  ClasseEntidade: TClass);
var
  ControllerObserver: iObservavel;
begin
  if not FLista.TryGetValue(ClasseEntidade, ControllerObserver) then
  begin
    ControllerObserver := TControllerPadraoObserver.New as TControllerPadraoObserver;
    FLista.Add(ClasseEntidade, ControllerObserver);
  end;
  ControllerObserver.Add(AForm as iObservador);
end;

procedure TControllerObserverEntidade.PararDeObservarEntidade(AForm: TForm;
  ClasseEntidade: TClass);
var
  ControllerObserver: iObservavel;
begin
  if FLista.TryGetValue(ClasseEntidade, ControllerObserver) then
    ControllerObserver.Remove(AForm as iObservador);
end;

initialization
  ControllerObserverEntidade := TControllerObserverEntidade.Create;

finalization
  ControllerObserverEntidade.Free;

end.
