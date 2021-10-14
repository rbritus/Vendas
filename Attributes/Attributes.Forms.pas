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

  TClassePesquisa = class(TCustomAttribute)
  private
    FClasse: TPersistentClass;
  public
    property Classe: TPersistentClass read FClasse write FClasse;
    constructor Create(const ClassValue: TPersistentClass);
  end;

  TCampoExibicao = class(TCustomAttribute)
  private
    FCampo: string;
  public
    property Campo: string read FCampo write FCampo;
    constructor Create(const Campo: string);
  end;

  TFormularioCadastro = class(TCustomAttribute)
  private
    FFormClasse: TComponentClass;
  public
    property FormClasse: TComponentClass read FFormClasse write FFormClasse;
    constructor Create(const ClassValue: TComponentClass);
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

  TCadastroVariavel = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
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

{ TFormularioCadastro }

constructor TFormularioCadastro.Create(const ClassValue: TComponentClass);
begin
  FFormClasse := ClassValue;
end;

{ TCadastroVariavel }

constructor TCadastroVariavel.Create(pNomePropriedade: string;
  pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
  FCampoObrigatorio := pCampoObrigatorio;
end;

{ TCampoExibicao }

constructor TCampoExibicao.Create(const Campo: string);
begin
  FCampo := Campo;
end;

{ TClassePesquisa }

constructor TClassePesquisa.Create(const ClassValue: TPersistentClass);
begin
  FClasse := ClassValue;
end;

end.
