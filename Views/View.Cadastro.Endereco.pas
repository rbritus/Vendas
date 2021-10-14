unit View.Cadastro.Endereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Padrao, Vcl.Buttons,
  Vcl.ExtCtrls, Entidade.Endereco, Attributes.Forms, Frame.Padrao,
  Frame.Pesquisa.Entidade.Padrao, Vcl.StdCtrls, Entidade.Logradouro;

type
  [TClasseCadastro(TEndereco)]
  TFrmCadastroEndereco = class(TFrmCadastroPadrao)
    [TCampoExibicao('ABREVIACAO')]
    [TClasseCadastro(TLogradouro)]
    FramePesquisaEntidadePadrao1: TFramePesquisaEntidadePadrao;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroEndereco: TFrmCadastroEndereco;

implementation

{$R *.dfm}

end.
