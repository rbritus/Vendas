unit Wrapper.PropriedadeCadastro;

interface

uses
  Utils.Enumerators, Interfaces.Wrapper.PropriedadeCadastro, Attributes.Forms,
  System.Rtti, System.TypInfo, Vcl.StdCtrls, Vcl.WinXCtrls, System.StrUtils,
  System.Math, System.Classes;

type
  TWrapperPropriedadeCadastro = class(TInterfacedObject, iWrapperPropriedadeCadastro)
  public
    class function New: iWrapperPropriedadeCadastro;
    function ObtemValorComponenteForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
    function ObtemValorEntidadeForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
    procedure SetarValorParaComponenteForm(Valor: TValue; Propriedade: TPropriedadeCadastro; Componente: TComponent);
  end;

  TTratarTEdit = class
      class function ObtemValorComponenteForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class function ObtemValorEntidadeForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(Componente: TComponent; Valor: TValue);
  end;

  TTratarTToggleSwitch = class
      class function ObtemValorComponenteForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class function ObtemValorEntidadeForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
      class procedure SetarValorParaComponenteForm(Componente: TComponent; Valor: TValue);
  end;

implementation

uses
  System.SysUtils;

{ TWrapperPropriedadeCadastro }

class function TWrapperPropriedadeCadastro.New: iWrapperPropriedadeCadastro;
begin
  Result := Self.Create;
end;

function TWrapperPropriedadeCadastro.ObtemValorComponenteForm(Valor: TValue; Propriedade:
  TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
begin
  if Propriedade is TCadastroEdit then
    Exit(TTratarTEdit.ObtemValorComponenteForm(Valor, Tipo));

  if Propriedade is TCadastroToggleSwitch then
    Exit(TTratarTToggleSwitch.ObtemValorComponenteForm(Valor, Tipo));

  Result := Valor;
end;

function TWrapperPropriedadeCadastro.ObtemValorEntidadeForm(Valor: TValue; Propriedade:
  TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
begin
  if Propriedade is TCadastroEdit then
    Exit(TTratarTEdit.ObtemValorEntidadeForm(Valor, Tipo));

  if Propriedade is TCadastroToggleSwitch then
    Exit(TTratarTToggleSwitch.ObtemValorEntidadeForm(Valor, Tipo));

  Result := Valor;
end;

procedure TWrapperPropriedadeCadastro.SetarValorParaComponenteForm(Valor: TValue;
  Propriedade: TPropriedadeCadastro; Componente: TComponent);
begin
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

class function TTratarTEdit.ObtemValorComponenteForm(Valor: TValue; Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := StrToIntDef(Valor.AsType<TEdit>.Text,0);
    ftDATA : Result := StrToDateTime(Valor.AsType<TEdit>.Text);
  else
    Result := Valor.AsType<TEdit>.Text;
  end;
end;

class function TTratarTEdit.ObtemValorEntidadeForm(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := IntToStr(Valor.AsInteger);
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

class function TTratarTToggleSwitch.ObtemValorComponenteForm(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := Ord(Valor.AsType<TToggleSwitch>.State);
  else
    Result := ifthen((Valor.AsType<TToggleSwitch>.State = tssOn),'S','N');
  end;
end;

class function TTratarTToggleSwitch.ObtemValorEntidadeForm(Valor: TValue;
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

end.
