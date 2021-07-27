unit Attributes.Forms;

interface

Uses
   System.SysUtils, System.Classes;

type
  TTiposDeCampo = (ftINTEIRO, ftTEXTO, ftDECIMAL, ftDATA, ftESTRANGEIRO,
     ftLISTAGEM, ftLOGICO, ftBLOBT);

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
  public
    property TipoPropriedade: TTiposDeCampo read FTipoPropriedade write FTipoPropriedade;
    property NomePropriedade: string read FNomePropriedade write FNomePropriedade;
  end;

  TCadastroEdit = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo);
  end;

  TCadastroToggleSwitch = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo);
  end;

implementation

{ TNomeTabela }

constructor TClasseCadastro.Create(const ClassValue: TPersistentClass);
begin
  FClasse := ClassValue;
end;

{ TPropCadastroTEdit }

constructor TCadastroEdit.Create(pNomePropriedade: string;
  pTipoPropriedade: TTiposDeCampo);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
end;

{ TCadastroToggleSwitch }

constructor TCadastroToggleSwitch.Create(pNomePropriedade: string;
  pTipoPropriedade: TTiposDeCampo);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
end;

end.
