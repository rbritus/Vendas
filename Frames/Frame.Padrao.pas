unit Frame.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFramePadrao = class(TFrame)
    pnlFundo: TPanel;
    pnlConteudo: TPanel;
    imgListaBotoes16: TImageList;
    imgListaBotoes32: TImageList;
    ImageCollection1: TImageCollection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
