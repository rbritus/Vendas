unit Controller.Cadastro.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Cadastro.Padrao;

type
  TControllerCadastroPadrao = class(TInterfacedObject, iControllerCadastroPadrao)
  strict private
    FForm: TForm;
    FEntidade: TPersistent;
  private
    procedure ObterObjeto;
    procedure PreencherEntidadeComCamposDoForm;
    procedure Gravar;
    constructor Create(pForm: TForm);
    procedure DestruirEntidade;
    procedure PreencherFormComCamposDaEntidade;
  public
    procedure GravarEntidade;
    procedure CarregarEntidadeParaEdicao(pId: Integer);

    class function New(pForm: TForm): iControllerCadastroPadrao;
  end;

implementation

uses
  Utils.Entidade, Utils.Form;

{ TControllerCadastroPadrao }

procedure TControllerCadastroPadrao.PreencherFormComCamposDaEntidade;
begin
  TUtilsForm.PreencherFormComCamposDaEntidade(FEntidade, FForm);
end;

procedure TControllerCadastroPadrao.CarregarEntidadeParaEdicao(pId: Integer);
begin
  var Classe := TUtilsForm.ObterClasseDoObjetoDeCadastroDoForm(FForm);
  FEntidade := TUtilsEntidade.ExecutarMetodoClasse(Classe,'PesquisarPorId',[pId]).AsType<TPersistent>;
  PreencherFormComCamposDaEntidade;
  DestruirEntidade;
end;

constructor TControllerCadastroPadrao.Create(pForm: TForm);
begin
  FForm := pForm;
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
  ObterObjeto;
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

