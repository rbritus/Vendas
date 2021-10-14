unit Frame.Pesquisa.Entidade.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frame.Padrao, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Buttons;

type
  TFramePesquisaEntidadePadrao = class(TFramePadrao)
    cds: TClientDataSet;
    dsc: TDataSource;
    Label1: TLabel;
    Edit1: TEdit;
    btnInserir: TBitBtn;
    btnExcluir: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FramePesquisaEntidadePadrao: TFramePesquisaEntidadePadrao;


implementation

{$R *.dfm}

uses
  Controller.Frame.Pesquisa.Entidade.Padrao;

{ TFramePesquisaEntidadePadrao }

end.
