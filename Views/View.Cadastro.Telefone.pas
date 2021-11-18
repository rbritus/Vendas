unit View.Cadastro.Telefone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, System.ImageList, Vcl.ImgList, Vcl.Buttons,
  Vcl.ExtCtrls, Entidade.Telefone, Vcl.StdCtrls, Vcl.Mask, Attributes.Forms,
  Utils.Enumerators, System.StrUtils, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.Actions, Vcl.ActnList;

type
  [TClasseCadastro(TTelefone)]
  TFrmCadastroTelefone = class(TFrmCadastroPadrao)
    lblTipoTelefone: TLabel;
    [TCadastroComboBox('TipoTelefone',ftENUMERATOR,coObrigatorio)]
    cmbTipoTelefone: TComboBox;
    lblNumero: TLabel;
    lblObservacao: TLabel;
    [TCadastroEdit('Observacao',ftTEXTO,coNaoObrigatorio)]
    edtObservacao: TEdit;
    [TCadastroEdit('Numero',ftTEXTO,coObrigatorio)]
    edtNumero: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure cmbTipoTelefoneChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarMascadaNoCampoNumero;
    function RegistroTipoCelular: Boolean;
  public
    { Public declarations }
  end;

var
  FrmCadastroTelefone: TFrmCadastroTelefone;

implementation

uses
  Utils.Constants;

{$R *.dfm}

procedure TFrmCadastroTelefone.cmbTipoTelefoneChange(Sender: TObject);
begin
  inherited;
  ValidarMascadaNoCampoNumero;
end;

procedure TFrmCadastroTelefone.FormShow(Sender: TObject);
begin
  inherited;
  cmbTipoTelefone.SetFocus;
end;

procedure TFrmCadastroTelefone.ValidarMascadaNoCampoNumero;
begin
  edtNumero.EditMask :=
    IfThen(RegistroTipoCelular, TConstantsMasks.CELULAR, TConstantsMasks.TELEFONE);
end;

function TFrmCadastroTelefone.RegistroTipoCelular: Boolean;
begin
  Result := cmbTipoTelefone.ItemIndex = TEnumerator<TTipoTelefone>.GetIndex(ttCelular);
end;

end.
