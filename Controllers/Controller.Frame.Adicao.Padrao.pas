unit Controller.Frame.Adicao.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Frame.Adicao.Padrao, Data.DB,
  RTTI, Componente.TObjectList, Attributes.Forms, Vcl.Controls;

type
  TControllerFrameAdicaoPadrao = class(TInterfacedObject, iControllerFrameAdicaoPadrao)
  strict private
    FFrame: TFrame;
    const JOIN = 'INNER JOIN %s ON(%s.ID = %s.%s)';
    const JOINLISTAGEM = 'INNER JOIN %s ON(%s.%S = %s.ID)';
    const WHERE = 'WHERE %s.ID = %d';
  private
    FIdObjRelacional: Integer;
    FEntidadeFrame: TObject;
    FEntidadeRelacional: TObject;
    constructor Create(pFrame: TFrame);
    function ObterNomeDaTabela(Obj: TObject): string;
    function ObterObjetoDeClassRelacional: TObject;
    function ObterObjetoDoFormParent(SelfParent: TWinControl): TWinControl;
    function RelacionamentoPorCampoEstrangeiro: Boolean;
    function ObterSqlPorCampoEstrangeiro: string;
    function ObterCampoChaveEstrangeira: string;
    function RelacionamentoPorCampoListagem: Boolean;
    function ObterSqlPorCampoListagem: string;
    function ObterCondicaoWhere: string;
    procedure RelacionamentoCondicionaisPorCampoListagem(var TabelaRelacional,
      CampoObjPrimario, CampoObjFrame: string);
    function ObterListaDeObjetosDaEntidadeRelacional: TObjectListFuck<TObject>;
  public
    class function New(pFrame: TFrame): iControllerFrameAdicaoPadrao;

    procedure ApresentarFormParaCadastro;
    procedure ApresentarFormParaEdicao(ID: Integer);
    function CarregarDataSet(pSql: string): TDataSet;
    function ObterSqlDeTabelaRelacional(pIdObjetoRelacional: Integer): string;
    procedure ObterListaPreenchidaDoFrame(cds: TDataSet; var Lista: TObjectListFuck<TObject>);
    function CarregarListaDeObjetosParaFrame(pIdObjetoRelacional: Integer): TObjectListFuck<TObject>;
    function ObterObjetoDoFrame: TObject;
    function ObterClasseDaEntidadeDeCadastro: TClass;
  end;

implementation

uses
  Utils.Entidade, Attributes.Entidades, Connection.Controller.SqLite,
  System.SysUtils, Utils.Frame, Controller.View;

{ TControllerFrameAdicaoPadrao }

function TControllerFrameAdicaoPadrao.ObterSqlDeTabelaRelacional(pIdObjetoRelacional: Integer): string;
begin
  Result := EmptyStr;
  FEntidadeFrame := ObterObjetoDoFrame;
  FEntidadeRelacional := ObterObjetoDeClassRelacional;
  FIdObjRelacional := pIdObjetoRelacional;
  var cSql: string;
  try
    if RelacionamentoPorCampoEstrangeiro then
      Exit(ObterSqlPorCampoEstrangeiro);

    if RelacionamentoPorCampoListagem then
      Exit(ObterSqlPorCampoListagem);
  finally
    FEntidadeFrame.Free;
    FEntidadeRelacional.Free;
  end;
end;

procedure TControllerFrameAdicaoPadrao.RelacionamentoCondicionaisPorCampoListagem(var TabelaRelacional: string;
  var CampoObjPrimario: string; var CampoObjFrame: string);
begin
  var TabelaObjPrimario := ObterNomeDaTabela(FEntidadeRelacional);
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);
  var Ctx := TRttiContext.Create;
  var Tipo := Ctx.GetType(FEntidadeRelacional.ClassType);
  try
    if Assigned(Tipo) then
      for var Prop in Tipo.GetDeclaredProperties do
        for var Atrib in Prop.GetAttributes do
          if Atrib is TCampoListagem then
          begin
            case TCampoListagem(Atrib).TipoAssociacao of
              taManyToMany:
                begin
                  if (TCampoListagem(Atrib).CampoPai = TabelaObjPrimario + '_FK') and
                    (TCampoListagem(Atrib).CampoFilho = TabelaObjFrame + '_FK') then
                  begin
                    TabelaRelacional := TCampoListagem(Atrib).TabelaRelacional;
                    CampoObjPrimario := TCampoListagem(Atrib).CampoPai;
                    CampoObjFrame := TCampoListagem(Atrib).CampoFilho;
                    Break;
                  end;
                end
            else
               if (TCampoListagem(Atrib).TabelaRelacional = TabelaObjFrame) then
                begin
                  TabelaRelacional := TCampoListagem(Atrib).TabelaRelacional;
                  CampoObjPrimario := TCampoListagem(Atrib).CampoPai;
                  CampoObjFrame := TCampoListagem(Atrib).CampoFilho;
                  Break;
                end;
            end;
          end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterCondicaoWhere: string;
begin
  var TabelaObjPrimario := ObterNomeDaTabela(FEntidadeRelacional);
  var cSql := Format(WHERE,[TabelaObjPrimario,FIdObjRelacional]);
  Result := cSql;
end;

procedure TControllerFrameAdicaoPadrao.ObterListaPreenchidaDoFrame(cds: TDataSet;
  var Lista: TObjectListFuck<TObject>);
begin
  cds.First;
  while not cds.Eof do
  begin
    var Objeto := ObterObjetoDoFrame;

    TUtilsEntidade.PreencheObjeto(TObject(Objeto), cds);
    Lista.Add(Objeto);

    cds.Next;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterSqlPorCampoListagem: string;
begin
  var TabelaObjPrimario := ObterNomeDaTabela(FEntidadeRelacional);
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);

  var TabelaRelacional := EmptyStr;
  var ChaveRelacionalObjPrimario := EmptyStr;
  var ChaveRelacionalObjFrame := EmptyStr;

  RelacionamentoCondicionaisPorCampoListagem(TabelaRelacional,ChaveRelacionalObjPrimario,ChaveRelacionalObjFrame);

  var cSql := Format(JOINLISTAGEM,[TabelaRelacional,TabelaRelacional,ChaveRelacionalObjFrame,TabelaObjFrame]) + ' ';
  cSql := cSql + Format(JOIN,[TabelaObjPrimario,TabelaObjPrimario,TabelaRelacional,ChaveRelacionalObjPrimario]);
  cSql := cSql + ' ' + ObterCondicaoWhere;

  Result := cSql;
end;

function TControllerFrameAdicaoPadrao.RelacionamentoPorCampoListagem: Boolean;
begin
  Result := False;
  var TabelaObjPrimario := ObterNomeDaTabela(FEntidadeRelacional);
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);
  var Ctx := TRttiContext.Create;
  var Tipo := Ctx.GetType(FEntidadeRelacional.ClassType);
  try
    if Assigned(Tipo) then
      for var Prop in Tipo.GetDeclaredProperties do
        for var Atrib in Prop.GetAttributes do
          if Atrib is TCampoListagem then
          begin
            case TCampoListagem(Atrib).TipoAssociacao of
              taManyToMany:
                begin
                  if (TCampoListagem(Atrib).CampoPai = TabelaObjPrimario + '_FK') and
                    (TCampoListagem(Atrib).CampoFilho = TabelaObjFrame + '_FK') then
                  begin
                    Result := True;
                    Break;
                  end;
                end
            else
               if (TCampoListagem(Atrib).TabelaRelacional = TabelaObjFrame) then
                begin
                  Result := True;
                  Break;
                end;
            end;
          end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterCampoChaveEstrangeira: string;
begin
  Result := EmptyStr;
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);
  var Ctx := TRttiContext.Create;
  var Tipo := Ctx.GetType(FEntidadeRelacional.ClassType);
  try
    if Assigned(Tipo) then
      for var Prop in Tipo.GetDeclaredProperties do
        for var Atrib in Prop.GetAttributes do
          if Atrib is TCampoEstrangeiro then
            if TCampoEstrangeiro(Atrib).caption = TabelaObjFrame then
            begin
              Result := TCampoEstrangeiro(Atrib).nome;
              Break;
            end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterClasseDaEntidadeDeCadastro: TClass;
begin
  Result := TUtilsFrame.ObterClasseDoObjetoDeCadastroDoFrame(FFrame);
end;

function TControllerFrameAdicaoPadrao.ObterSqlPorCampoEstrangeiro: string;
begin
  var TabelaObjPrimario := ObterNomeDaTabela(FEntidadeRelacional);
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);
  var ChaveEstrangeira := ObterCampoChaveEstrangeira;
  var cSql := Format(JOIN,[TabelaObjPrimario,TabelaObjPrimario,ChaveEstrangeira,TabelaObjFrame]);
  cSql := cSql + ' ' + ObterCondicaoWhere;
  Result := cSql;
end;

function TControllerFrameAdicaoPadrao.RelacionamentoPorCampoEstrangeiro: Boolean;
begin
  Result := False;
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);
  var Ctx := TRttiContext.Create;
  var Tipo := Ctx.GetType(FEntidadeRelacional.ClassType);
  try
    if Assigned(Tipo) then
      for var Prop in Tipo.GetDeclaredProperties do
        for var Atrib in Prop.GetAttributes do
          if Atrib is TCampoEstrangeiro then
            if TCampoEstrangeiro(Atrib).caption = TabelaObjFrame then
            begin
              Result := True;
              Break;
            end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterObjetoDoFormParent(SelfParent: TWinControl): TWinControl;
begin
  if SelfParent is TForm then
  begin
    Result := TWinControl(SelfParent);
    Exit;
  end;
  Result := ObterObjetoDoFormParent(SelfParent.Parent);
end;

function TControllerFrameAdicaoPadrao.ObterObjetoDeClassRelacional: TObject;
begin
  var Entidade: TObject := nil;
  var Ctx := TRttiContext.Create;
  try
    var SelfParent := ObterObjetoDoFormParent(FFrame.Parent);
    if not Assigned(SelfParent) then
      Exit(nil);

    var Tipo := Ctx.GetType(SelfParent.ClassType);
    if not Assigned(Tipo) then
      Exit(nil);

    for var Atrib in Tipo.GetAttributes do
    begin
      if Atrib is TClasseCadastro then
      begin
        Entidade := TUtilsEntidade.ExecutarMetodoClasse(TClasseCadastro(Atrib).Classe,'PesquisarPorId',[FIdObjRelacional]).AsObject;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
  Result := Entidade;
end;

function TControllerFrameAdicaoPadrao.ObterObjetoDoFrame: TObject;
begin
  Result := TUtilsFrame.ObterObjetoDeCadastroDoFrame(FFrame);
end;

function TControllerFrameAdicaoPadrao.ObterNomeDaTabela(Obj: TObject): string;
begin
  Result := TUtilsEntidade.ObterNomeDaTabela(Obj);
end;

function TControllerFrameAdicaoPadrao.CarregarDataSet(pSql: string): TDataSet;
begin
  var cds := TConexao.GetInstance.EnviaConsulta(pSql);
  Result := cds;
end;

function TControllerFrameAdicaoPadrao.ObterListaDeObjetosDaEntidadeRelacional: TObjectListFuck<TObject>;
begin
  Result := nil;
  var TabelaObjPrimario := ObterNomeDaTabela(FEntidadeRelacional);
  var TabelaObjFrame := ObterNomeDaTabela(FEntidadeFrame);
  var Ctx := TRttiContext.Create;
  var Tipo := Ctx.GetType(FEntidadeRelacional.ClassType);
  try
    if Assigned(Tipo) then
      for var Prop in Tipo.GetDeclaredProperties do
        for var Atrib in Prop.GetAttributes do
          if Atrib is TCampoListagem then
          begin
            case TCampoListagem(Atrib).TipoAssociacao of
              taManyToMany:
                begin
                  if (TCampoListagem(Atrib).CampoPai = TabelaObjPrimario + '_FK') and
                    (TCampoListagem(Atrib).CampoFilho = TabelaObjFrame + '_FK') then
                  begin
                    Result := TObjectListFuck<TObject>(Prop.GetValue(FEntidadeRelacional).AsObject);
                    Break;
                  end;
                end
            else
               if (TCampoListagem(Atrib).TabelaRelacional = TabelaObjFrame) then
                begin
                  Result := TObjectListFuck<TObject>(Prop.GetValue(FEntidadeRelacional).AsObject);
                  Break;
                end;
            end;
          end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.CarregarListaDeObjetosParaFrame(pIdObjetoRelacional: Integer): TObjectListFuck<TObject>;
begin
  FIdObjRelacional := pIdObjetoRelacional;
  FEntidadeFrame := ObterObjetoDoFrame;
  FEntidadeRelacional := ObterObjetoDeClassRelacional;
  try
    var ListaParaClone := ObterListaDeObjetosDaEntidadeRelacional;
    if not Assigned(ListaParaClone) then
      Exit(nil);

    var Lista := TObjectListFuck<TObject>.Create;
    Lista.CopyTo(ListaParaClone);
    Result := Lista;
  finally
    FEntidadeFrame.Free;
    FEntidadeRelacional.Free;
  end;
end;

procedure TControllerFrameAdicaoPadrao.ApresentarFormParaCadastro;
begin
  var ClasseForm := TUtilsFrame.ObterClasseDoFormularioCadastro(FFrame);
  var Form : TForm := nil;
  ControllerView.AdicionarFormNalista(TComponentClass(ClasseForm), Form);
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'CarregarFormParaCadastro',[]);
  ControllerView.ShowForm(TComponentClass(ClasseForm));
end;

procedure TControllerFrameAdicaoPadrao.ApresentarFormParaEdicao(ID: Integer);
begin
  var ClasseForm := TUtilsFrame.ObterClasseDoFormularioCadastro(FFrame);
  var Form : TForm := nil;
  ControllerView.AdicionarFormNalista(TComponentClass(ClasseForm), Form);
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'CarregarEntidadeParaEdicao',[ID]);
  ControllerView.ShowForm(TComponentClass(ClasseForm));
end;

constructor TControllerFrameAdicaoPadrao.Create(pFrame: TFrame);
begin
  FFrame := pFrame;
end;

class function TControllerFrameAdicaoPadrao.New(pFrame: TFrame): iControllerFrameAdicaoPadrao;
begin
  Result := Self.Create(pFrame);
end;

end.

