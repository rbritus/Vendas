unit Services.Padrao;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades, Interfaces.Services,
  Connection.Controller.SqLite, Datasnap.DBClient, Data.DB, System.SysUtils,
  Utils.Entidade, Controls, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
   TServico<T: class> = Class(TInterfacedPersistent, iServico<T>)
   private
      Procedure PersistirListagem(Propriedade: TRttiProperty; Lista:
         TList<TObject>; EntidadePai: TObject);
      procedure CorrigirCaptionDataSet(cds: TDataSet; Obj: T);
   public
      procedure Gravar(Objeto: TObject);
      procedure Excluir(Objeto: TObject);
      function ListarTodos(): TList<T>;
      function ListarTodosCDS(): TDataSet;
      function PesquisarPorId(Id: Integer): T;
      function PesquisarPorCondicao(cSql: string): TList<T>;
   End;

Type
   TRec = Record
      FNomeParametro: String;
      FValorParametro: String;
      FValorParametroBlob: TMemoryStream;
      FTipoPropriedade: TTiposDeCampo;
   End;

implementation

{ TServico<T> }

procedure TServico<T>.CorrigirCaptionDataSet(cds: TDataSet; Obj: T);
Var
   Ctx  : TRttiContext;
   Prop : TRttiProperty;
   Tipo : TRTTIType;
   Atrib: TCustomAttribute;
Begin
   Ctx    := TRttiContext.Create;
   Tipo   := ctx.GetType(Obj.ClassType);

   Try
      If Tipo <> Nil Then
      Begin
         For Prop In Tipo.GetDeclaredProperties Do
         Begin
            For Atrib In Prop.GetAttributes Do
            Begin
               If Atrib Is TAtributoBanco Then
               Begin
                  if cds.FindField(TAtributoBanco(Atrib).nome) = nil then
                     Continue;

                  cds.FieldByName(TAtributoBanco(Atrib).nome).DisplayLabel := TAtributoBanco(Atrib).caption;
               End;
            End;
         End;
      End;
   Finally
      Ctx.Free;
   End;
end;

procedure TServico<T>.Excluir(Objeto: TObject);
Var
   cTabela, cId, cValor: String;

   Ctx           : TRttiContext;
   Prop          : TRttiProperty;
   Tipo, TipoEstr: TRTTIType;
   Atrib         : TCustomAttribute;

   Lista         : TList<TObject>;
   ObjEstrangeiro: TObject;

Begin
   If Objeto = Nil Then
      Exit;

   cTabela := TUtilsEntidade.ObterNomeDaTabela(Objeto);
   cId     := TUtilsEntidade.ObterChavePrimaria(Objeto);
   cValor  := TUtilsEntidade.ObterValorPropriedade(Objeto, cId);

   Ctx := TRttiContext.Create;
   Try
      Tipo := Ctx.GetType(FindClass(Objeto.ClassName));
      If Tipo <> Nil Then
      Begin
         For Prop In Tipo.GetProperties Do
         Begin
            For Atrib In Prop.GetAttributes Do
            Begin
               If Atrib Is TCampoListagem Then
               Begin
                  Case TCampoListagem(Atrib).TipoAssociacao Of
                     taOneToMany:
                        Begin
                           Case TCampoListagem(Atrib).TipoCascata Of
                              ctCascade:
                                 Begin
                                    Lista := Prop.GetValue(Objeto).AsType<TList<TObject>>;
                                    For ObjEstrangeiro In Lista Do
                                       TUtilsEntidade.ExecutarMetodoObjeto(ObjEstrangeiro,'Excluir',[]);
                                 End;
                              ctSetNull:
                                 Begin
                                    Lista := Prop.GetValue(Objeto).AsType<TList<TObject>>;
                                    For ObjEstrangeiro In Lista Do
                                       TConexao.GetInstance.EnviarComando('UPDATE ' + TCampoListagem(Atrib).TabelaRelacional +
                                        ' SET ' + TCampoListagem(Atrib).CampoPai + ' = NULL ' +
                                        ' WHERE ' + TCampoListagem(Atrib).CampoFilho + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(ObjEstrangeiro, 'ID')));
                                 End;
                              ctRestrict:
                                 Raise Exception.Create('Erro de exclusão (OneToMany)');
                           End;
                        End;
                     taManyToMany:
                        Begin
                           Case TCampoListagem(Atrib).TipoCascata Of
                              ctCascade:
                                 Begin
                                    TConexao.GetInstance.EnviarComando('DELETE FROM ' + TCampoListagem(Atrib).TabelaRelacional +
                                       ' WHERE ' + TCampoListagem(Atrib).CampoPai + ' = ' + cValor);

                                    Lista          := Prop.GetValue(Objeto).AsType<TList<TObject>>;
                                    For ObjEstrangeiro In Lista Do
                                    Begin
                                       TConexao.GetInstance.EnviarComando('DELETE FROM ' + TCampoListagem(Atrib).TabelaRelacional +
                                        ' WHERE ' + TCampoListagem(Atrib).CampoFilho + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(ObjEstrangeiro, 'ID')));

                                       TUtilsEntidade.ExecutarMetodoObjeto(ObjEstrangeiro,'Excluir',[]);
                                    End;
                                 End;
                              ctSetNull:
                                 Begin
                                    Lista := Prop.GetValue(Objeto).AsType<TList<TObject>>;
                                    TConexao.GetInstance.EnviarComando('DELETE FROM ' + TCampoListagem(Atrib).TabelaRelacional +
                                       ' WHERE ' + TCampoListagem(Atrib).CampoPai + ' = ' + cValor);
                                 End;
                              ctRestrict:
                                 Raise Exception.Create('Erro de exclusão (ManyToMany)');
                           End;
                        End;
                  End;
               End;
            End;
         End;
      End;
   Finally
      Ctx.Free;
   End;

   TConexao.GetInstance.EnviarComando('DELETE FROM ' + cTabela + ' WHERE ' + cId + ' = '
      + cValor);
end;

procedure TServico<T>.Gravar(Objeto: TObject);
Var
   Ctx           : TRttiContext;
   Prop          : TRttiProperty;
   Tipo, TipoEstr: TRTTIType;
   Atrib         : TCustomAttribute;

   DSet       : TDataSet;
   nContRecord: Integer;
   RecParam   : Array Of TRec;
   cSql       : String;
   Qry        : TQuery;

   objEstr: TObject;
Begin
   If Objeto = Nil Then
      Exit;

   SetLength(RecParam, 1);
   nContRecord := 0;

   Ctx  := TRttiContext.Create;
   Tipo := Ctx.GetType(FindClass(Objeto.ClassName));
   Try
      If Tipo <> Nil Then
      Begin
         For Prop In Tipo.GetDeclaredProperties Do
         Begin
            For Atrib In Prop.GetAttributes Do
            Begin
               If (Atrib Is TAtributoBanco) Then
               Begin
                  If (TAtributoBanco(Atrib).Tipo <> ftLISTAGEM) Then
                  Begin
                     If Trim(RecParam[nContRecord].FNomeParametro) <> EmptyStr Then
                     Begin
                        Inc(nContRecord);
                        SetLength(RecParam, length(RecParam) + 1);
                     End;

                     If CHAVE_PRIMARIA In TAtributoBanco(Atrib).propriedades Then
                        Continue;

                     Begin
                        RecParam[nContRecord].FNomeParametro := TAtributoBanco(Atrib).nome;

                        RecParam[nContRecord].FTipoPropriedade := TAtributoBanco(Atrib).Tipo;

                        If Prop.GetValue(Objeto).IsEmpty Then
                        Begin
                           RecParam[nContRecord].FValorParametro := 'null';
                           Continue;
                        End;

                        Case RecParam[nContRecord].FTipoPropriedade Of
                           ftESTRANGEIRO:
                              Begin
                                 RecParam[nContRecord].FValorParametro :=
                                    TUtilsEntidade.ObterValorPropriedade(Prop.GetValue(Objeto).AsType<TObject>, 'id');
                                 if RecParam[nContRecord].FValorParametro = '0' then
                                    RecParam[nContRecord].FValorParametro := 'null';
                              End;
                           ftBLOBT:
                              Begin
                                 RecParam[nContRecord].FValorParametroBlob := TMemoryStream.Create;
                                 TMemoryStream(Prop.GetValue(Objeto).AsType<TMemoryStream>)
                                    .SaveToStream(RecParam[nContRecord].FValorParametroBlob);
                              End;
                           ftLOGICO:
                              Begin
                                 RecParam[nContRecord].FValorParametro := BoolToStr(Prop.GetValue(Objeto).AsBoolean);
                              End;
                           ftDATA:
                              begin
                                 RecParam[nContRecord].FValorParametro := DateToStr(Prop.GetValue(Objeto).AsExtended);
                              end
                        Else
                           RecParam[nContRecord].FValorParametro := Prop.GetValue(Objeto).AsVariant;
                        End;
                     End;
                  End
                  Else
                  Begin
                     If Not Prop.GetValue(Objeto).IsEmpty Then
                        PersistirListagem(Prop, Prop.GetValue(Objeto).AsType<TList<TObject>>, Objeto);
                  End;
               End;
            End;
         End;
      End;

      DSet := TConexao.GetInstance.EnviaConsulta('select * from ' +
         TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' where ' +
         TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' +
         IntToStr(TUtilsEntidade.ObterValorPropriedade(Objeto,'ID')));

      cSql := '';

      If DSet.IsEmpty Then
      Begin
         cSql := 'INSERT INTO ' + TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' (';

         For nContRecord := Low(RecParam) To High(RecParam) Do
         Begin
            cSql := cSql + RecParam[nContRecord].FNomeParametro;

            If nContRecord <> High(RecParam) Then
               cSql := cSql + ',';
         End;

         cSql := cSql + ') VALUES (';

         For nContRecord := Low(RecParam) To High(RecParam) Do
         Begin
            If RecParam[nContRecord].FValorParametro = 'null' Then
               cSql := cSql + 'Null'
            Else
               cSql := cSql + ':' + RecParam[nContRecord].FNomeParametro;

            If nContRecord <> High(RecParam) Then
               cSql := cSql + ',';
         End;

         cSql := cSql + ')';
      End
      Else
      Begin
         cSql := 'UPDATE ' + TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' SET ';

         For nContRecord := Low(RecParam) To High(RecParam) Do
         Begin
            If RecParam[nContRecord].FValorParametro = 'null' Then
               cSql := cSql + RecParam[nContRecord].FNomeParametro + ' = Null'
            Else
               cSql := cSql + RecParam[nContRecord].FNomeParametro + ' = :' +
                  RecParam[nContRecord].FNomeParametro;

            If nContRecord <> High(RecParam) Then
               cSql := cSql + ',';
         End;

         cSql := cSql + ' WHERE ' + TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' +
            IntToStr(TUtilsEntidade.ObterValorPropriedade(Objeto,'ID'));
      End;

      Qry := TConexao.GetInstance.ObterQuery;
      Qry.SQL.Add(cSql);

      For nContRecord := Low(RecParam) To High(RecParam) Do
      Begin
         If RecParam[nContRecord].FValorParametro = 'null' Then
            Continue;

         Case RecParam[nContRecord].FTipoPropriedade Of
            ftBLOBT:
               Begin
                  if RecParam[nContRecord].FValorParametroBlob.Size = 0 then
                     Qry.ParamByName(RecParam[nContRecord].FNomeParametro).Clear
                  else
                     Qry.ParamByName(RecParam[nContRecord].FNomeParametro).LoadFromStream(RecParam[nContRecord].FValorParametroBlob, ftBlob);
               End;
            ftLOGICO:
               Begin
                  Qry.ParamByName(RecParam[nContRecord].FNomeParametro).AsBoolean :=
                     StrToBoolDef(RecParam[nContRecord].FValorParametro, False);
               End;
            ftDATA:
               begin
                  if (StrToDateDef(RecParam[nContRecord].FValorParametro,0) <> StrToDate('30/12/1899')) then
                     Qry.ParamByName(RecParam[nContRecord].FNomeParametro).AsDate := StrToDate(RecParam[nContRecord].FValorParametro)
                  else
                     Qry.ParamByName(RecParam[nContRecord].FNomeParametro).AsString := 'null';
               end;
            ftDECIMAL:
               begin
                  Qry.ParamByName(RecParam[nContRecord].FNomeParametro).AsFloat := StrToFloatDef(RecParam[nContRecord].FValorParametro,0);
               end;
         Else
            Qry.ParamByName(RecParam[nContRecord].FNomeParametro).AsString := RecParam[nContRecord].FValorParametro;
         End;
      End;

      Qry.ExecSQL;
      TConexao.GetInstance.Commit;
//      Banco.IncluirNaCache(TEntidade(Objeto));
   Finally
      FreeAndNil(Qry);
      Ctx.Free;
   End;
end;

Procedure TServico<T>.PersistirListagem(Propriedade: TRttiProperty;
   Lista: TList<TObject>; EntidadePai: TObject);
Var
   entFilho: TObject;
   idPai   : Integer;
   idFilho : Integer;

   cTabela    : String;
   cCampoPai  : String;
   cCampoFilho: String;

   Ctx  : TRttiContext;
   Tipo : TRTTIType;
   Atrib: TCustomAttribute;

   nRelacao: TTipoAssociacaoEntreTabelas;
   DSet: TDataSet;
   lAchou: Boolean;
   cIdRemovidos: string;
Begin
   idPai := TUtilsEntidade.ObterValorPropriedade(EntidadePai, 'id');

   Ctx := TRttiContext.Create;

   Try
      For Atrib In Propriedade.GetAttributes Do
      Begin
         If Atrib Is TCampoListagem Then
         Begin
            cTabela     := TCampoListagem(Atrib).TabelaRelacional;
            cCampoPai   := TCampoListagem(Atrib).CampoPai;
            cCampoFilho := TCampoListagem(Atrib).CampoFilho;
            nRelacao    := TCampoListagem(Atrib).TipoAssociacao;

            Break;
         End;
      End;

      If nRelacao = taManyToMany Then
      Begin
         DSet := TConexao.GetInstance.EnviaConsulta('select * from ' + cTabela + ' where ' + cCampoPai + ' = ' + IntToStr(idPai));

         For entFilho In Lista Do
         Begin
            if (DSet.Locate(cCampoFilho, TUtilsEntidade.ObterValorPropriedade(entFilho, 'id'), [])) then
               Continue
            else
            begin
               TConexao.GetInstance.EnviarComando(
                  'insert into ' + cTabela + ' (id,' + cCampoPai + ',' + cCampoFilho +
                  ') values (' +
                  IntToStr(TConexao.GetInstance.ObterProximaSequencia(cTabela)) + ',' +
                  IntToStr(idPai) + ',' +
                  IntToStr(TUtilsEntidade.ObterValorPropriedade(entFilho, 'id')) + ')'
                  );
            end;
         End;
         //Remove as associações que não existem mais na relação
         cIdRemovidos := EmptyStr;
         DSet.First;
         while not DSet.Eof do
         begin
            lAchou := False;
            for entFilho in Lista do
            begin
               if ( (TUtilsEntidade.ObterValorPropriedade(entFilho, 'id')) = (DSet.FieldByName(cCampoFilho).AsInteger) ) then
               begin
                  lAchou := True;
                  break;
               end;
            end;
            if (not lAchou) then
            begin
               if (cIdRemovidos <> EmptyStr) then
                  cIdRemovidos := cIdRemovidos + ', ' + DSet.FieldByName(cCampoFilho).AsString
               else
                  cIdRemovidos := DSet.FieldByName(cCampoFilho).AsString;
            end;
            DSet.Next;
         end;

         if (cIdRemovidos <> EmptyStr) then
         begin
            TConexao.GetInstance.EnviarComando('delete from ' + cTabela + ' where ' + cCampoPai + ' = ' + IntToStr(idPai) +
                  ' and ' + cCampoFilho + ' in (' + cIdRemovidos + ')' );
         end;
      End
      Else
      Begin
         TConexao.GetInstance.EnviarComando(
            'update ' + cTabela +
            ' set ' + cCampoPai + ' = null ' +
            ' where ' + cCampoPai + ' = ' + IntToStr(idPai));

         For entFilho In Lista Do
            TConexao.GetInstance.EnviarComando(
               'update ' + cTabela +
               ' set ' + cCampoPai + ' = ' + IntToStr(idPai) +
               ' where ' + cCampoFilho + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(entFilho, 'id')));
      End;
   Finally
      Ctx.Free;
   End;

End;

function TServico<T>.ListarTodosCDS(): TDataSet;
Var
   DSet   : TDataSet;
   Objeto : T;
Begin
   Objeto  := TUtilsEntidade.ObterObjetoGenerico<T>();

   Try
      DSet := TConexao.GetInstance.EnviaConsulta('select * from ' +
         TUtilsEntidade.ObterNomeDaTabela(Objeto));
      CorrigirCaptionDataSet(DSet, Objeto);
   Finally
      FreeAndNil(Objeto);
   End;

   Result := DSet;
end;

function TServico<T>.ListarTodos: TList<T>;
Var
   DSet   : TDataSet;
   ListObj: TList<T>;
   Objeto : T;
Begin
   ListObj := TList<T>.Create;
   Objeto  := TUtilsEntidade.ObterObjetoGenerico<T>();

   Try
      DSet := TConexao.GetInstance.EnviaConsulta('select * from ' +
         TUtilsEntidade.ObterNomeDaTabela(Objeto));
   Finally
      FreeAndNil(Objeto);
   End;

   DSet.First;
   While Not DSet.Eof Do
   Begin
      Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();

      TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
      ListObj.Add(Objeto);

      DSet.Next;
   End;
   FreeAndNil(DSet);

   Result := ListObj;
end;

function TServico<T>.PesquisarPorCondicao(cSql: string): TList<T>;
Var
   DSet  : TDataSet;
   ListObj: TList<T>;
   Objeto: T;
Begin
   ListObj := TList<T>.Create;
   Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();

   DSet   := TConexao.GetInstance.EnviaConsulta('select * from ' +
       TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' where ' + cSql);

   If DSet.IsEmpty Then
   Begin
      FreeAndNil(DSet);
      Result := nil;
      Exit;
   End;

   // Cria a classe dereflexão do objeto
   Try
      DSet.First;
      While Not DSet.Eof Do
      Begin
         Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();

         TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
         ListObj.Add(Objeto);

         DSet.Next;
      End;
   Finally
      FreeAndNil(DSet);
   End;

   Result := ListObj;
end;

function TServico<T>.PesquisarPorId(Id: Integer): T;
Var
   DSet  : TDataSet;
   Objeto: T;
Begin
   Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();

   DSet   := TConexao.GetInstance.EnviaConsulta('select * from ' +
       TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' where ' +
       TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' + IntToStr(id));

   If DSet.IsEmpty Then
   Begin
      FreeAndNil(DSet);
      Result := T(Nil);
      Raise Exception.Create('Dados não encontrados. (PesquisarPorId)');
   End;

   // Cria a classe dereflexão do objeto
   Try
      TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
   Finally
      FreeAndNil(DSet);
   End;

   Result := T(Objeto);
end;

end.
