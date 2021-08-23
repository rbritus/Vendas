Unit Connection.Scripter.SqLite;

Interface

Uses
   Rtti, SysUtils, Connection.Controller.SqLite, Data.DB, Attributes.Entidades,
   Objeto.ScriptDML;

type
  TScriptSQL = class
  private
    FClasse: TClass;
    FNomeTabela: string;
    function ObterScriptDaEntidade: string;
    function TabelaExisteNoBanco: Boolean;
    function ObterNomeTabela: String;
    function ObterScriptParaAdicionarNovosCamposNaTabela: string;
    function ObterScriptParaAdicionarTabelaCompleta: string;
    procedure CriarTabelaRelacional(Campo: TCampoListagem);
//    function ObterScriptParaCriarSequence: string;
//    function ObterScriptParaAtualizarSequencia: string;
  public
    class function RegistrarEntidadeNoBanco(pClasse: TClass): boolean;
    class function ExecutarScriptNoBanco(Script: TScriptDML): boolean;
  end;

Implementation

procedure TScriptSQL.CriarTabelaRelacional(Campo: TCampoListagem);
begin
  var cScript := Campo.getScriptCampo;
  TConexao.GetInstance.EnviarComando(cScript);
end;

function TScriptSQL.ObterScriptParaAdicionarNovosCamposNaTabela: string;
var
  DataSet: TDataSet;
const
  txtPadrao = 'alter table %s add %s';

  function ExisteCampo(Campo: string): Boolean;
  var
    lResposta: Boolean;
  begin
    DataSet.Filter := 'name = ' + QuotedStr(Campo);
    DataSet.Filtered := True;
    try
      lResposta := DataSet.RecordCount > 0;
    finally
      DataSet.Filter := EmptyStr;
      DataSet.Filtered := False;
    end;

    Result := lResposta;
  end;

  function RetirarNotNull(sql: string): string;
  begin
    Result := StringReplace(sql, 'not null', EmptyStr, []);
  end;

begin
  var cScriptTabela := EmptyStr;
  var cSQL := 'PRAGMA Table_Info(' + QuotedStr(FNomeTabela) + ')';
  DataSet := TConexao.GetInstance.EnviaConsulta(cSQL);
  var ctx := TRttiContext.Create;
  try
    for var prop in ctx.GetType(FClasse).GetDeclaredProperties do
      for var atrib in prop.GetAttributes do
        if atrib is TAtributoBanco then
          if TAtributoBanco(atrib) is TCampoListagem then
          begin
            if TCampoListagem(atrib).TipoAssociacao = taManyToMany then
            begin
              if not TConexao.GetInstance.TabelaExiste(TCampoListagem(atrib).TabelaRelacional) then
                CriarTabelaRelacional(TCampoListagem(atrib));
            end;
          end
          else
          begin
            if not ExisteCampo(TAtributoBanco(atrib).nome) then
            begin
              cScriptTabela := cScriptTabela + Format(txtPadrao, [FNomeTabela, RetirarNotNull(TAtributoBanco(atrib).getScriptCampo)]);

              if atrib is TCampoEstrangeiro then
                cScriptTabela := cScriptTabela + ' REFERENCES ' + TAtributoBanco(atrib).caption + '(ID);' + sLineBreak;

              cScriptTabela := cScriptTabela + ';' + sLineBreak;
            end;
          end;
    DataSet.Close;
  finally
    ctx.Free;
    FreeAndNil(DataSet);
  end;
  Result := cScriptTabela;
end;

class function TScriptSQL.ExecutarScriptNoBanco(Script: TScriptDML): boolean;
begin
  Result := False;
  var DataSet := TConexao.GetInstance.EnviaConsulta(Script.ObterSqlParaVerificarSeScriptFoiExecutado);
  try
    if not DataSet.IsEmpty then
      Exit(True);

    try
      TConexao.GetInstance.EnviarComando(Script.Script);
      TConexao.GetInstance.EnviarComando(Script.ObterSqlParaRegistrarExecucaoDoScriptNoBanco);
      TConexao.GetInstance.Commit;
      Result := True;
    except
      TConexao.GetInstance.Rollback;
    end;
  finally
    FreeAndNil(DataSet);
  end;
end;

Function TScriptSQL.ObterNomeTabela: String;
Begin
  Result :=  EmptyStr;
  var ctx := TRttiContext.Create;
  For var atrib In ctx.GetType(FClasse).GetAttributes Do
  Begin
     If atrib Is TNomeTabela Then
     Begin
        Result := TNomeTabela(atrib).nome;
        Break;
     End;
  End;
End;

function TScriptSQL.TabelaExisteNoBanco: Boolean;
begin
  FNomeTabela := ObterNomeTabela;
  Result := TConexao.GetInstance.TabelaExiste(FNomeTabela);
end;

function TScriptSQL.ObterScriptParaAdicionarTabelaCompleta: string;
begin
  var cAuxiliar := EmptyStr;
  var cScriptTabela := 'Create Table ' + FNomeTabela + '(' + sLineBreak;
  var cFK := EmptyStr;
  var ctx := TRttiContext.Create;
  for var prop in ctx.GetType(FClasse).GetDeclaredProperties do
    for var atrib in prop.GetAttributes do
    begin
      if atrib is TAtributoBanco then
      begin
        if TAtributoBanco(atrib) is TCampoListagem then
        begin
          if TCampoListagem(atrib).TipoAssociacao = taManyToMany then
          begin
            if not TConexao.GetInstance.TabelaExiste(TCampoListagem(atrib).TabelaRelacional) then
              CriarTabelaRelacional(TCampoListagem(atrib));
          end;
          Continue;
        end;

        cAuxiliar := TAtributoBanco(atrib).getScriptCampo;

        if CHAVE_PRIMARIA in TAtributoBanco(atrib).propriedades then
          cAuxiliar := cAuxiliar + ' primary key AUTOINCREMENT';

        if atrib is TCampoEstrangeiro then
          cFK := cFK + ', FOREIGN KEY(' + TAtributoBanco(atrib).nome + ') REFERENCES ' + TAtributoBanco(atrib).caption + '(ID)';

        if Trim(cAuxiliar) <> '' then
          cScriptTabela := cScriptTabela + cAuxiliar + ',';
      end;
    end;

  Result := Copy(cScriptTabela, 1, Length(cScriptTabela) - 1) + cFK + ');' + sLineBreak + sLineBreak;
end;

//function TScriptSQL.ObterScriptParaCriarSequence: string;
//begin
//  Result := 'CREATE SEQUENCE gen_id_' + FNomeTabela + ' ;' + #13;
//end;
//
//function TScriptSQL.ObterScriptParaAtualizarSequencia: string;
//begin
//  var Script := EmptyStr;
//  var DataSetA := TQuery(TConexao.GetInstance.EnviaConsulta('select last_value from gen_id_' + FNomeTabela));
//  var DataSetB := TQuery(TConexao.GetInstance.EnviaConsulta('select Max(id) as "ID" from ' + FNomeTabela));
//  try
//     var SequenciaAtual := DataSetA.FieldByName('last_value').AsInteger;
//     var SequencialTabela := DataSetB.FieldByName('ID').AsInteger;
//
//     if SequencialTabela > SequenciaAtual then
//      Script := 'alter sequence gen_id_' + FNomeTabela + ' restart with ' +
//        IntToStr(SequencialTabela + 1) + ' ;' + #13;
//  finally
//     FreeAndNil(DataSetA);
//     FreeAndNil(DataSetB);
//  end;
//  Result := Script;
//end;

Function TScriptSQL.ObterScriptDaEntidade: String;
Begin
  var Script := EMptyStr;
  if TabelaExisteNoBanco then
    Script := ObterScriptParaAdicionarNovosCamposNaTabela// + ObterScriptParaAtualizarSequencia
  else
    Script := ObterScriptParaAdicionarTabelaCompleta{ + ObterScriptParaCriarSequence};

  Result := Script;
End;

class Function TScriptSQL.RegistrarEntidadeNoBanco(pClasse: TClass): boolean;
Begin
  Result := False;
  var ScriptCreate := TScriptSQL.Create;
  ScriptCreate.FClasse := pClasse;
  try
    var cScript := ScriptCreate.ObterScriptDaEntidade;
    if Trim(cScript) = EmptyStr then
      Exit;
    try
      TConexao.GetInstance.EnviarComando(cScript);
      Result := True;
    except
      TConexao.GetInstance.RollbackRetaining;
    end;
  finally
    ScriptCreate.Free;
  end;
End;

End.
