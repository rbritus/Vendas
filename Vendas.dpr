program Vendas;

uses
  Vcl.Forms,
  View.Menu in 'Views\View.Menu.pas' {FrmMenu},
  Controller.View in 'Controllers\Controller.View.pas',
  View.Padrao in 'Views\View.Padrao.pas' {FrmPadrao},
  Wrapper.Exception in 'Wrappers\Wrapper.Exception.pas',
  View.Cadastro.Padrao in 'Views\View.Cadastro.Padrao.pas' {FrmCadastroPadrao},
  Connection.Controller.SqLite in 'Connections\Connection.Controller.SqLite.pas',
  Connection.Scripter.SqLite in 'Connections\Connection.Scripter.SqLite.pas',
  Attributes.Entidades in 'Attributes\Attributes.Entidades.pas',
  Entidade.Padrao in 'Entitys\Entidade.Padrao.pas',
  Services.Padrao in 'Services\Services.Padrao.pas',
  Interfaces.Services in 'Interfaces\Interfaces.Services.pas',
  Utils.Entidade in 'Utils\Utils.Entidade.pas',
  Utils.Constants in 'Utils\Utils.Constants.pas',
  Interfaces.Pessoa in 'Interfaces\Interfaces.Pessoa.pas',
  Entidade.Pessoa in 'Entitys\Entidade.Pessoa.pas',
  View.Cadastro.Pessoa in 'Views\View.Cadastro.Pessoa.pas' {FrmCadastroPessoa},
  Attributes.Forms in 'Attributes\Attributes.Forms.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.Run;
end.
