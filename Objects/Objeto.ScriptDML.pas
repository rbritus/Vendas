unit Objeto.ScriptDML;

interface

uses
  System.Generics.Collections, Attributes.Entidades, Utils.Constants;

type
  [TNomeTabela('SCRIPT_CONTROLE')]
  TScriptDML = class(TObject)
  private
    FGUIDControle: string;
    FScript: string;
    FVersao: string;
  public
    [TCampoTexto('GUID', TConstantsInteger.TAMANHO_GUID, [CHAVE_PRIMARIA, NOTNULL], 'GUID')]
    property GUIDControle: string read FGUIDControle write FGUIDControle;
    [TCampoTexto('VERSAO', 50, [NOTNULL], 'Versão')]
    property Versao: string read FVersao write FVersao;
    [TCampoTexto('ID_CONTROLE', 50, [NOTNULL], 'Id Controle')]
    property Script: string read FScript write FScript;
    constructor Create(pID, pVersao, pScript: string);

    function ObterSqlParaRegistrarExecucaoDoScriptNoBanco: string;
    function ObterSqlParaVerificarSeScriptFoiExecutado: string;
  end;

implementation

uses
  System.SysUtils, Utils.GUID;

{ TScriptDML }

constructor TScriptDML.Create(pID, pVersao, pScript: string);
begin
  FGUIDControle := pID;
  FScript := pScript;
  FVersao := pVersao;
end;

function TScriptDML.ObterSqlParaRegistrarExecucaoDoScriptNoBanco: string;
begin
  Result := 'INSERT INTO SCRIPT_CONTROLE (GUID,VERSAO,ID_CONTROLE) VALUES ( ' + TUtilsGUID.CreateClassGUID.QuotedString + ',' + FVersao.QuotedString + ',' + FGUIDControle.QuotedString + ')';
end;

function TScriptDML.ObterSqlParaVerificarSeScriptFoiExecutado: string;
begin
  Result := 'SELECT * FROM SCRIPT_CONTROLE WHERE VERSAO = ' + FVersao.QuotedString + ' AND ID_CONTROLE = ' + FGUIDControle.QuotedString;
end;

end.
