unit Controller.Componente.TImagemValidacao;

interface

uses
  Vcl.Forms, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
  Interfaces.Controller.Componente.TImagemValidacao, Componente.TImagemValidacao;

type
  TControllerTImagemValidacao = class(TInterfacedObject, iControllerTImagemValidacao)
  private
    FForm: TForm;
  protected
    constructor Create(AForm: TForm);
  public
    class function New(AForm: TForm): iControllerTImagemValidacao;
    function CriarImagemDeValidacao(AComponente: TWinControl; Mensagem: string): TImagemValidacao;
    procedure DestruirTImagemValidacaoDoForm;
  end;

implementation

{ TControllerTImagemValidacao }

constructor TControllerTImagemValidacao.Create(AForm: TForm);
begin
  FForm := AForm;
end;

function TControllerTImagemValidacao.CriarImagemDeValidacao(AComponente: TWinControl; Mensagem: string): TImagemValidacao;
begin
  Result := TImagemValidacao.New(FForm, AComponente, Mensagem);
end;

procedure TControllerTImagemValidacao.DestruirTImagemValidacaoDoForm;
begin
  TImagemValidacao.DestruirTImagemValidacao(FForm);
end;

class function TControllerTImagemValidacao.New(AForm: TForm): iControllerTImagemValidacao;
begin
  Result := Self.Create(AForm);
end;

end.
