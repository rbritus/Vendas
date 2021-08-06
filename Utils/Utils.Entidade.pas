unit Utils.Entidade;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades, System.SysUtils, Data.DB,
  Connection.Controller.SqLite, Utils.Enumerators;

type
  TUtilsEntidade = class
  public
    class function ObterObjetoGenerico<T>: T;
    class function ObterNomeDaTabela(Objeto: TObject): string;
    class function ObterChavePrimaria(Objeto: TObject): string;

    class function ExecutarMetodoObjeto(Objeto: TObject; NomeMetodo: string;
      ParametrosDoMetodo: array of TValue): TValue;
    class function ExecutarMetodoClasse(Classe: TClass; NomeMetodo: string;
      ParametrosDoMetodo: array of TValue): TValue;

    class procedure SetarValorParaPropriedade(Objeto: TObject; NomePropriedade:
      string; Valor: TValue);
    class function ObterValorPropriedade(Obj: TObject; cNomePropriedade: string): Variant;
    class function ObterObjetoChaveEstrangeira(ObjPai: TObject;
      ClasseObjEstrangeiro: TPersistentClass): TObject;

    class procedure PreencheObjeto(var Obj: TObject; DSet: TDataSet);
    class procedure Limpar(Objeto: TObject);
  end;

implementation

{ TUtilsEntidade }

class function TUtilsEntidade.ObterObjetoGenerico<T>: T;
var
  AValue: TValue;
  ctx: TRttiContext;
  rType: TRttiType;
  AMethCreate: TRttiMethod;
  instanceType: TRttiInstanceType;
begin
  ctx := TRttiContext.Create;
  rType := ctx.GetType(TypeInfo(T));
  for AMethCreate in rType.GetMethods do
  begin
    if (AMethCreate.IsConstructor) and (Length(AMethCreate.GetParameters) = 0) then
    begin
      instanceType := rType.AsInstance;
      AValue := AMethCreate.Invoke(instanceType.MetaclassType, []);
      Result := AValue.AsType<T>;

      Exit;
    end;
  end;
end;

class function TUtilsEntidade.ExecutarMetodoClasse(Classe: TClass; NomeMetodo: string;
  ParametrosDoMetodo: array of TValue): TValue;
var
  ctx: TRttiContext;
  lType: TRttiType;
  lMethod: TRttiMethod;
begin
  ctx := TRttiContext.Create;
  lType := ctx.GetType(Classe);
  Result := nil;
  try
    if Assigned(lType) then
    begin
      lMethod := lType.GetMethod(NomeMetodo);

      if Assigned(lMethod) then
        Result := lMethod.Invoke(Classe, ParametrosDoMetodo);

      lMethod.Free;
    end;
  finally
    ctx.Free;
  end;
end;

class function TUtilsEntidade.ExecutarMetodoObjeto(Objeto: TObject;
  NomeMetodo: string; ParametrosDoMetodo: array of TValue): TValue;
var
  ctx: TRttiContext;
  lType: TRttiType;
  lMethod: TRttiMethod;
begin
  ctx := TRttiContext.Create;
  lType := ctx.GetType(Objeto.ClassType);
  Result := nil;
  try
    if Assigned(lType) then
    begin
      lMethod := lType.GetMethod(NomeMetodo);

      if Assigned(lMethod) then
        Result := lMethod.Invoke(Objeto, ParametrosDoMetodo);

      lMethod.Free;
    end;
  finally
    ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterObjetoChaveEstrangeira(ObjPai: TObject;
   ClasseObjEstrangeiro: TPersistentClass): TObject;
var
  ObjEstrangeiro: TObject;
  DSetSelf, DSetEstrangeiro: TDataSet;
  cTabela: string;
  cPK: string;
begin
  try
    DSetSelf := TConexao.GetInstance.EnviaConsulta('select * from ' + ObterNomeDaTabela(ObjPai) + ' where ' + ObterChavePrimaria(ObjPai) + ' = ' + IntToStr(ObterValorPropriedade(ObjPai, 'ID')));

    ObjEstrangeiro := TObject(ClasseObjEstrangeiro.Create);

    cTabela := ObterNomeDaTabela(TObject(ObjEstrangeiro));
    cPK := ObterChavePrimaria(TObject(ObjEstrangeiro));
    DSetEstrangeiro := TConexao.GetInstance.EnviaConsulta('select * from ' + cTabela + ' where ' + cPK + ' = ' + IntToStr(DSetSelf.FieldByName(cTabela + '_FK').AsInteger));
    try
      if DSetEstrangeiro.IsEmpty then
        Result := Nil
      else
      begin
        PreencheObjeto(ObjEstrangeiro, DSetEstrangeiro);
        Result := ObjEstrangeiro;
      end;
    finally
      FreeAndNil(DSetEstrangeiro);
    end;

  finally
    FreeAndNil(DSetSelf);
  end;
end;

class function TUtilsEntidade.ObterChavePrimaria(Objeto: TObject): string;
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
begin
  Result := EmptyStr;
  Ctx := TRttiContext.Create;
  Tipo := Ctx.GetType(Objeto.ClassType);

  try
    if Tipo <> Nil then
    begin
      for Prop in Tipo.GetDeclaredProperties do
      begin
        for Atrib in Prop.GetAttributes do
        begin
          if Atrib is TAtributoBanco then
          begin
            if CHAVE_PRIMARIA in TAtributoBanco(Atrib).propriedades then
            begin
              Result := Trim(TAtributoBanco(Atrib).nome);
              Break;
            end;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterNomeDaTabela(Objeto: TObject): string;
begin
  Result := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Objeto.ClassType);
    if Tipo <> Nil then
    begin
      for var Atrib in Tipo.GetAttributes do
      begin
        if Atrib is TNomeTabela then
        begin
          Result := Trim(TNomeTabela(Atrib).Nome);
          Break;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterValorPropriedade(Obj: TObject;
  cNomePropriedade: String): Variant;
var
  Ctx: TRttiContext;
  Tipo: TRTTIType;
begin
  Result := EmptyStr;
  Ctx := TRttiContext.Create;
  Tipo := Ctx.GetType(FindClass(Obj.ClassName));

  try
    if Tipo <> Nil then
      Result := Tipo.GetProperty(cNomePropriedade).GetValue(Obj).AsVariant;
  finally
    Ctx.Free;
  end;
end;

class procedure TUtilsEntidade.PreencheObjeto(var Obj: TObject; DSet: TDataSet);
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
  MemoStream: TMemoryStream;
begin
  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(FindClass(Obj.ClassName));
    if Tipo <> Nil then
    begin
      for Prop in Tipo.GetDeclaredProperties do
      begin
        for Atrib in Prop.GetAttributes do
        begin
          if Atrib is TAtributoBanco then
          begin
            case TAtributoBanco(Atrib).Tipo of
              ftINTEIRO:
                Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsInteger);
              ftDECIMAL:
                Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsFloat);
              ftTEXTO:
                Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsString);
              ftDATA:
                begin
                  if not DSet.FieldByName(TAtributoBanco(Atrib).nome).IsNull then
                    Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsDateTime);
                end;
              ftLOGICO:
                Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsBoolean);
              ftBLOBT:
                begin
                  MemoStream := TMemoryStream.Create;
                  (DSet.FieldByName(TAtributoBanco(Atrib).nome) as TBlobField).SaveToStream(MemoStream);
                  Prop.SetValue(Obj, MemoStream);
                end;
            end;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
End;

class procedure TUtilsEntidade.SetarValorParaPropriedade(Objeto: TObject;
  NomePropriedade: string; Valor: TValue);
var
  ctx: TRttiContext;
  lType: TRttiType;
  prop: TRttiProperty;
begin
  ctx := TRttiContext.Create;
  try
    lType := ctx.GetType(Objeto.ClassType);
    prop := lType.GetProperty(NomePropriedade);
    prop.SetValue(Objeto, Valor);
  finally
    ctx.Free;
  end;
end;

class procedure TUtilsEntidade.Limpar(Objeto: TObject);
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
begin
  Ctx := TRttiContext.Create;
  Tipo := Ctx.GetType(Objeto.ClassType);

  try
    if Tipo <> Nil then
    begin
      for Prop in Tipo.GetDeclaredProperties do
      begin
        for Atrib in Prop.GetAttributes do
        begin
          if Atrib is TAtributoBanco then
          begin
            case TAtributoBanco(Atrib).Tipo of
              ftINTEIRO, ftDECIMAL, ftDATA:
                Prop.SetValue(Objeto, 0);
              ftTEXTO:
                Prop.SetValue(Objeto, EmptyStr);
              ftLOGICO:
                Prop.SetValue(Objeto, False);
              ftBLOBT, ftESTRANGEIRO, ftLISTAGEM:
                Prop.SetValue(Objeto, nil);
            else
              Prop.SetValue(Objeto, EmptyStr);
            end;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

end.
