unit Controller.View;

interface

uses
  Vcl.ExtCtrls, vcl.controls, System.classes, Vcl.StdCtrls, vcl.forms,
  System.UITypes, System.Generics.Collections, System.SysUtils, System.Types,
  Winapi.Windows, Winapi.Messages;

type
  TControllerView = class(TObject)
  private
    ListaForm: TDictionary<TComponentClass, TForm>;
    FMainForm: TForm;
    FParent: TPanel;
    FTitle: TPanel;
    function CarregarForm(Value: TComponentClass): TForm;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ListForms(var Lista: TListBox; var Title: TPanel);
    procedure ReRenderForms;
    procedure DesablePanel(var aPanel: TPanel);
    procedure EnablePanel(var aPanel: TPanel; aColor: TColor);
    function CountForms: integer;
    function ModuloForm(aForm: Tform): string;
    procedure ArredondarCantos(componente: TWinControl);
    procedure CaptionShow(aForm: Tform);
    procedure CriarSublinhadoParaCamposEditaveis(Componente: TWinControl);

    procedure AdicionarFormNalista(Value: TComponentClass; var pForm: TForm);
    procedure ShowForm(Value: TComponentClass);
    procedure ShowFormModal(Value: TComponentClass);

    property MainForm: TForm read FMainForm write FMainForm;
    property Parent: TPanel read FParent write FParent;
    property Title: TPanel read FTitle write FTitle;
  end;

var
  ControllerView : TControllerView;

implementation

{ TControllerView }

function TControllerView.CarregarForm(Value: TComponentClass): TForm;
var
  aForm: TForm;
  LabelCaminhoForm: Tlabel;
  LabelAtual: Tlabel;
begin
  AdicionarFormNalista(Value,aForm);
  Parent.Visible := True;
  Title.Visible := True;
  aForm.Parent := Parent;
  aForm.Align := alClient;
  aForm.BorderStyle := bsNone;
  aForm.Visible := True;
  aForm.FormStyle := fsNormal;
  if Assigned(Title) then
  begin
    Title.Caption := aForm.Caption;
    LabelCaminhoForm := MainForm.FindComponent('LabelCaminhoFormAtual') as TLabel;
    if LabelCaminhoForm <> nil then
      LabelCaminhoForm.Caption := 'Início>' + ModuloForm(aForm) + '>';
    LabelAtual := MainForm.FindComponent('LabelFormAtual') as TLabel;
    if LabelCaminhoForm <> nil then
      LabelCaminhoForm.Caption := 'Início>' + ModuloForm(aForm) + '>';
    if LabelAtual <> nil then
      LabelAtual.Caption := aForm.Caption;
  end;
  Result := aForm;
end;

procedure TControllerView.ShowForm(Value: TComponentClass);
begin
  CarregarForm(Value).Show;
end;

procedure TControllerView.ShowFormModal(Value: TComponentClass);
begin
  CarregarForm(Value).ShowModal;
end;

procedure TControllerView.AdicionarFormNalista(Value: TComponentClass; var pForm: TForm);
begin
  if not ListaForm.TryGetValue(Value, pForm) then
  begin
    Application.CreateForm(Value, pForm);
    ListaForm.Add(Value, pForm);
  end;
end;

procedure TControllerView.CriarSublinhadoParaCamposEditaveis(
  Componente: TWinControl);
begin
  var panel := TPanel.Create(Componente.Owner);
  panel.Name := 'pnl' + Componente.Name + Random(1000000).ToString;
  panel.Top := Componente.Top + Componente.Height;
  panel.Left := Componente.Left;
  panel.Width := Componente.Width;
  panel.Height := 2;
  panel.Parent := Componente.Parent;
end;

procedure TControllerView.ArredondarCantos(componente: TWinControl);
begin
  var BX := componente.ClientRect;
  var mdo := CreateRoundRectRgn(BX.Left, BX.Top, BX.Right, BX.Bottom, 20, 20);
  componente.Perform(EM_GETRECT, 0, lParam(@BX));
  InflateRect(BX, -4, -4);
  componente.Perform(EM_SETRECTNP, 0, lParam(@BX));
  SetWindowRgn(componente.Handle, mdo, True);
  componente.Invalidate;
end;

procedure TControllerView.CaptionShow(aForm: Tform);
begin
  if Assigned(Title) then
    Title.Caption := aForm.Caption;
end;

function TControllerView.CountForms: integer;
begin
  Result := ListaForm.Count;
end;

constructor TControllerView.Create;
begin
  ListaForm := TDictionary<TComponentClass, TForm>.Create;
end;

procedure TControllerView.ListForms(var Lista: TListBox; var Title: TPanel);
begin
  Lista.Items.Clear;
  Lista.Style := lbOwnerDrawFixed;
  Lista.Ctl3D := false;
  Lista.ItemHeight := 25;

  for var Key in ListaForm.Values do
    Lista.AddItem(Key.Caption, Key);
end;

function TControllerView.ModuloForm(aForm: Tform): string;
begin
  var Nome := copy(aForm.Name, length(aForm.Name));

  if UpperCase(Nome)='C' then
    Result := 'Cadastros';
end;

procedure TControllerView.ReRenderForms;
begin
  for var Key in ListaForm.Values do
  begin
    if Key.Showing then
    begin
      Key.Visible := false;
      Key.Visible := true;
    end;
  end;
end;

procedure TControllerView.DesablePanel (var aPanel : TPanel);
begin
  aPanel.Enabled := false;
  aPanel.Color := $00C7C3BE;
  aPanel.Cursor := crNo;
end;

destructor TControllerView.Destroy;
begin
  FreeAndNil(ListaForm);
  inherited;
end;

procedure TControllerView.EnablePanel (var aPanel : TPanel; aColor: TColor);
begin
  aPanel.Enabled := True;
  aPanel.Color := aColor;
  aPanel.Cursor := crHandPoint;
end;

initialization
  ControllerView := TControllerView.Create;

finalization
  ControllerView.Free;

end.
