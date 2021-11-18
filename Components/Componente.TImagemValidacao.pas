unit Componente.TImagemValidacao;

interface

uses
  System.Classes, Vcl.ExtCtrls, Vcl.Forms, Vcl.Controls, View.Padrao,
  Vcl.Imaging.GIFImg, Winapi.Windows;

type
  TImagemValidacao = class(TImage)
  public
    class function New(AForm: TForm; AComponente: TWinControl;
      Mensagem: string): TImagemValidacao;
      class procedure DestruirTImagemValidacao(AForm: TForm);
  end;

implementation

{ TImagemValidacao }

class function TImagemValidacao.New(AForm: TForm; AComponente: TWinControl;
  Mensagem: string): TImagemValidacao;
const
  LARGURA = 28;
  ALTURA = 24;
  RECUO_TOPO = -5;
  RECUO_ESQUERDA = -32;
  IMAGEM_ALERTA = 3;
begin
  var Imagem := Self.Create(AForm);
  Imagem.Parent := AComponente.Parent;
  Imagem.Height := ALTURA;
  Imagem.Width := LARGURA;
  Imagem.Top := AComponente.Top + RECUO_TOPO;
  Imagem.Left := AComponente.Left + RECUO_ESQUERDA;
  Imagem.Hint := Mensagem;
  Imagem.ShowHint := True;

  var aGIF := TGIFImage.Create;
  var Resource := TResourceStream.Create(hInstance, 'gifValidation', RT_RCDATA);
  try
    aGIF.LoadFromStream(Resource);
    aGIF.Animate := true;
    aGIF.AnimationSpeed := 150;
    Imagem.Picture.Graphic := aGIF;
  finally
    Resource.Free;
    aGIF.free;
  end;

  Result := Imagem;
end;

class procedure TImagemValidacao.DestruirTImagemValidacao(AForm: TForm);
begin
  var Indice := 0;
  while Indice <= Pred(AForm.ComponentCount) do
  begin
    if AForm.Components[Indice].ClassType = TImagemValidacao then
    begin
      TImagemValidacao(AForm.Components[Indice]).Free;
      Continue;
    end;
    inc(Indice);
  end;
end;

end.
