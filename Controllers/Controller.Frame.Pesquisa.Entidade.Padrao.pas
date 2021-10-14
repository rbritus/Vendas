unit Controller.Frame.Pesquisa.Entidade.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Data.DB, RTTI, Vcl.Controls,
  Interfaces.Controller.Frame.Pesquisa.Entidade.Padrao;

type
  TControllerFrameAdicaoPadrao = class(TInterfacedObject, iControllerFramePesquisaEntidadePadrao)
  strict private
    FFrame: TFrame;
  private
    constructor Create(pFrame: TFrame);
  public
    class function New(pFrame: TFrame): iControllerFramePesquisaEntidadePadrao;
  end;

implementation

{ TControllerFrameAdicaoPadrao }

constructor TControllerFrameAdicaoPadrao.Create(pFrame: TFrame);
begin
  FFrame := pFrame;
end;

class function TControllerFrameAdicaoPadrao.New(pFrame: TFrame): iControllerFramePesquisaEntidadePadrao;
begin
  Result := Self.Create(pFrame);
end;

end.
