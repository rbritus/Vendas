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
    function ObterDataSetComDadosParaGride: TDataSet;
    procedure ApresentarFormParaEdicao(ID: Integer);
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
  ControllerView.ShowFormModal(TComponentClass(ClasseForm));
end;

procedure TControllerCadastroListaPadrao.ApresentarFormParaEdicao(ID: Integer);
begin
  var ClasseForm := TUtilsForm.ObterClasseDoFormularioCadastro(FForm);
  var Form : TForm := nil;
  ControllerView.AdicionarFormNalista(TComponentClass(ClasseForm), Form);
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'CarregarEntidadeParaEdicao',[ID]);
  ControllerView.ShowFormModal(TComponentClass(ClasseForm));
end;

constructor TControllerCadastroListaPadrao.Create(pForm: TForm);
begin
  FForm := pForm;
end;

class function TControllerCadastroListaPadrao.New(pForm: TForm): iControllerCadastroListaPadrao;
begin
  Result := Self.Create(pForm);
end;

function TControllerCadastroListaPadrao.ObterDataSetComDadosParaGride: TDataSet;
begin
  var FClientDataSet: TDataSet;
  var Entidade := TUtilsForm.ObterObjetoDeCadastroDoForm(FForm);
  try
    FClientDataSet := TUtilsEntidade.ExecutarMetodoClasse(GetClass(Entidade.ClassName),'ListarTodosCDS',[]).AsType<TClientDataSet>;
  finally
    FreeAndNil(Entidade);
  end;
  Result := FClientDataSet;
end;

end.
