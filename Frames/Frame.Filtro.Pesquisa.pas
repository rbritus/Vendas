unit Frame.Filtro.Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Frame.Padrao, Vcl.StdCtrls, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Controller.Frame.FiltroGride,
  Interfaces.Controller.Frame.FiltroGride, Vcl.DBGrids;

type
  TFrameFiltroPesquisa = class(TFramePadrao)
    pnlFiltros: TPanel;
    pnlPesquisa: TPanel;
    edtPesquisa: TEdit;
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaChange(Sender: TObject);
  private
    { Private declarations }
    FControllerFrameAdicaoPadrao: iControllerFrameFiltroGride;
    procedure CriarCard(Filtro: string);
  public
    { Public declarations }
    procedure SetDbGrid(ADbGrid: TDbGrid);
    procedure SetFocusOnKeyDown(Key: Char);
    procedure LimparPesquisa;
  end;

var
  FrameFiltroPesquisa: TFrameFiltroPesquisa;

implementation

uses
  Utils.Validacoes;

{$R *.dfm}

{ TFrameFiltroPesquisa }

procedure TFrameFiltroPesquisa.CriarCard(Filtro: string);
begin
  FControllerFrameAdicaoPadrao.CriarPanelFiltro(Filtro);
end;

procedure TFrameFiltroPesquisa.edtPesquisaChange(Sender: TObject);
begin
  inherited;
  FControllerFrameAdicaoPadrao.Filtrar(Trim(edtPesquisa.Text));
end;

procedure TFrameFiltroPesquisa.edtPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    if Trim(edtPesquisa.Text).IsEmpty then
    begin
      Perform(Wm_NextDlgCtl,0,0);
      Exit;
    end;

    CriarCard(edtPesquisa.Text);
    edtPesquisa.Clear;
    edtPesquisa.SetFocus;
  end;
end;

procedure TFrameFiltroPesquisa.LimparPesquisa;
begin
  edtPesquisa.Clear;
  FControllerFrameAdicaoPadrao.LimparPesquisa;
end;

procedure TFrameFiltroPesquisa.SetDbGrid(ADbGrid: TDbGrid);
begin
  FControllerFrameAdicaoPadrao := TControllerFrameAdicaoPadrao.New(Self);
  FControllerFrameAdicaoPadrao.InformarDbGrid(ADbGrid);
end;

procedure TFrameFiltroPesquisa.SetFocusOnKeyDown(Key: Char);
begin
  if TUtilsValidacoes.SomenteNumeros(Key) or TUtilsValidacoes.SomenteLetras(Key) then
  begin
    edtPesquisa.SetFocus;
    edtPesquisa.Text := edtPesquisa.Text + Key;
    edtPesquisa.SelStart := Length(edtPesquisa.Text);
  end;
end;

end.
