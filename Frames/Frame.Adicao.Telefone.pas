unit Frame.Adicao.Telefone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Adicao.Padrao, Data.DB, Datasnap.DBClient, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.DBCGrids, Vcl.DBCtrls,
  Entidade.Telefone, Componente.TObjectList, Attributes.Forms,
  View.Cadastro.Telefone, System.StrUtils, System.MaskUtils;

type
  [TFormularioCadastro(TFrmCadastroTelefone)]
  [TClasseCadastro(TTelefone)]
  TFrameAdicaoTelefone = class(TFrameAdicaoPadrao)
    edtTipoEndereco: TDBText;
    edtNumero: TDBText;
    edtObservacao: TDBText;
    lblCEP: TLabel;
  private
    function RegistroTipoCelular: Boolean;
    procedure ValidarMascaraNumeroOnGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    function ObterMascaraDoNumeroTelefone: string;
    { Private declarations }
  protected
    procedure CriarDataSet; override;
  public
    { Public declarations }
    function ObterLista: TObjectListFuck<TTelefone>;
  end;

var
  FrameAdicaoTelefone: TFrameAdicaoTelefone;

implementation

uses
  Utils.Constants, Utils.Enumerators;

{$R *.dfm}

{ TFrameAdicaoTelfone }

function TFrameAdicaoTelefone.RegistroTipoCelular: Boolean;
begin
  Result := cdsDados.FieldByName('TIPO_TELEFONE').AsInteger = TEnumerator<TTipoTelefone>.GetValue(ttCelular).AsInteger;
end;

function TFrameAdicaoTelefone.ObterMascaraDoNumeroTelefone: string;
begin
  Result := IfThen(RegistroTipoCelular,TConstantsMasks.CELULAR,TConstantsMasks.TELEFONE);
end;

procedure TFrameAdicaoTelefone.ValidarMascaraNumeroOnGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString <> string.Empty then
      Text := FormatMaskText(ObterMascaraDoNumeroTelefone, Sender.AsString);
end;

procedure TFrameAdicaoTelefone.CriarDataSet;
begin
  inherited;
  cdsDados.FieldByName('NUMERO').OnGetText := ValidarMascaraNumeroOnGetText;
end;

function TFrameAdicaoTelefone.ObterLista: TObjectListFuck<TTelefone>;
begin
  var Lista := TObjectListFuck<TTelefone>.Create;
  try
    ObterListaPreenchida(TObjectListFuck<TObject>(Lista));
  finally
    Result := Lista;
  end;
end;

end.
