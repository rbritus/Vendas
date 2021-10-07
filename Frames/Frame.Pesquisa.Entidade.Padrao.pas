unit Frame.Pesquisa.Entidade.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frame.Padrao, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Datasnap.DBClient;

type
  TFramePadrao1 = class(TFramePadrao)
    cds: TClientDataSet;
    dsc: TDataSource;
    DBComboBox1: TDBComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FramePadrao1: TFramePadrao1;

implementation

{$R *.dfm}

end.
