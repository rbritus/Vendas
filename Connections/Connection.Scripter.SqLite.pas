Unit Connection.Scripter.SqLite;

Interface

Uses
   Rtti, SysUtils, Connection.Controller.SqLite, Data.DB;

type
  TScriptSQL = class
  private
      class Function ObterScriptDaEntidade(classe: TClass): String;
  public
      class Function RegistrarEntidadeNoBanco(classe: TClass): boolean;
  end;

Implementation

Uses
  Attributes.Entidades;

Class Function TScriptSQL.ObterScriptDaEntidade(classe: TClass): String;
Var
   cScriptTabela          : String;
   cScriptSequence        : String;
   cScriptAtualizaSequence: String;
   cNomeTabela            : String;
   lTabelaExiste          : Boolean;

   ctx  : TRttiContext;

   Function _getNomeTabela: String;
   Var
      atrib: TCustomAttribute;
   Begin
      Result := '';
      For atrib In ctx.GetType(classe).GetAttributes Do
      Begin
         If atrib Is TNomeTabela Then
         Begin
            Result := TNomeTabela(atrib).nome;
            Break;
         End;
      End;
   End;

   Procedure _ObterTabelaCompleta;
   Var
      atrib: TCustomAttribute;
      prop : TRttiProperty;
      cAux, cFK : String;
   Begin
      cScriptTabela := 'Create Table ' + cNomeTabela + '(' + sLineBreak;

      cFK := EmptyStr;
      For prop In ctx.GetType(classe).GetDeclaredProperties Do
         For atrib In prop.GetAttributes Do
         Begin
            If atrib Is TAtributoBanco Then
            Begin
               cAux := TAtributoBanco(atrib).getScriptCampo;

               If CHAVE_PRIMARIA In TAtributoBanco(atrib).propriedades Then
                  cAux := cAux + ' primary key AUTOINCREMENT';

               If atrib is TCampoEstrangeiro Then
                  cFK := cFK + ', FOREIGN KEY(' + TAtributoBanco(atrib).nome +
                     ') REFERENCES ' + TAtributoBanco(atrib).caption + '(ID)';

               if Trim(cAux) <> '' then
                  cScriptTabela := cScriptTabela + cAux + ',';
            End;
         End;

      cScriptTabela := Copy(cScriptTabela, 1, Length(cScriptTabela) - 1) + cFK + ');' + sLineBreak + sLineBreak;
   End;

   Procedure _ObterSomenteCampos;
   Var
      atrib: TCustomAttribute;
      prop : TRttiProperty;
      MyDataSet: TDataSet;
      cSQL : String;
   Const
      txtPadrao = 'alter table %s add %s';

      function ExisteCampo(Campo: string): Boolean;
      Var
         lResposta: Boolean;
      Begin
         MyDataSet.Filter := 'name = ' + QuotedStr(Campo);
         MyDataSet.Filtered := True;
         try
            lResposta := MyDataSet.RecordCount > 0;
         finally
            MyDataSet.Filter := EmptyStr;
            MyDataSet.Filtered := False;
         end;

         Result := lResposta;
      end;

      function RetirarNotNull(sql: string): string;
      begin
         Result := StringReplace(sql,'not null',EmptyStr,[]);
      end;

   Begin
      cScriptTabela := '';

      cSQL := 'PRAGMA Table_Info('+ QuotedStr(cNomeTabela) + ')';
      MyDataSet := TConexao.GetInstance.EnviaConsulta(cSQL);
      try
         For prop In ctx.GetType(classe).GetDeclaredProperties Do
            For atrib In prop.GetAttributes Do
               If atrib Is TAtributoBanco Then
                  if not(TAtributoBanco(atrib) is TCampoListagem) then
                     If Not ExisteCampo(TAtributoBanco(atrib).nome) Then
                     begin
                        cScriptTabela := cScriptTabela +
                           Format(txtPadrao,[cNomeTabela, RetirarNotNull(TAtributoBanco(atrib).getScriptCampo)]);

                        If atrib is TCampoEstrangeiro Then
                           cScriptTabela := cScriptTabela + ' REFERENCES ' + TAtributoBanco(atrib).caption + '(ID);' + sLineBreak;

                        cScriptTabela := cScriptTabela + ';' + sLineBreak;
                     end;
      finally
         MyDataSet.Close;
         FreeAndNil(MyDataSet);
      end;
   End;

   procedure _ObterSequencia;
   begin
      cScriptSequence := 'CREATE SEQUENCE gen_id_' + cNomeTabela + ' ;' + #13;
   end;

   procedure _AtualizarSequencia;
   var
      dSet: TQuery;
      nSequenciaAtual,
      nSequencialTabela: Integer;
   begin
      try
         dSet := TQuery(TConexao.GetInstance.EnviaConsulta('select last_value from gen_id_' + cNomeTabela));
         nSequenciaAtual := dSet.FieldByName('last_value').AsInteger;
         dSet.Free;
         dSet := TQuery(TConexao.GetInstance.EnviaConsulta('select Max(id) as "ID" from ' + cNomeTabela));
         nSequencialTabela := dSet.FieldByName('ID').AsInteger;

         if nSequencialTabela > nSequenciaAtual then
            cScriptAtualizaSequence := 'alter sequence gen_id_'+ cNomeTabela +
                                       ' restart with ' + IntToStr(nSequencialTabela+1)+
                                       ' ;' + #13;

      finally
         FreeAndNil(dSet);
      end;
   end;

Begin
   cScriptTabela           := '';
   cScriptSequence         := '';
   cScriptAtualizaSequence := '';

   ctx := TRttiContext.Create;
   Try
      cNomeTabela := _getNomeTabela;
      lTabelaExiste := TConexao.GetInstance.TabelaExiste(cNomeTabela);

      If lTabelaExiste Then
         _ObterSomenteCampos
      Else
         _ObterTabelaCompleta;

   Finally
      ctx.Free;
   End;

   Result := cScriptTabela + cScriptSequence + cScriptAtualizaSequence;
End;

class Function TScriptSQL.RegistrarEntidadeNoBanco(classe: TClass): boolean;
Begin
   Result := False;
   Var cScript := TScriptSQL.ObterScriptDaEntidade(classe);

   If Trim(cScript) <> '' Then
   Begin
      try
         TConexao.GetInstance.EnviarComando(cScript);
         Result := True;
      except
         TConexao.GetInstance.RollbackRetaining;
      end;
   End;
End;

End.
