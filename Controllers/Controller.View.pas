unit Controller.View;

interface

uses
  Vcl.ExtCtrls, vcl.controls, System.classes, Vcl.StdCtrls, vcl.forms,
  System.UITypes, System.Generics.Collections, System.SysUtils, System.Types,
  Winapi.Windows, Winapi.Messages, Rtti, Utils.Constants, System.Math, Vcl.Mask;

type
  TControllerView = class(TObject)
  private
    ListaForm: TDictionary<TComponentClass, TForm>;
    FMainForm: TForm;
    FParent: TPanel;
    FTitle: TPanel;
    FMenuExpandido: Boolean;
    function CarregarForm(Value: TComponentClass): TForm;
    function CarregarFormModal(Value: TComponentClass): TForm;
    procedure SetarCaptionOwner(AForm: TForm; Caption: string);
    function GetCaptionOwner(AForm: TForm): string;
    function GetLarguraMenu: Integer;
  public
    ParentOrigem: TPanel;
    constructor Create;
    destructor Destroy; override;
    procedure ListForms(var Lista: TListBox; var Title: TPanel);
    procedure ReRenderForms;
    procedure DesablePanel(var aPanel: TPanel);
    procedure EnablePanel(var aPanel: TPanel; aColor: TColor);
    function CountForms: integer;
    function ModuloForm(AForm: Tform): string;
    procedure ArredondarCantos(componente: TWinControl);
    procedure ShowFormCaption(AForm: Tform);
    procedure ShowOwnerCaption(AForm: Tform);
    procedure CriarSublinhadoParaCamposEditaveis(Componente: TWinControl);
    procedure AtribuirUpperCaseParaCamponentesEditaveis(AForm: TForm);
    procedure CentralizarHorizontalmenteComOParent(AControl : TControl);
    procedure CentralizarVerticalmenteComOParent(AControl : TControl);
    procedure AjustarLarguraMinimaDaAplicao;

    procedure AdicionarFormNalista(Value: TComponentClass; var AForm: TForm);
    procedure ShowForm(Value: TComponentClass);
    procedure ShowFormOrigem(Value: TComponentClass);
    function ShowFormModal(Value: TComponentClass): TForm;

    property MainForm: TForm read FMainForm write FMainForm;
    property Parent: TPanel read FParent write FParent;
    property Title: TPanel read FTitle write FTitle;
    property MenuExpandido: Boolean read FMenuExpandido write FMenuExpandido;
  end;

var
  ControllerView : TControllerView;

implementation

uses
  Utils.Entidade;

{ TControllerView }

function TControllerView.CarregarForm(Value: TComponentClass): TForm;
var
  AForm: TForm;
begin
  AdicionarFormNalista(Value,AForm);
  Parent.Visible := True;
  Title.Visible := True;
  AForm.Parent := Parent;
  AForm.Align := alClient;
  AForm.BorderStyle := bsNone;
  AForm.FormStyle := fsNormal;
  Result := AForm;
end;

procedure TControllerView.ShowForm(Value: TComponentClass);
begin
  var Form := CarregarForm(Value);
  Form.Show;
  TUtilsEntidade.ExecutarMetodoObjeto(Form,'Show',[]);
end;

function TControllerView.CarregarFormModal(Value: TComponentClass): TForm;
var
  AForm: TForm;
begin
  const DIFERENCA_BORDA = 3;
  AdicionarFormNalista(Value,AForm);
  AForm.Parent := nil;
  AForm.Align := alNone;
  AForm.BorderStyle := bsSingle;
  AForm.BorderIcons := [];
  AForm.Position := poDesigned;
  AForm.FormStyle := fsNormal;
  AForm.Top := MainForm.Top + Parent.Top  + Trunc((Parent.Height - AForm.Height)/2);
  AForm.Left := (GetLarguraMenu + MainForm.Left + Parent.Left + Trunc((Parent.Width - AForm.Width)/2)) + DIFERENCA_BORDA;
  AForm.Color := $004F4F4F;
//  AForm.AlphaBlend := True;
//  AForm.AlphaBlendValue := 235;
  Result := AForm;
end;

procedure TControllerView.CentralizarHorizontalmenteComOParent(
  AControl: TControl);
begin
  AControl.Left := (AControl.Parent.ClientWidth - AControl.Width) div 2;
end;

procedure TControllerView.CentralizarVerticalmenteComOParent(
  AControl: TControl);
begin
  AControl.Top := (AControl.Parent.ClientHeight - AControl.Height) div 2;
end;

function TControllerView.ShowFormModal(Value: TComponentClass): TForm;
begin
  var FormModal := CarregarFormModal(Value);
  FormModal.ShowModal;
  Result := FormModal;
end;

procedure TControllerView.ShowFormOrigem(Value: TComponentClass);
var
  AForm: TForm;

    function CloneComponent(AAncestor: TComponent): TComponent;
      var
        XMemoryStream: TMemoryStream;
        XTempName: string;
      begin
        Result:=nil;
        if not Assigned(AAncestor) then
          exit;
        XMemoryStream:=TMemoryStream.Create;
        try
          XTempName:=AAncestor.Name;
          AAncestor.Name:='clone_' + XTempName + Random(9999999).ToString;;
          XMemoryStream.WriteComponent(AAncestor);
          AAncestor.Name:=XTempName;
          XMemoryStream.Position:=0;
          Result:=TComponentClass(AAncestor.ClassType).Create(AAncestor.Owner);
          if AAncestor is TControl then TControl(Result).Parent:=TControl(AAncestor).Parent;
          XMemoryStream.ReadComponent(Result);
        finally
          XMemoryStream.Free;
        end;
      end;

begin
  AdicionarFormNalista(Value,AForm);
  if Assigned(AForm.Parent) then
  begin
    Parent.Visible := False;
    Parent := TPanel(AForm.Parent);
    Parent.Visible := True;
  end
  else
  begin
    Parent := CloneComponent(ParentOrigem) as TPanel;
    Parent.Visible := True;
    Title.Visible := True;
    AForm.Parent := Parent;
    AForm.Align := alClient;
    AForm.BorderStyle := bsNone;
    AForm.FormStyle := fsNormal;
    AForm.Show;
  end;
  TUtilsEntidade.ExecutarMetodoObjeto(AForm,'Show',[]);
end;

procedure TControllerView.ShowOwnerCaption(AForm: Tform);
begin
  if Assigned(Title) then
    Title.Caption := GetCaptionOwner(AForm);
end;

procedure TControllerView.AdicionarFormNalista(Value: TComponentClass; var AForm: TForm);
begin
  if not ListaForm.TryGetValue(Value, AForm) then
  begin
    Application.CreateForm(Value, AForm);
    ListaForm.Add(Value, AForm);
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

procedure TControllerView.AjustarLarguraMinimaDaAplicao;
begin
  if not Assigned(FParent) then
    Exit;

  const DIFERENCA_ENTRE_BORDAS = 260;
  FMainForm.Constraints.MinWidth :=  FParent.Width + DIFERENCA_ENTRE_BORDAS;
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

procedure TControllerView.AtribuirUpperCaseParaCamponentesEditaveis(
  AForm: TForm);
begin
  for var Indice := 0 to Pred(AForm.ComponentCount) do
  begin
    if AForm.Components[Indice].ClassType = TEdit then
      TEdit(AForm.Components[Indice]).CharCase := TEditCharCase.ecUpperCase
    else
    if AForm.Components[Indice].ClassType = TMaskEdit then
      TMaskEdit(AForm.Components[Indice]).CharCase := TEditCharCase.ecUpperCase;
  end;
end;

procedure TControllerView.ShowFormCaption(AForm: Tform);
begin
  if Assigned(Title) then
  begin
    SetarCaptionOwner(AForm, Title.Caption);
    Title.Caption := AForm.Caption;
  end;
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

function TControllerView.ModuloForm(AForm: Tform): string;
begin
  var Nome := copy(AForm.Name, length(AForm.Name));

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

procedure TControllerView.SetarCaptionOwner(AForm: TForm; Caption: string);
begin
  var ctx := TRttiContext.Create;
  try
    var lType := ctx.GetType(AForm.ClassType);
    var prop := lType.GetProperty('OwnerCaption');
    Prop.SetValue(AForm,Caption);
  finally
    ctx.Free;
  end;
end;

function TControllerView.GetCaptionOwner(AForm: TForm): string;
begin
  var ctx := TRttiContext.Create;
  try
    var lType := ctx.GetType(AForm.ClassType);
    var prop := lType.GetProperty('OwnerCaption');
    Result := Prop.GetValue(AForm).AsString;
  finally
    ctx.Free;
  end;
end;

function TControllerView.GetLarguraMenu: Integer;
begin
  Result := ifthen(FMenuExpandido,TConstantsInteger.LARGURA_MENU_MAXIMIZADO,
    TConstantsInteger.LARGURA_MENU_MINIMIZADO);
end;

initialization
  ControllerView := TControllerView.Create;

finalization
  ControllerView.Free;

end.
