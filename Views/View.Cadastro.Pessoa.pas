unit View.Cadastro.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Padrao, Vcl.Buttons, Interfaces.Entidade.Pessoa, Vcl.ExtCtrls,
  Entidade.Pessoa, Attributes.Forms, Vcl.StdCtrls, Vcl.WinXCtrls,
  Utils.Enumerators, Frame.Padrao, Frame.Adicao.Padrao, Frame.Adicao.Endereco,
  Entidade.Endereco, Componente.TObjectList;

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
    [TCadastroEdit('CPF',ftTEXTO,coObrigatorio)]
    edtCPF: TEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    [TCadastroVariavel('Enderecos',ftLISTAGEM,coNaoObrigatorio)]
    FEnderecos: TObjectListFuck<TEndereco>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroPessoa: TFrmCadastroPessoa;

implementation

{$R *.dfm}

procedure TFrmCadastroPessoa.FormShow(Sender: TObject);
begin
  inherited;
  FrameAdicaoEndereco.SetarIdObjRelacional(Self.FID);
  FrameAdicaoEndereco.CarregarDataSet;
end;

procedure TFrmCadastroPessoa.SpeedButton6Click(Sender: TObject);
begin
  FEnderecos := FrameAdicaoEndereco.ObterLista;
  inherited;
end;

end.
