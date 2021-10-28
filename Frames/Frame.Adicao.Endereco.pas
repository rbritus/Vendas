unit Frame.Adicao.Endereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Adicao.Padrao, Vcl.Buttons, Vcl.ExtCtrls, Entidade.Endereco,
  Attributes.Forms, Vcl.Imaging.pngimage, Vcl.DBCGrids, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.DBCtrls, Componente.TObjectList, Data.DB,
  Datasnap.DBClient, Objeto.CustomSelect, Utils.Entidade, View.Cadastro.Endereco;

type
  [TFormularioCadastro(TFrmCadastroEndereco)]
  [TClasseCadastro(TEndereco)]
  TFrameAdicaoEndereco = class(TFrameAdicaoPadrao)
    edtTipoEndereco: TDBText;
    edtCEP: TDBText;
    edtEndereco: TDBText;
    edtNumero: TDBText;
    lblNumero: TLabel;
    edtCidade: TDBText;
    edtEstado: TDBText;
    lblTraco: TLabel;
  protected
    function ObterSqlParaDatSet: string; override;
    procedure CriarDataSet; override;
    procedure PreencherDataSet(Obj: TObject); override;
    procedure UpdateItem(Value : TObject); override;
  public
    { Public declarations }
    function ObterLista: TObjectListFuck<TEndereco>;
  end;

var
  FrameAdicaoEndereco: TFrameAdicaoEndereco;

implementation

uses
  Utils.ClientDataSet;

{$R *.dfm}

{ TFrameAdicaoEndereco }

procedure TFrameAdicaoEndereco.CriarDataSet;
begin
  inherited;
  var Obj := Self.ObterObjetoDoFrame;
  try
    TUtilsClientDataSet.PrepararClientDataSet(cdsDados);
    TUtilsClientDataSet.CreateFielsdByEntidade(cdsDados,Obj as TPersistent);
    TUtilsClientDataSet.CreateField(cdsDados,'ESTADO',ftString,2);
    TUtilsClientDataSet.CreateField(cdsDados,'CIDADE',ftString,200);
//    TUtilsClientDataSet.CreateField(cdsDados,'LOGRADOURO',ftString,20);
    TUtilsClientDataSet.ConcluirClientDataSet(cdsDados,Obj as TPersistent);
  finally
    Obj.Free
  end;
end;

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
  'CIDADE.NOME CIDADE,	ESTADO.ABREVIACAO ESTADO, '+
  TCustomSelectTipoEndereco.getSelectCustom('TIPO_ENDERECO') +
  ' FROM ENDERECO '+
  'INNER JOIN CIDADE ON (CIDADE.ID = ENDERECO.CIDADE_FK) '+
  'INNER JOIN ESTADO ON (ESTADO.ID = CIDADE.ESTADO_FK) ';
  Result := cSql + Self.ObterSqlDeTabelaRelacional;
end;

procedure TFrameAdicaoEndereco.PreencherDataSet(Obj: TObject);
begin
  inherited;
  var Endereco := TEndereco(Obj);

  if cdsDados.Locate('ID',Endereco.Id,[]) then
    cdsDados.Delete;

  cdsDados.Append;
  TUtilsClientDataSet.PreencherDataSet(cdsDados,TPersistent(Endereco));
  cdsDados.FieldByName('ESTADO').AsString := Endereco.Cidade.Estado.Abreviacao;
  cdsDados.FieldByName('CIDADE').AsString := Endereco.Cidade.Nome;
//  cdsDados.FieldByName('LOGRADOURO').AsString := Endereco.Logradouro.Abreviacao;
  cdsDados.Post;
end;

procedure TFrameAdicaoEndereco.UpdateItem(Value: TObject);
begin
  PreencherDataSet(Value);
  inherited;
end;

end.
