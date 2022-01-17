unit View.Cadastro.Lista.Tamanho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Lista.Padrao, Data.DB,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Frame.Padrao, Frame.Filtro.Pesquisa,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, View.Cadastro.Tamanho,
  Attributes.Forms, Entidade.Tamanho;

type
  [TFormularioCadastro(TFrmCadastroTamanho)]
  [TClasseCadastro(TTamanho)]
  TFrmCadastroListaTamanho = class(TFrmCadastroListaPadrao)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroListaTamanho: TFrmCadastroListaTamanho;

implementation

{$R *.dfm}

end.
