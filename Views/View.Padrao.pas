unit View.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Controller.View,
  System.Actions, Vcl.ActnList;

type
  TFrmPadrao = class(TForm)
    pnlFundo: TPanel;
    pnlConteudo: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure MudarFoco;
    procedure LimparCampos();
  public
    { Public declarations }
  end;

var
  FrmPadrao: TFrmPadrao;

implementation

{$R *.dfm}

procedure TFrmPadrao.MudarFoco();
begin
   keybd_event(VK_TAB, 0, 0, 0);
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

procedure TFrmPadrao.FormShow(Sender: TObject);
begin
  ControllerView.CaptionShow(Self);
end;

procedure TFrmPadrao.LimparCampos();
begin
//   ControllerView.AtualizarVariaveisDeDescricaoDaGride();
//   ControllerView.LimpaCampos(self,[]);
end;

end.
