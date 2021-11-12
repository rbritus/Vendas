unit Objeto.CustomSelect;

interface

uses
  Utils.Enumerators;

type
  TCustomSelect = class
    class function getSelectCustom(FieldName: string): string; virtual; abstract;
    class function getFieldNameCustom(FieldName: string): string;
  end;

  TClasseCustom  = class of TCustomSelect;

  TCustomSelectAtivo = class(TCustomSelect)
    class function getSelectCustom(FieldName: string): string; override;
  end;

  TCustomSelectTipoEndereco = class(TCustomSelect)
    class function getSelectCustom(FieldName: string): string; override;
  end;

  TCustomSelectTipoTelefone = class(TCustomSelect)
    class function getSelectCustom(FieldName: string): string; override;
  end;

implementation

{ TCustomSelectAtivo }

class function TCustomSelectAtivo.getSelectCustom(FieldName: string): string;
begin
  Result := TEnumerator<TRegistroAtivo>.GetCustomSelect(FieldName);
end;

{ TCustomSelectTipoEndereco }

class function TCustomSelectTipoEndereco.getSelectCustom(FieldName: string): string;
begin
  Result := TEnumerator<TTipoEndereco>.GetCustomSelect(FieldName);
end;

{ TCustomSelect }

class function TCustomSelect.getFieldNameCustom(FieldName: string): string;
begin
  Result := TEnumerator<TEnumGenerics>.GetNameCustoField(FieldName);
end;

{ TCustomSelectTipoTelefone }

class function TCustomSelectTipoTelefone.getSelectCustom(
  FieldName: string): string;
begin
  Result := TEnumerator<TTipoTelefone>.GetCustomSelect(FieldName);
end;

end.
