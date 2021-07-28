unit View.Cadastro.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, Vcl.Buttons, Interfaces.Entidade.Pessoa, Vcl.ExtCtrls,
  Entidade.Pessoa, Attributes.Forms, Vcl.StdCtrls, Vcl.WinXCtrls,
  Utils.Enumerators;

type
  [TClasseCadastro(TPessoa)]
  TFrmCadastroPessoa = class(TFrmCadastroPadrao)
    [TCadastroEdit('Id',ftINTEIRO,coNaoObrigatorio)]
    edtId: TEdit;
    Label1: TLabel;
    [TCadastroEdit('Nome',ftTEXTO,coObrigatorio)]
    edtNome: TEdit;
    Label2: TLabel;
    [TCadastroToggleSwitch('Ativo',ftTEXTO,coObrigatorio)]
    ToggleSwitch1: TToggleSwitch;
    Label3: TLabel;
  private
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

end.
