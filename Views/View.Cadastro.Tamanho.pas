unit View.Cadastro.Tamanho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Padrao,
  Vcl.BaseImageCollection, Vcl.ImageCollection, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.WinXCtrls, Entidade.Tamanho, Attributes.Forms, Utils.Enumerators;

type
  [TClasseCadastro(TTamanho)]
  TFrmCadastroTamanho = class(TFrmCadastroPadrao)
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    [TCadastroEdit('Abreviacao',ftTEXTO,coObrigatorio)]
    edtAbreviacao: TEdit;
    [TCadastroToggleSwitch('Ativo',ftTEXTO,coObrigatorio)]
    tswAtivo: TToggleSwitch;
    [TCadastroEdit('Nome',ftTEXTO,coObrigatorio)]
    edtTamanho: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroTamanho: TFrmCadastroTamanho;

implementation

{$R *.dfm}

end.
