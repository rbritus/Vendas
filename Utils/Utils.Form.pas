unit Utils.Form;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades, System.SysUtils,
  Vcl.Forms, Attributes.Forms, Attributes.Enumerators, Vcl.StdCtrls;

type
  TUtilsForm = class
  public
    class function ObterObjetoDeCadastroDoForm(AForm: TForm): TObject;
    class function ObterClasseDoObjetoDeCadastroDoForm(AForm: TForm): TClass; static;
    class function ObterClasseDoFormularioCadastro(AForm: TForm): TFormClass;
    class procedure PreencherEntidadeComCamposDoForm(var AEntidade: TObject;AForm: TForm);
    class procedure PreencherFormComCamposDaEntidade(var AEntidade: TObject;AForm: TForm);
    class procedure LimparCamposDoForm(AForm: TForm);
    class procedure DestruirEntidadesEstrangeiras(AForm: TForm);
    class procedure CarregarComboBoxComEnumerators(var AEntidade: TObject;AForm: TForm);
  end;

implementation

uses
  Interfaces.Wrapper.PropriedadeCadastro, Wrapper.PropriedadeCadastro,
  Utils.Entidade, Utils.Enumerators;

{ TUtilsForm }

class procedure TUtilsForm.PreencherEntidadeComCamposDoForm(var AEntidade: TObject;
  AForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New(AForm);
  Wrapper.PreencherEntidadeDeCadastroComDadosDoForm(AEntidade);
end;

class procedure TUtilsForm.PreencherFormComCamposDaEntidade(var AEntidade: TObject;
  AForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New(AForm);
  Wrapper.PreencherFormComEntidade(AEntidade);
end;

class procedure TUtilsForm.CarregarComboBoxComEnumerators(
  var AEntidade: TObject; AForm: TForm);
var
  CustomAttribute: TCustomAttribute;
begin
  var CtxForm := TRttiContext.Create;
  try
    var Tipo := CtxForm.GetType(AForm.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var FieldForm in Tipo.GetDeclaredFields do
    begin
      for var AtribForm in FieldForm.GetAttributes do
      begin
        if AtribForm is TCadastroComboBox then
        begin
          if TCadastroComboBox(AtribForm).TipoPropriedade = ftENUMERATOR then
          begin
              var ctx := TRttiContext.Create;
              try
                var lType := ctx.GetType(AEntidade.ClassType);
                var prop := lType.GetProperty(TCadastroComboBox(AtribForm).NomePropriedade);
                if prop.PropertyType.TypeKind = tkEnumeration then
                begin
                  var AComponente := AForm.FindComponent(FieldForm.Name);
                  TComboBox(AComponente).Items.Clear;
                  for CustomAttribute in Prop.PropertyType.GetAttributes do
                  begin
                    if CustomAttribute is TEnumAttribute then
                      TComboBox(AComponente).Items.Add(TEnumAttribute(CustomAttribute).Caption);
                  end;
                end;
              finally
                ctx.Free;
              end;
          end;
        end;
      end;
    end;
  finally
    CtxForm.Free;
  end;
end;

class procedure TUtilsForm.DestruirEntidadesEstrangeiras(AForm: TForm);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AForm.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var Field in Tipo.GetDeclaredFields do
    begin
      for var Atrib in Field.GetAttributes do
      begin
        if Atrib is TCadastroVariavel then
        begin
          if TAtributoBanco(Atrib).tipo = ftESTRANGEIRO then
          begin
            var Obj := Field.GetValue(AForm).AsObject;
            if Assigned(Obj) then
              Obj.Free;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class procedure TUtilsForm.LimparCamposDoForm(AForm: TForm);
begin
  var Wrapper := TWrapperPropriedadeCadastro.New(AForm);
  Wrapper.InicializarCamposEditaveisDoForm;
end;

class function TUtilsForm.ObterClasseDoFormularioCadastro(AForm: TForm): TFormClass;
begin
  var ClasseForm: TFormClass := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AForm.ClassType);
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

class function TUtilsForm.ObterObjetoDeCadastroDoForm(AForm: TForm): TObject;
begin
  var Entidade: TObject := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AForm.ClassType);
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

class function TUtilsForm.ObterClasseDoObjetoDeCadastroDoForm(AForm: TForm): TClass;
begin
  var Classe: TClass := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AForm.ClassType);
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
