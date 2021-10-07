unit Wrapper.PropriedadeCadastro;

interface

uses
  Utils.Enumerators, Interfaces.Wrapper.PropriedadeCadastro, Attributes.Forms,
  System.Rtti, System.TypInfo, Vcl.StdCtrls, Vcl.WinXCtrls, System.StrUtils,
  System.Math, System.Classes, Componente.TObjectList, Vcl.Dialogs, Vcl.Forms,
  Utils.Entidade;

type
  TWrapperPropriedadeCadastro = class(TInterfacedObject, iWrapperPropriedadeCadastro)
  protected
    FForm: TForm;
    procedure SetarValorParaComponenteForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Field: TRttiField);
  public
    class function New(pForm: TForm): iWrapperPropriedadeCadastro;
    procedure PreencherObjetoDoForm(var pEntidade: TPersistent);
    procedure PreencherFormComEntidade(pEntidade: TPersistent);
    procedure InicializarCamposEditaveisDoForm;
    constructor Create(pForm: TForm);
  end;

  TTratarVariavel = class
      class function ObterValorComponenteForm(pForm: TForm; Field: TRttiField; Tipo: TTiposDeCampo): TValue;
      class function ObterValorEntidadeForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(pForm: TForm; Field: TRttiField; Valor: TValue);
      class procedure Inicializar(Field: TRttiField; pForm: TForm);
  end;

  TTratarTEdit = class
      class function ObterValorComponenteForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class function ObterValorEntidadeForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(Componente: TComponent; Valor: TValue);
      class procedure Inicializar(Componente: TComponent);
  end;

  TTratarTToggleSwitch = class
      class function ObterValorComponenteForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class function ObterValorEntidadeForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(Componente: TComponent; Valor: TValue);
      class procedure Inicializar(Componente: TComponent);
  end;

implementation

uses
  System.SysUtils;

{ TWrapperPropriedadeCadastro }

constructor TWrapperPropriedadeCadastro.Create(pForm: TForm);
begin
  FForm := pForm;
end;

procedure TWrapperPropriedadeCadastro.InicializarCamposEditaveisDoForm;
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var FField in Tipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            TTratarVariavel.Inicializar(FField, FForm);

          var Componente := FForm.FindComponent(FField.Name);
          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            TTratarTEdit.Inicializar(Componente);

          if TPropriedadeCadastro(Atrib) is TCadastroToggleSwitch then
            TTratarTToggleSwitch.Inicializar(Componente);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TWrapperPropriedadeCadastro.New(pForm: TForm): iWrapperPropriedadeCadastro;
begin
  Result := Self.Create(pForm);
end;

procedure TWrapperPropriedadeCadastro.PreencherObjetoDoForm(var pEntidade: TPersistent);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var FField in Tipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          var Valor: TValue;
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            Valor := TTratarVariavel.ObterValorComponenteForm(FForm, FField, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            Valor := TTratarTEdit.ObterValorComponenteForm(FField.GetValue(FForm), TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroToggleSwitch then
            Valor := TTratarTToggleSwitch.ObterValorComponenteForm(FField.GetValue(FForm), TPropriedadeCadastro(Atrib).TipoPropriedade);

          TUtilsEntidade.SetarValorParaPropriedade(pEntidade, TPropriedadeCadastro(Atrib).NomePropriedade, Valor);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TWrapperPropriedadeCadastro.PreencherFormComEntidade(pEntidade: TPersistent);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var FField in Tipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          var ValorPropriedade := TUtilsEntidade.ObterValorPropriedade(pEntidade,TPropriedadeCadastro(Atrib).NomePropriedade);
          var Valor: TValue;
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            Valor := TTratarVariavel.ObterValorEntidadeForm(ValorPropriedade, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            Valor := TTratarTEdit.ObterValorEntidadeForm(ValorPropriedade, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroToggleSwitch then
            Valor := TTratarTToggleSwitch.ObterValorEntidadeForm(ValorPropriedade, TPropriedadeCadastro(Atrib).TipoPropriedade);

          SetarValorParaComponenteForm(Valor, TPropriedadeCadastro(Atrib), FField);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TWrapperPropriedadeCadastro.SetarValorParaComponenteForm(Valor: TValue;
  Propriedade: TPropriedadeCadastro; Field: TRttiField);
begin
  if Propriedade is TCadastroVariavel then
  begin
    TTratarVariavel.SetarValorParaComponenteForm(FForm, Field, Valor);
    Exit;
  end;

  var Componente := FForm.FindComponent(Field.Name);
  if Propriedade is TCadastroEdit then
  begin
    TTratarTEdit.SetarValorParaComponenteForm(Componente, Valor);
    Exit;
  end;

  if Propriedade is TCadastroToggleSwitch then
  begin
    TTratarTToggleSwitch.SetarValorParaComponenteForm(Componente, Valor);
    Exit;
  end;
end;

{ TTratarEdit }

class procedure TTratarTEdit.Inicializar(Componente: TComponent);
begin
  Tedit(Componente).Clear;
end;

class function TTratarTEdit.ObterValorComponenteForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := TValue.FromVariant(StrToIntDef(Valor.AsType<TEdit>.Text,0));
    ftDATA : Result := TValue.FromVariant(StrToDateTime(Valor.AsType<TEdit>.Text));
  else
    Result := TValue.FromVariant(Valor.AsType<TEdit>.Text);
  end;
end;

class function TTratarTEdit.ObterValorEntidadeForm(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO : Result := IntToStr(Valor.AsInteger);
    ftDECIMAL : Result := FloatToStr(Valor.AsCurrency);
    ftDATA : Result := DateTimeToStr(Valor.AsType<TDateTime>);
  else
    Result := Valor.AsString;
  end;
end;

class procedure TTratarTEdit.SetarValorParaComponenteForm(Componente: TComponent;
  Valor: TValue);
begin
  var Ctx := TRttiContext.Create;
  try
    var Prop := Ctx.GetType(Componente.ClassType).GetProperty('Text');
    Prop.SetValue(Componente, Valor.AsString);
  finally
    Ctx.Free;
  end;
end;

{ TTratarTToggleSwitch }

class procedure TTratarTToggleSwitch.Inicializar(Componente: TComponent);
begin
  TToggleSwitch(Componente).State := tssOn;
end;

class function TTratarTToggleSwitch.ObterValorComponenteForm(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := TValue.FromVariant(Ord(Valor.AsType<TToggleSwitch>.State));
  else
    Result := TValue.FromVariant(ifthen((Valor.AsType<TToggleSwitch>.State = tssOn),'S','N'));
  end;
end;

class function TTratarTToggleSwitch.ObterValorEntidadeForm(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftTEXTO : Result := IfThen(Valor.AsString = 'N',0,1);
    ftLOGICO : Result := IfThen(Valor.AsBoolean,1,0);
  else
    Result := Valor.AsInteger;
  end;
end;

class procedure TTratarTToggleSwitch.SetarValorParaComponenteForm(Componente: TComponent;
  Valor: TValue);
begin
  var Ctx := TRttiContext.Create;
  try
    var Prop := Ctx.GetType(Componente.ClassType).GetProperty('State');
    Prop.SetValue(Componente, TValue.From(TToggleSwitchState(Valor.AsInteger)));
  finally
    Ctx.Free;
  end;
end;

{ TTratarVariavel }

class procedure TTratarVariavel.Inicializar(Field: TRttiField; pForm: TForm);
begin
  case Field.FieldType.TypeKind of
//    tkClass:
//      begin
//        var Obj := Field.GetValue(pForm).AsObject;
//        if Assigned(Obj) then
//          Obj.Free;
//      end;
    tkInteger, tkFloat:
      Field.SetValue(pForm, 0);
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Field.SetValue(pForm, EmptyStr);
    tkVariant:
      Field.SetValue(pForm, EmptyStr);
    tkEnumeration:
      begin
        var Value := TValue.FromOrdinal(Field.GetValue(pForm).TypeInfo, 0);
        Field.SetValue(pForm, Value);
      end;
  end;
end;

class function TTratarVariavel.ObterValorComponenteForm(pForm: TForm; Field: TRttiField;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO : Result := TValue.FromVariant(Field.GetValue(pForm).AsInteger);
    ftDECIMAL, ftDATA : Result := TValue.FromVariant(Field.GetValue(pForm).AsCurrency);
    ftLISTAGEM : Result := TValue.From(TObjectListFuck<TPersistent>(Field.GetValue(pForm).AsObject));
    ftLOGICO : Result := TValue.FromVariant(Field.GetValue(pForm).AsBoolean);
  else
    Result := TValue.FromVariant(Field.GetValue(pForm).AsString);
  end;
end;

class function TTratarVariavel.ObterValorEntidadeForm(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO : Result := Valor.AsInteger;
    ftDECIMAL, ftDATA : Result := Valor.AsCurrency;
    ftLISTAGEM : Result := TObjectListFuck<TPersistent>(Valor.AsObject);
    ftLOGICO : Result := Valor.AsBoolean;
  else
    Result := Valor.AsString;
  end;
end;

class procedure TTratarVariavel.SetarValorParaComponenteForm(pForm: TForm;
  Field: TRttiField; Valor: TValue);
begin
  Field.SetValue(pForm, Valor);
end;

end.
