unit Utils.Frame;

interface

uses
  Vcl.Forms, Rtti, Attributes.Forms;

type
  TUtilsFrame = class
  public
    class function ObterObjetoDeCadastroDoFrame(AFrame: TFrame): TObject;
    class function ObterClasseDoObjetoDeCadastroDoFrame(AFrame: TFrame): TClass; static;
    class function ObterClasseDoFormularioCadastro(AFrame: TFrame): TFormClass;
  end;

implementation

{ TUtilsForm }

class function TUtilsFrame.ObterClasseDoFormularioCadastro(
  AFrame: TFrame): TFormClass;
begin
  var ClasseForm: TFormClass := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AFrame.ClassType);
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

class function TUtilsFrame.ObterClasseDoObjetoDeCadastroDoFrame(
  AFrame: TFrame): TClass;
begin
  var Classe: TClass := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AFrame.ClassType);
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

class function TUtilsFrame.ObterObjetoDeCadastroDoFrame(AFrame: TFrame): TObject;
begin
  var Entidade: TObject := nil;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(AFrame.ClassType);
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


end.
