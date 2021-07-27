unit View.Cadastro.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, Vcl.Buttons, Interfaces.Pessoa, Vcl.ExtCtrls,
  Entidade.Pessoa, Attributes.Forms, Vcl.StdCtrls, Vcl.WinXCtrls;

type
  [TClasseCadastro(TPessoa)]
  TFrmCadastroPessoa = class(TFrmCadastroPadrao)
    [TCadastroEdit('Id',ftINTEIRO)]
    edtId: TEdit;
    Label1: TLabel;
    [TCadastroEdit('Nome',ftTEXTO)]
    edtNome: TEdit;
    Label2: TLabel;
    [TCadastroToggleSwitch('Ativo',ftTEXTO)]
    ToggleSwitch1: TToggleSwitch;
    Label3: TLabel;
    procedure SpeedButton6Click(Sender: TObject);
  private
    procedure PreencherEntidadeComEdits;
    function ObterObjeto(Objeto: TForm): TPersistent;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroPessoa: TFrmCadastroPessoa;

implementation

uses
  System.Rtti, System.TypInfo, System.StrUtils, Utils.Entidade;

{$R *.dfm}

Procedure TFrmCadastroPessoa.PreencherEntidadeComEdits;
Var
   Ctx  : TRttiContext;
   Tipo : TRTTIType;
   Atrib: TCustomAttribute;
   Entidade: TPersistent;
   Field : TRttiField;

   function PegaValorTToggleSwitch(ToggleSwitch: TToggleSwitch): string;
   begin
     Result := ifthen((ToggleSwitch.State = tssOn),'S','N');
   end;

begin
  Entidade := ObterObjeto(Self);
  Ctx := TRttiContext.Create;
  try
    Tipo := Ctx.GetType(Self.ClassType);
    if Tipo <> Nil then
      for Field in Tipo.GetFields do
      begin
        for Atrib in Field.GetAttributes do
        begin
          if Atrib is TPropriedadeCadastro then
          begin
            var valor: TValue;
            if Atrib is TCadastroEdit then
                valor := Field.GetValue(Self).AsType<TEdit>.Text;

            if Atrib is TCadastroToggleSwitch then
              valor := PegaValorTToggleSwitch(Field.GetValue(Self).AsType<TToggleSwitch>);

            ShowMessage('Encontrado campo: ' + Field.Name + sLineBreak +
              'Seu tipo é: ' + Field.FieldType.ToString + sLineBreak +
              'Seu valor é : ' + valor.AsString + sLineBreak +
              'Sua Propriedade é: ' + TPropriedadeCadastro(Atrib).NomePropriedade);

            if TPropriedadeCadastro(Atrib).TipoPropriedade = ftINTEIRO then
              valor := StrToInt(valor.AsString);

            TUtilsEntidade.SetarValorParaPropriedade(Entidade,
              TPropriedadeCadastro(Atrib).NomePropriedade,valor);
          end;
        end;
      end;

      ShowMessage('Classe: ' + TPessoa(Entidade).ClassName + sLineBreak +
        'Id: ' + TPessoa(Entidade).Id.ToString + sLineBreak +
        'Nome: ' + TPessoa(Entidade).Nome + sLineBreak +
        'Ativo: ' + TPessoa(Entidade).Ativo);
  finally
    Ctx.Free;
    Entidade.Free;
  end;
end;

procedure TFrmCadastroPessoa.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  PreencherEntidadeComEdits;
end;

function TFrmCadastroPessoa.ObterObjeto(Objeto: TForm): TPersistent;
Var
   Ctx  : TRttiContext;
   Tipo : TRTTIType;
   Atrib: TCustomAttribute;
Begin
   Result := nil;
   Ctx    := TRttiContext.Create;
   Try
      Tipo   := ctx.GetType(Objeto.ClassType);
      If Tipo <> Nil Then
      Begin
         For Atrib In Tipo.GetAttributes Do
         Begin
            If Atrib Is TClasseCadastro Then
            Begin
               Result := TPersistentClass(TClasseCadastro(Atrib).Classe).Create;
               Break;
            End;
         End;
      End;
   Finally
      Ctx.Free;
   End;
end;


end.
