unit Objeto.CustomSelect;

interface

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

implementation

{ TCustomSelectAtivo }

class function TCustomSelectAtivo.getSelectCustom(FieldName: string): string;
begin
  Result := 'CASE ' + FieldName + ' WHEN ''S'' THEN ''Ativo'' ELSE ''Inativo'' END ' +
  getFieldNameCustom(FieldName);
end;

{ TCustomSelectTipoEndereco }

class function TCustomSelectTipoEndereco.getSelectCustom(FieldName: string): string;
begin
  Result := 'CASE  ' + FieldName +
  '  WHEN 0 THEN ''PRINCIPAL'' '+
  'WHEN 1 THEN ''RESIDENCIAL'' WHEN 2 THEN ''COMERCIAL'' '+
  'WHEN 3 THEN ''ENTREGA'' ELSE ''NÃO INFORMADO'' END ' +
  getFieldNameCustom(FieldName);
end;
{ TCustomSelect }

class function TCustomSelect.getFieldNameCustom(FieldName: string): string;
begin
  Result := FieldName + '_CUSTOM';
end;

end.
