unit Utils.Entidade;

interface

uses
  Generics.Collections, Rtti, Classes, Attributes.Entidades, System.SysUtils, Data.DB,
  Connection.Controller.SqLite, Utils.Enumerators, Componente.TObjectList,
  Attributes.Enumerators, System.TypInfo, Data.DBXJSON, Data.DBXJSONReflect,
  System.JSON, Vcl.StdCtrls;

type
  TUtilsEntidade = class
  private
    class function GetEnumerator(Prop: TRttiProperty; Obj: TObject; Valor: Variant): TValue; overload; static;
    class function GetEnumerator(Field: TRttiField; Obj: TObject; Valor: Variant): TValue; overload; static;
    class function GetValueEnumerator(Prop: TRttiProperty; Obj: TObject): TValue; overload; static;
    class function GetValueEnumerator(Field: TRttiField; Obj: TObject): TValue; overload; static;
  public
    class function ObterCloneObjeto(ObjetoClone: TObject): TObject;
    class function ObterObjetoGenerico<T>: T;
    class function ObterNomeDaTabela(Classe: TPersistentClass): string; overload;
    class function ObterNomeDaTabela(Objeto: TObject): string; overload;
    class function ObterChavePrimaria(Objeto: TObject): string;

    class function ExecutarMetodoObjeto(Objeto: TObject; NomeMetodo: string;
      ParametrosDoMetodo: array of TValue): TValue;
    class function ExecutarMetodoClasse(Classe: TClass; NomeMetodo: string;
      ParametrosDoMetodo: array of TValue): TValue;

    class procedure SetarValorParaField(Objeto: TObject; NomePropriedade: string; Valor: TValue);
    class procedure SetarValorParaPropriedade(Objeto: TObject; NomePropriedade: string; Valor: TValue);
    class function ObterValorPropriedade(Obj: TObject; cNomePropriedade: string): TValue;
    class function ObterValorField(Obj: TObject; cNomePropriedade: string): TValue;
    class function ObterObjetoChaveEstrangeira(ObjPai: TObject; ClasseObjEstrangeiro: TPersistentClass): TObject;
    class function ObterListaComTabelaRelacional<T: class>(ID: Integer; CampoRelacionalProprio, CampoRelacionalTerceiro, TabelaIntermediaria: String;
         ClasseDestino: TPersistentClass): TObjectListFuck<T>;
    class function GetCaptionEnumerator(Prop: TRttiProperty; Obj: TObject): string; static;

    class procedure PreencheObjeto(var Obj: TObject; DSet: TDataSet);
    class procedure Limpar(Objeto: TObject);
    class procedure LimparEntidades(Objeto: TObject); static;
  end;

implementation

{ TUtilsEntidade }

class procedure TUtilsEntidade.SetarValorParaField(Objeto: TObject;
  NomePropriedade: string; Valor: TValue);
begin
  var ctx := TRttiContext.Create;
  try
    var lType := ctx.GetType(Objeto.ClassType);
    var Field := lType.GetField(NomePropriedade);

    var Value: TValue;
    for var Atrib in Field.GetAttributes do
    begin
      if Atrib is TCampoListagem then
      begin
        Field.SetValue(Objeto, Valor);
        Exit;
      end;
    end;

    if Field.FieldType.TypeKind = tkEnumeration then
    begin
      Value := GetEnumerator(Field,Objeto,Valor.AsVariant);
      Field.SetValue(Objeto,Value);
      Exit;
    end;

    case Field.FieldType.TypeKind of
      tkInteger:
        Value := Valor.AsInteger;
      tkFloat:
        Value := Valor.AsCurrency;
      tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
        Value := Valor.AsString;
      tkClass:
        Value := Valor.AsObject;
    end;

    Field.SetValue(Objeto, Value);
  finally
    ctx.Free;
  end;
end;

class procedure TUtilsEntidade.SetarValorParaPropriedade(Objeto: TObject;
  NomePropriedade: string; Valor: TValue);
begin
  var ctx := TRttiContext.Create;
  try
    var lType := ctx.GetType(Objeto.ClassType);
    var prop := lType.GetProperty(NomePropriedade);

    var Value: TValue;
    for var Atrib in prop.GetAttributes do
    begin
      if Atrib is TCampoListagem then
      begin
        prop.SetValue(Objeto, Valor);
        Exit;
      end;
    end;

    if Prop.PropertyType.TypeKind = tkEnumeration then
    begin
      Value := GetEnumerator(Prop,Objeto,Valor.AsVariant);
      Prop.SetValue(Objeto,Value);
      Exit;
    end;

    case Prop.PropertyType.TypeKind of
      tkInteger:
        Value := Valor.AsInteger;
      tkFloat:
        Value := Valor.AsCurrency;
      tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
        Value := Valor.AsString;
      tkClass:
        Value := Valor.AsObject;
    end;

    prop.SetValue(Objeto, Value);
  finally
    ctx.Free;
  end;
end;

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
  DSetSelf := TConexao.GetInstance.EnviaConsulta('select * from ' + ObterNomeDaTabela(ObjPai) +
    ' where ' + ObterChavePrimaria(ObjPai) + ' = ' + IntToStr(ObterValorPropriedade(ObjPai, 'ID').AsInteger));
  try
    ObjEstrangeiro := TObject(ClasseObjEstrangeiro.Create);

    cTabela := ObterNomeDaTabela(TObject(ObjEstrangeiro));
    cPK := ObterChavePrimaria(TObject(ObjEstrangeiro));
    DSetEstrangeiro := TConexao.GetInstance.EnviaConsulta('select * from ' + cTabela +
      ' where ' + cPK + ' = ' + IntToStr(DSetSelf.FieldByName(cTabela + '_FK').AsInteger));
    try
      if DSetEstrangeiro.IsEmpty then
      begin
        ObjEstrangeiro.Free;
        Exit(nil);
      end;

      PreencheObjeto(ObjEstrangeiro, DSetEstrangeiro);
      Result := ObjEstrangeiro;
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

class function TUtilsEntidade.ObterListaComTabelaRelacional<T>(ID: Integer;
  CampoRelacionalProprio, CampoRelacionalTerceiro, TabelaIntermediaria: String;
  ClasseDestino: TPersistentClass): TObjectListFuck<T>;
var
  ListObj: TObjectListFuck<T>;
Begin
  const ctSelect = 'select TAB1.* from %s TAB1 inner join %s TAB2 on TAB2.%s = TAB1.ID where TAB2.%s = %d';
  var sql := Format(ctSelect, [TUtilsEntidade.ObterNomeDaTabela(ClasseDestino),
    TabelaIntermediaria, CampoRelacionalTerceiro, CampoRelacionalProprio, ID]);

  ListObj := TObjectListFuck<T>.Create;
  var DSet := TConexao.GetInstance.EnviaConsulta(sql);
  try
    if DSet.IsEmpty then
    begin
      ListObj.Free;
      Exit(nil);
    end;

    DSet.First;
    while not DSet.Eof do
    begin
      var Objeto := TUtilsEntidade.ObterObjetoGenerico<T>;
      TUtilsEntidade.PreencheObjeto(TObject(Objeto), DSet);
      ListObj.Add(Objeto);
//            Banco.IncluirNaCache(TObject(Objeto));

      DSet.Next;
    end;
  finally
    DSet.Close;
    FreeAndNil(DSet);
  end;

  Result := ListObj;
end;

class function TUtilsEntidade.ObterNomeDaTabela(Classe: TPersistentClass): string;
begin
  Result := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Classe);
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

class function TUtilsEntidade.ObterNomeDaTabela(Objeto: TObject): string;
begin
  Result := TUtilsEntidade.ObterNomeDaTabela(TPersistentClass(Objeto.ClassType));
end;

class function TUtilsEntidade.GetEnumerator(Field: TRttiField; Obj: TObject;
  Valor: Variant): TValue;
begin
  Result := TValue.From(0);

  for var CustomAttribute in Field.FieldType.GetAttributes do
  begin
    if CustomAttribute is TEnumAttribute then
      if TEnumAttribute(CustomAttribute).Value = Valor then
      begin
        var Value := Field.GetValue(Obj);
        Result := TValue.FromOrdinal(Value.TypeInfo, TEnumAttribute(CustomAttribute).Indice);
        Break;
      end;
  end;
end;

class function TUtilsEntidade.GetValueEnumerator(Field: TRttiField;
  Obj: TObject): TValue;
var
  Ctx: TRttiContext;
  CustomAttribute: TCustomAttribute;
begin
  Result := TValue.From(0);
  Ctx := TRttiContext.Create;
  try
    var Enum := Field.GetValue(Obj);
    for CustomAttribute in Field.FieldType.GetAttributes do
    begin
      if CustomAttribute is TEnumAttribute then
        if TEnumAttribute(CustomAttribute).Indice = Enum.AsOrdinal then
        begin
          Result := TValue.From(TEnumAttribute(CustomAttribute).Value);
          Break;
        end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.GetValueEnumerator(Prop: TRttiProperty; Obj: TObject): TValue;
var
  CustomAttribute: TCustomAttribute;
begin
  Result := TValue.From(0);

  var Enum := Prop.GetValue(Obj);
  for CustomAttribute in Prop.PropertyType.GetAttributes do
  begin
    if CustomAttribute is TEnumAttribute then
      if TEnumAttribute(CustomAttribute).Indice = Enum.AsOrdinal then
      begin
        Result := TValue.From(TEnumAttribute(CustomAttribute).Value);
        Break;
      end;
  end;
end;

class function TUtilsEntidade.GetCaptionEnumerator(Prop: TRttiProperty; Obj: TObject): string;
var
  CustomAttribute: TCustomAttribute;
begin
  Result := EmptyStr;

  var Enum := Prop.GetValue(Obj);
  for CustomAttribute in Prop.PropertyType.GetAttributes do
  begin
    if CustomAttribute is TEnumAttribute then
      if TEnumAttribute(CustomAttribute).Indice = Enum.AsOrdinal then
      begin
        Result := TEnumAttribute(CustomAttribute).Caption;
        Break;
      end;
  end;
end;

class function TUtilsEntidade.ObterValorField(Obj: TObject;
  cNomePropriedade: string): TValue;
var
  Ctx: TRttiContext;
  Tipo: TRTTIType;
begin
  Result := EmptyStr;
  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(Obj.ClassType);
    if not Assigned(Tipo) then
      Exit;

    var field := Tipo.GetField(cNomePropriedade);

    for var Atrib in field.GetAttributes do
    begin
      if Atrib is TCampoListagem then
        Exit(TValue.From(TObjectListFuck<TObject>(field.GetValue(Obj).AsObject)))
    end;

    if field.FieldType.TypeKind = tkEnumeration then
    begin
      var Value := GetValueEnumerator(field, Obj);
      Exit(Value);
    end;

    case field.FieldType.TypeKind of
      tkInteger:
        Exit(TValue.FromVariant(field.GetValue(Obj).AsInteger));
      tkFloat:
        Exit(TValue.FromVariant(field.GetValue(Obj).AsCurrency));
      tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
        Exit(TValue.FromVariant(field.GetValue(Obj).AsString));
    end;
    Result := field.GetValue(Obj);
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterValorPropriedade(Obj: TObject; cNomePropriedade: String): TValue;
var
  Ctx: TRttiContext;
  Tipo: TRTTIType;
begin
  Result := EmptyStr;
  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(Obj.ClassType);
    if not Assigned(Tipo) then
      Exit;

    var prop := Tipo.GetProperty(cNomePropriedade);

    for var Atrib in prop.GetAttributes do
    begin
      if Atrib is TCampoListagem then
        Exit(TValue.From(TObjectListFuck<TObject>(Prop.GetValue(Obj).AsObject)))
    end;

    if Prop.PropertyType.TypeKind = tkEnumeration then
    begin
      var Value := GetValueEnumerator(Prop, Obj);
      Exit(Value);
    end;

    case Prop.PropertyType.TypeKind of
      tkInteger:
        Exit(TValue.FromVariant(Prop.GetValue(Obj).AsInteger));
      tkFloat:
        Exit(TValue.FromVariant(Prop.GetValue(Obj).AsCurrency));
      tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
        Exit(TValue.FromVariant(Prop.GetValue(Obj).AsString));
    end;
    Result := Prop.GetValue(Obj);
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.GetEnumerator(Prop: TRttiProperty; Obj: TObject; Valor: Variant): TValue;
begin
  Result := TValue.From(0);

  for var CustomAttribute in Prop.PropertyType.GetAttributes do
  begin
    if CustomAttribute is TEnumAttribute then
      if TEnumAttribute(CustomAttribute).Value = Valor then
      begin
        var Value := Prop.GetValue(Obj);
        Result := TValue.FromOrdinal(Value.TypeInfo, TEnumAttribute(CustomAttribute).Indice);
        Break;
      end;
  end;
end;

class procedure TUtilsEntidade.PreencheObjeto(var Obj: TObject; DSet: TDataSet);
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
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
            if Prop.PropertyType.TypeKind = tkEnumeration then
            begin
              if DSet.FieldByName(TAtributoBanco(Atrib).nome).IsNull then
                Continue;

              var Value: TValue;
              case TAtributoBanco(Atrib).Tipo of
                ftINTEIRO:
                  Value := GetEnumerator(Prop,Obj,DSet.FieldByName(TAtributoBanco(Atrib).nome).AsInteger);
                ftTEXTO:
                  Value := GetEnumerator(Prop,Obj,DSet.FieldByName(TAtributoBanco(Atrib).nome).AsString);
                ftLOGICO:
                  Value := GetEnumerator(Prop,Obj,DSet.FieldByName(TAtributoBanco(Atrib).nome).AsBoolean);
              end;
              Prop.SetValue(Obj,Value);
              Continue;
            end;

            case Prop.PropertyType.TypeKind of
              tkInteger:
                Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsInteger);
              tkFloat:
                begin
                  if  TAtributoBanco(Atrib).Tipo = ftDATA then
                  begin
                    if not DSet.FieldByName(TAtributoBanco(Atrib).nome).IsNull then
                      Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsDateTime);
                    Continue;
                  end;

                  Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsFloat);
                end;
              tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
                Prop.SetValue(Obj, DSet.FieldByName(TAtributoBanco(Atrib).nome).AsString);
              tkVariant:
                Prop.SetValue(Obj, TValue.From(DSet.FieldByName(TAtributoBanco(Atrib).nome).AsVariant));
            end;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
End;

class procedure TUtilsEntidade.Limpar(Objeto: TObject);
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Tipo: TRTTIType;
begin
  Ctx := TRttiContext.Create;
  Tipo := Ctx.GetType(Objeto.ClassType);

  try
    if Tipo <> Nil then
    begin
      for Prop in Tipo.GetDeclaredProperties do
      begin
        case Prop.PropertyType.TypeKind of
          tkClass:
            begin
              var Obj := Prop.GetValue(Objeto).AsObject;
              if Assigned(Obj) then
                Obj.Free;
            end;
          tkInteger, tkFloat:
            Prop.SetValue(Objeto, 0);
          tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
            Prop.SetValue(Objeto, EmptyStr);
          tkVariant:
            Prop.SetValue(Objeto, EmptyStr);
          tkEnumeration:
            begin
              var Value := TValue.FromOrdinal(Prop.GetValue(Objeto).TypeInfo, 0);
              Prop.SetValue(Objeto, Value);
            end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class procedure TUtilsEntidade.LimparEntidades(Objeto: TObject);
begin
  if not Assigned(Objeto) then
    Exit;

  var Ctx := TRttiContext.Create;
  var Tipo := Ctx.GetType(Objeto.ClassType);

  try
    if Assigned(Tipo) then
    begin
      for var Prop in Tipo.GetDeclaredProperties do
      begin
        case Prop.PropertyType.TypeKind of
          tkClass:
          begin
            var Obj := Prop.GetValue(Objeto).AsObject;
            if Assigned(Obj) then
              Obj.Free;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TUtilsEntidade.ObterCloneObjeto(ObjetoClone: TObject): TObject;
var
  MarshalObj: TJSONMarshal;
  UnMarshalObj: TJSONUnMarshal;
  JSONValue: TJSONValue;
begin
  Result:= nil;
  MarshalObj := TJSONMarshal.Create;
  UnMarshalObj := TJSONUnMarshal.Create;
  try
    JSONValue := MarshalObj.Marshal(ObjetoClone);
    try
      if Assigned(JSONValue) then
        Result:= UnMarshalObj.Unmarshal(JSONValue);
    finally
      JSONValue.Free;
    end;
  finally
    MarshalObj.Free;
    UnMarshalObj.Free;
  end;
end;

end.
