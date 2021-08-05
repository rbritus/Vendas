unit View.Cadastro.Lista.Pessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Lista.Padrao, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFrmCadastroListaPessoa = class(TFrmCadastroListaPadrao)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroListaPessoa: TFrmCadastroListaPessoa;

implementation

uses
  Services.Entidade.Pessoa, View.Cadastro.Pessoa;

{$R *.dfm}

procedure TFrmCadastroListaPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  FServicolistaCadastro := TServicoPessoa.New;
  FTClasseFormCadastro := TFrmCadastroPessoa;
end;

end.
