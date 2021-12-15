unit Utils.ClientDataSet;

interface

uses
  Datasnap.DBClient, Data.DB, System.Classes, Attributes.Entidades, System.Rtti,
  Objeto.CustomSelect, Utils.Enumerators, System.SysUtils, Utils.Entidade;

type
  TUtilsClientDataSet = class
  private
//    class procedure CriarFieldDescricaoConsultaDoCampoEstrangeiro(
//      cds: TClientDataSet; ObjEstrangeiro: TObject; cNomeDescricaoConsulta: String); static;
  public
    class procedure PrepararClientDataSet(cds: TClientDataSet);
    class procedure CreateField(cds: TClientDataSet; Nome: string;Tipo: TFieldType); overload;
    class procedure CreateField(cds: TClientDataSet; Nome: string;Tipo: TFieldType; Tamanho: Integer); overload;
    class procedure CreateFielsdByEntidade(cds: TClientDataSet; Entidade: TObject);
    class procedure ConcluirClientDataSet(cds: TClientDataSet; Entidade: TObject);
    class procedure AlterarPropriedadeCaptionEVisibleDoField(cds: TClientDataSet; Entidade: TObject);
    class procedure PreencherDataSet(cds: TClientDataSet; Entidade: TObject);
  end;

implementation

{ TUtilsClientDataSet }

class procedure TUtilsClientDataSet.ConcluirClientDataSet(cds: TClientDataSet; Entidade: TObject);
begin
  cds.CreateDataSet;
  TUtilsClientDataSet.AlterarPropriedadeCaptionEVisibleDoField(cds,Entidade);
end;

class procedure TUtilsClientDataSet.CreateField(cds: TClientDataSet;
  Nome: string; Tipo: TFieldType);
begin
  cds.FieldDefs.add(Nome,Tipo);
end;

class procedure TUtilsClientDataSet.CreateField(cds: TClientDataSet;
  Nome: string; Tipo: TFieldType; Tamanho: Integer);
begin
  cds.FieldDefs.add(Nome,Tipo,Tamanho);
end;

//class procedure TUtilsClientDataSet.CriarFieldDescricaoConsultaDoCampoEstrangeiro(
//  cds: TClientDataSet; ObjEstrangeiro: TObject; cNomeDescricaoConsulta: String);
//begin
//  var Ctx := TRttiContext.Create;
//  try
//    var Tipo := Ctx.GetType(FindClass(ObjEstrangeiro.ClassName));
//    if not Assigned(Tipo) then
//      Exit;
//
//    var prop := Tipo.GetProperty(cNomeDescricaoConsulta);
//
//    for var Atrib in prop.GetAttributes do
//    begin
//      if Atrib is TAtributoBanco then
//      begin
//        case TAtributoBanco(Atrib).Tipo of
//          ftINTEIRO:
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftInteger);
//          ftDECIMAL:
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftCurrency);
//          ftTEXTO:
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftString, TCampoTexto(Atrib).tamanho);
//          ftDATA:
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftDate);
//          ftLOGICO:
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftBoolean);
//          ftBLOBT:
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftBlob);
//          ftESTRANGEIRO:
//          begin
//            TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftInteger);
////            TUtilsClientDataSet.CriarFieldDescricaoConsultaDoCampoEstrangeiro(cds,
////              Prop.GetValue(ObjEstrangeiro).AsType<TObject>,TCampoEstrangeiro(Atrib).CampoDescricaoConsulta);
//          end;
//        end;
//      end;
//    end;
//  finally
//    Ctx.Free;
//  end;
//end;

class procedure TUtilsClientDataSet.CreateFielsdByEntidade(cds: TClientDataSet;
  Entidade: TObject);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(FindClass(Entidade.ClassName));
    if Tipo <> Nil then
    begin
      for var Prop in Tipo.GetProperties do
      begin
        for var Atrib in Prop.GetAttributes do
        begin
          if Atrib is TAtributoBanco then
          begin
            case TAtributoBanco(Atrib).Tipo of
              ftINTEIRO:
                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftInteger);
              ftDECIMAL:
                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftCurrency);
              ftTEXTO, ftESTRANGEIRO:
                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftString, TCampoTexto(Atrib).tamanho);
              ftDATA:
                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftDate);
              ftLOGICO:
                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftBoolean);
              ftBLOBT:
                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftBlob);
//              ftESTRANGEIRO:
//              begin
//                TUtilsClientDataSet.CreateField(cds,TAtributoBanco(Atrib).nome,ftString);
////                ObjEstrangeiro := TObject(Prop.GetValue(Entidade).AsInterface);
////                TUtilsClientDataSet.CriarFieldDescricaoConsultaDoCampoEstrangeiro(cds,
////                  ObjEstrangeiro  ,TCampoEstrangeiro(Atrib).CampoDescricaoConsulta);
//              end;
            end;
          end;

          if Prop.PropertyType.TypeKind = tkEnumeration then
          begin
            var CustomName := TCustomSelect.getFieldNameCustom(TAtributoBanco(Atrib).nome);
            TUtilsClientDataSet.CreateField(cds,CustomName,ftString, 50);
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class procedure TUtilsClientDataSet.PreencherDataSet(cds: TClientDataSet;
  Entidade: TObject);
begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Entidade.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var Prop in Tipo.GetProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if Atrib is TAtributoBanco then
        begin
          if cds.FindField(TAtributoBanco(Atrib).nome) = nil then
            Continue;

          case Prop.PropertyType.TypeKind of
            tkEnumeration:
              cds.FieldByName(TAtributoBanco(Atrib).nome).AsVariant := TUtilsEntidade.ObterValorPropriedade(Entidade,Prop.Name).AsVariant;
            tkClass:
              cds.FieldByName(TAtributoBanco(Atrib).nome).AsString := TUtilsEntidade.ObterValorPropriedade(Prop.GetValue(Entidade).AsType<TObject>, 'GUID').AsString;
            tkInterface:
              cds.FieldByName(TAtributoBanco(Atrib).nome).AsString := TUtilsEntidade.ObterValorPropriedade(TObject(Prop.GetValue(Entidade).AsInterface), 'GUID').AsString;
          else
            cds.FieldByName(TAtributoBanco(Atrib).nome).AsVariant := Prop.GetValue(Entidade).AsVariant;
          end;

          if Assigned(TAtributoBanco(Atrib).CustomSelect) then
          begin
            var NomeFieldCustom := TAtributoBanco(Atrib).CustomSelect.getFieldNameCustom(TAtributoBanco(Atrib).nome);

            if cds.FindField(NomeFieldCustom) = nil then
              Continue;

            cds.FieldByName(NomeFieldCustom).AsString := TUtilsEntidade.GetCaptionEnumerator(Prop, TObject(Entidade));
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

class procedure TUtilsClientDataSet.PrepararClientDataSet(cds: TClientDataSet);
begin
  if not cds.IsEmpty then
    cds.EmptyDataSet;
  cds.Close;
  cds.FieldDefs.Clear;
end;

class procedure TUtilsClientDataSet.AlterarPropriedadeCaptionEVisibleDoField(cds: TClientDataSet;
  Entidade: TObject);

  function ObterMascaraField(AProp: TRttiProperty): string;
  begin
    Result := string.Empty;
    for var AtribNew in AProp.GetAttributes do
    begin
      if AtribNew is TAtributoMascara then
        Result := TAtributoMascara(AtribNew).Mascara;
    end;
  end;

  procedure TratarCustomSelect(Atrib: TAtributoBanco);
  begin
    if not TAtributoBanco(Atrib).Visivel then
      Exit;

    var NomeFieldCustom := TAtributoBanco(Atrib).CustomSelect.getFieldNameCustom(TAtributoBanco(Atrib).nome);

    if cds.FindField(NomeFieldCustom) = nil then
      Exit;;

    cds.FieldByName(TAtributoBanco(Atrib).nome).DisplayLabel := TAtributoBanco(Atrib).nome;
    cds.FieldByName(TAtributoBanco(Atrib).nome).Visible := False;
    cds.FieldByName(NomeFieldCustom).DisplayLabel := TAtributoBanco(Atrib).caption;
    cds.FieldByName(NomeFieldCustom).Visible := True;
    cds.FieldByName(NomeFieldCustom).EditMask := cds.FieldByName(TAtributoBanco(Atrib).nome).EditMask;
  end;

  procedure TratarCampoEstrangeiro(Atrib: TAtributoBanco);
  begin
    var NomeCampoDescricao := TCampoEstrangeiro(Atrib).Tabela;
    if cds.FindField(NomeCampoDescricao) = nil then
      Exit;

    cds.FieldByName(TAtributoBanco(Atrib).nome).Visible := False;
    cds.FieldByName(NomeCampoDescricao).Visible := TAtributoBanco(Atrib).Visivel;
    cds.FieldByName(NomeCampoDescricao).EditMask := cds.FieldByName(TAtributoBanco(Atrib).nome).EditMask;
    cds.FieldByName(NomeCampoDescricao).DisplayLabel := TCampoEstrangeiro(Atrib).caption;
  end;

  procedure InformarMascaraAoField(Atrib: TAtributoBanco; AProp: TRttiProperty);
  begin
    var Mascara := ObterMascaraField(AProp);
    if Mascara.IsEmpty  then
      Exit;

    if Atrib.tipo in ([ftINTEIRO,ftDECIMAL,ftDATA]) then
      TNumericField(cds.FieldByName(Atrib.nome)).DisplayFormat := Mascara
    else
      TStringField(cds.FieldByName(Atrib.nome)).EditMask := Mascara;
  end;

begin
  var Ctx := TRttiContext.Create;
  try
    var Tipo := Ctx.GetType(Entidade.ClassType);
    if not Assigned(Tipo) then
      Exit;

    for var Prop in Tipo.GetProperties do
    begin
      for var Atrib in Prop.GetAttributes do
      begin
        if Atrib is TAtributoBanco then
        begin
          if cds.FindField(TAtributoBanco(Atrib).nome) = nil then
            Continue;

          cds.FieldByName(TAtributoBanco(Atrib).nome).DisplayLabel := TAtributoBanco(Atrib).caption;
          cds.FieldByName(TAtributoBanco(Atrib).nome).Visible := TAtributoBanco(Atrib).Visivel;
          InformarMascaraAoField(TAtributoBanco(Atrib),Prop);

          if Atrib is TCampoEstrangeiro then
            TratarCampoEstrangeiro(Atrib as TAtributoBanco);

          if Assigned(TAtributoBanco(Atrib).CustomSelect) then
            TratarCustomSelect(Atrib as TAtributoBanco);

        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

end.
