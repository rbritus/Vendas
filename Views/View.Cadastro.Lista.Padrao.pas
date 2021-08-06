unit View.Cadastro.Lista.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Padrao, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids,
  View.Cadastro.Padrao, Datasnap.DBClient;

type
  TFrmCadastroListaPadrao = class(TFrmPadrao)
    pnlMenu: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    pnlBarraLateralBotao: TPanel;
    grdLista: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure grdListaDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FClientDataSet : TClientDataSet;
    FDataSource: TDataSource;
    procedure ApresentarDadosNaGrid;
    procedure CriarDataSource;
    procedure ExecutarConsulta;
  public
    { Public declarations }
  end;

var
  FrmCadastroListaPadrao: TFrmCadastroListaPadrao;

implementation

uses
  Controller.View, Utils.Form, Utils.Entidade;

{$R *.dfm}

{ TFrmCadastroListaPadrao }

procedure TFrmCadastroListaPadrao.CriarDataSource;
begin
  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FClientDataSet;
  grdLista.DataSource := FDataSource;
end;

procedure TFrmCadastroListaPadrao.ExecutarConsulta;
begin
  var Entidade := TUtilsForm.ObterObjetoDeCadastroDoForm(Self);
  try
    FClientDataSet := TUtilsEntidade.ExecutarMetodoClasse(GetClass(Entidade.ClassName),'ListarTodosCDS',[]).AsType<TClientDataSet>;
  finally
    FreeAndNil(Entidade);
  end;
end;

procedure TFrmCadastroListaPadrao.ApresentarDadosNaGrid;
begin
  ExecutarConsulta;
  CriarDataSource;
end;

procedure TFrmCadastroListaPadrao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDataSource);
  FreeAndNil(FClientDataSet);
end;

procedure TFrmCadastroListaPadrao.FormShow(Sender: TObject);
begin
  inherited;
  ApresentarDadosNaGrid;
end;

procedure TFrmCadastroListaPadrao.grdListaDblClick(Sender: TObject);
begin
  inherited;
  var ClasseForm := TUtilsForm.ObterClasseDoFormularioCadastro(Self);
  ControllerView.ShowForm(TComponentClass(ClasseForm));
end;

end.
