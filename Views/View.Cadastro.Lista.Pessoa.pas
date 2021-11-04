unit View.Cadastro.Lista.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Cadastro.Lista.Padrao, Data.DB, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, View.Cadastro.Pessoa, Attributes.Forms, Entidade.Pessoa,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  [TFormularioCadastro(TFrmCadastroPessoa)]
  [TClasseCadastro(TPessoa)]
  TFrmCadastroListaPessoa = class(TFrmCadastroListaPadrao)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroListaPessoa: TFrmCadastroListaPessoa;

implementation

{$R *.dfm}

end.
