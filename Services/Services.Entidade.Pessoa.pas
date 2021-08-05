unit Services.Entidade.Pessoa;

interface

uses
   System.Classes, Interfaces.Services.ListaCadastro, Data.DB;

type
  TServicoPessoa = class(TInterfacedObject, iServicesListaCadastro)
  private
    function GetSqlListaCadastro: string;
  public
    function GetDataSetListaCadastro: TDataSet;

    class function New: iServicesListaCadastro;
  end;

implementation

uses
  Connection.Controller.SqLite;

{ TServicoPessoa }

function TServicoPessoa.GetDataSetListaCadastro: TDataSet;
begin
  var Sql := GetSqlListaCadastro;
  Result := TConexao.GetInstance.EnviaConsulta(Sql);
end;

function TServicoPessoa.GetSqlListaCadastro: string;
begin
  Result := 'SELECT	' + SlineBreak +
    '	ID AS Id, ' + SlineBreak +
    '	NOME as Nome, ' + SlineBreak +
    '	CASE ATIVO  ' + SlineBreak +
    '		WHEN ''S'' THEN ''Ativo'' ' + SlineBreak +
    '	ELSE ' + SlineBreak +
    '		''Inativo'' ' + SlineBreak +
    '	END AS Situação'  + SlineBreak +
    'FROM ' + SlineBreak +
    '	PESSOA ';
end;

class function TServicoPessoa.New: iServicesListaCadastro;
begin
  Result := Self.Create;
end;

end.
