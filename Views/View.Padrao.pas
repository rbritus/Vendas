unit View.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Controller.View,
  System.Actions, Vcl.ActnList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Interfaces.Padrao.Observer;

type
  TFrmPadrao = class(TForm)
    pnlFundo: TPanel;
    pnlConteudo: TScrollBox;
    imgListaBotoes16: TImageList;
    imgListaBotoes32: TImageList;
    actLista: TActionList;
    ImageCollection: TImageCollection;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlConteudoMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure pnlConteudoMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    FOwnerCaption: string;
    { Private declarations }
  protected
    FObservador: iObservador;
    procedure MudarFoco;
    procedure LimparCampos();
  public
    { Public declarations }
    property OwnerCaption: string read FOwnerCaption write FOwnerCaption;
    procedure SetObservador(Value: TWinControl);
    procedure NotificarObservador(Value: TObject);
    procedure Show; virtual;
  end;

var
  FrmPadrao: TFrmPadrao;

implementation

{$R *.dfm}

procedure TFrmPadrao.MudarFoco();
begin
  keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrmPadrao.NotificarObservador(Value: TObject);
begin
  if not Assigned(FObservador) then
    Exit;

  FObservador.UpdateItem(Value);
  FObservador := nil;
end;

procedure TFrmPadrao.pnlConteudoMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  with TScrollBox(Sender).VertScrollBar do
  begin
    Position := Position + Increment;
  end;
end;

procedure TFrmPadrao.pnlConteudoMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  with TScrollBox(Sender).VertScrollBar do
  begin
    Position := Position - Increment;
  end;
end;

procedure TFrmPadrao.SetObservador(Value: TWinControl);
begin
  FObservador := Value as iObservador;
end;

procedure TFrmPadrao.Show;
begin
  ControllerView.ShowFormCaption(Self);
end;

procedure TFrmPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ControllerView.ShowOwnerCaption(Self);
end;

procedure TFrmPadrao.FormCreate(Sender: TObject);
begin
  ControllerView.AtribuirUpperCaseParaCamponentesEditaveis(Self);
end;

procedure TFrmPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    MudarFoco();
end;

procedure TFrmPadrao.FormResize(Sender: TObject);
begin
//  ControllerView.ArredondarCantos(pnlConteudo);
//  ControllerView.ArredondarCantos(pnlFundo);
end;

procedure TFrmPadrao.LimparCampos();
begin
//   ControllerView.AtualizarVariaveisDeDescricaoDaGride();
//   ControllerView.LimpaCampos(self,[]);
end;

end.
