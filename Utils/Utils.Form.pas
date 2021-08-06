unit Utils.Form;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades, System.SysUtils,
  Vcl.Forms, Attributes.Forms;

type
  TUtilsForm = class
  public
    class function ObterObjetoDeCadastroDoForm(pForm: TForm): TPersistent;
    class procedure PreencherEntidadeComCamposDoForm(var pEntidade: TPersistent;pForm: TForm);
    class function ObterClasseDoFormularioCadastro(pForm: TForm): TFormClass;
  end;

implementation

uses
  Interfaces.Wrapper.PropriedadeCadastro, Wrapper.PropriedadeCadastro,
  Utils.Entidade;

{ TUtilsForm }

class procedure TUtilsForm.PreencherEntidadeComCamposDoForm(var pEntidade: TPersistent;
  pForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(pForm.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var FField in Tipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          var Valor := Wrapper.ObtemValor(FField.GetValue(pForm), TPropriedadeCadastro(Atrib), TPropriedadeCadastro(Atrib).TipoPropriedade);

          TUtilsEntidade.SetarValorParaPropriedade(pEntidade, TPropriedadeCadastro(Atrib).NomePropriedade, Valor);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

{ TUtilsForm }

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

class function TUtilsForm.ObterObjetoDeCadastroDoForm(pForm: TForm): TPersistent;
begin
  var Entidade: TPersistent := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(pForm.ClassType);
    if not Assigned(Tipo) then
      Exit(nil);

    for var Atrib in Tipo.GetAttributes do
    begin
      if Atrib is TClasseCadastro then
      begin
        Entidade := TPersistentClass(TClasseCadastro(Atrib).Classe).Create;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
  Result := Entidade;
end;

end.
