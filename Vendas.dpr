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
  Interfaces.Services.Padrao in 'Interfaces\Interfaces.Services.Padrao.pas',
  Utils.Entidade in 'Utils\Utils.Entidade.pas',
  Utils.Constants in 'Utils\Utils.Constants.pas',
  Interfaces.Entidade.Pessoa in 'Interfaces\Interfaces.Entidade.Pessoa.pas',
  Entidade.Pessoa in 'Entitys\Entidade.Pessoa.pas',
  View.Cadastro.Pessoa in 'Views\View.Cadastro.Pessoa.pas' {FrmCadastroPessoa},
  Attributes.Forms in 'Attributes\Attributes.Forms.pas',
  Controller.Cadastro.Padrao in 'Controllers\Controller.Cadastro.Padrao.pas',
  Wrapper.PropriedadeCadastro in 'Wrappers\Wrapper.PropriedadeCadastro.pas',
  Interfaces.Controller.Cadastro.Padrao in 'Interfaces\Interfaces.Controller.Cadastro.Padrao.pas',
  Utils.Enumerators in 'Utils\Utils.Enumerators.pas',
  Interfaces.Wrapper.PropriedadeCadastro in 'Interfaces\Interfaces.Wrapper.PropriedadeCadastro.pas',
  View.Cadastro.Lista.Padrao in 'Views\View.Cadastro.Lista.Padrao.pas' {FrmCadastroListaPadrao},
  Interfaces.Objeto.PropertyCustom in 'Interfaces\Interfaces.Objeto.PropertyCustom.pas',
  Interfaces.Services.ListaCadastro in 'Interfaces\Interfaces.Services.ListaCadastro.pas',
  View.Cadastro.Lista.Pessoa in 'Views\View.Cadastro.Lista.Pessoa.pas' {FrmCadastroListaPessoa},
  Objeto.CustomSelect in 'Objects\Objeto.CustomSelect.pas',
  Utils.Form in 'Utils\Utils.Form.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.Run;
end.
