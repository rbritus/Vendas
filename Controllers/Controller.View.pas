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

    procedure AdicionarFormNalista(Value: TComponentClass; var pForm: TForm);
    procedure ShowForm(Value: TComponentClass);

    property MainForm: TForm read FMainForm write FMainForm;
    property Parent: TPanel read FParent write FParent;
    property Title: TPanel read FTitle write FTitle;
  end;

var
  ControllerView : TControllerView;

implementation

{ TControllerView }

procedure TControllerView.ShowForm(Value: TComponentClass);
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
//  aForm.WindowState := wsMaximized;
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
  aForm.Show;
end;

procedure TControllerView.AdicionarFormNalista(Value: TComponentClass;
  var pForm: TForm);
begin
  if not ListaForm.TryGetValue(Value, pForm) then
  begin
    Application.CreateForm(Value, pForm);
    ListaForm.Add(Value, pForm);
  end;
end;

procedure TControllerView.ArredondarCantos(componente: TWinControl);
var
  BX: TRect;
  mdo: HRGN;
begin
  BX := componente.ClientRect;
  mdo := CreateRoundRectRgn(BX.Left, BX.Top, BX.Right, BX.Bottom, 20, 20);
  componente.Perform(EM_GETRECT, 0, lParam(@BX));
  InflateRect(BX, -4, -4);
  componente.Perform(EM_SETRECTNP, 0, lParam(@BX));
  SetWindowRgn(componente.Handle, mdo, True);
  componente.Invalidate;
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
var
  Key : TForm;
begin
  Lista.Items.Clear;
  Lista.Style := lbOwnerDrawFixed;
  Lista.Ctl3D := false;
  Lista.ItemHeight := 25;

  for Key in ListaForm.Values do
    Lista.AddItem(Key.Caption, Key);
end;

function TControllerView.ModuloForm(aForm: Tform): string;
var
  M : String;
begin
  M := copy(aForm.Name, length(aForm.Name));

  if UpperCase(M)='C' then
    Result := 'Cadastros';
end;

procedure TControllerView.ReRenderForms;
var
  Key : TForm;
begin
  try
    for Key in ListaForm.Values do
    begin
      if key.Showing then
      begin
        key.Visible := false;
        key.Visible := true;
      end;
    end;
  finally
  end;
end;

procedure TControllerView.DesablePanel (var aPanel : TPanel);
begin
  with aPanel do
  begin
    Enabled := false;
    Color   := $00C7C3BE;
    Cursor  := crNo;
  end;
end;

destructor TControllerView.Destroy;
begin
  FreeAndNil(ListaForm);
  inherited;
end;

procedure TControllerView.EnablePanel (var aPanel : TPanel; aColor: TColor);
begin
  with aPanel do
  begin
    Enabled := True;
    Color   := aColor;
    Cursor  := crHandPoint;
  end;
end;

initialization
  ControllerView := TControllerView.Create;

finalization
  ControllerView.Free;

end.
