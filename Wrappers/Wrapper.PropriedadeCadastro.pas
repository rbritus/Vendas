unit Wrapper.PropriedadeCadastro;

interface

uses
  Utils.Enumerators, Interfaces.Wrapper.PropriedadeCadastro, Attributes.Forms,
  System.Rtti, System.TypInfo, Vcl.StdCtrls, Vcl.WinXCtrls, System.StrUtils,
  System.Math, System.Classes, Componente.TObjectList, Vcl.Dialogs, Vcl.Forms,
  Utils.Entidade, Attributes.Enumerators;

type
  TWrapperPropriedadeCadastro = class(TInterfacedObject, iWrapperPropriedadeCadastro)
  protected
    FForm: TForm;
    procedure SetarValorParaComponenteForm(AValor: TValue; Propriedade: TPropriedadeCadastro; AField: TRttiField);
  public
    class function New(AForm: TForm): iWrapperPropriedadeCadastro;
    procedure PreencherEntidadeDeCadastroComDadosDoForm(var AEntidade: TObject);
    procedure PreencherFormComEntidade(AEntidade: TObject);
    procedure InicializarCamposEditaveisDoForm;
    constructor Create(AForm: TForm);
  end;

  TTratarVariavel = class
      class function ObterValorDoComponenteDoForm(AForm: TForm; AField: TRttiField; ATipo: TTiposDeCampo): TValue;
      class function ObterValorDaEntidadeParaForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(AForm: TForm; AField: TRttiField; AValor: TValue);
      class procedure Inicializar(AField: TRttiField; AForm: TForm);
  end;

  TTratarTEdit = class
      class function ObterValorDoComponenteDoForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
      class function ObterValorDaEntidadeParaForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(AComponente: TComponent; AValor: TValue);
      class procedure Inicializar(AComponente: TComponent);
  end;

  TTratarTToggleSwitch = class
      class function ObterValorDoComponenteDoForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
      class function ObterValorDaEntidadeParaForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(AComponente: TComponent; AValor: TValue);
      class procedure Inicializar(AComponente: TComponent);
  end;

  TTratarTComboBox = class
      class function ObterValorDoComponenteDoForm(const AEntidade: TObject;
        AForm: TForm; AField: TRttiField; APropriedadeCadastro: TPropriedadeCadastro): TValue;
      class function ObterValorDaEntidadeParaForm(const AEntidade: TObject;
        AValor: TValue; APropriedadeCadastro: TPropriedadeCadastro): TValue;
      class procedure SetarValorParaComponenteForm(AComponente: TComponent; AValor: TValue);
      class procedure Inicializar(AComponente: TComponent);
  end;

implementation

uses
  System.SysUtils;

{ TWrapperPropriedadeCadastro }

constructor TWrapperPropriedadeCadastro.Create(AForm: TForm);
begin
  FForm := AForm;
end;

procedure TWrapperPropriedadeCadastro.InicializarCamposEditaveisDoForm;
begin
  var Ctx := TRttiContext.Create;
  try
    var ATipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(ATipo) then
      Exit;

    for var FField in ATipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            TTratarVariavel.Inicializar(FField, FForm);

          var AComponente := FForm.FindComponent(FField.Name);
          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            TTratarTEdit.Inicializar(AComponente);

          if TPropriedadeCadastro(Atrib) is TCadastroToggleSwitch then
            TTratarTToggleSwitch.Inicializar(AComponente);

          if TPropriedadeCadastro(Atrib) is TCadastroComboBox then
            TTratarTComboBox.Inicializar(AComponente);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TWrapperPropriedadeCadastro.New(AForm: TForm): iWrapperPropriedadeCadastro;
begin
  Result := Self.Create(AForm);
end;

procedure TWrapperPropriedadeCadastro.PreencherEntidadeDeCadastroComDadosDoForm(var AEntidade: TObject);
begin
  var Ctx := TRttiContext.Create;
  try
    var ATipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(ATipo) then
      Exit;

    for var FField in ATipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          var AValor: TValue;
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            AValor := TTratarVariavel.ObterValorDoComponenteDoForm(FForm, FField, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            AValor := TTratarTEdit.ObterValorDoComponenteDoForm(FField.GetValue(FForm), TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroToggleSwitch then
            AValor := TTratarTToggleSwitch.ObterValorDoComponenteDoForm(FField.GetValue(FForm), TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroComboBox then
            AValor := TTratarTComboBox.ObterValorDoComponenteDoForm(AEntidade, FForm, FField, TPropriedadeCadastro(Atrib));

          TUtilsEntidade.SetarValorParaPropriedade(AEntidade, TPropriedadeCadastro(Atrib).NomePropriedade, AValor);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TWrapperPropriedadeCadastro.PreencherFormComEntidade(AEntidade: TObject);
begin
  var Ctx := TRttiContext.Create;
  try
    var ATipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(ATipo) then
      Exit;

    for var FField in ATipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          var ValorPropriedade := TUtilsEntidade.ObterValorPropriedade(AEntidade,TPropriedadeCadastro(Atrib).NomePropriedade);
          var AValor: TValue;
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            AValor := TTratarVariavel.ObterValorDaEntidadeParaForm(ValorPropriedade, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            AValor := TTratarTEdit.ObterValorDaEntidadeParaForm(ValorPropriedade, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroToggleSwitch then
            AValor := TTratarTToggleSwitch.ObterValorDaEntidadeParaForm(ValorPropriedade, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroComboBox then
            AValor := TTratarTComboBox.ObterValorDaEntidadeParaForm(AEntidade, ValorPropriedade, TPropriedadeCadastro(Atrib));

          SetarValorParaComponenteForm(AValor, TPropriedadeCadastro(Atrib), FField);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TWrapperPropriedadeCadastro.SetarValorParaComponenteForm(AValor: TValue;
  Propriedade: TPropriedadeCadastro; AField: TRttiField);
begin
  if Propriedade is TCadastroVariavel then
  begin
    TTratarVariavel.SetarValorParaComponenteForm(FForm, AField, AValor);
    Exit;
  end;

  var AComponente := FForm.FindComponent(AField.Name);
  if Propriedade is TCadastroEdit then
  begin
    TTratarTEdit.SetarValorParaComponenteForm(AComponente, AValor);
    Exit;
  end;

  if Propriedade is TCadastroToggleSwitch then
  begin
    TTratarTToggleSwitch.SetarValorParaComponenteForm(AComponente, AValor);
    Exit;
  end;

  if Propriedade is TCadastroComboBox then
  begin
    TTratarTComboBox.SetarValorParaComponenteForm(AComponente, AValor);
    Exit;
  end;
end;

{ TTratarEdit }

class procedure TTratarTEdit.Inicializar(AComponente: TComponent);
begin
  Tedit(AComponente).Clear;
end;

class function TTratarTEdit.ObterValorDoComponenteDoForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
begin
  case ATipo of
    ftINTEIRO, ftDECIMAL : Result := TValue.FromVariant(StrToIntDef(AValor.AsType<TEdit>.Text,0));
    ftDATA : Result := TValue.FromVariant(StrToDateTime(AValor.AsType<TEdit>.Text));
  else
    Result := TValue.FromVariant(AValor.AsType<TEdit>.Text);
  end;
end;

class function TTratarTEdit.ObterValorDaEntidadeParaForm(AValor: TValue;
  ATipo: TTiposDeCampo): TValue;
begin
  case ATipo of
    ftINTEIRO : Result := IntToStr(AValor.AsInteger);
    ftDECIMAL : Result := FloatToStr(AValor.AsCurrency);
    ftDATA : Result := DateTimeToStr(AValor.AsType<TDateTime>);
  else
    Result := AValor.AsString;
  end;
end;

class procedure TTratarTEdit.SetarValorParaComponenteForm(AComponente: TComponent;
  AValor: TValue);
begin
  var Ctx := TRttiContext.Create;
  try
    var Prop := Ctx.GetType(AComponente.ClassType).GetProperty('Text');
    Prop.SetValue(AComponente, AValor.AsString);
  finally
    Ctx.Free;
  end;
end;

{ TTratarTToggleSwitch }

class procedure TTratarTToggleSwitch.Inicializar(AComponente: TComponent);
begin
  TToggleSwitch(AComponente).State := tssOn;
end;

class function TTratarTToggleSwitch.ObterValorDoComponenteDoForm(AValor: TValue;
  ATipo: TTiposDeCampo): TValue;
begin
  case ATipo of
    ftINTEIRO, ftDECIMAL : Result := TValue.FromVariant(Ord(AValor.AsType<TToggleSwitch>.State));
  else
    Result := TValue.FromVariant(ifthen((AValor.AsType<TToggleSwitch>.State = tssOn),'S','N'));
  end;
end;

class function TTratarTToggleSwitch.ObterValorDaEntidadeParaForm(AValor: TValue;
  ATipo: TTiposDeCampo): TValue;
begin
  case ATipo of
    ftTEXTO : Result := IfThen(AValor.AsString = 'N',0,1);
    ftLOGICO : Result := IfThen(AValor.AsBoolean,1,0);
  else
    Result := AValor.AsInteger;
  end;
end;

class procedure TTratarTToggleSwitch.SetarValorParaComponenteForm(AComponente: TComponent;
  AValor: TValue);
begin
  var Ctx := TRttiContext.Create;
  try
    var Prop := Ctx.GetType(AComponente.ClassType).GetProperty('State');
    Prop.SetValue(AComponente, TValue.From(TToggleSwitchState(AValor.AsInteger)));
  finally
    Ctx.Free;
  end;
end;

{ TTratarVariavel }

class procedure TTratarVariavel.Inicializar(AField: TRttiField; AForm: TForm);
begin
  case AField.FieldType.TypeKind of
//    tkClass:
//      begin
//        var Obj := Field.GetValue(pForm).AsObject;
//        if Assigned(Obj) then
//          Obj.Free;
//      end;
    tkInteger, tkFloat:
      AField.SetValue(AForm, 0);
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      AField.SetValue(AForm, EmptyStr);
    tkVariant:
      AField.SetValue(AForm, EmptyStr);
    tkEnumeration:
      begin
        var Value := TValue.FromOrdinal(AField.GetValue(AForm).TypeInfo, 0);
        AField.SetValue(AForm, Value);
      end;
  end;
end;

class function TTratarVariavel.ObterValorDoComponenteDoForm(AForm: TForm; AField: TRttiField;
  ATipo: TTiposDeCampo): TValue;
begin
  case ATipo of
    ftINTEIRO : Result := TValue.FromVariant(AField.GetValue(AForm).AsInteger);
    ftDECIMAL, ftDATA : Result := TValue.FromVariant(AField.GetValue(AForm).AsCurrency);
    ftLISTAGEM : Result := TValue.From(TObjectListFuck<TObject>(AField.GetValue(AForm).AsObject));
    ftLOGICO : Result := TValue.FromVariant(AField.GetValue(AForm).AsBoolean);
    ftESTRANGEIRO : Result := TValue.From(AField.GetValue(AForm).AsObject);
  else
    Result := TValue.FromVariant(AField.GetValue(AForm).AsString);
  end;
end;

class function TTratarVariavel.ObterValorDaEntidadeParaForm(AValor: TValue;
  ATipo: TTiposDeCampo): TValue;
begin
  case ATipo of
    ftINTEIRO : Result := AValor.AsInteger;
    ftDECIMAL, ftDATA : Result := AValor.AsCurrency;
    ftLISTAGEM : Result := TObjectListFuck<TObject>(AValor.AsObject);
    ftLOGICO : Result := AValor.AsBoolean;
    ftESTRANGEIRO : Result := AValor.AsObject;
  else
    Result := AValor.AsString;
  end;
end;

class procedure TTratarVariavel.SetarValorParaComponenteForm(AForm: TForm;
  AField: TRttiField; AValor: TValue);
begin
  AField.SetValue(AForm, AValor);
end;

{ TTratarTComboBox }

class procedure TTratarTComboBox.Inicializar(AComponente: TComponent);
begin
  TComboBox(AComponente).Items.Clear;
end;

class function TTratarTComboBox.ObterValorDoComponenteDoForm(const AEntidade: TObject;
  AForm: TForm; AField: TRttiField; APropriedadeCadastro: TPropriedadeCadastro): TValue;
var
  CustomAttribute: TCustomAttribute;
begin
  var isEnumerator := False;
  var ctx := TRttiContext.Create;
  try
    var lType := ctx.GetType(AEntidade.ClassType);
    var prop := lType.GetProperty(APropriedadeCadastro.NomePropriedade);
    if prop.PropertyType.TypeKind = tkEnumeration then
    begin
      for CustomAttribute in Prop.PropertyType.GetAttributes do
      begin
        var AComponente := AForm.FindComponent(AField.Name);
        if CustomAttribute is TEnumAttribute then
          if TEnumAttribute(CustomAttribute).Indice = TComboBox(AComponente).ItemIndex then
          begin
            isEnumerator := True;
            Result := TValue.FromVariant(TEnumAttribute(CustomAttribute).Value);
            Break;
          end;
      end;
    end;
  finally
    ctx.Free;
  end;

  if isEnumerator then
    Exit;

  var AComponente := AForm.FindComponent(AField.Name);
  Result := TValue.FromVariant(TComboBox(AComponente).ItemIndex);
end;

class function TTratarTComboBox.ObterValorDaEntidadeParaForm(const AEntidade: TObject;
  AValor: TValue; APropriedadeCadastro: TPropriedadeCadastro): TValue;
var
  CustomAttribute: TCustomAttribute;
begin
  var isEnumerator := False;
  var ctx := TRttiContext.Create;
  try
    var lType := ctx.GetType(AEntidade.ClassType);
    var prop := lType.GetProperty(APropriedadeCadastro.NomePropriedade);
    if prop.PropertyType.TypeKind = tkEnumeration then
    begin
      var Enum := Prop.GetValue(AEntidade);
      for CustomAttribute in Prop.PropertyType.GetAttributes do
      begin
        if CustomAttribute is TEnumAttribute then
          if TEnumAttribute(CustomAttribute).Value = Enum.AsVariant then
          begin
            isEnumerator := True;
            Result := TValue.FromVariant(TEnumAttribute(CustomAttribute).Indice);
            Break;
          end;
      end;
    end;
  finally
    ctx.Free;
  end;

  if isEnumerator then
    Exit;

  Result := AValor.AsInteger;
end;

class procedure TTratarTComboBox.SetarValorParaComponenteForm(
  AComponente: TComponent; AValor: TValue);
begin
  var Ctx := TRttiContext.Create;
  try
    var Prop := Ctx.GetType(AComponente.ClassType).GetProperty('ItemIndex');
    Prop.SetValue(AComponente, AValor.AsInteger);
  finally
    Ctx.Free;
  end;
end;

end.
