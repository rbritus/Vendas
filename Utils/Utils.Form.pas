unit Utils.Form;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades, System.SysUtils,
  Vcl.Forms, Attributes.Forms;

type
  TUtilsForm = class
  public
    class function ObterObjetoDeCadastroDoForm(pForm: TForm): TObject;
    class function ObterClasseDoFormularioCadastro(pForm: TForm): TFormClass;
    class procedure PreencherEntidadeComCamposDoForm(var pEntidade: TObject;pForm: TForm);
    class procedure PreencherFormComCamposDaEntidade(var pEntidade: TObject;pForm: TForm);
    class function ObterClasseDoObjetoDeCadastroDoForm(pForm: TForm): TClass; static;
    class procedure LimparCamposDoForm(pForm: TForm);
  end;

implementation

uses
  Interfaces.Wrapper.PropriedadeCadastro, Wrapper.PropriedadeCadastro,
  Utils.Entidade;

{ TUtilsForm }

class procedure TUtilsForm.PreencherEntidadeComCamposDoForm(var pEntidade: TObject;
  pForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New(pForm);
  Wrapper.PreencherObjetoDoForm(pEntidade);
//  var Ctx := TRttiContext.Create;
//  try
//    var Tipo := Ctx.GetType(pForm.ClassType);
//    if not Assigned(Tipo) then
//      Exit;
//
//    for var FField in Tipo.GetFields do
//    begin
//      for var Atrib in FField.GetAttributes do
//      begin
//        if Atrib is TPropriedadeCadastro then
//        begin
//          var Valor := Wrapper.ObtemValorComponenteForm(FField.GetValue(pForm), TPropriedadeCadastro(Atrib), TPropriedadeCadastro(Atrib).TipoPropriedade);
//
//          TUtilsEntidade.SetarValorParaPropriedade(pEntidade, TPropriedadeCadastro(Atrib).NomePropriedade, Valor);
//        end;
//      end;
//    end;
//  finally
//    Ctx.Free;
//  end;
end;

class procedure TUtilsForm.PreencherFormComCamposDaEntidade(var pEntidade: TObject;
  pForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New(pForm);
  Wrapper.PreencherFormComEntidade(pEntidade);
//  var Ctx := TRttiContext.Create;
//  try
//    var Tipo := Ctx.GetType(pForm.ClassType);
//    if not Assigned(Tipo) then
//      Exit;
//
//    for var FField in Tipo.GetFields do
//    begin
//      for var Atrib in FField.GetAttributes do
//      begin
//        if Atrib is TPropriedadeCadastro then
//        begin
//          var ValorPropriedade: TValue := TValue.From(TUtilsEntidade.ObterValorPropriedade(pEntidade,TPropriedadeCadastro(Atrib).NomePropriedade));
//          var Valor := Wrapper.ObtemValorEntidadeForm(ValorPropriedade, TPropriedadeCadastro(Atrib), TPropriedadeCadastro(Atrib).TipoPropriedade);
//          var Componente := pForm.FindComponent(FField.Name);
//          if Assigned(Componente) then
//            Wrapper.SetarValorParaComponenteForm(Valor, TPropriedadeCadastro(Atrib), Componente);
//
//          if Assigned(Componente) then
//            Wrapper.SetarValorParaComponenteForm(Valor, TPropriedadeCadastro(Atrib), Componente);
//        end;
//      end;
//    end;
//  finally
//    Ctx.Free;
//  end;
end;

{ TUtilsForm }

class procedure TUtilsForm.LimparCamposDoForm(pForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New(pForm);
  Wrapper.InicializarCamposEditaveisDoForm;
end;

class function TUtilsForm.ObterClasseDoFormularioCadastro(pForm: TForm): TFormClass;
begin
  var ClasseForm: TFormClass := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(pForm.ClassType);
    if not Assigned(Tipo) then
      Exit(nil);

    for var Atrib in Tipo.GetAttributes do
    begin
      if Atrib is TFormularioCadastro then
      begin
        ClasseForm := TFormClass(TFormularioCadastro(Atrib).FormClasse);
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
  Result := ClasseForm;
end;

class function TUtilsForm.ObterObjetoDeCadastroDoForm(pForm: TForm): TObject;
begin
  var Entidade: TObject := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(pForm.ClassType);
    if not Assigned(Tipo) then
      Exit(nil);

    for var Atrib in Tipo.GetAttributes do
    begin
      if Atrib is TClasseCadastro then
      begin
        Entidade := TClass(TClasseCadastro(Atrib).Classe).Create;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
  Result := Entidade;
end;

class function TUtilsForm.ObterClasseDoObjetoDeCadastroDoForm(pForm: TForm): TClass;
begin
  var Classe: TClass := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(pForm.ClassType);
    if not Assigned(Tipo) then
      Exit(nil);

    for var Atrib in Tipo.GetAttributes do
    begin
      if Atrib is TClasseCadastro then
      begin
        Classe := TClasseCadastro(Atrib).Classe;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
  Result := Classe;
end;

end.
