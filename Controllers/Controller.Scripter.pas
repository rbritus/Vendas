unit Controller.Scripter;

interface

type
  TControllerScript = class
  private
    class procedure ExecutarScriptsVersao00;
    class procedure ExecutarScriptDeCriacaoDeTabelas;
    class procedure ExecutarScriptsDML;
    class procedure ExecutarScripts;
    class procedure ExecutarAcoesNoBancoDeDados;
  public
    class procedure RegistrarEntidadesNoBanco;
  end;


implementation

uses
  Connection.Scripter.SqLite, Entidade.Endereco, Entidade.Pessoa, Entidade.Pais,
  Entidade.Estado, Entidade.Cidade, System.Threading, System.SysUtils,
  System.Classes, Scripts.Versao00, Objeto.ScriptDML, Utils.Menssages;


{ TScriptSQL }

class procedure TControllerScript.ExecutarScriptsVersao00;
begin
  var ListaScript := TScriptVersao00.ObterListaScripts;
  try
    for var Objeto in ListaScript do
      TScriptSQL.ExecutarScriptNoBanco(Objeto);
  finally
    FreeAndNil(ListaScript);
  end;
end;

class procedure TControllerScript.ExecutarScriptsDML;
begin
  ExecutarScriptsVersao00;
end;

class procedure TControllerScript.ExecutarScriptDeCriacaoDeTabelas;
begin
  TScriptSQL.RegistrarEntidadeNoBanco(TScriptDML);
  TScriptSQL.RegistrarEntidadeNoBanco(TPais);
  TScriptSQL.RegistrarEntidadeNoBanco(TEstado);
  TScriptSQL.RegistrarEntidadeNoBanco(TCidade);
  TScriptSQL.RegistrarEntidadeNoBanco(TEndereco);
  TScriptSQL.RegistrarEntidadeNoBanco(TPessoa);
end;

class procedure TControllerScript.ExecutarScripts;
begin
  TControllerScript.ExecutarScriptDeCriacaoDeTabelas;
  TControllerScript.ExecutarScriptsDML;
end;

class procedure TControllerScript.ExecutarAcoesNoBancoDeDados;
begin
  TUtilsMenssages.ShowWaitMessage('Atualizando o banco de dados...', ExecutarScripts);
end;

class procedure TControllerScript.RegistrarEntidadesNoBanco;
begin
  var Task: ITask := TTask.Create(
    TControllerScript.ExecutarAcoesNoBancoDeDados
  );
  Task.Start;
end;

end.
