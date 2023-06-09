unit Controller.Cadastro.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Cadastro.Padrao, Vcl.ExtCtrls,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Mask;

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
    function isComponenteTEdit(AComponente: TComponent): Boolean;
    function isComponenteTMaskEdit(AComponente: TComponent): Boolean;
    function isComponenteTComboBox(AComponente: TComponent): Boolean;
    procedure LimpaFramesAdicao;
    function isComponenteTFrameAdicao(AComponente: TComponent): Boolean;
    procedure ModificarComboBox(edt: TComboBox);
  public
    procedure GravarEntidade;
    procedure CarregarEntidadeParaEdicao(AGUID: string);
    procedure CarregarLayoutDeCamposEditaveis;
    procedure LimparCamposEditaveis;
    procedure LimparEntidadesMapeadas;
    procedure DestruirEntidadesPosCadastro;
    procedure CarregarComboBoxComEnumerators;
    procedure CarregarMascarasNosCampos;
    function CamposObrigatoriosEstaoPreenchidos: Boolean;
    procedure CriarImagemDeValidacaoDeCampo(AComponente: TWinControl; Mensagem: string);

    class function New(AForm: TForm): iControllerCadastroPadrao;
  end;

implementation

uses
  Utils.Entidade, Utils.Form, Controller.View, Frame.Adicao.Padrao;

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

procedure TControllerCadastroPadrao.CarregarEntidadeParaEdicao(AGUID: string);
begin
  var Classe := TUtilsForm.ObterClasseDoObjetoDeCadastroDoForm(FForm);
  FEntidade := TUtilsEntidade.ExecutarMetodoClasse(Classe,'PesquisarPorGUID',[AGUID]).AsType<TObject>;
  PreencherFormComCamposDaEntidade;
  DestruirEntidade;
end;

procedure TControllerCadastroPadrao.ModificarLayoutEdit(edt: TEdit);
begin
  edt.BorderStyle := bsNOne;
end;

procedure TControllerCadastroPadrao.ModificarComboBox(edt: TComboBox);
begin
  edt.Style := csDropDownList;
end;

procedure TControllerCadastroPadrao.CarregarLayoutDeCamposEditaveis;
begin
  for var Indice := 0 to Pred(FForm.ComponentCount) do
  begin
    if isComponenteTEdit(FForm.Components[Indice]) or isComponenteTMaskEdit(FForm.Components[Indice])  then
    begin
      ModificarLayoutEdit(TEdit(FForm.Components[Indice]));
      ControllerView.CriarSublinhadoParaCamposEditaveis(FForm.Components[Indice] as TWinControl);
      Continue;
    end;

    if isComponenteTComboBox(FForm.Components[Indice]) then
    begin
      ModificarComboBox(TComboBox(FForm.Components[Indice]));
      Continue;
    end;
  end;
end;

procedure TControllerCadastroPadrao.CarregarMascarasNosCampos;
begin
  TUtilsForm.CarregarMascarasEmTMaskEdits(FForm);
end;

constructor TControllerCadastroPadrao.Create(AForm: TForm);
begin
  FForm := AForm;
end;

procedure TControllerCadastroPadrao.CriarImagemDeValidacaoDeCampo(
  AComponente: TWinControl; Mensagem: string);
begin
  TUtilsForm.CriarImagemDeValidacao(FForm,AComponente,Mensagem);
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

function TControllerCadastroPadrao.CamposObrigatoriosEstaoPreenchidos: Boolean;
begin
  Result := TUtilsForm.CamposObrigatoriosEstaoPreenchidos(FForm);
end;

procedure TControllerCadastroPadrao.InformarObservador;
begin
  TUtilsEntidade.ExecutarMetodoObjeto(FForm,'NotificarObservador',[FEntidade]);
end;

function TControllerCadastroPadrao.isComponenteTComboBox(
  AComponente: TComponent): Boolean;
begin
  Result := AComponente.ClassType = TComboBox;
end;

function TControllerCadastroPadrao.isComponenteTEdit(
  AComponente: TComponent): Boolean;
begin
  Result := AComponente.ClassType = TEdit;
end;

function TControllerCadastroPadrao.isComponenteTFrameAdicao(
  AComponente: TComponent): Boolean;
begin
  Result := AComponente is TFrameAdicaoPadrao;
end;

function TControllerCadastroPadrao.isComponenteTMaskEdit(
  AComponente: TComponent): Boolean;
begin
  Result := AComponente.ClassType = TMaskEdit;
end;

procedure TControllerCadastroPadrao.GravarEntidade;
begin
  ObterObjeto;
  PreencherEntidadeComCamposDoForm;
  Gravar;
  InformarObservador;
  DestruirEntidade;
end;

procedure TControllerCadastroPadrao.LimpaFramesAdicao;
begin
  for var Indice := 0 to Pred(FForm.ComponentCount) do
    if isComponenteTFrameAdicao(FForm.Components[Indice]) then
      TFrameAdicaoPadrao(FForm.Components[Indice]).LimparDataSet;
end;

procedure TControllerCadastroPadrao.LimparCamposEditaveis;
begin
  TUtilsForm.LimparCamposDoForm(FForm);
  LimpaFramesAdicao;
end;

procedure TControllerCadastroPadrao.LimparEntidadesMapeadas;
begin
  TUtilsForm.LimparEntidadesDoForm(FForm);
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

