unit Controller.Cadastro.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Cadastro.Padrao, Vcl.ExtCtrls,
  Vcl.Controls, Vcl.StdCtrls;

type
  TControllerCadastroPadrao = class(TInterfacedObject, iControllerCadastroPadrao)
  strict private
    FForm: TForm;
    FEntidade: TObject;
  private
    procedure ObterObjeto;
    procedure PreencherEntidadeComCamposDoForm;
    procedure Gravar;
    constructor Create(AForm: TForm);
    procedure DestruirEntidade;
    procedure PreencherFormComCamposDaEntidade;
    procedure ModificarLayoutEdit(edt: TEdit);
    procedure InformarObservador;
  public
    procedure GravarEntidade;
    procedure CarregarEntidadeParaEdicao(pId: Integer);
    procedure CarregarLayoutDeCamposEditaveis;
    procedure LimparCamposEditaveis;
    procedure DestruirEntidadesPosCadastro;
    procedure CarregarComboBoxComEnumerators;

    class function New(AForm: TForm): iControllerCadastroPadrao;
  end;

implementation

uses
  Utils.Entidade, Utils.Form, Controller.View;

{ TControllerCadastroPadrao }

procedure TControllerCadastroPadrao.PreencherFormComCamposDaEntidade;
begin
  TUtilsForm.PreencherFormComCamposDaEntidade(FEntidade, FForm);
end;

procedure TControllerCadastroPadrao.CarregarComboBoxComEnumerators;
begin
  ObterObjeto;
  TUtilsForm.CarregarComboBoxComEnumerators(FEntidade, FForm);
  DestruirEntidade;
end;

procedure TControllerCadastroPadrao.CarregarEntidadeParaEdicao(pId: Integer);
begin
  var Classe := TUtilsForm.ObterClasseDoObjetoDeCadastroDoForm(FForm);
  FEntidade := TUtilsEntidade.ExecutarMetodoClasse(Classe,'PesquisarPorId',[pId]).AsType<TObject>;
  PreencherFormComCamposDaEntidade;
  DestruirEntidade;
end;

procedure TControllerCadastroPadrao.ModificarLayoutEdit(edt: TEdit);
begin
  edt.BorderStyle := bsNOne;
end;

procedure TControllerCadastroPadrao.CarregarLayoutDeCamposEditaveis;
begin
  for var Indice := 0 to Pred(FForm.ComponentCount) do
    if FForm.Components[Indice].ClassType = TEdit then
    begin
      ModificarLayoutEdit(FForm.Components[Indice] as TEdit);
      ControllerView.CriarSublinhadoParaCamposEditaveis(FForm.Components[Indice] as TWinControl);
    end;
end;

constructor TControllerCadastroPadrao.Create(AForm: TForm);
begin
  FForm := AForm;
end;

procedure TControllerCadastroPadrao.Gravar;
begin
  TUtilsEntidade.ExecutarMetodoObjeto(FEntidade,'Gravar',[]);
end;

procedure TControllerCadastroPadrao.DestruirEntidade;
begin
  FEntidade.Free;
end;

procedure TControllerCadastroPadrao.DestruirEntidadesPosCadastro;
begin
  TUtilsForm.DestruirEntidadesEstrangeiras(FForm);
end;

procedure TControllerCadastroPadrao.InformarObservador;
begin
  TUtilsEntidade.ExecutarMetodoObjeto(FForm,'NotificarObservador',[FEntidade]);
end;

procedure TControllerCadastroPadrao.GravarEntidade;
begin
  ObterObjeto;
  PreencherEntidadeComCamposDoForm;
  Gravar;
  InformarObservador;
  DestruirEntidade;
end;

procedure TControllerCadastroPadrao.LimparCamposEditaveis;
begin
  TUtilsForm.LimparCamposDoForm(FForm);
end;

class function TControllerCadastroPadrao.New(AForm: TForm): iControllerCadastroPadrao;
begin
  Result := Self.Create(AForm);
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

