unit Controller.Frame.FiltroGride;

interface

uses
  Interfaces.Controller.Frame.FiltroGride, Vcl.StdCtrls, Vcl.Forms,
  System.Types, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Controls, Vcl.Grids,
  System.SysUtils, Vcl.Graphics, Winapi.Windows, System.Classes,
  System.Generics.Collections, Data.DB, System.Generics.Defaults,
  Winapi.Messages, system.StrUtils, Componente.TObjectList;

type
  TLabelCard = class(TLabel);

  TControllerFrameAdicaoPadrao = class(TInterfacedObject, iControllerFrameFiltroGride)
  strict private
    FFrame: TFrame;
  private
    FDbGrid: TDbGrid;
    FFiltroEmAcao: Boolean;
    FTextoFiltro: string;
    function ObterPanel: TPanel;
    procedure CriarLabel(Panel: TPanel; Filtro: string);
    procedure CriarImagemFechar(Panel: TPanel);
    procedure ArredondarCantos(componente: TWinControl);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawTextDestacado(Canvas: TCanvas; Rect: TRect; TextoOrig,
      TextoDestaque: string; CorDestaque: TColor);
    procedure ImageClick(Sender: TObject);
    procedure OrdernarLista(var Lista: TListFuck<string>; Texto: string);
    function GetCamposComFiltro(TextoFiltro: string): string;
    function GetCaptionFiltro: TListFuck<string>;
    function GetFiltroAplicado: string;
  protected
    constructor Create(AFrame: TFrame);
    property FiltroEmAcao: Boolean read FFiltroEmAcao write FFiltroEmAcao default False;
  public
    class function New(AFrame: TFrame): iControllerFrameFiltroGride;
    procedure CriarPanelFiltro(Filtro: string);
    procedure InformarDbGrid(ADbGrid: TDbGrid);
    procedure Filtrar(Filtro: string);
  end;

implementation

uses
  Frame.Padrao;

{ TControllerFrameAdicaoPadrao }

procedure TControllerFrameAdicaoPadrao.CriarPanelFiltro(Filtro: string);
begin
  if Filtro.IsEmpty then
    Exit;

  var Panel := ObterPanel;
  CriarLabel(Panel,Filtro);
  CriarImagemFechar(Panel);
  ArredondarCantos(Panel);
end;

class function TControllerFrameAdicaoPadrao.New(AFrame: TFrame): iControllerFrameFiltroGride;
begin
  Result := Self.Create(AFrame);
end;

function TControllerFrameAdicaoPadrao.ObterPanel: TPanel;
begin
  var panel := TPanel.Create(FFrame);
  panel.Parent := TWinControl(FFrame.FindComponent('pnlFiltros'));
  panel.Name := 'pnlFiltro' + Random(1000000).ToString;
  panel.Caption := string.Empty;
  panel.left := 99999;
  panel.AlignWithMargins := True;
  panel.Margins.Left := 10;
  panel.Margins.Top := 2;
  panel.Margins.Right := 0;
  panel.Margins.Bottom := 1;
  panel.AutoSize := True;
  panel.BevelOuter := bvNone;
  panel.BevelInner := bvNone;
  panel.Color := $00F5F0EC;//clSilver;
  panel.Font.Charset := DEFAULT_CHARSET;
  panel.Font.Color := 16744448;
  panel.Font.Name := 'Sitka Small';
  panel.Font.Style := [fsBold];
  panel.Padding.Top := 0;
  panel.ParentBackground := False;
  panel.ParentFont := False;
  panel.Align := alLeft;
  Result := panel;
end;

procedure TControllerFrameAdicaoPadrao.CriarLabel(Panel: TPanel; Filtro: string);
begin
  var LabelFiltro := TLabelCard.Create(FFrame);
  LabelFiltro.Parent := Panel;
  LabelFiltro.Name := 'lblFiltro' + Random(1000000).ToString;
  LabelFiltro.Top := 0;
  LabelFiltro.Align := alLeft;
  LabelFiltro.Font.Color := clGrayText;
  LabelFiltro.Font.Name := 'Lucida Sans Unicode';
  LabelFiltro.Font.Size := 12;
  LabelFiltro.Font.Style := [fsBold];
  LabelFiltro.Caption := Filtro;
  LabelFiltro.AlignWithMargins := True;
  LabelFiltro.Margins.Top := 0;
  LabelFiltro.Margins.Left := 10;
  LabelFiltro.Margins.Right := 10;
  LabelFiltro.Margins.Bottom := 4;
  LabelFiltro.Alignment := taCenter;
  LabelFiltro.Layout := tlCenter;
  LabelFiltro.AutoSize := True;
  LabelFiltro.ParentCustomHint := False;
  LabelFiltro.ParentBiDiMode := False;
  LabelFiltro.ParentColor := False;
  LabelFiltro.ParentFont := False;
  LabelFiltro.ParentShowHint := False;
  LabelFiltro.BiDiMode := bdLeftToRight;
  LabelFiltro.Color := clSilver;
end;

constructor TControllerFrameAdicaoPadrao.Create(AFrame: TFrame);
begin
  FFrame := AFrame;
end;

procedure TControllerFrameAdicaoPadrao.CriarImagemFechar(Panel: TPanel);
begin
  var Imagem := TImage.Create(FFrame);
  Imagem.Parent := Panel;
  Imagem.Name := 'imgFiltro' + Random(1000000).ToString;
  Imagem.AlignWithMargins := True;
  Imagem.Left := 100;
  Imagem.Top := 2;
  Imagem.Width := 16;
  Imagem.Height := 28;
  Imagem.Cursor := crHandPoint;
  Imagem.Margins.Left := 0;
  Imagem.Margins.Top := 0;
  Imagem.Margins.Right := 6;
  Imagem.Align := alLeft;
  Imagem.AutoSize := True;
  Imagem.Center := True;
  Imagem.Transparent := True;
  Imagem.Picture.Assign(TFramePadrao(FFrame).ImageCollection1.Images.Items[0].SourceImages.Items[0].Image);
  Imagem.OnClick := ImageClick;
end;

procedure TControllerFrameAdicaoPadrao.ImageClick(Sender: TObject);
begin
  var Panel := TImage(Sender).Parent;
  Panel.Free;
  Filtrar('');
end;

procedure TControllerFrameAdicaoPadrao.InformarDbGrid(ADbGrid: TDbGrid);
begin
  FDbGrid := ADbGrid;
  FDbGrid.OnDrawColumnCell := DBGrid1DrawColumnCell;
end;

procedure TControllerFrameAdicaoPadrao.Filtrar(Filtro: string);
begin
  if FiltroEmAcao then
    Exit;

  var FiltroAplicado := GetFiltroAplicado;
  FDbGrid.DataSource.DataSet.Filter := FiltroAplicado;
  FDbGrid.DataSource.DataSet.Filtered := True;
  FTextoFiltro := Trim(Filtro);

  if FTextoFiltro.IsEmpty then
    Exit;

  if (FDbGrid.DataSource.DataSet.IsEmpty) then
    Exit;

  if not FiltroAplicado.IsEmpty then
    FiltroAplicado := FiltroAplicado + ' AND ';

  FDbGrid.DataSource.DataSet.Filter := FiltroAplicado +
    GetCamposComFiltro(FTextoFiltro);
  FDbGrid.DataSource.DataSet.Filtered := True;
end;

procedure TControllerFrameAdicaoPadrao.ArredondarCantos(componente: TWinControl);
begin
  var BX := componente.ClientRect;
  var mdo := CreateRoundRectRgn(BX.Left, BX.Top, BX.Right, BX.Bottom, 15, 15);
  componente.Perform(EM_GETRECT, 0, lParam(@BX));
  InflateRect(BX, -4, -4);
  componente.Perform(EM_SETRECTNP, 0, lParam(@BX));
  SetWindowRgn(componente.Handle, mdo, True);
  componente.Invalidate;
end;

procedure TControllerFrameAdicaoPadrao.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not (gdSelected in State) then
  begin
    if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
      (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
    else
      (Sender as TDBGrid).Canvas.Brush.Color:= $00F5F0EC;//$00F1F2F3; // leve cinza

    // Aplicando prto para a cor da fonte
    (Sender as TDBGrid).Canvas.Font.Color:= clBlack;
    (Sender as TDBGrid).Canvas.FillRect(Rect);
    (Sender as TDBGrid).Canvas.TextOut(Rect.Left + 2, Rect.Top, Column.Field.DisplayText);
  end;

  DrawTextDestacado(TDbGrid(Sender).Canvas, Rect, Column.Field.DisplayText, Trim(FTextoFiltro), clBlue);
end;

procedure TControllerFrameAdicaoPadrao.DrawTextDestacado(Canvas : TCanvas; Rect: TRect;
  TextoOrig, TextoDestaque : string;
  CorDestaque : TColor);

  procedure DrawOrigem(S : string; Cor : TColor);
  begin
    Canvas.Font.Color:= Cor;
    Canvas.Font.Style := [];
    Canvas.TextRect(Rect, Rect.Left, Rect.Top + 2, S);
    Inc(Rect.Left, Canvas.TextWidth(S));
  end;

  procedure DrawDestaque(S : string; Cor : TColor);
  begin
    Canvas.Font.Color:= Cor;
    Canvas.Font.Style := [fsBold];
    Canvas.TextRect(Rect, Rect.Left, Rect.Top + 2, S);
    Inc(Rect.Left, Canvas.TextWidth(S));
  end;

var
  S1 : string;
  P : Integer;
  CorOrig : TColor;
begin
  if FiltroEmAcao then
    Exit;

  Canvas.FillRect(Rect);
  Inc(Rect.Left, 2);
  CorOrig := Canvas.Font.Color;

  FiltroEmAcao := True;
  var Lista := GetCaptionFiltro;
  try
    if not TextoDestaque.Trim.IsEmpty then
      Lista.Add(TextoDestaque);

    OrdernarLista(Lista,TextoOrig);
    for var Indice := 0 to Pred(Lista.Count) do
    begin
      var Destque2 := Lista.Items[Indice];

      if Destque2 = string.Empty then
        Continue;

      while not (Destque2 = string.Empty) do
      begin
        P := Pos(' ', Destque2);
        if P = 0 then
        begin
          S1 := Destque2;
          Destque2 := string.Empty;
        end
        else
        begin
          S1 := Copy(Destque2, 1, P - 1);
          Destque2 := Trim(Copy(Destque2, P + 1, 255));
        end;

        if not (S1 = '') then
        begin
          P := Pos(UpperCase(S1), UpperCase(TextoOrig));
          while P <> 0 do
          begin
            DrawOrigem(Copy(TextoOrig, 1, P - 1), CorOrig);
            Delete(TextoOrig, 1, P - 1);
            P := Length(S1);
            DrawDestaque(Copy(TextoOrig, 1, P), CorDestaque);
            Delete(TextoOrig, 1, P);
            P := Pos(UpperCase(S1), UpperCase(TextoOrig));
          end;
        end;

      end;
    end;
  finally
    Lista.Free;
    FiltroEmAcao := False;
  end;

  if not (TextoOrig = '') then
    DrawOrigem(TextoOrig, CorOrig);
end;

procedure TControllerFrameAdicaoPadrao.OrdernarLista(var Lista: TListFuck<string>; Texto: string);
var
  ValorComeco: Integer;
  ValorFinal: Integer;
begin
  if Lista.count = 0 then
    Exit;

  var PosicaoInicio := 0;
  while PosicaoInicio < Pred(Lista.Count) do
  begin
    ValorComeco := Pos(Lista.Items[PosicaoInicio],UpperCase(Texto));
    var PosicaoFinal := Pred(Lista.Count);
    while PosicaoFinal > 0 do
    begin
      ValorFinal := Pos(Lista.Items[PosicaoFinal],UpperCase(Texto));

      if ValorComeco > ValorFinal then
      begin
        var valor := Lista.Items[PosicaoFinal];
        Lista.Items[PosicaoFinal] := Lista.Items[PosicaoInicio];
        Lista.Items[PosicaoInicio] := valor;
      end;
      Dec(PosicaoFinal);
    end;
    Inc(PosicaoInicio);
  end;
end;

function TControllerFrameAdicaoPadrao.GetCamposComFiltro(TextoFiltro: string): string;

  function GetOR(Texto: string): string;
  begin
    Result := IfThen(Texto.IsEmpty,string.Empty,' OR ');
  end;

begin
  var Retorno := string.Empty;
  var DSet := FDbGrid.DataSource.DataSet;
  for var Indice := 0 to Pred(DSet.FieldCount) do
    if DSet.Fields[Indice].Visible then
      Retorno := Retorno + GetOR(Retorno) +
        ' UPPER('+DSet.Fields[Indice].FieldName+') like ' + QuotedStr('%'+ TextoFiltro +'%');

  Result := '(' + Retorno + ')';
end;

function TControllerFrameAdicaoPadrao.GetCaptionFiltro: TListFuck<string>;
begin
  var Lista :=  TListFuck<string>.Create;
  for var Indice := 0 to Pred(FFrame.ComponentCount) do
    if FFrame.Components[Indice] is TLabelCard then
      Lista.Add(TPanel(FFrame.Components[Indice]).Caption);
  Result := Lista;
end;

function TControllerFrameAdicaoPadrao.GetFiltroAplicado: string;
begin
  var Retorno := string.Empty;
  var Lista := GetCaptionFiltro;
  for var Indice := 0 to Pred(Lista.Count) do
      Retorno := IfThen(Retorno.IsEmpty,Retorno,Retorno + ' AND ') + GetCamposComFiltro(Lista.Items[Indice]);
  Result := Retorno;
  Lista.Free;
end;

end.
