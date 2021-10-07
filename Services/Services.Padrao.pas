unit Services.Padrao;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades,
  Interfaces.Services.Padrao, Connection.Controller.SqLite, Datasnap.DBClient,
  Data.DB, System.SysUtils, Utils.Entidade, Controls, FireDAC.Comp.Client,
  FireDAC.Stan.Param, Utils.Enumerators, Componente.TObjectList;

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
    procedure GravarPropertyLista(Propriedade: TRttiProperty; Lista: TObjectListFuck<TObject>; EntidadePai: TObject);
    procedure AlterarCaptionEVisibilidadeDoField(cds: TDataSet);
    procedure PreencherArrayComParametros(Propriedade: TRttiProperty; Objeto: TObject; Atrib: TAtributoBanco; var RecParam: TParametro);
    function ObterArrayComParametrosPreenchidos(Objeto: TObject): TArrayParametros;
    function RegistroJaGravadoEmBanco(Objeto: TObject): Boolean;
    procedure PersistirObjetoEmBanco(Objeto: TObject; Parametros: TArrayParametros);
    function CriarSqlParaInsercao(Objeto: TObject; Parametros: TArrayParametros): string;
    function CriarSqlParaAtualizacao(Objeto: TObject; Parametros: TArrayParametros): string;
    procedure PreencherQueryComArray(Qry: TQuery; Parametros: TArrayParametros);
    procedure ObterSqlParaPersistencia(Qry: TQuery; Objeto: TObject; Parametros: TArrayParametros);
    function ObterSqlCustomizada: string;
    procedure RecuperarIdParaObjeto(Objeto: TObject; qry: TFDQuery);
    procedure PersistirPropriedadesTipoLista(Objeto: TObject);
    const ID_ZERADO = 0;
  public
    procedure Gravar(Objeto: TObject);
    procedure Excluir(Objeto: TObject);
    function ListarTodos: TObjectListFuck<T>;
    function ListarTodosCDS: TDataSet;
    function PesquisarPorId(Id: Integer): T;
    function PesquisarPorCondicao(cSql: string): TObjectListFuck<T>;
    class function New: iServico<T>;
  end;

implementation

uses
  Objeto.CustomSelect, FireDAC.Phys.Intf, Utils.ClientDataSet;

{ TServico<T> }

procedure TServico<T>.AlterarCaptionEVisibilidadeDoField(cds: TDataSet);
begin
  var Objeto := TUtilsEntidade.ObterObjetoGenerico<T>();
  try
    TUtilsClientDataSet.AlterarPropriedadeCaptionEVisibleDoField(TClientDataSet(cds),TPersistent(Objeto));
  finally
    Objeto.Free;
  end;
//  var Ctx := TRttiContext.Create;
//  try
//    var Tipo := Ctx.GetType(TypeInfo(T));
//    if not Assigned(Tipo) then
//      Exit;
//
//    for var Prop in Tipo.GetDeclaredProperties do
//    begin
//      for var Atrib in Prop.GetAttributes do
//      begin
//        if Atrib is TAtributoBanco then
//        begin
//          if cds.FindField(TAtributoBanco(Atrib).nome) = nil then
//            Continue;
//
//          cds.FieldByName(TAtributoBanco(Atrib).nome).DisplayLabel := TAtributoBanco(Atrib).caption;
//          cds.FieldByName(TAtributoBanco(Atrib).nome).Visible := TAtributoBanco(Atrib).Visivel;
//
//          if not TAtributoBanco(Atrib).Visivel then
//            Continue;
//
//          if Assigned(TAtributoBanco(Atrib).CustomSelect) then
//          begin
//            var NomeFieldCustom := TAtributoBanco(Atrib).CustomSelect.getFieldNameCustom(TAtributoBanco(Atrib).nome);
//
//            if cds.FindField(NomeFieldCustom) = nil then
//              Continue;
//
//            cds.FieldByName(TAtributoBanco(Atrib).nome).DisplayLabel := TAtributoBanco(Atrib).nome;
//            cds.FieldByName(TAtributoBanco(Atrib).nome).Visible := False;
//            cds.FieldByName(NomeFieldCustom).DisplayLabel := TAtributoBanco(Atrib).caption;
//            cds.FieldByName(NomeFieldCustom).Visible := True;
//          end;
//
//        end;
//      end;
//    end;
//  finally
//    Ctx.Free;
//  end;
end;

procedure TServico<T>.Excluir(Objeto: TObject);
var
  cTabela, cId, cValor: string;
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Tipo, TipoEstr: TRTTIType;
  Atrib: TCustomAttribute;
  Lista: TObjectListFuck<TObject>;
  ObjEstrangeiro: TObject;
begin
  if Objeto = Nil then
    Exit;

  cTabela := TUtilsEntidade.ObterNomeDaTabela(Objeto);
  cId := TUtilsEntidade.ObterChavePrimaria(Objeto);
  cValor := TUtilsEntidade.ObterValorPropriedade(Objeto, cId).AsString;

  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(FindClass(Objeto.ClassName));
    if Tipo <> Nil then
    begin
      for Prop in Tipo.GetProperties do
      begin
        for Atrib in Prop.GetAttributes do
        begin
          if Atrib is TCampoListagem then
          begin
            case TCampoListagem(Atrib).TipoAssociacao of
              taOneToMany:
                begin
                  case TCampoListagem(Atrib).TipoCascata of
                    ctCascade:
                      begin
                        Lista := Prop.GetValue(Objeto).AsType<TObjectListFuck<TObject>>;
                        for ObjEstrangeiro in Lista do
                          TUtilsEntidade.ExecutarMetodoObjeto(ObjEstrangeiro, 'Excluir', []);
                      end;
                    ctSetNull:
                      begin
                        Lista := Prop.GetValue(Objeto).AsType<TObjectListFuck<TObject>>;
                        for ObjEstrangeiro in Lista do
                          TConexao.GetInstance.EnviarComando('UPDATE ' + TCampoListagem(Atrib).TabelaRelacional + ' SET ' + TCampoListagem(Atrib).CampoPai + ' = NULL ' + ' WHERE ' + TCampoListagem(Atrib).CampoFilho + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(ObjEstrangeiro, 'ID').AsInteger));
                      end;
                    ctRestrict:
                      raise Exception.Create('Erro de exclusão (OneToMany)');
                  end;
                end;
              taManyToMany:
                begin
                  case TCampoListagem(Atrib).TipoCascata of
                    ctCascade:
                      begin
                        TConexao.GetInstance.EnviarComando('DELETE FROM ' + TCampoListagem(Atrib).TabelaRelacional + ' WHERE ' + TCampoListagem(Atrib).CampoPai + ' = ' + cValor);

                        Lista := Prop.GetValue(Objeto).AsType<TObjectListFuck<TObject>>;
                        for ObjEstrangeiro in Lista do
                        begin
                          TConexao.GetInstance.EnviarComando('DELETE FROM ' + TCampoListagem(Atrib).TabelaRelacional + ' WHERE ' + TCampoListagem(Atrib).CampoFilho + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(ObjEstrangeiro, 'ID').AsInteger));

                          TUtilsEntidade.ExecutarMetodoObjeto(ObjEstrangeiro, 'Excluir', []);
                        end;
                      end;
                    ctSetNull:
                      begin
                        Lista := Prop.GetValue(Objeto).AsType<TObjectListFuck<TObject>>;
                        TConexao.GetInstance.EnviarComando('DELETE FROM ' + TCampoListagem(Atrib).TabelaRelacional + ' WHERE ' + TCampoListagem(Atrib).CampoPai + ' = ' + cValor);
                      end;
                    ctRestrict:
                      raise Exception.Create('Erro de exclusão (ManyToMany)');
                  end;
                end;
            end;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;

  TConexao.GetInstance.EnviarComando('DELETE FROM ' + cTabela + ' WHERE ' + cId + ' = ' + cValor);
end;

procedure TServico<T>.PreencherArrayComParametros(Propriedade: TRttiProperty; Objeto: TObject; Atrib: TAtributoBanco; var RecParam: TParametro);
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
        RecParam.FValorParametro := TUtilsEntidade.ObterValorPropriedade(Propriedade.GetValue(Objeto).AsType<TObject>, 'id').AsString;
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
    RecParam.FValorParametro := TUtilsEntidade.ObterValorPropriedade(Objeto, Propriedade.Name).AsString;
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
            Continue;
//          begin
//            if not Prop.GetValue(Objeto).IsEmpty then
//              GravarPropertyLista(Prop, TObjectListFuck<TObject>(Prop.GetValue(Objeto).AsObject), Objeto);
//            Continue;
//          end;

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

procedure TServico<T>.PersistirPropriedadesTipoLista(Objeto: TObject);
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
          if (TAtributoBanco(Atrib).Tipo = ftLISTAGEM) then
          begin
            if not Prop.GetValue(Objeto).IsEmpty then
            begin
              var Lista := TObjectListFuck<TObject>(Prop.GetValue(Objeto).AsObject);
              GravarPropertyLista(Prop, Lista, Objeto);
            end;
          end;
        end;
      end;
    end;
    Tipo.Free;
  finally
    Ctx.Free;
  end;
end;

function TServico<T>.RegistroJaGravadoEmBanco(Objeto: TObject): Boolean;
begin
  var IdBanco: Integer := TUtilsEntidade.ObterValorPropriedade(Objeto, 'ID').AsInteger;
  Result := (IdBanco <> ID_ZERADO)
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

  Result := cSqlCampos + ') VALUES (' + cSqlParametros + ');';
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
  Result := cSql + ' WHERE ' + TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(Objeto, 'ID').AsInteger);
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

procedure TServico<T>.ObterSqlParaPersistencia(Qry: TQuery; Objeto: TObject; Parametros: TArrayParametros);
begin
  if RegistroJaGravadoEmBanco(Objeto) then
  begin
    Qry.Command.CommandKind := skUpdate;
    Qry.SQL.Add(CriarSqlParaAtualizacao(Objeto, Parametros));
    Exit;
  end;

  Qry.SQL.Add(CriarSqlParaInsercao(Objeto, Parametros));
  Qry.SQL.Add(TConexao.SELECT_RECUPERACAO_ID);
end;

procedure TServico<T>.RecuperarIdParaObjeto(Objeto: TObject; qry: TFDQuery);
begin
  if RegistroJaGravadoEmBanco(Objeto) then
    Exit;

  var Id := qry.FieldByName('result_id').AsInteger;
  TUtilsEntidade.SetarValorParaPropriedade(Objeto, 'ID', TValue.FromVariant(Id));
end;

procedure TServico<T>.PersistirObjetoEmBanco(Objeto: TObject; Parametros: TArrayParametros);
begin
  var Qry := TConexao.GetInstance.ObterQuery;
  try
    ObterSqlParaPersistencia(Qry, Objeto, Parametros);
    PreencherQueryComArray(Qry, Parametros);
    Qry.ExecScript;
    RecuperarIdParaObjeto(Objeto, Qry);
    PersistirPropriedadesTipoLista(Objeto);
    TConexao.GetInstance.Commit;
    Qry.Close;
  finally
    FreeAndNil(Qry);
  end;
end;

procedure TServico<T>.Gravar(Objeto: TObject);
begin
  if not Assigned(Objeto) then
    Exit;

  var Parametros := ObterArrayComParametrosPreenchidos(Objeto);
  try
    PersistirObjetoEmBanco(Objeto, Parametros);
  finally
    SetLength(Parametros, 0);
  end;
//      Banco.IncluirNaCache(TEntidade(Objeto));
end;

procedure TServico<T>.GravarPropertyLista(Propriedade: TRttiProperty; Lista: TObjectListFuck<TObject>; EntidadePai: TObject);
var
  entFilho: TObject;
  idPai: Integer;
  idFilho: Integer;
  cTabela: string;
  cCampoPai: string;
  cCampoFilho: string;
  Ctx: TRttiContext;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
  nRelacao: TTipoAssociacaoEntreTabelas;
  DSet: TDataSet;
  lAchou: Boolean;
  cIdRemovidos: string;
begin
  idPai := TUtilsEntidade.ObterValorPropriedade(EntidadePai, 'id').AsInteger;

  Ctx := TRttiContext.Create;
  try
    for Atrib in Propriedade.GetAttributes do
    begin
      if Atrib is TCampoListagem then
      begin
        cTabela := TCampoListagem(Atrib).TabelaRelacional;
        cCampoPai := TCampoListagem(Atrib).CampoPai;
        cCampoFilho := TCampoListagem(Atrib).CampoFilho;
        nRelacao := TCampoListagem(Atrib).TipoAssociacao;

        Break;
      end;
    end;

    if nRelacao = taManyToMany then
    begin
      DSet := TConexao.GetInstance.EnviaConsulta('select * from ' + cTabela + ' where ' + cCampoPai + ' = ' + IntToStr(idPai));
      try
        for entFilho in Lista do
        begin
//          TUtilsEntidade.ExecutarMetodoObjeto(entFilho,'Gravar',[]);
          if (DSet.Locate(cCampoFilho, TUtilsEntidade.ObterValorPropriedade(entFilho, 'id').AsInteger, [])) then
            Continue;

          TConexao.GetInstance.EnviarComando('insert into ' + cTabela + ' (' + cCampoPai + ',' + cCampoFilho + ') values (' +
          {IntToStr(TConexao.GetInstance.ObterProximaSequencia(cTabela)) + ',' +} IntToStr(idPai) + ',' +
          IntToStr(TUtilsEntidade.ObterValorPropriedade(entFilho, 'id').AsInteger) + ')');
        end;

        cIdRemovidos := EmptyStr;
        DSet.First;
        while not DSet.Eof do
        begin
          lAchou := False;
          for entFilho in Lista do
          begin
            if ((TUtilsEntidade.ObterValorPropriedade(entFilho, 'id').AsInteger) = (DSet.FieldByName(cCampoFilho).AsInteger)) then
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
          TConexao.GetInstance.EnviarComando('delete from ' + cTabela + ' where ' + cCampoPai + ' = ' + IntToStr(idPai) + ' and ' +
          cCampoFilho + ' in (' + cIdRemovidos + ')');
        end;
        DSet.Close;
      finally
        FreeAndNil(DSet);
      end;
    end
    else
    begin
      TConexao.GetInstance.EnviarComando('update ' + cTabela + ' set ' + cCampoPai + ' = null ' + ' where ' + cCampoPai + ' = ' + IntToStr(idPai));

      for entFilho in Lista do
        TConexao.GetInstance.EnviarComando('update ' + cTabela + ' set ' + cCampoPai + ' = ' + IntToStr(idPai) + ' where ' +
        cCampoFilho + ' = ' + IntToStr(TUtilsEntidade.ObterValorPropriedade(entFilho, 'id').AsInteger));
    end;
  finally
    Ctx.Free;
  end;

end;

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

        if Atrib is TCampoListagem then
          Continue;

        if not Sql.IsEmpty then
          Sql := Sql + ', ';

        Sql := Sql + TAtributoBanco(Atrib).nome;

        if  Assigned(TAtributoBanco(Atrib).CustomSelect) then
        begin
          if not Sql.IsEmpty then
            Sql := Sql + ', ';

          Sql := Sql +  TAtributoBanco(Atrib).CustomSelect.getSelectCustom(TAtributoBanco(Atrib).nome)//TUtilsEntidade.ExecutarMetodoClasse(TAtributoBanco(Atrib).CustomSelect, 'getSelectCustom',[TAtributoBanco(Atrib).nome,TAtributoBanco(Atrib).caption]).AsString;
        end;
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
  AlterarCaptionEVisibilidadeDoField(DSet);
  Result := DSet;
end;

class function TServico<T>.New: iServico<T>;
begin
  Result := Self.Create;
end;

function TServico<T>.ListarTodos: TObjectListFuck<T>;
var
  DSet: TDataSet;
  ListObj: TObjectListFuck<T>;
  Objeto: T;
begin
  ListObj := TObjectListFuck<T>.Create;
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

function TServico<T>.PesquisarPorCondicao(cSql: string): TObjectListFuck<T>;
var
  DSet: TDataSet;
  ListObj: TObjectListFuck<T>;
  Objeto: T;
begin
  ListObj := TObjectListFuck<T>.Create;
  Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

  DSet := TConexao.GetInstance.EnviaConsulta('select * from ' + TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' where ' + cSql);

  if DSet.IsEmpty then
  begin
    FreeAndNil(DSet);
    Result := nil;
    Exit;
  end;

  try
    DSet.First;
    while not DSet.Eof do
    begin
      Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

      TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
      ListObj.Add(Objeto);

      DSet.Next;
    end;
  finally
    FreeAndNil(DSet);
  end;

  Result := ListObj;
end;

function TServico<T>.PesquisarPorId(Id: Integer): T;
var
  DSet: TDataSet;
  Objeto: T;
begin
  Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;

  DSet := TConexao.GetInstance.EnviaConsulta('select * from ' + TUtilsEntidade.ObterNomeDaTabela(Objeto) + ' where ' + TUtilsEntidade.ObterChavePrimaria(Objeto) + ' = ' + IntToStr(Id));

  if DSet.IsEmpty then
  begin
    FreeAndNil(DSet);
    Exit(Objeto);
//    raise Exception.Create('Dados não encontrados. (PesquisarPorId)');
  end;

  try
    TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
  finally
    FreeAndNil(DSet);
  end;

  Result := T(Objeto);
end;

end.

