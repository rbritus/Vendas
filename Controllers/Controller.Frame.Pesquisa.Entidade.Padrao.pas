unit Controller.Frame.Pesquisa.Entidade.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Data.DB, RTTI, Vcl.Controls,
  Interfaces.Controller.Frame.Pesquisa.Entidade.Padrao, System.SysUtils;

type
  TControllerFrameAdicaoPadrao = class(TInterfacedObject, iControllerFramePesquisaEntidadePadrao)
  strict private
    FFrame: TFrame;
  private
    function ObterClasseDePesquisaDoFrame: TClass;
    function ObterCampoExibicao: string;
    function ObterCaptionDoCampoExibicao: string;
  protected
    constructor Create(pFrame: TFrame);
  public
    class function New(pFrame: TFrame): iControllerFramePesquisaEntidadePadrao;
    procedure ExibirListaDeRegistrosParaSelecao;
    function ObterValorDoCampoDeExibicao(ID: Integer): string;
    function ObterEntidade(ID: Integer): TObject;
  end;

implementation

uses
  View.Lista.Selecao.Entidade, Controller.View, Utils.Entidade, Attributes.Forms,
  Attributes.Entidades, Interfaces.Padrao.Observer;

{ TControllerFrameAdicaoPadrao }

constructor TControllerFrameAdicaoPadrao.Create(pFrame: TFrame);
begin
  FFrame := pFrame;
end;

procedure TControllerFrameAdicaoPadrao.ExibirListaDeRegistrosParaSelecao;
begin
  var Form : TForm := nil;
  ControllerView.AdicionarFormNalista(TFrmListaSelecaoEntidade, Form);
  Form.Caption := 'Selecionar ' + ObterCaptionDoCampoExibicao;
  var ClassePesquisa := ObterClasseDePesquisaDoFrame;
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'SetObservador',TValue.From<TWinControl>(FFrame));
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'InformarClasseDaEntidade',[ClassePesquisa]);
  ControllerView.ShowForm(TFrmListaSelecaoEntidade);
end;

class function TControllerFrameAdicaoPadrao.New(pFrame: TFrame): iControllerFramePesquisaEntidadePadrao;
begin
  Result := Self.Create(pFrame);
end;

function TControllerFrameAdicaoPadrao.ObterValorDoCampoDeExibicao(ID: Integer): string;
begin
  var Campo := ObterCampoExibicao;
  var Classe := ObterClasseDePesquisaDoFrame;
  var Obj := TUtilsEntidade.ExecutarMetodoClasse(Classe,'PesquisarPorId',[ID]).AsType<TObject>;

  if not Assigned(Obj) then
    Exit(EmptyStr);

  try
    Result := TUtilsEntidade.ObterValorPropriedade(Obj, Campo).AsString;
  finally
    Obj.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterClasseDePesquisaDoFrame: TClass;
begin
  Result := nil;
  var Ctx := TRttiContext.Create;
  try
    var SelfParent := FFrame.Owner;
    if not Assigned(SelfParent) then
      Exit(nil);

    var Tipo := Ctx.GetType(SelfParent.ClassType);
    if not Assigned(Tipo) then
      Exit(nil);

    var FField := Tipo.GetField(FFrame.Name);

    for var Atrib in FField.GetAttributes do
    begin
      if Atrib is TClassePesquisa then
      begin
        Result := TClass(TClassePesquisa(Atrib).Classe);
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterEntidade(ID: Integer): TObject;
begin
  var Classe := ObterClasseDePesquisaDoFrame;
  var Obj := TUtilsEntidade.ExecutarMetodoClasse(Classe,'PesquisarPorId',[ID]).AsType<TObject>;
  Result := Obj;
end;

function TControllerFrameAdicaoPadrao.ObterCampoExibicao: string;
begin
  Result := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var SelfParent := FFrame.Owner;
    if not Assigned(SelfParent) then
      Exit(EmptyStr);

    var Tipo := Ctx.GetType(SelfParent.ClassType);
    if not Assigned(Tipo) then
      Exit(EmptyStr);

    var FField := Tipo.GetField(FFrame.Name);

    for var Atrib in FField.GetAttributes do
    begin
      if Atrib is TCampoExibicao then
      begin
        Result := TCampoExibicao(Atrib).Campo;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

function TControllerFrameAdicaoPadrao.ObterCaptionDoCampoExibicao: string;
begin
  Result := EmptyStr;
  var Ctx := TRttiContext.Create;
  try
    var Campo := ObterCampoExibicao;
    var Classe := ObterClasseDePesquisaDoFrame;

    var Tipo := Ctx.GetType(Classe);
    if not Assigned(Tipo) then
      Exit(EmptyStr);

    var FProp := Tipo.GetProperty(Campo);
    for var Atrib in FProp.GetAttributes do
    begin
      if Atrib is TCampoTexto then
      begin
        Result := TCampoTexto(Atrib).caption;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

end.
