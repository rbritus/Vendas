unit Objeto.ScriptDML;

interface

uses
  System.Generics.Collections, Attributes.Entidades;

type
  [TNomeTabela('SCRIPT_CONTROLE')]
  TScriptDML = class(TObject)
  private
    FIDControle: string;
    FScript: string;
    FVersao: string;
  public
    [TCampoInteiro('ID', [CHAVE_PRIMARIA, NOTNULL], 'ID')]
    property IDControle: string read FIDControle write FIDControle;
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
  System.SysUtils;

{ TScriptDML }

constructor TScriptDML.Create(pID, pVersao, pScript: string);
begin
  FIDControle := pID;
  FScript := pScript;
  FVersao := pVersao;
end;

function TScriptDML.ObterSqlParaRegistrarExecucaoDoScriptNoBanco: string;
begin
  Result := 'INSERT INTO SCRIPT_CONTROLE (VERSAO,ID_CONTROLE) VALUES ( ' + FVersao.QuotedString + ',' + FIDControle.QuotedString + ')';
end;

function TScriptDML.ObterSqlParaVerificarSeScriptFoiExecutado: string;
begin
  Result := 'SELECT * FROM SCRIPT_CONTROLE WHERE VERSAO = ' + FVersao.QuotedString + ' AND ID_CONTROLE = ' + FIDControle.QuotedString;
end;

end.
