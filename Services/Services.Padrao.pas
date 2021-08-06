unit Services.Padrao;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades,
  Interfaces.Services.Padrao, Connection.Controller.SqLite, Datasnap.DBClient,
  Data.DB, System.SysUtils, Utils.Entidade, Controls, FireDAC.Comp.Client,
  FireDAC.Stan.Param, Utils.Enumerators;

type
  TParametro = record
    FNomeParametro: string;
    FValorParametro: string;
    FValorParametroBlob: TMemoryStream;
    FTipoPropriedade: TTiposDeCampo;
  end;

  TArrayParametros = array of TParametro;

  TServico<T: class> = class(TInterfacedObject, iServico<T>)
  private
    procedure PersistirListagem(Propriedade: TRttiProperty; Lista: TList<TObject>; EntidadePai: TObject);
    procedure AlterarPropriedadeVisibleDoField(cds: TDataSet);
    procedure PreencherArrayComParametros(Propriedade: TRttiProperty; Objeto: TObject; Atrib: TAtributoBanco; var RecParam: TParametro);
    function ObterArrayComParametrosPreenchidos(Objeto: TObject): TArrayParametros;
    function RegistroJaGravadoEmBanco(Objeto: TObject): Boolean;
    procedure PersistirObjetoEmBanco(Objeto: TObject; Parametros: TArrayParametros);
    function CriarSqlParaInsercao(Objeto: TObject; Parametros: TArrayParametros): string;
    function CriarSqlParaAtualizacao(Objeto: TObject; Parametros: TArrayParametros): string;
    procedure PreencherQueryComArray(Qry: TQuery; Parametros: TArrayParametros);
    function ObterSqlParaPersistencia(Objeto: TObject; Parametros: TArrayParametros): string;
    function ObterSqlCustomizada: string;
  public
    procedure Gravar(Objeto: TObject);
    procedure Excluir(Objeto: TObject);
    function ListarTodos: TList<T>;
    function ListarTodosCDS: TDataSet;
    function PesquisarPorId(Id: Integer): T;
    function PesquisarPorCondicao(cSql: string): TList<T>;
    class function New: iServico<T>;
  end;

implementation

uses
  Objeto.CustomSelect;

{ TServico<T> }

procedure TServico<T>.AlterarPropriedadeVisibleDoField(cds: TDataSet);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(TypeInfo(T));
    if not Assigned(Tipo) then
      Exit;

    for var Prop in Tipo.GetDeclaredProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if Atrib is TAtributoBanco then
        begin
          if cds.FindField(TAtributoBanco(Atrib).nome) = nil then
            Continue;

          cds.FieldByName(TAtributoBanco(Atrib).nome).Visible := TAtributoBanco(Atrib).Visivel;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
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

procedure TServico<T>.PreencherArrayComParametros(Propriedade: TRttiProperty;
   Objeto: TObject; Atrib: TAtributoBanco; var RecParam: TParametro);
begin
  RecParam.FNomeParametro := TAtributoBanco(Atrib).nome;

  RecParam.FTipoPropriedade := TAtributoBanco(Atrib).Tipo;

  if Propriedade.GetValue(Objeto).IsEmpty then
  begin
    RecParam.FValorParametro := 'null';
    Exit;
  end;

  case RecParam.FTipoPropriedade of
    ftESTRANGEIRO:
      begin
        RecParam.FValorParametro := TUtilsEntidade.ObterValorPropriedade(Propriedade.GetValue(Objeto).AsType<TObject>, 'id');
        if RecParam.FValorParametro = '0' then
          RecParam.FValorParametro := 'null';
      end;
    ftBLOBT:
      begin
        RecParam.FValorParametroBlob := TMemoryStream.Create;
        TMemoryStream(Propriedade.GetValue(Objeto).AsType<TMemoryStream>).SaveToStream(RecParam.FValorParametroBlob);
      end;
    ftLOGICO:
      begin
        RecParam.FValorParametro := BoolToStr(Propriedade.GetValue(Objeto).AsBoolean);
      end;
    ftDATA:
      begin
        RecParam.FValorParametro := DateToStr(Propriedade.GetValue(Objeto).AsExtended);
      end
  else
    RecParam.FValorParametro := Propriedade.GetValue(Objeto).AsVariant;
  end;
end;

function TServico<T>.ObterArrayComParametrosPreenchidos(Objeto: TObject): TArrayParametros;
begin
  var Parametros: TArrayParametros;
  SetLength(Parametros, 1);

  var IndiceArray := 0;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(FindClass(Objeto.ClassName));
    if Tipo = Nil then
      Exit;

    for var Prop in Tipo.GetDeclaredProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if (Atrib is TAtributoBanco) then
        begin
          if CHAVE_PRIMARIA in TAtributoBanco(Atrib).propriedades then
            Continue;

          if (TAtributoBanco(Atrib).Tipo = ftLISTAGEM) then
          begin
            if not Prop.GetValue(Objeto).IsEmpty then
              PersistirListagem(Prop, Prop.GetValue(Objeto).AsType<TList<TObject>>, Objeto);
            Continue;
          end;

          if Trim(Parametros[IndiceArray].FNomeParametro) <> EmptyStr then
          begin
            Inc(IndiceArray);
            SetLength(Parametros, length(Parametros) + 1);
          end;

          PreencherArrayComParametros(Prop, Objeto, TAtributoBanco(Atrib), Parametros[IndiceArray]);
        end;
      end;
    end;
    Tipo.Free;
  finally
    Ctx.Free;
    Result := Parametros;
  end;
end;

function TServico<T>.RegistroJaGravadoEmBanco(Objeto: TObject): Boolean;
var
  DSet: TDataSet;
begin
  DSet := TConexao.GetInstance.EnviaConsulta('select * from ' +
    TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' where ' +
    TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' +
    IntToStr(TUtilsEntidade.ObterValorPropriedade(Objeto, 'ID')));
  Result := not DSet.IsEmpty;
  FreeAndNil(DSet);
end;

function TServico<T>.CriarSqlParaInsercao(Objeto: TObject; Parametros: TArrayParametros): string;
begin
  var cSqlCampos := 'INSERT INTO ' + TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' (';
  var cSqlParametros := EmptyStr;
  for var IndiceArray := Low(Parametros) to High(Parametros) do
  begin
    cSqlCampos := cSqlCampos + Parametros[IndiceArray].FNomeParametro;

    if IndiceArray <> High(Parametros) then
      cSqlCampos := cSqlCampos + ',';

    if Parametros[IndiceArray].FValorParametro = 'null' then
      cSqlParametros := cSqlParametros + 'Null'
    else
      cSqlParametros := cSqlParametros + ':' + Parametros[IndiceArray].FNomeParametro;

    if IndiceArray <> High(Parametros) then
      cSqlParametros := cSqlParametros + ',';
  end;

  Result := cSqlCampos + ') VALUES (' + cSqlParametros + ')';
end;

function TServico<T>.CriarSqlParaAtualizacao(Objeto: TObject; Parametros: TArrayParametros): string;
begin
  var cSql := 'UPDATE ' + TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' SET ';

  for var IndiceArray := Low(Parametros) to High(Parametros) do
  begin
    if Parametros[IndiceArray].FValorParametro = 'null' then
      cSql := cSql + Parametros[IndiceArray].FNomeParametro + ' = Null'
    else
      cSql := cSql + Parametros[IndiceArray].FNomeParametro + ' = :' + Parametros[IndiceArray].FNomeParametro;

    if IndiceArray <> High(Parametros) then
      cSql := cSql + ',';
  end;
  Result := cSql + ' WHERE ' + TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' +
    IntToStr(TUtilsEntidade.ObterValorPropriedade(Objeto, 'ID'));
end;

procedure TServico<T>.PreencherQueryComArray(Qry: TQuery; Parametros: TArrayParametros);
begin
  for var IndiceArray := Low(Parametros) to High(Parametros) do
  begin
    if Parametros[IndiceArray].FValorParametro = 'null' then
      Continue;

    case Parametros[IndiceArray].FTipoPropriedade of
      ftBLOBT:
        begin
          if Parametros[IndiceArray].FValorParametroBlob.Size = 0 then
            Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).Clear
          else
            Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).LoadFromStream(Parametros[IndiceArray].FValorParametroBlob, ftBlob);
        end;
      ftLOGICO:
        begin
          Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).AsBoolean := StrToBoolDef(Parametros[IndiceArray].FValorParametro, False);
        end;
      ftDATA:
        begin
          if (StrToDateDef(Parametros[IndiceArray].FValorParametro, 0) <> StrToDate('30/12/1899')) then
            Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).AsDate := StrToDate(Parametros[IndiceArray].FValorParametro)
          else
            Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).AsString := 'null';
        end;
      ftDECIMAL:
        begin
          Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).AsFloat := StrToFloatDef(Parametros[IndiceArray].FValorParametro, 0);
        end;
    else
      Qry.ParamByName(Parametros[IndiceArray].FNomeParametro).AsString := Parametros[IndiceArray].FValorParametro;
    end;
  end;
end;

function TServico<T>.ObterSqlParaPersistencia(Objeto: TObject; Parametros: TArrayParametros): string;
begin
  var cSql: string;
  if not RegistroJaGravadoEmBanco(Objeto) then
    cSql := CriarSqlParaInsercao(Objeto, Parametros)
  else
    cSql := CriarSqlParaAtualizacao(Objeto, Parametros);
  Result := cSql;
end;

procedure TServico<T>.PersistirObjetoEmBanco(Objeto: TObject; Parametros: TArrayParametros);
begin
  var Qry := TConexao.GetInstance.ObterQuery;
  try
    Qry.SQL.Add(ObterSqlParaPersistencia(Objeto, Parametros));
    PreencherQueryComArray(Qry, Parametros);
    Qry.ExecSQL;
    TConexao.GetInstance.Commit;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TServico<T>.Gravar(Objeto: TObject);
Begin
   If Objeto = Nil Then
      Exit;

  var Parametros := ObterArrayComParametrosPreenchidos(Objeto);
  try
    PersistirObjetoEmBanco(Objeto, Parametros);
  finally
    SetLength(Parametros,0);
  end;
//      Banco.IncluirNaCache(TEntidade(Objeto));
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

function TServico<T>.ObterSqlCustomizada: string;
var
  Objeto: T;
begin
  var Sql := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(TypeInfo(T));
    if not Assigned(Tipo) then
      Exit;

    for var Prop in Tipo.GetDeclaredProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if not (Atrib is TAtributoBanco) then
          Continue;

        if not Sql.IsEmpty then
          Sql := Sql + ', ';

        if not Assigned(TAtributoBanco(Atrib).CustomSelect) then
        begin
          Sql := Sql + TAtributoBanco(Atrib).nome + ' as ' + TAtributoBanco(Atrib).caption;
          Continue;
        end;
        Sql := Sql + TUtilsEntidade.ExecutarMetodoClasse(TAtributoBanco(Atrib).CustomSelect,'getSelectCustom',[]).AsString;
      end;
    end;
    Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();
    try
      Sql := 'select ' + Sql + ' from ' + TUtilsEntidade.ObterNomeDaTabela(Objeto);
    finally
      Objeto.Free;
    end;
  finally
    Ctx.Free;
  end;
  Result := Sql;
end;

function TServico<T>.ListarTodosCDS: TDataSet;
begin
  var Sql := ObterSqlCustomizada;
  var DSet := TConexao.GetInstance.EnviaConsulta(Sql);
  AlterarPropriedadeVisibleDoField(DSet);
  Result := DSet;
end;

class function TServico<T>.New: iServico<T>;
begin
  Result := Self.Create;
end;

function TServico<T>.ListarTodos: TList<T>;
var
  DSet: TDataSet;
  ListObj: TList<T>;
  Objeto: T;
begin
  ListObj := TList<T>.Create;
  Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();

  try
    DSet := TConexao.GetInstance.EnviaConsulta('select * from ' + TUtilsEntidade.ObterNomeDaTabela(Objeto));
  finally
    FreeAndNil(Objeto);
  end;

  DSet.First;
  while not DSet.Eof do
  begin
    Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

    TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
    ListObj.Add(Objeto);

    DSet.Next;
  end;
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
   Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

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
         Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

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
   Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

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
