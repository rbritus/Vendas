unit View.Cadastro.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, Vcl.Buttons, Interfaces.Entidade.Pessoa, Vcl.ExtCtrls,
  Entidade.Pessoa, Attributes.Forms, Vcl.StdCtrls, Vcl.WinXCtrls,
  Utils.Enumerators, Frame.Padrao, Frame.Adicao.Padrao, Frame.Adicao.Endereco,
  Entidade.Endereco, Componente.TObjectList, Frame.Pesquisa.Entidade.Padrao,
  System.ImageList, Vcl.ImgList, Vcl.Mask, Utils.Constants;

type
  [TClasseCadastro(TPessoa)]
  TFrmCadastroPessoa = class(TFrmCadastroPadrao)
    Label2: TLabel;
    [TCadastroEdit('Nome',ftTEXTO,coObrigatorio)]
    edtNome: TEdit;
    [TCadastroToggleSwitch('Ativo',ftTEXTO,coObrigatorio)]
    ToggleSwitch1: TToggleSwitch;
    Label3: TLabel;
    FrameAdicaoEndereco: TFrameAdicaoEndereco;
    [TMascaraCampo(TConstantsMasks.CPF)]
    [TCadastroEdit('CPF',ftTEXTO,coObrigatorio)]
    edtCPF: TMaskEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
  private
    [TCadastroVariavel('Enderecos',ftLISTAGEM,coObrigatorio,'FrameAdicaoEndereco')]
    FEnderecos: TObjectListFuck<TEndereco>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroPessoa: TFrmCadastroPessoa;

implementation

uses
  Utils.Edit;

{$R *.dfm}

procedure TFrmCadastroPessoa.btnCadastrarClick(Sender: TObject);
begin
  FEnderecos := FrameAdicaoEndereco.ObterLista;
  inherited;
end;

procedure TFrmCadastroPessoa.edtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not TUtilsEdit.SomenteNumeros(key,['0'..'9']) then
    key := TConstantsString.CHAR_RESULT;
end;

procedure TFrmCadastroPessoa.FormShow(Sender: TObject);
begin
  inherited;
  FrameAdicaoEndereco.CarregarFrame(Self.FID);
  edtCPF.SetFocus;
end;

end.
