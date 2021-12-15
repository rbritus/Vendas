unit Controller.Cadastro.Lista.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Cadastro.Lista.Padrao, Data.DB,
  Datasnap.DBClient, System.SysUtils;

type
  TControllerCadastroListaPadrao = class(TInterfacedObject, iControllerCadastroListaPadrao)
  strict private
    FForm: TForm;
  private
    constructor Create(pForm: TForm);
  public
    function ObterClasseDaEntidadeDeCadastro: TClass;
    function ObterDataSetComDadosParaGride: TDataSet;
    procedure ApresentarFormParaEdicao(AGUID: string);
    procedure ApresentarFormParaCadastro;

    class function New(pForm: TForm): iControllerCadastroListaPadrao;
  end;

implementation

uses
  Controller.View, Utils.Form, Utils.Entidade;

{ TControllerCadastroListaPadrao }

procedure TControllerCadastroListaPadrao.ApresentarFormParaCadastro;
begin
  var ClasseForm := TUtilsForm.ObterClasseDoFormularioCadastro(FForm);
  var Form : TForm := nil;
  ControllerView.AdicionarFormNalista(TComponentClass(ClasseForm), Form);
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'CarregarFormParaCadastro',[]);
  ControllerView.ShowForm(TComponentClass(ClasseForm));
end;

procedure TControllerCadastroListaPadrao.ApresentarFormParaEdicao(AGUID: string);
begin
  var ClasseForm := TUtilsForm.ObterClasseDoFormularioCadastro(FForm);
  var Form : TForm := nil;
  ControllerView.AdicionarFormNalista(TComponentClass(ClasseForm), Form);
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'CarregarEntidadeParaEdicao',[AGUID]);
  ControllerView.ShowForm(TComponentClass(ClasseForm));
end;

constructor TControllerCadastroListaPadrao.Create(pForm: TForm);
begin
  FForm := pForm;
end;

class function TControllerCadastroListaPadrao.New(pForm: TForm): iControllerCadastroListaPadrao;
begin
  Result := Self.Create(pForm);
end;

function TControllerCadastroListaPadrao.ObterClasseDaEntidadeDeCadastro: TClass;
begin
  Result := TUtilsForm.ObterClasseDoObjetoDeCadastroDoForm(FForm);
end;

function TControllerCadastroListaPadrao.ObterDataSetComDadosParaGride: TDataSet;
begin
  var FClientDataSet: TDataSet;
  var Entidade := TUtilsForm.ObterObjetoDeCadastroDoForm(FForm);
  try
    FClientDataSet := TDataSet(TUtilsEntidade.ExecutarMetodoClasse(GetClass(Entidade.ClassName),'ListarTodosCDS',[]).AsObject);
  finally
    FreeAndNil(Entidade);
  end;
  Result := FClientDataSet;
end;

end.
