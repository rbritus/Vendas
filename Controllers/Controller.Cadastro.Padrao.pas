unit Controller.Cadastro.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Cadastro.Padrao;

type
  TControllerCadastroPadrao = class(TInterfacedObject, iControllerCadastroPadrao)
    FForm: TForm;
    FEntidade: TPersistent;
  private
    procedure ObterObjeto;
    procedure PreencherEntidadeComCamposDoForm;
    procedure Gravar;
    constructor Create(pForm: TForm);
    procedure DestruirEntidade;
  public
    procedure GravarEntidade;

    class function New(pForm: TForm): iControllerCadastroPadrao;
  end;

implementation

uses
  Utils.Entidade, Utils.Form;

{ TControllerCadastroPadrao }

constructor TControllerCadastroPadrao.Create(pForm: TForm);
begin
  FForm := pForm;
  ObterObjeto;
end;

procedure TControllerCadastroPadrao.Gravar;
begin
  TUtilsEntidade.ExecutarMetodoObjeto(FEntidade,'Gravar',[]);
end;

procedure TControllerCadastroPadrao.DestruirEntidade;
begin
  FEntidade.Free;
end;

procedure TControllerCadastroPadrao.GravarEntidade;
begin
  if FEntidade = nil then
    Exit;

  PreencherEntidadeComCamposDoForm;
  Gravar;
  DestruirEntidade;
end;

class function TControllerCadastroPadrao.New(pForm: TForm): iControllerCadastroPadrao;
begin
  Result := Self.Create(pForm);
end;

procedure TControllerCadastroPadrao.ObterObjeto;
begin
  FEntidade := TUtilsForm.ObterObjetoDeCadastroDoForm(FForm);
end;

procedure TControllerCadastroPadrao.PreencherEntidadeComCamposDoForm;
begin
  TUtilsForm.PreencherEntidadeComCamposDoForm(FEntidade, FForm);
end;

end.

