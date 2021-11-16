program Vendas;

{$R *.dres}

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
  Utils.Form in 'Utils\Utils.Form.pas',
  Entidade.Endereco in 'Entitys\Entidade.Endereco.pas',
  Interfaces.Entidade.Endereco in 'Interfaces\Interfaces.Entidade.Endereco.pas',
  Entidade.Cidade in 'Entitys\Entidade.Cidade.pas',
  Interfaces.Entidade.Cidade in 'Interfaces\Interfaces.Entidade.Cidade.pas',
  Entidade.Estado in 'Entitys\Entidade.Estado.pas',
  Interfaces.Entidade.Estado in 'Interfaces\Interfaces.Entidade.Estado.pas',
  Entidade.Pais in 'Entitys\Entidade.Pais.pas',
  Interfaces.Entidade.Pais in 'Interfaces\Interfaces.Entidade.Pais.pas',
  Controller.Scripter in 'Controllers\Controller.Scripter.pas',
  Scripts.Versao00 in 'Scripts\Scripts.Versao00.pas',
  Objeto.ScriptDML in 'Objects\Objeto.ScriptDML.pas',
  Frame.Padrao in 'Frames\Frame.Padrao.pas' {FramePadrao: TFrame},
  Controller.Cadastro.Lista.Padrao in 'Controllers\Controller.Cadastro.Lista.Padrao.pas',
  Interfaces.Controller.Cadastro.Lista.Padrao in 'Interfaces\Interfaces.Controller.Cadastro.Lista.Padrao.pas',
  Utils.DBGrid in 'Utils\Utils.DBGrid.pas',
  Componente.TObjectList in 'Components\Componente.TObjectList.pas',
  Frame.Adicao.Padrao in 'Frames\Frame.Adicao.Padrao.pas' {FrameAdicaoPadrao: TFrame},
  Frame.Adicao.Endereco in 'Frames\Frame.Adicao.Endereco.pas' {FrameAdicaoEndereco: TFrame},
  Interfaces.Controller.Frame.Adicao.Padrao in 'Interfaces\Interfaces.Controller.Frame.Adicao.Padrao.pas',
  Attributes.Enumerators in 'Attributes\Attributes.Enumerators.pas',
  Utils.ClientDataSet in 'Utils\Utils.ClientDataSet.pas',
  Controller.Frame.Adicao.Padrao in 'Controllers\Controller.Frame.Adicao.Padrao.pas',
  Frame.Pesquisa.Entidade.Padrao in 'Frames\Frame.Pesquisa.Entidade.Padrao.pas' {FramePesquisaEntidadePadrao: TFrame},
  View.Cadastro.Endereco in 'Views\View.Cadastro.Endereco.pas' {FrmCadastroEndereco},
  Controller.Frame.Pesquisa.Entidade.Padrao in 'Controllers\Controller.Frame.Pesquisa.Entidade.Padrao.pas',
  Interfaces.Controller.Frame.Pesquisa.Entidade.Padrao in 'Interfaces\Interfaces.Controller.Frame.Pesquisa.Entidade.Padrao.pas',
  Interfaces.Padrao.Observer in 'Interfaces\Interfaces.Padrao.Observer.pas',
  Controller.Padrao.Observer in 'Controllers\Controller.Padrao.Observer.pas',
  View.Lista.Selecao.Entidade in 'Views\View.Lista.Selecao.Entidade.pas' {FrmListaSelecaoEntidade},
  Controller.Lista.Selecao.Entidade in 'Controllers\Controller.Lista.Selecao.Entidade.pas',
  Interfaces.Controller.Lista.Selecao.Entidade in 'Interfaces\Interfaces.Controller.Lista.Selecao.Entidade.pas',
  Interfaces.Controller.Objeto.ConsultaCEP in 'Interfaces\Interfaces.Controller.Objeto.ConsultaCEP.pas',
  Objeto.ConsultaCEP in 'Objects\Objeto.ConsultaCEP.pas',
  Controller.Objeto.ConsultaCEP in 'Controllers\Controller.Objeto.ConsultaCEP.pas',
  Interfaces.Objeto.ConsultaCEP in 'Interfaces\Interfaces.Objeto.ConsultaCEP.pas',
  Utils.Frame in 'Utils\Utils.Frame.pas',
  Utils.Menssages in 'Utils\Utils.Menssages.pas',
  Utils.Validacoes in 'Utils\Utils.Validacoes.pas',
  Interfaces.Controller.Frame.FiltroGride in 'Interfaces\Interfaces.Controller.Frame.FiltroGride.pas',
  Controller.Frame.FiltroGride in 'Controllers\Controller.Frame.FiltroGride.pas',
  Frame.Filtro.Pesquisa in 'Frames\Frame.Filtro.Pesquisa.pas' {FrameFiltroPesquisa: TFrame},
  Entidade.Telefone in 'Entitys\Entidade.Telefone.pas',
  Interfaces.Entidade.Telefone in 'Interfaces\Interfaces.Entidade.Telefone.pas',
  Frame.Adicao.Telefone in 'Frames\Frame.Adicao.Telefone.pas' {FrameAdicaoTelefone: TFrame},
  View.Cadastro.Telefone in 'Views\View.Cadastro.Telefone.pas' {FrmCadastroTelefone},
  Componente.TImagemValidacao in 'Components\Componente.TImagemValidacao.pas',
  Controller.Componente.TImagemValidacao in 'Controllers\Controller.Componente.TImagemValidacao.pas',
  Interfaces.Controller.Componente.TImagemValidacao in 'Interfaces\Interfaces.Controller.Componente.TImagemValidacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.Run;
end.
