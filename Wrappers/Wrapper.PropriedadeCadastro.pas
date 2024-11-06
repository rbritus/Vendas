unit Wrapper.PropriedadeCadastro;

interface

uses
  Utils.Enumerators, Interfaces.Wrapper.PropriedadeCadastro, Attributes.Forms,
  System.Rtti, System.TypInfo, Vcl.StdCtrls, Vcl.WinXCtrls, System.StrUtils,
  System.Math, System.Classes, Componente.TObjectList, Vcl.Dialogs, Vcl.Forms,
  Utils.Entidade, Attributes.Enumerators, Vcl.Mask, Vcl.Controls;

type
  TWrapperPropriedadeCadastro = class(TInterfacedObject, iWrapperPropriedadeCadastro)
  protected
    FForm: TForm;
    procedure SetarValorParaComponenteForm(AValor: TValue; Propriedade: TPropriedadeCadastro; AField: TRttiField);
    procedure IndicarComponenteComoNaoPreenchido(AForm: TForm; AComponente: TComponent);
  public
    class function New(AForm: TForm): iWrapperPropriedadeCadastro;
    procedure PreencherEntidadeDeCadastroComDadosDoForm(var AEntidade: TObject);
    procedure PreencherFormComEntidade(AEntidade: TObject);
    procedure InicializarVariaveisDeEntidadesDoForm;
    procedure InicializarCamposEditaveisDoForm;
    procedure DestruirAlertasTImagemValidacao;
    function ValidarSeCamposObrigatoriosEstaoPreenchidos: Boolean;
    constructor Create(AForm: TForm);
  end;

  TTratarVariavel = class
      class function ObterValorDoComponenteDoForm(AForm: TForm; AField: TRttiField; ATipo: TTiposDeCampo): TValue;
      class function ObterValorDaEntidadeParaForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(AForm: TForm; AField: TRttiField; AValor: TValue);
      class procedure Inicializar(AField: TRttiField; AForm: TForm);
      class function CampoPreenchido(AForm: TForm; AField: TRttiField; CadastroVariavel: TCadastroVariavel): Boolean;
      class procedure DestruirVariaveis(AField: TRttiField; AForm: TForm);
  end;

  TTratarTEdit = class
  private
    class function ComponenteTipoTMaskEdit(AComponente: TComponent): Boolean;
    class function ObterValorSemMascara(AComponente: TComponent): string;
    class function ObterValorDoComponente(AComponente: TComponent): string;
  public
    class function ObterValorDoComponenteDoForm(AComponente: TComponent; ATipo: TTiposDeCampo): TValue;
    class function ObterValorDaEntidadeParaForm(AValor: TValue; ATipo: TTiposDeCampo): TValue;
    class procedure SetarValorParaComponenteForm(AComponente: TComponent; AValor: TValue);
    class procedure Inicializar(AComponente: TComponent);
    class function CampoPreenchido(AComponente: TComponent): Boolean;
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
      class function CampoPreenchido(AComponente: TComponent): Boolean;
  end;

  TTratarFrameClassPesquisa = class
      class procedure Inicializar(AComponente: TComponent);
  end;

implementation

uses
  System.SysUtils, View.Padrao, Utils.Constants, Controller.Componente.TImagemValidacao;

{ TWrapperPropriedadeCadastro }

constructor TWrapperPropriedadeCadastro.Create(AForm: TForm);
begin
  FForm := AForm;
end;

procedure TWrapperPropriedadeCadastro.DestruirAlertasTImagemValidacao;
begin
  var ControllerTImagemValidacao := TControllerTImagemValidacao.New(FForm);
  ControllerTImagemValidacao.DestruirTImagemValidacaoDoForm;
end;

procedure TWrapperPropriedadeCadastro.IndicarComponenteComoNaoPreenchido(AForm: TForm;
  AComponente: TComponent);
begin
  const Mensagem = 'Campo com preenchimento obrigatório.';
  var ControllerTImagemValidacao := TControllerTImagemValidacao.New(AForm);
  ControllerTImagemValidacao.CriarImagemDeValidacao(TWinControl(AComponente), Mensagem);
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
        if Atrib is TClassePesquisa then
        begin
          var AComponente := FForm.FindComponent(FField.Name);
          TTratarFrameClassPesquisa.Inicializar(AComponente);
          Continue;
        end;

        if Atrib is TPropriedadeCadastro then
        begin
          var AComponente := FForm.FindComponent(FField.Name);
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            TTratarVariavel.Inicializar(FField, FForm);

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

procedure TWrapperPropriedadeCadastro.InicializarVariaveisDeEntidadesDoForm;
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
            TTratarVariavel.DestruirVariaveis(FField, FForm);
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
          var AComponente := FForm.FindComponent(FField.Name);
          var AValor: TValue;
          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
            AValor := TTratarVariavel.ObterValorDoComponenteDoForm(FForm, FField, TPropriedadeCadastro(Atrib).TipoPropriedade);

          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
            AValor := TTratarTEdit.ObterValorDoComponenteDoForm(AComponente, TPropriedadeCadastro(Atrib).TipoPropriedade);

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

function TWrapperPropriedadeCadastro.ValidarSeCamposObrigatoriosEstaoPreenchidos: Boolean;
begin
  var CamposObrigatoriosPreenchidos := True;
  var Ctx := TRttiContext.Create;
  try
    var ATipo := Ctx.GetType(FForm.ClassType);
    if not Assigned(ATipo) then
      Exit(CamposObrigatoriosPreenchidos);

    for var FField in ATipo.GetFields do
    begin
      for var Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          if TPropriedadeCadastro(Atrib).CampoObrigatorio = coNaoObrigatorio then
            Continue;

          if TPropriedadeCadastro(Atrib) is TCadastroVariavel then
          begin
            if TTratarVariavel.CampoPreenchido(FForm, FField, TCadastroVariavel(Atrib)) then
              Continue;

            var AComponente := FForm.FindComponent(TCadastroVariavel(Atrib).NomeComponenteValicadao);
            IndicarComponenteComoNaoPreenchido(FForm, AComponente);
            CamposObrigatoriosPreenchidos := False;
          end;

          var AComponente := FForm.FindComponent(FField.Name);
          if TPropriedadeCadastro(Atrib) is TCadastroEdit then
          begin
            if TTratarTEdit.CampoPreenchido(AComponente) then
              Continue;

            IndicarComponenteComoNaoPreenchido(FForm, AComponente);
            CamposObrigatoriosPreenchidos := False;
          end;

          if TPropriedadeCadastro(Atrib) is TCadastroComboBox then
          begin
            if TTratarTComboBox.CampoPreenchido(AComponente) then
              Continue;

            IndicarComponenteComoNaoPreenchido(FForm, AComponente);
            CamposObrigatoriosPreenchidos := False;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
  Result := CamposObrigatoriosPreenchidos;
end;

{ TTratarEdit }

class function TTratarTEdit.CampoPreenchido(AComponente: TComponent): Boolean;
begin
  if TTratarTEdit.ComponenteTipoTMaskEdit(AComponente) then
    Result := TTratarTEdit.ObterValorSemMascara(AComponente).Trim <> string.Empty
  else
    Result := Trim(Tedit(AComponente).Text) <> string.Empty;
end;

class function TTratarTEdit.ComponenteTipoTMaskEdit(AComponente: TComponent): Boolean;
begin
  Result := AComponente.ClassType = TMaskEdit;
end;

class procedure TTratarTEdit.Inicializar(AComponente: TComponent);
begin
  Tedit(AComponente).Clear;
  if TTratarTEdit.ComponenteTipoTMaskEdit(AComponente) then
    TMaskEdit(AComponente).EditMask := string.Empty;
end;

class function TTratarTEdit.ObterValorDoComponente(
  AComponente: TComponent): string;
begin
  var Ctx := TRttiContext.Create;
  try
    var Prop := Ctx.GetType(AComponente.ClassType).GetProperty('Text');
    Result := Prop.GetValue(AComponente).AsString;
  finally
    Ctx.Free;
  end;
end;

class function TTratarTEdit.ObterValorDoComponenteDoForm(AComponente: TComponent;
  ATipo: TTiposDeCampo): TValue;
begin
  var Valor := TTratarTEdit.ObterValorDoComponente(AComponente);
  if ComponenteTipoTMaskEdit(AComponente) then
     Valor := ObterValorSemMascara(AComponente);

  case ATipo of
    ftINTEIRO, ftDECIMAL : Result := TValue.FromVariant(StrToIntDef(Valor,0));
    ftDATA : Result := TValue.FromVariant(StrToDateTime(Valor));
  else
    Result := TValue.FromVariant(Valor);
  end;
end;

class function TTratarTEdit.ObterValorSemMascara(AComponente: TComponent): string;
begin
  var Mascara := TMaskEdit(AComponente).EditMask;
  TMaskEdit(AComponente).EditMask := string.Empty;
  Result := TMaskEdit(AComponente).Text;
  TMaskEdit(AComponente).EditMask := Mascara;
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

class function TTratarVariavel.CampoPreenchido(AForm: TForm;
  AField: TRttiField; CadastroVariavel: TCadastroVariavel): Boolean;
begin
  Result := True;
  case AField.FieldType.TypeKind of
    tkClass:
      begin
        var Obj := AField.GetValue(AForm).AsObject;
        Result := Assigned(Obj);
        if CadastroVariavel.TipoPropriedade = ftLISTAGEM then
          Exit(TList(Obj).Count > TConstantsInteger.ZERO);

        if CadastroVariavel.TipoPropriedade = ftESTRANGEIRO then
        begin
          var EstaPreenchido := not TUtilsEntidade.ExecutarMetodoObjeto(Obj,'EstaVazia',[]).AsBoolean;
          Exit(EstaPreenchido);
        end;
      end;
    tkInteger:
      Result := AField.GetValue(AForm).AsInteger <> TConstantsInteger.ZERO;
    tkFloat:
      Result := AField.GetValue(AForm).AsExtended <> TConstantsInteger.ZERO;
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := AField.GetValue(AForm).AsString <> string.Empty;
    tkVariant:
      AField.SetValue(AForm, EmptyStr);
    tkEnumeration:
      begin
        var Value := TValue.FromOrdinal(AField.GetValue(AForm).TypeInfo, TConstantsInteger.ZERO);
        Result := Value.AsInteger > -1;
      end;
  end;
end;

class procedure TTratarVariavel.DestruirVariaveis(AField: TRttiField;
  AForm: TForm);
begin
  case AField.FieldType.TypeKind of
    tkClass:
      begin
        var Obj := AField.GetValue(AForm).AsObject;
        if Assigned(Obj) then
          Obj.Free;

        AField.SetValue(AForm,nil);
      end;
  end;
end;

class procedure TTratarVariavel.Inicializar(AField: TRttiField; AForm: TForm);
begin
  case AField.FieldType.TypeKind of
    tkClass:
        AField.SetValue(AForm, nil);
    tkInteger, tkFloat:
      AField.SetValue(AForm, TConstantsInteger.ZERO);
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      AField.SetValue(AForm, EmptyStr);
    tkVariant:
      AField.SetValue(AForm, EmptyStr);
    tkEnumeration:
      begin
        var Value := TValue.FromOrdinal(AField.GetValue(AForm).TypeInfo, TConstantsInteger.ZERO);
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
    ftLISTAGEM :
      begin
        Result := TObjectListFuck<TObject>(AField.GetValue(AForm).AsObject);
        Result := TValue.From(TUtilsEntidade.ObterCloneObjeto(Result.AsObject));
      end;
    ftLOGICO : Result := TValue.FromVariant(AField.GetValue(AForm).AsBoolean);
    ftESTRANGEIRO : Result := TValue.From(TUtilsEntidade.ObterCloneObjeto(AField.GetValue(AForm).AsObject));
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
    ftLISTAGEM :
      begin
        Result := TObjectListFuck<TObject>(AValor.AsObject);
        Result := TUtilsEntidade.ObterCloneObjeto(Result.AsObject);
      end;
    ftLOGICO : Result := AValor.AsBoolean;
    ftESTRANGEIRO : Result := TUtilsEntidade.ObterCloneObjeto(AValor.AsObject);
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

class function TTratarTComboBox.CampoPreenchido(
  AComponente: TComponent): Boolean;
begin
  Result := TComboBox(AComponente).ItemIndex > TConstantsInteger.MENOS_UM;
end;

class procedure TTratarTComboBox.Inicializar(AComponente: TComponent);
begin
  TComboBox(AComponente).ItemIndex := TConstantsInteger.MENOS_UM;
  TComboBox(AComponente).Text := String.Empty;
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

{ TTratarFrameClassPesquisa }

class procedure TTratarFrameClassPesquisa.Inicializar(AComponente: TComponent);
begin
  TUtilsEntidade.ExecutarMetodoObjeto(AComponente,'LimparEdit',[]);
end;

end.
