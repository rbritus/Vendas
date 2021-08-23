unit Scripts.Versao;

interface

uses
  System.Generics.Collections;

type
  TScriptDML = class(TObject)
  private
    FID: string;
    FScript: string;
    FVersao: string;
  public
    property ID: string read FID write FID;
    property Versao: string read FVersao write FVersao;
    property Script: string read FScript write FScript;
    constructor Create(pID, pVersao, pScript: string);
  end;

  TScriptVersao = class
  public
    class function ObterListaScripts: TObjectList<TScriptDML>;
  end;

implementation

{ TScriptDML }

constructor TScriptDML.Create(pID, pVersao, pScript: string);
begin
  FID := pID;
  FScript := pScript;
  FVersao := pVersao;
end;

{ TScriptVersao }

class function TScriptVersao.ObterListaScripts: TObjectList<TScriptDML>;
begin
  var Lista: TObjectList<TScriptDML>.Create;

end;

end.
