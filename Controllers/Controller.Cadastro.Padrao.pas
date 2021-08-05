unit Controller.Cadastro.Padrao;

interface

uses
  Vcl.Forms, System.Classes, Interfaces.Controller.Cadastro.Padrao;

type
  TControllerCadastroPadrao = class(TInterfacedObject, iControllerCadastroPadrao)
    FForm: TForm;
    FEntidade: TPersistent;
  private
    procedure ObterObjeto;
    procedure PreencherEntidadeComCamposDoForm;
    procedure Gravar;
    constructor Create(pForm: TForm);
    procedure DestruirEntidade;
  public
    procedure GravarEntidade;

    class function New(pForm: TForm): iControllerCadastroPadrao;
  end;

implementation

uses
  System.Rtti, Attributes.Forms, Utils.Entidade, Wrapper.PropriedadeCadastro,
  Interfaces.Wrapper.PropriedadeCadastro, System.SysUtils;

{ TControllerCadastroPadrao }

constructor TControllerCadastroPadrao.Create(pForm: TForm);
begin
  FForm := pForm;
  ObterObjeto;
end;

procedure TControllerCadastroPadrao.Gravar;
begin
  TUtilsEntidade.ExecutarMetodoObjeto(FEntidade,'Gravar',[]);
end;

procedure TControllerCadastroPadrao.DestruirEntidade;
begin
  FEntidade.Free;
end;

procedure TControllerCadastroPadrao.GravarEntidade;
begin
  if FEntidade = nil then
    Exit;

  PreencherEntidadeComCamposDoForm;
  Gravar;
  DestruirEntidade;
end;

class function TControllerCadastroPadrao.New(pForm: TForm): iControllerCadastroPadrao;
begin
  Result := Self.Create(pForm);
end;

procedure TControllerCadastroPadrao.ObterObjeto;
var
  Ctx: TRttiContext;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
begin
  FEntidade := nil;
  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(FForm.ClassType);
    if Tipo = Nil then
      Exit;

    for Atrib in Tipo.GetAttributes do
    begin
      if Atrib is TClasseCadastro then
      begin
        FEntidade := TPersistentClass(TClasseCadastro(Atrib).Classe).Create;
        Break;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TControllerCadastroPadrao.PreencherEntidadeComCamposDoForm;
var
  Ctx: TRttiContext;
  Tipo: TRTTIType;
  Atrib: TCustomAttribute;
  FField: TRttiField;
  Wrapper: iWrapperPropriedadeCadastro;
begin
  Wrapper := TWrapperPropriedadeCadastro.New;
  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(FForm.ClassType);
    if Tipo = Nil then
      Exit;

    for FField in Tipo.GetFields do
    begin
      for Atrib in FField.GetAttributes do
      begin
        if Atrib is TPropriedadeCadastro then
        begin
          var Valor := Wrapper.ObtemValor(FField.GetValue(FForm), TPropriedadeCadastro(Atrib), TPropriedadeCadastro(Atrib).TipoPropriedade);

          TUtilsEntidade.SetarValorParaPropriedade(FEntidade, TPropriedadeCadastro(Atrib).NomePropriedade, Valor);
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

end.

