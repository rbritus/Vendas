unit Wrapper.PropriedadeCadastro;

interface

uses
  Utils.Enumerators, Interfaces.Wrapper.PropriedadeCadastro, Attributes.Forms,
  System.Rtti, System.TypInfo, Vcl.StdCtrls, Vcl.WinXCtrls, System.StrUtils;

type
  TWrapperPropriedadeCadastro = class(TInterfacedObject, iWrapperPropriedadeCadastro)
  public
    class function New: iWrapperPropriedadeCadastro;
    function ObtemValor(Valor: TValue; Propriedade: TPropriedadeCadastro;
      Tipo: TTiposDeCampo): TValue;
  end;

  TTratarTEdit = class
      class function ObtemValor(Valor: TValue; Tipo: TTiposDeCampo): TValue;
  end;

  TTratarTToggleSwitch = class
      class function ObtemValor(Valor: TValue; Tipo: TTiposDeCampo): TValue;
  end;

implementation

uses
  System.SysUtils;

{ TWrapperPropriedadeCadastro }

class function TWrapperPropriedadeCadastro.New: iWrapperPropriedadeCadastro;
begin
  Result := Self.Create;
end;

function TWrapperPropriedadeCadastro.ObtemValor(Valor: TValue; Propriedade:
  TPropriedadeCadastro; Tipo: TTiposDeCampo): TValue;
begin
  if Propriedade is TCadastroEdit then
    Exit(TTratarTEdit.ObtemValor(Valor, Tipo));

  if Propriedade is TCadastroToggleSwitch then
    Exit(TTratarTToggleSwitch.ObtemValor(Valor, Tipo));

  Result := Valor;
end;

{ TTratarEdit }

class function TTratarTEdit.ObtemValor(Valor: TValue; Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := StrToIntDef(Valor.AsType<TEdit>.Text,0);
    ftDATA : Result := StrToDateTime(Valor.AsType<TEdit>.Text);
  else
    Result := Valor.AsType<TEdit>.Text;
  end;
end;

{ TTratarTToggleSwitch }

class function TTratarTToggleSwitch.ObtemValor(Valor: TValue;
  Tipo: TTiposDeCampo): TValue;
begin
  case Tipo of
    ftINTEIRO, ftDECIMAL : Result := Ord(Valor.AsType<TToggleSwitch>.State);
  else
    Result := ifthen((Valor.AsType<TToggleSwitch>.State = tssOn),'S','N');
  end;
end;

end.
