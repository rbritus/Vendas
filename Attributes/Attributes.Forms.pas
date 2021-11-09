unit Attributes.Forms;

interface

Uses
   System.SysUtils, System.Classes, Utils.Enumerators, Vcl.Controls;

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
    constructor Create(const ACampo: string);
  end;

  TFormularioCadastro = class(TCustomAttribute)
  private
    FFormClasse: TComponentClass;
  public
    property FormClasse: TComponentClass read FFormClasse write FFormClasse;
    constructor Create(const ClassValue: TComponentClass);
  end;

  TMascaraCampo = class(TCustomAttribute)
  private
    FMascara: string;
  public
    property Mascara: string read FMascara write FMascara;
    constructor Create(const AMascara: string);
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
  private
    FNomeComponenteValidacao: string;
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio;
      ANomeComponenteValidacao: string = string.Empty);

    property NomeComponenteValicadao: string read FNomeComponenteValidacao write FNomeComponenteValidacao;
  end;

  TCadastroEdit = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
  end;

  TCadastroToggleSwitch = class(TPropriedadeCadastro)
  public
    constructor Create(pNomePropriedade: string; pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
  end;

  TCadastroComboBox = class(TPropriedadeCadastro)
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
  pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio; ANomeComponenteValidacao: string);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
  FCampoObrigatorio := pCampoObrigatorio;
  FNomeComponenteValidacao := ANomeComponenteValidacao;
end;

{ TCampoExibicao }

constructor TCampoExibicao.Create(const ACampo: string);
begin
  FCampo := ACampo;
end;

{ TClassePesquisa }

constructor TClassePesquisa.Create(const ClassValue: TPersistentClass);
begin
  FClasse := ClassValue;
end;

{ TCadastroComboBox }

constructor TCadastroComboBox.Create(pNomePropriedade: string;
  pTipoPropriedade: TTiposDeCampo; pCampoObrigatorio: TCampoObrigatorio);
begin
  FNomePropriedade := pNomePropriedade;
  FTipoPropriedade := pTipoPropriedade;
  FCampoObrigatorio := pCampoObrigatorio;
end;

{ TMascaraCampo }

constructor TMascaraCampo.Create(const AMascara: string);
begin
  FMascara := AMascara;
end;

end.
