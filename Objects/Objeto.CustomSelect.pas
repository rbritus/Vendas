unit Objeto.CustomSelect;

interface

type
  TCustomSelect = class
    class function getSelectCustom: string; virtual; abstract;
  end;

  TClasseCustom  = class of TCustomSelect;

  TCustomSelectAtivo = class(TCustomSelect)
    class function getSelectCustom: string; override;
  end;

implementation

{ TCustomSelectAtivo }

class function TCustomSelectAtivo.getSelectCustom: string;
begin
  Result := 'CASE ATIVO WHEN ''S'' THEN ''Ativo'' ELSE ''Inativo'' END AS Situação';
end;

end.
