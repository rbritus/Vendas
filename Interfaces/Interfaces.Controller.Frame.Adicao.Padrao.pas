unit Interfaces.Controller.Frame.Adicao.Padrao;

interface

uses
   System.Classes, Data.DB, Componente.TObjectList;

type

  iControllerFrameAdicaoPadrao = interface
    ['{2B0418C5-FE1E-4A9E-92E3-781CF12FBFC8}']
    procedure ApresentarFormParaCadastro;
    procedure ApresentarFormParaEdicao(ID: Integer);
    function CarregarDataSet(pSql: string): TDataSet;
    function ObterSqlDeTabelaRelacional(pIdObjetoRelacional: Integer): string;
    procedure ObterListaPreenchidaDoFrame(cds: TDataSet; var Lista: TObjectListFuck<TObject>);
    function ObterObjetoDoFrame: TObject;
    function ObterClasseDaEntidadeDeCadastro: TClass;
    function CarregarListaDeObjetosParaFrame(pIdObjetoRelacional: Integer): TObjectListFuck<TObject>;
  end;

implementation

end.
