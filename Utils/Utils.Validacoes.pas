unit Utils.Validacoes;

interface

uses
  Classes, System.SysUtils;

type
  TUtilsValidacoes = class
  public
    class function SomenteNumeros(Key: Char): Boolean;
    class function SomenteLetras(Key: Char): Boolean;
    class function CPFValido(ACPF: string): Boolean;
    class function CEPValido(ACEP: string): Boolean;
    class function TelefoneValido(ANumero: string): Boolean;
  end;

implementation

uses
  Utils.Constants;

{ TUtilsEdit }

class function TUtilsValidacoes.SomenteNumeros(Key: Char): Boolean;
begin
  Result := CharInSet(key,['0'..'9']);
end;

class function TUtilsValidacoes.SomenteLetras(Key: Char): Boolean;
begin
  Result := CharInSet(key,['a'..'z','A'..'Z',Chr(8)]);
end;

class function TUtilsValidacoes.CPFValido(ACPF: string): Boolean;
var
  Indice: integer;
  Want: char;
  Wvalid: boolean;
  Wdigit1, Wdigit2: integer;
begin
  if ACPF.Trim.IsEmpty then
    Exit(False);

  Wvalid := False;
  Wdigit1 := 0;
  Wdigit2 := 0;
  Want := ACPF[1];
  Delete(ACPF, ansipos('.', ACPF), 1);
  Delete(ACPF, ansipos('.', ACPF), 1);
  Delete(ACPF, ansipos('-', ACPF), 1);
  ACPF := StringReplace(ACPF,' ',string.Empty,[rfReplaceAll]);

  for Indice := 1 to length(ACPF) do
  begin
    if ACPF[Indice] <> Want then
    begin
      Wvalid := true;
      break
    end;
  end;

  if not Wvalid then
    Exit(False);

  if Length(ACPF) < 11 then
    Exit(False);

  for Indice := 1 to 9 do
  begin
    Wdigit1 := Wdigit1 + (strtoint(ACPF[10 - Indice]) * (Indice + 1));
  end;
  Wdigit1 := ((11 - (Wdigit1 mod 11)) mod 11) mod 10;

  if IntToStr(Wdigit1) <> ACPF[10] then
  begin
    Result := false;
    exit;
  end;

  for Indice := 1 to 10 do
  begin
    Wdigit2 := Wdigit2 + (strtoint(ACPF[11 - Indice]) * (Indice + 1));
  end;
  Wdigit2 := ((11 - (Wdigit2 mod 11)) mod 11) mod 10;

  if IntToStr(Wdigit2) <> ACPF[11] then
  begin
    Result := false;
    exit;
  end;

  Result := True;
end;

class function TUtilsValidacoes.TelefoneValido(ANumero: string): Boolean;
begin
  Result := (Length(ANumero) = TConstantsInteger.TAMANHO_NUMERO_TELEFONE) OR
    (Length(ANumero) = TConstantsInteger.TAMANHO_NUMERO_CELULAR)
end;

class function TUtilsValidacoes.CEPValido(ACEP: string): Boolean;
var
  Indice: integer;
begin
  var CEP := string.Empty;
  for Indice := 1 to Length(ACEP) do
    if CharInSet(ACEP[Indice],['0'..'9']) then
      CEP := CEP + ACEP[Indice];
  Result := Length(CEP) = 8;
end;

end.
