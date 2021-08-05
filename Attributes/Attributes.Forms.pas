unit Attributes.Forms;

interface

Uses
   System.SysUtils, System.Classes, Utils.Enumerators;

type
  TClasseCadastro = class(TCustomAttribute)
  private
    FClasse: TPersistentClass;
  public
    property Classe: TPersistentClass read FClasse write FClasse;
    constructor Create(const ClassValue: TPersistentClass);
  end;

  TPropriedadeCadastro = class(TCustomAttribute)
  private
    FNomePropriedade: string;
    FTipoPropriedade: TTiposDeCampo;
    FCampoObrigatorio: TCampoObrigatorio;
  public
    property TipoPropriedade: TTiposDeCampo read FTipoPropriedade write FTipoPropriedade;
    property NomePropriedade: string read FNomePropriedade write FNomePropriedade;
    property CampoObrigatorio: TCampoObrigatorio read FCampoObrigatorio write FCampoObrigatorio;
  end;

  TCadastroEdit = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
  end;

  TCadastroToggleSwitch = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
  end;

implementation

{ TNomeTabela }

constructor TClasseCadastro.Create(const ClassValue: TPersistentClass);
begin
  FClasse := ClassValue;
end;

{ TPropCadastroTEdit }

constructor TCadastroEdit.Create(pNomePropriedade: string;
  pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
  FCampoObrigatorio := pCampoObrigatorio;
end;

{ TCadastroToggleSwitch }

constructor TCadastroToggleSwitch.Create(pNomePropriedade: string;
  pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
  FCampoObrigatorio := pCampoObrigatorio;
end;

end.
