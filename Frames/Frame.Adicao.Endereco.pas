unit Frame.Adicao.Endereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Adicao.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Entidade.Endereco,
  Attributes.Forms, Vcl.Imaging.pngimage, Vcl.DBCGrids, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.DBCtrls, Componente.TObjectList, Data.DB,
  Datasnap.DBClient, Objeto.CustomSelect;

type
  [TClasseCadastro(TEndereco)]
  TFrameAdicaoEndereco = class(TFrameAdicaoPadrao)
    edtTipoEndereco: TDBText;
    edtLogradouro: TDBText;
    edtCEP: TDBText;
    edtEndereco: TDBText;
    edtNumero: TDBText;
    lblNumero: TLabel;
    edtCidade: TDBText;
    edtEstado: TDBText;
    lblTraco: TLabel;
  public
    { Public declarations }
    function ObterSqlParaDatSet: string; override;
    function ObterLista: TObjectListFuck<TEndereco>;
  end;

var
  FrameAdicaoEndereco: TFrameAdicaoEndereco;

implementation

{$R *.dfm}

{ TFrameAdicaoEndereco }

function TFrameAdicaoEndereco.ObterLista: TObjectListFuck<TEndereco>;
begin
  var Lista := TObjectListFuck<TEndereco>.Create;
  try
    ObterListaPreenchida(TObjectListFuck<TObject>(Lista));
  finally
    Result := Lista;
  end;
end;

function TFrameAdicaoEndereco.ObterSqlParaDatSet: string;
begin
  var cSql := 'SELECT ' +
  'ENDERECO.*, '+
  'LOGRADOURO.ABREVIACAO LOGRADOURO, '+
  'CIDADE.NOME CIDADE,	ESTADO.ABREVIACAO ESTADO, '+
  TCustomSelectTipoEndereco.getSelectCustom('TIPO_ENDERECO') +
  ' FROM ENDERECO '+
  'INNER JOIN LOGRADOURO ON (LOGRADOURO.ID = ENDERECO.LOGRADOURO_FK) '+
  'INNER JOIN CIDADE ON (CIDADE.ID = ENDERECO.CIDADE_FK) '+
  'INNER JOIN ESTADO ON (ESTADO.ID = CIDADE.ESTADO_FK) ';
  Result := cSql + Self.ObterSqlDeTabelaRelacional;
end;

end.
