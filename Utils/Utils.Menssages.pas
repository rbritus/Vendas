{ *************************************************************************
                     Copyright (C) Ivan Cesar Ferreira
                         email: ivancesarf@gmail.com
                         skype: proadvanced
                         whatsapp: (74) 99943-1865
***************************************************************************
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*************************************************************************** }

{ exemplo de uso
  // mensagem de pergunta simples, com parâmetro para exibir ou nao´ícone de atenção
  if TDialogMessage.ConfirmMessage('Mensagem de pergunta', True ) then


  // mensagem personalizada, com várias versões overloads
  if TDialogMessage.ShowMessageDialog(
    'Mensagem a ser exibida',
    'Título da janela',
    mtInformation, // [mtWarning, mtError, mtInformation, mtConfirmation, mtCustom]
    ['Caption do botão 1', 'Caption do botão 2', 'Caption do botão N'] // array de strings que será criado um botão para cada caption passado
    1, // índice do botão que deve ser o Default (quando clicado ENTER) - começa em 1 e não em zero
    1 // índice do botão acionado quando clicado no ESC - começa em 1 e não em zero
    ) = 1 /*retorno do índice do botão clicado -  começa em 1 e não em zero*/ then


  // mensagem de aguarde, cria uma tela bloqueando tudo o que for digitado e clicado
  with TDialogMessage do
  begin
    ShowWaitMessage('Mensagem de aguarde ...');
    try
      // seu código demorado
    finally
      // sempre que usar essa versão (sem método anônimo), deve chamar o closeWaitMessage
      // senão a tela de aguarde apenas fechará se outro formulário for chamado com ShowModal
      CloseWaitMessage;
    end;
  end;


  TDialogMessage.ShowWaitMessage('Aguarde ...',
  procedure
  begin
    // seu código demorado
    // aqui não precisa chamar o CloseWaitMessage, pois o método quando terminado já fechará a tela
  end);


  // mensagem de erro, que aborta o código após ela, caso exista
  TDialogMessage.ShowExceptionDialog('Mensagem de erro.');

  // pode tmb passar uma excepton como parametro
  ....
  except
    on E: Exception do
      TDialogMessage.ShowExceptionDialog(E);
  end;

  // mensagem de erro que apenas exibe a mensage, mas continua o código após ela, caso exista
  TDialogMessage.ShowErrorMessage('Mensagem de erro.');
  }

unit Utils.Menssages;

interface

uses
  System.Classes,
  System.Sysutils,
  System.Math,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellApi,
  Vcl.Consts,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.AppEvnts;

type
  TUtilsMenssages = class sealed
  private
    class procedure InternalFree;
  public
    constructor Create; reintroduce;
    class function GetInstance: TUtilsMenssages;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;

    // base dialog
    class function ShowCustomMessageDialog(
      const AMessage, ATitle: string;
      const ADialogType: TMsgDlgType;
      const AButtons: array of string;
      const ADefaultIndex, ACancelIndex: Integer;
      const AHelpIndex, AHelpContext: Longint;
      const AHelpFileName: string;
      const APositionX, APositionY: Integer): Integer; overload;

    // with positioning
    class function ShowCustomMessageDialogPos(
      const AMessage, ATitle: string;
      const ADialogType: TMsgDlgType;
      const AButtons: array of string;
      const ADefaultIndex, ACancelIndex: Integer;
      const APositionX, APositionY: Integer): Integer;

    // with specializations
    class function ShowMessageDialog(
      const AMessage, ATitle: string;
      const ADialogType: TMsgDlgType;
      const AButtons: array of string;
      const ADefaultIndex, ACancelIndex: Integer): Integer; overload;

    class function ShowMessageDialog(
      const AMessage: string;
      const ADialogType: TMsgDlgType;
      const AButtons: array of string;
      const ADefaultIndex, ACancelIndex: Integer): Integer; overload;

    class function ShowMessageDialog(
      const AMessage, ATitle: string;
      const ADialogType: TMsgDlgType;
      const AButtons: array of string): Integer; overload;
    class function ShowMessageDialog(
      const AMessage: string;
      const ADialogType: TMsgDlgType;
      const AButtons: array of string): Integer; overload;
    class procedure ShowMessageDialog(const AMessage, ATitle: string); overload;
    class procedure ShowMessageDialog(const AMessage: string); overload;

    // confirmation message
    class function ConfirmMessage(const AMessage: string; AWarningIcon: Boolean): Boolean; overload;
    class function ConfirmMessage(const AMessage: string): Boolean; overload;

    // error message
    class procedure ShowErrorMessage(AErrorMessage: string); overload;
    class procedure ShowExceptionDialog(AErrorMessage: string); overload;
    class procedure ShowExceptionDialog(AException: Exception); overload;

    // wait message
    class function ShowWaitMessage(const AMessage: string = ''): TUtilsMenssages; overload;
    class function ShowWaitMessage(const AMessage: string; AProc: TProc): TUtilsMenssages; overload;
    class function ShowWaitMessage(const AMessage: string; AFunc: TFunc<Boolean>): TUtilsMenssages; overload;
    class function CloseWaitMessage: TUtilsMenssages;
  end;

function DialogMessage: TUtilsMenssages;

{ direct access }
function ShowMessageDialog(const AMessage, ATitle: string; const ADialogType: TMsgDlgType; const AButtons: array of string; const ADefaultIndex, ACancelIndex: Integer): Integer; overload;
function ShowMessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: array of string; const ADefaultIndex, ACancelIndex: Integer): Integer; overload;
function ShowMessageDialog(const AMessage, ATitle: string; const ADialogType: TMsgDlgType; const AButtons: array of string): Integer; overload;
function ShowMessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: array of string): Integer; overload;
procedure ShowMessageDialog(const AMessage, ATitle: string); overload;
procedure ShowMessageDialog(const AMessage: string); overload;
function ConfirmMessage(const AMessage: string; AWarningIcon: Boolean): Boolean; overload;
function ConfirmMessage(const AMessage: string): Boolean; overload;
procedure ShowErrorMessage(AErrorMessage: string); overload;
procedure ShowExceptionDialog(AErrorMessage: string); overload;
procedure ShowExceptionDialog(AException: Exception); overload;
function ShowWaitMessage(const AMessage: string = ''): TUtilsMenssages; overload;
function ShowWaitMessage(const AMessage: string; AProc: TProc): TUtilsMenssages; overload;
function ShowWaitMessage(const AMessage: string; AFunc: TFunc<Boolean>): TUtilsMenssages; overload;
function CloseWaitMessage: TUtilsMenssages;

implementation

function MsgDlgInstance: TUtilsMenssages;
begin
  Result := TUtilsMenssages.GetInstance;
end;

function DialogMessage: TUtilsMenssages;
begin
  Result := MsgDlgInstance;
end;



type
  TResizableLabel = class(TLabel)
  protected
    FTextHeight, FTextWidth: integer;
    function GetCaption: TCaption;
    procedure SetCaption(ACaption: TCaption);
    function GetFont: TFont;
    procedure SetFont(AFont: TFont);
  public
    procedure Resize; override;
    property Caption: TCaption read GetCaption write SetCaption;
    property Font: TFont read GetFont write SetFont;
  end;

  TMessageDialog = class(TForm)
  private
    CanCloseForm: Boolean;
    ScrollBoxMsg: TScrollBox;
    PanelCaption: TPanel;
    PanelButtons: TPanel;
    LabelMessage: TResizableLabel;
    LabelCopy   : TLabel;
    ImageIcon   : TImage;
    ButtonArray : array of TButton;
    ExeVersion  : string;
    procedure ButtonClick(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CustomLabelClick(Sender: TObject);
    procedure CustomCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CustomWriteTextToClipBoard(AText: string);
    procedure CustomPanelCaptionOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CustomScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure CustomScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    function FormToText: string;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

  TWaitForm = class(TForm)
  private
    PanelContainer: TPanel;
    LabelMessage  : TLabel;
    AppEvents     : TApplicationEvents;
  protected
    procedure CustomAppEventsModalBegin(Sender: TObject);
  end;

  { TResizableLabel }

function TResizableLabel.GetCaption: TCaption;
begin
  Result := inherited Caption;
end;

function TResizableLabel.GetFont: TFont;
begin
  Result := inherited Font;
end;

function GetTextHeight(const AText: string; AFont: TFont): Integer;
var
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    LBitmap.Canvas.Font := AFont;
    Result := LBitmap.Canvas.TextHeight(AText);
  finally
    LBitmap.Free;
  end;
end;

function GetTextWidth(const AText: string; AFont: TFont): Integer;
var
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    LBitmap.Canvas.Font := AFont;
    Result := LBitmap.Canvas.TextWidth(AText);
  finally
    LBitmap.Free;
  end;
end;

procedure TResizableLabel.Resize;
var
  LNum: Double;
begin
  inherited;
  if AutoSize then
  begin
    if (FTextHeight = 0) or (FTextWidth = 0) then
    begin
      // lazy evaluation, we re evaluate every time the caption or font changes
      FTextWidth := GetTextWidth(Caption, Font);
      FTextHeight := GetTextHeight(Caption, Font);
    end;
    // TODO: there is still one bug here, set alCenter and make the last word long enough so it cant always wrapped to the line before,
    // even though there is globally enough space
    try
      LNum := (Height / FTextHeight) - (FTextWidth / Width);
    except
      LNum := -1;
    end;
    // if LNum is greater then 1 it means we need an extra line, if it is lower then zero it means there is an extra line
    if (LNum > 1) or (LNum < 0) then
    begin
      // just doing this all the time will cause it to really resize and will break alTop matching the whole space
      AutoSize := False;
      AutoSize := True;
    end;
  end;
end;

procedure TResizableLabel.SetCaption(ACaption: TCaption);
begin
  FTextWidth := GetTextWidth(ACaption, Self.Font);
  FTextHeight := GetTextHeight(ACaption, Self.Font);
  inherited Caption := ACaption;
end;

procedure TResizableLabel.SetFont(AFont: TFont);
begin
  FTextWidth := GetTextWidth(Caption, AFont);
  FTextHeight := GetTextHeight(Caption, AFont);
  inherited Font := AFont;
end;

{ TMessageDialog }

procedure TMessageDialog.ButtonClick(Sender: TObject);
begin
  CanCloseForm := True;
  ModalResult := TButton(Sender).Tag;
end;

procedure TMessageDialog.CustomCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseForm;
end;

procedure TMessageDialog.CustomLabelClick(Sender: TObject);
begin
  MessageBeep(0);
  CustomWriteTextToClipBoard(FormToText);
end;

procedure TMessageDialog.CustomPanelCaptionOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Self.Perform($0112, $F012, 0);
  end;
end;

procedure ScrollBoxRollDown(const AScollBox: TScrollBox);
begin
  if AScollBox.VertScrollBar.IsScrollBarVisible then
    with AScollBox.VertScrollBar do
    begin
      if (Position <= (Range - Increment)) then
        Position := Position + Increment
      else
        Position := Range - Increment;
    end;
end;

procedure ScrollBoxRollUp(const AScollBox: TScrollBox);
begin
  if AScollBox.VertScrollBar.IsScrollBarVisible then
    with AScollBox.VertScrollBar do
    begin
      if (Position >= Increment) then
        Position := Position - Increment
      else
        Position := 0;
    end;
end;

procedure TMessageDialog.CustomScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBoxRollDown(TScrollBox(Sender));
end;

procedure TMessageDialog.CustomScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBoxRollUp(TScrollBox(Sender));
end;

procedure TMessageDialog.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    if Key = Word('C') then
    begin
      MessageBeep(0);
      CustomWriteTextToClipBoard(FormToText);
    end;
    if Key = VK_HOME then
      ScrollBoxMsg.VertScrollBar.Position := 0;
    if Key = VK_END then
      ScrollBoxMsg.VertScrollBar.Position := ScrollBoxMsg.VertScrollBar.Range;
  end;

  if Key = VK_DOWN then
  begin
    ScrollBoxMsg.SetFocus;
    ScrollBoxRollDown(ScrollBoxMsg);
  end;
  if Key = VK_UP then
  begin
    ScrollBoxMsg.SetFocus;
    ScrollBoxRollUp(ScrollBoxMsg);
  end;
end;

function DoGetExeVersion: string;
type
  pFFI = ^VS_FIXEDFILEINFO;
var
  F       : pFFI;
  dwHandle: Cardinal;
  dwLen   : Cardinal;
  szInfo  : Cardinal;
  pchData : PWideChar;
  pchFile : PWideChar;
  ptrBuff : Pointer;
  strFile : string;
begin
  strFile := Application.ExeName;
  pchFile := StrAlloc(Length(strFile) + 1);
  StrPcopy(pchFile, strFile);
  szInfo := GetFileVersionInfoSize(pchFile, dwHandle);
  Result := '';
  if szInfo > 0 then
  begin
    pchData := StrAlloc(szInfo + 1);
    if GetFileVersionInfo(pchFile, dwHandle, szInfo, pchData) then
    begin
      VerQueryValue(pchData, '\', ptrBuff, dwLen);
      F := pFFI(ptrBuff);
      Result := Format('v%d.%d.%d (%.3d) %s', [
          HiWord(F^.dwFileVersionMs),
          LoWord(F^.dwFileVersionMs),
          HiWord(F^.dwFileVersionLs),
          LoWord(F^.dwFileVersionLs),
          {$IFDEF DEBUG} 'Debug'{$ELSE} ''{$ENDIF}]).Trim;
    end;
    StrDispose(pchData);
  end;
  StrDispose(pchFile);
end;

procedure TMessageDialog.CustomWriteTextToClipBoard(AText: string);
var
  LHandle : THandle;
  LPointer: Pointer;
begin
  if OpenClipBoard(0) then
  begin
    try
      LHandle := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, ByteLength(AText) + SizeOf(WideChar));
      try
        LPointer := GlobalLock(LHandle);
        try
          Move(PWideChar(AText)^, LPointer^, ByteLength(AText) + SizeOf(WideChar));
          EmptyClipBoard;
          SetClipboardData(CF_UNICODETEXT, LHandle);
        finally
          GlobalUnlock(LHandle);
        end;
      except
        GlobalFree(LHandle);
        raise;
      end;
    finally
      CloseClipBoard;
    end;
  end
  else
    raise Exception.Create('Não foi possível acessar a área de transferência.');
end;

function TMessageDialog.FormToText: string;
var
  DividerLine   : string;
  ButtonCaptions: string;
  I             : Integer;
begin
  DividerLine := StringOfChar('-', 80) + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TButton then
      ButtonCaptions := ButtonCaptions + AnsiQuotedStr(TButton(Components[I]).Caption, '|') + StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions, '&', '', [rfReplaceAll]) + sLineBreak;
  Result :=
    DividerLine +
    ExtractFileName(ParamStr(0)) +
    ' -> ' +
    Caption +
    sLineBreak +
    DividerLine +
    LabelMessage.Caption +
    sLineBreak +
    DividerLine +
    ButtonCaptions +
    DividerLine;
end;

procedure DoCenterControl(AControl: TControl; AVertical, AHorizontal: Boolean);
var
  LeftValue  : Integer;
  TopValue   : Integer;
  HeightValue: Integer;
  WidthValue : Integer;
begin
  HeightValue := AControl.Height;
  WidthValue := AControl.Width;
  LeftValue := (AControl.Parent.Width div 2) - (WidthValue div 2);
  TopValue := (AControl.Parent.Height div 2) - (HeightValue div 2);
  if AVertical then
    AControl.Top := TopValue;
  if AHorizontal then
    AControl.Left := LeftValue;
end;

constructor TMessageDialog.CreateNew(AOwner: TComponent);
const
  SMsgDlgCopyToClipBrd     = 'Copiar';
  SHintMsgDlgCopyToClipBrd = 'Copia a mensagem para a área de transferência';
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
  AutoScroll := False;
  BiDiMode := Application.BiDiMode;
  Font.Name := 'Tahoma';
  Font.Size := 9;
  // Font.Color := clWhite;
  // Canvas.Font := Font;
  ShowHint := True;
  PopupMode := pmAuto;
  Position := poScreenCenter;
  ActiveControl := nil;
  BorderIcons := [];
  // BorderStyle := bsDialog;
  BorderStyle := bsNone;
  Color := $00EAEAEA; // $00949494;
  // Font.Color := clWhite;
  // Font.Style := [fsBold];
  AlphaBlend := True;
  AlphaBlendValue := 235;
  KeyPreview := True;
  OnKeyDown := CustomKeyDown;
  OnCloseQuery := CustomCloseQuery;

  // panel caption
  PanelCaption := TPanel.Create(Self);
  PanelCaption.Name := 'PanelCaption';
  PanelCaption.Parent := Self;
  PanelCaption.Align := alTop;
  PanelCaption.Height := 25;
  PanelCaption.Alignment := taCenter;
  PanelCaption.BevelOuter := bvNone;
  PanelCaption.ShowCaption := True;
  PanelCaption.TabStop := False;
  PanelCaption.ParentBackground := False;
  PanelCaption.ParentColor := False;
  PanelCaption.Color := $004F4F4F; // $00787878; // $00949494;
  PanelCaption.Font.Color := clWhite;
  PanelCaption.Font.Style := [fsBold];
  PanelCaption.Cursor := crDrag;
  PanelCaption.OnMouseDown := CustomPanelCaptionOnMouseDown;

  // image icon
  ImageIcon := TImage.Create(Self);
  ImageIcon.Name := 'ImageIcon';
  ImageIcon.Parent := Self;
  ImageIcon.Left := 16;
  ImageIcon.Top := 16 + PanelCaption.Height;
  ImageIcon.Width := 32;
  ImageIcon.Height := 32;
  ImageIcon.Transparent := True;
  ImageIcon.IncrementalDisplay := True;

  // panel button
  PanelButtons := TPanel.Create(Self);
  PanelButtons.Name := 'PanelButtons';
  PanelButtons.Parent := Self;
  PanelButtons.Align := alBottom;
  PanelButtons.Height := 41;
  PanelButtons.BevelOuter := bvNone;
  PanelButtons.Caption := '';
  PanelButtons.ShowCaption := False;
  PanelButtons.TabStop := False;
  // PanelButtons.Color := clBtnFace;
  PanelButtons.ParentBackground := True;
  PanelButtons.ParentColor := True;

  // label copy to clibrd
  LabelCopy := TLabel.Create(Self);
  LabelCopy.Name := 'LabelCopy';
  LabelCopy.Parent := PanelButtons;
  LabelCopy.Left := ImageIcon.Left;
  LabelCopy.AutoSize := True;
  LabelCopy.Transparent := True;
  LabelCopy.Layout := tlCenter;
  LabelCopy.Font.Style := [fsUnderline];
  LabelCopy.Font.Size := 7;
  LabelCopy.Cursor := crHandPoint;
  LabelCopy.Caption := SMsgDlgCopyToClipBrd;
  LabelCopy.Hint := SHintMsgDlgCopyToClipBrd;
  LabelCopy.OnClick := CustomLabelClick;

  // scrollbox
  ScrollBoxMsg := TScrollBox.Create(Self);
  ScrollBoxMsg.Name := 'ScrollBoxMsg';
  ScrollBoxMsg.Parent := Self;
  ScrollBoxMsg.ParentBackground := True;
  ScrollBoxMsg.ParentColor := True;
  ScrollBoxMsg.BorderStyle := bsNone;
  ScrollBoxMsg.TabStop := False;
  ScrollBoxMsg.AlignWithMargins := True;
  ScrollBoxMsg.Margins.Top := 16;
  ScrollBoxMsg.Margins.Left := 64;
  ScrollBoxMsg.Margins.Bottom := 8;
  ScrollBoxMsg.Align := alClient;
  ScrollBoxMsg.HorzScrollBar.Visible := False;
  ScrollBoxMsg.VertScrollBar.Smooth := True;
  ScrollBoxMsg.VertScrollBar.Style := ssHotTrack;
  ScrollBoxMsg.VertScrollBar.Tracking := True;
  ScrollBoxMsg.Font.Name := 'Lucida Sans Typewriter';
  ScrollBoxMsg.Font.Size := 10;
// ScrollBoxMsg.Font.Style := [fsBold];
  ScrollBoxMsg.OnMouseWheelDown := CustomScrollBoxMouseWheelDown;
  ScrollBoxMsg.OnMouseWheelUp := CustomScrollBoxMouseWheelUp;

  // label message
  LabelMessage := TResizableLabel.Create(Self);
  LabelMessage.Name := 'LabelMessage';
  LabelMessage.Parent := ScrollBoxMsg;
  LabelMessage.ParentFont := True;
  LabelMessage.Top := 0;
  LabelMessage.Left := 0;
  LabelMessage.Layout := tlTop;
  LabelMessage.Transparent := True;
  LabelMessage.AlignWithMargins := True;
  LabelMessage.AutoSize := True;
end;

function DoGetDlgIcon(ADialogType: TMsgDlgType): HICON;
const
  IconIDs: array [TMsgDlgType] of PWideChar = (IDI_EXCLAMATION, IDI_ERROR, IDI_INFORMATION, IDI_QUESTION, IDI_APPLICATION);
var
  IconID: PWideChar;
begin
  IconID := IconIDs[ADialogType];
  Result := LoadIcon(0, IconID);
end;

function DoTaskBarBounds: TRect;
begin
  GetWindowRect(FindWindow('Shell_TrayWnd', nil), Result);
end;

function DoTaskBarPosition: TAlign;
var
  LTaskBarBounds: TRect;
  LScrW, LScrH  : Integer;
begin
  LScrW := Screen.Width;
  LScrH := Screen.Height;
  LTaskBarBounds := DoTaskBarBounds;
  if (LTaskBarBounds.Top > LScrH div 2) and (LTaskBarBounds.Right >= LScrW) then
    Result := alBottom
  else
    if (LTaskBarBounds.Top < LScrH div 2) and (LTaskBarBounds.Bottom <= LScrW div 2) then
      Result := alTop
    else
      if (LTaskBarBounds.Left < LScrW div 2) and (LTaskBarBounds.Top <= 0) then
        Result := alLeft
      else
        Result := alRight;
end;

function DoTaskBarWidth: Integer;
begin
  with DoTaskBarBounds do
    Result := Right - Left;
end;

function DoTaskBarHeight: Integer;
begin
  with DoTaskBarBounds do
    Result := Bottom - Top;
end;

{ TWaitForm }

procedure TWaitForm.CustomAppEventsModalBegin(Sender: TObject);
begin
  MsgDlgInstance.CloseWaitMessage;
end;

procedure DisableProcessWindowsGhosting;
var
  LUser32: HMODULE;
  LProc  : TProcedure;
begin
  LUser32 := GetModuleHandle('USER32');
  if LUser32 <> 0 then
  begin
    LProc := GetProcAddress(LUser32, 'DisableProcessWindowsGhosting');
    if Assigned(LProc) then
      LProc;
  end;
end;

procedure EmptyKeyQueue;
var
  LMessage: TMsg;
begin
  while PeekMessage(LMessage, 0, $0100, $0109, 1 or 2) do
      ;
end;

procedure EmptyMouseQueue;
var
  LMessage: TMsg;
begin
  while PeekMessage(LMessage, 0, $0200, $020E, 1 or 2) do
      ;
end;

var
  WaitForm      : TForm;
  LastActiveForm: TForm;
  WindowList    : TTaskWindowList;
  WindowLocked  : Boolean;

const
  MinHeight = 120;
  MinWidth  = 450;

function CreateWaitDlg(const AMessage: string): TForm;
const
  FWhiteColor = 16777215;
  FFontTahoma = 'Tahoma';

var
  FPanelLeft, FPanelTop: Integer;
begin
  if not Assigned(LastActiveForm) then
    if Assigned(Screen.ActiveForm) then
      if not(Screen.ActiveForm.ClassNameIs(TWaitForm.ClassName)) then
      begin
        LastActiveForm := Screen.ActiveForm;
        if Assigned(LastActiveForm) then
          WindowLocked := LockWindowUpdate(LastActiveForm.Handle);
      end;
  Result := TWaitForm.CreateNew(LastActiveForm);
  with Result do
  begin
    Name := 'WaitForm';
    BorderIcons := [];
    BorderStyle := bsNone;
    DoubleBuffered := False;
    Color := clFuchsia;
    Tag := -99;
    PopupMode := pmAuto;
    Position := poOwnerFormCenter;
    Caption := Application.Title;
    // dimensões padrao
    ClientHeight := MinHeight;
    ClientWidth := MinWidth;
    // dimensiona de acordo ao formulario ativo
    if Assigned(LastActiveForm) then
    begin
      ClientHeight := LastActiveForm.Height;
      ClientWidth := LastActiveForm.Width;
    end;
    // posição do panel
    FPanelLeft := 0;
    FPanelTop := (ClientHeight div 2) - (MinHeight div 2);
    // tratamento de transparência
    TransparentColorValue := Color;
    TransparentColor := True;
    AlphaBlendValue := 240;
    AlphaBlend := True;
  end;

  // panel
  TWaitForm(Result).PanelContainer := TPanel.Create(Result);
  with TWaitForm(Result).PanelContainer do
  begin
    Parent := Result;
    Color := $00804000; // $0068001F;
    ParentBackground := False;
    if Assigned(LastActiveForm) then
      BevelKind := bkNone
    else
      BevelKind := bkFlat;
    SetBounds(FPanelLeft, FPanelTop, TWaitForm(Result).ClientWidth, MinHeight);
  end;

  // label version
  with TLabel.Create(Result) do
  begin
    Parent := TWaitForm(Result).PanelContainer;
    Transparent := True;
    Caption := DoGetExeVersion;
    ParentFont := False;
    Layout := tlCenter;
    Font.Color := FWhiteColor;
    Font.Name := FFontTahoma;
    Font.Size := 7;
    Left := 8;
    Top := 5;
  end;

  // label aguarde
  with TLabel.Create(Result) do
  begin
    Parent := TWaitForm(Result).PanelContainer;
    AlignWithMargins := True;
    Align := alTop;
    Margins.Top := 15;
    Alignment := taCenter;
    Transparent := True;
    Caption := 'Aguarde';
    ParentFont := False;
    Layout := tlCenter;
    Font.Color := FWhiteColor;
    Font.Name := FFontTahoma;
    Font.Size := 18;
    Font.Style := [fsBold];
  end;

  // label msg
  TWaitForm(Result).LabelMessage := TLabel.Create(Result);
  with TWaitForm(Result).LabelMessage do
  begin
    Parent := TWaitForm(Result).PanelContainer;
    AlignWithMargins := True;
    Align := alClient;
    Alignment := taCenter;
    Transparent := True;
    Caption := 'Processando ...';
    ParentFont := False;
    Layout := tlCenter;
    WordWrap := True;
    Font.Color := FWhiteColor;
    Font.Name := FFontTahoma;
    Font.Size := 12;
    Font.Style := [fsBold];
  end;

  // ApplicationEvents
  with TWaitForm(Result) do
  begin
    AppEvents := TApplicationEvents.Create(Result);
    AppEvents.OnModalBegin := CustomAppEventsModalBegin;
  end;
end;

{ TDialogMessage }

var
  FDialogMessageInstance: TUtilsMenssages = nil;
  FDialogMessageCanFree : Boolean        = False;

class function TUtilsMenssages.ConfirmMessage(const AMessage: string; AWarningIcon: Boolean): Boolean;
var
  LMsgType : TMsgDlgType;
  LMsgSound: Cardinal;
begin
  LMsgType := mtConfirmation;
  LMsgSound := 32;
  if AWarningIcon then
  begin
    LMsgType := mtWarning;
    LMsgSound := 48;
  end;
  MessageBeep(LMsgSound);
  Result := Self.ShowMessageDialog(AMessage, LMsgType, ['&Sim', '&Não', 'Cancela'], -1, 3) = 1;
end;

class function TUtilsMenssages.ConfirmMessage(const AMessage: string): Boolean;
begin
  Result := Self.ConfirmMessage(AMessage, False);
end;

constructor TUtilsMenssages.Create;
begin
  raise Exception.Create('O método "Create" da classe não pode ser usado, utilize "GetInstance".');
end;

procedure TUtilsMenssages.FreeInstance;
begin
  if FDialogMessageCanFree then
    inherited;
end;

class function TUtilsMenssages.GetInstance: TUtilsMenssages;
begin
  Result := (Self.NewInstance as TUtilsMenssages);
end;

class procedure TUtilsMenssages.InternalFree;
begin
  if Assigned(FDialogMessageInstance) then
  begin
    FDialogMessageCanFree := True;
    FDialogMessageInstance.Free;
  end;
end;

class function TUtilsMenssages.NewInstance: TObject;
begin
  if not(Assigned(FDialogMessageInstance)) then
  begin
    FDialogMessageInstance := TUtilsMenssages(inherited NewInstance);
    FDialogMessageCanFree := False;
  end;
  Result := FDialogMessageInstance;
end;

function CreateCustomMessageDialog(
  const AMessage: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string;
  const ADefaultIndex, ACancelIndex: Integer;
  const AButtonWidth: Integer = 75;
  const AButtonHeight: Integer = 25): TForm;
var
  I             : Integer;
  LButtonsLeft  : Integer;
  LButtonsWidth : Integer;
  LIconTextWidth: Integer;
  LLabelWidth   : Integer;
  LScreenWidth  : Integer;
  LScreenHeight : Integer;
  LClientWidth  : Integer;
begin
  Result := TMessageDialog.CreateNew(Application);
  with TMessageDialog(Result) do
  begin
    ExeVersion := DoGetExeVersion;
    ImageIcon.Picture.Icon.Handle := DoGetDlgIcon(ADialogType);
    PanelButtons.Height := AButtonHeight + 16;
    DoCenterControl(LabelCopy, True, False);
    LabelMessage.Caption := AMessage;
    LIconTextWidth := Max(ImageIcon.ClientWidth + LabelMessage.ClientWidth + 16, 250);
    LLabelWidth := LabelCopy.ClientWidth + 10;
    LButtonsWidth := LLabelWidth;
    SetLength(ButtonArray, Length(AButtons));
    for I := Low(AButtons) to High(AButtons) do
    begin
      ButtonArray[I] := TButton.Create(Result);
      ButtonArray[I].Parent := PanelButtons;
      ButtonArray[I].Font.Style := [];
      if I = Pred(ADefaultIndex) then
      begin
        ButtonArray[I].Default := True;
        ActiveControl := ButtonArray[I];
      end;
      ButtonArray[I].Cancel := I = Pred(ACancelIndex);
      ButtonArray[I].Tag := I + 1;
      ButtonArray[I].Caption := AButtons[I];
      ButtonArray[I].OnClick := ButtonClick;
      ButtonArray[I].Height := AButtonHeight;
      ButtonArray[I].Width := Max(AButtonWidth, Canvas.TextWidth(AButtons[I]) + 20);
      LButtonsWidth := LButtonsWidth + ButtonArray[I].Width + 4;
      ButtonArray[I].Top := 8;
    end;
    LScreenWidth := Screen.WorkAreaWidth;
    LScreenHeight := Screen.WorkAreaHeight;
    case DoTaskBarPosition of
      alTop, alBottom:
        LScreenHeight := LScreenHeight - DoTaskBarHeight;
      alLeft, alRight:
        LScreenWidth := LScreenWidth - DoTaskBarWidth;
    end;

    LClientWidth := Min(Max(LButtonsWidth, LIconTextWidth) + 32, (LScreenWidth - 64));

    if LabelMessage.ClientWidth > LClientWidth then
    begin
      LabelMessage.Constraints.MaxWidth := LClientWidth - 80;
      LabelMessage.WordWrap := True;
    end
    else
    begin
      // LabelMessage.AutoSize := False;
      LabelMessage.Align := alClient;
      LabelMessage.Layout := tlCenter;
    end;

    ClientWidth := LClientWidth;

    ClientHeight := Min(
      Max(PanelCaption.Height +
          PanelButtons.Height +
          LabelMessage.Height + 32,

        PanelCaption.Height +
          PanelButtons.Height +
          ImageIcon.Height) + 32,

      (LScreenHeight - 32)
      );

    LButtonsLeft := LLabelWidth + ((ClientWidth - LButtonsWidth) div 2);
    for I := Low(ButtonArray) to High(ButtonArray) do
    begin
      ButtonArray[I].Left := LButtonsLeft;
      LButtonsLeft := LButtonsLeft + ButtonArray[I].Width + 6;
    end;
  end;
end;

class function TUtilsMenssages.ShowCustomMessageDialog(
  const AMessage, ATitle: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string;
  const ADefaultIndex, ACancelIndex, AHelpIndex, AHelpContext: Integer;
  const AHelpFileName: string;
  const APositionX, APositionY: Integer): Integer;
var
  LDialog: TMessageDialog;
  LTitle : string;
begin
  LDialog := TMessageDialog(CreateCustomMessageDialog(AMessage, ADialogType, AButtons, ADefaultIndex, ACancelIndex));
  try
    LTitle := ATitle.Trim;
    if LTitle.IsEmpty then
      LTitle := Application.Title.Trim;
    LDialog.PanelCaption.Caption := LTitle.Trim;
    if not(LDialog.ExeVersion.Trim.IsEmpty) and not(LTitle.IsEmpty) then
      LTitle := LDialog.ExeVersion + ' - ' + LTitle.Trim;
    LDialog.Caption := LTitle;
    LDialog.HelpFile := AHelpFileName;
    if AHelpIndex in [Low(AButtons) .. High(AButtons)] then
    begin
      LDialog.ButtonArray[AHelpIndex].HelpContext := AHelpContext;
      LDialog.ButtonArray[AHelpIndex].Tag := 0;
    end;
    if APositionX >= 0 then
      LDialog.Left := APositionX;
    if APositionY >= 0 then
      LDialog.Top := APositionY;
    if (APositionY < 0) and (APositionX < 0) then
      LDialog.Position := poOwnerFormCenter;
    Application.NormalizeAllTopMosts;
    Application.RestoreTopMosts;
    Application.BringToFront;
    Result := LDialog.ShowModal;
  finally
    LDialog.Free;
  end;
end;

class function TUtilsMenssages.ShowCustomMessageDialogPos(
  const AMessage, ATitle: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string;
  const ADefaultIndex, ACancelIndex, APositionX, APositionY: Integer): Integer;
begin
  Result := Self.ShowCustomMessageDialog(AMessage, ATitle, ADialogType, AButtons, ADefaultIndex, ACancelIndex, -1, 0, '', APositionX, APositionY);
end;

class procedure TUtilsMenssages.ShowErrorMessage(AErrorMessage: string);
begin
  if AErrorMEssage.Trim.IsEmpty then
    AErrorMessage := 'Error Message';
  Self.ShowCustomMessageDialogPos(AErrorMessage.Trim, Application.Title, mtError, ['&Ok'], 0, -1, -1, -1);
end;

class procedure TUtilsMenssages.ShowExceptionDialog(AErrorMessage: string);
begin
  Self.ShowErrorMessage(AErrorMessage);
  Abort;
end;

class procedure TUtilsMenssages.ShowExceptionDialog(AException: Exception);
begin
  Self.ShowExceptionDialog(AException.Message);
end;

class procedure TUtilsMenssages.ShowMessageDialog(const AMessage, ATitle: string);
begin
  Self.ShowMessageDialog(AMessage, ATitle, mtInformation, ['&Ok']);
end;

class procedure TUtilsMenssages.ShowMessageDialog(const AMessage: string);
begin
  Self.ShowMessageDialog(AMessage, Application.Title);
end;

class function TUtilsMenssages.ShowWaitMessage(const AMessage: string): TUtilsMenssages;
begin
  Result := Self.GetInstance;
  if not Assigned(WaitForm) then
  begin
    WaitForm := CreateWaitDlg(AMessage);
    WindowList := DisableTaskWindows(0);
    Screen.FocusedForm := WaitForm;
    WaitForm.Show;
    SendMessage(WaitForm.Handle, CM_ACTIVATE, 0, 0);
    Screen.Cursor := crHourGlass;
  end;

  with TWaitForm(WaitForm) do
  begin
    if AMessage.Trim.IsEmpty then
      LabelMessage.Caption := 'Processando ...'
    else
      LabelMessage.Caption := AMessage.Trim;
  end;
  UpdateWindow(WaitForm.Handle);
end;

class function TUtilsMenssages.ShowWaitMessage(const AMessage: string; AProc: TProc): TUtilsMenssages;
begin
  Result := Self.GetInstance;
  Self.ShowWaitMessage(AMessage);
  try
    if Assigned(AProc) then
      AProc;
  finally
    Self.CloseWaitMessage;
  end;
end;

class function TUtilsMenssages.ShowWaitMessage(const AMessage: string; AFunc: TFunc<Boolean>): TUtilsMenssages;
begin
  Result := Self.GetInstance;
  Self.ShowWaitMessage(AMessage);
  try
    if Assigned(AFunc) then
      AFunc;
  finally
    Self.CloseWaitMessage;
  end;
end;

class function TUtilsMenssages.CloseWaitMessage: TUtilsMenssages;
begin
  Result := MsgDlgInstance;
  try
    if Assigned(WaitForm) then
    begin
      try
        if WindowList <> nil then
          EnableTaskWindows(WindowList);
        WaitForm.Tag := -1;
        WaitForm.Close;
        FreeAndNil(WaitForm);
      finally
        EmptyKeyQueue;
        EmptyMouseQueue;
        if Assigned(LastActiveForm) then
          Screen.FocusedForm := LastActiveForm;
        LastActiveForm := nil;
        WindowList := nil;
        Screen.Cursor := crDefault;
      end;
    end;
  finally
    if WindowLocked then
    begin
      LockWindowUpdate(0);
      WindowLocked := False;
    end;
  end;
end;

class function TUtilsMenssages.ShowMessageDialog(
  const AMessage, ATitle: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string;
  const ADefaultIndex,
  ACancelIndex: Integer): Integer;
begin
  Result := Self.ShowCustomMessageDialogPos(AMessage, ATitle, ADialogType, AButtons, ADefaultIndex, ACancelIndex, -1, -1);
end;

class function TUtilsMenssages.ShowMessageDialog(
  const AMessage: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string;
  const ADefaultIndex,
  ACancelIndex: Integer): Integer;
begin
  Result := Self.ShowMessageDialog(AMessage, '', ADialogType, AButtons, ADefaultIndex, ACancelIndex);
end;

class function TUtilsMenssages.ShowMessageDialog(
  const AMessage, ATitle: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string): Integer;
begin
  Result := Self.ShowMessageDialog(AMessage, ATitle, ADialogType, AButtons, 0, -1);
end;

class function TUtilsMenssages.ShowMessageDialog(
  const AMessage: string;
  const ADialogType: TMsgDlgType;
  const AButtons: array of string): Integer;
begin
  Result := Self.ShowMessageDialog(AMessage, '', ADialogType, AButtons, 0, -1);
end;



function ShowMessageDialog(const AMessage, ATitle: string; const ADialogType: TMsgDlgType; const AButtons: array of string; const ADefaultIndex, ACancelIndex: Integer): Integer; overload;
begin
  Result := DialogMessage.ShowMessageDialog(AMessage, ADialogType, AButtons, ADefaultIndex, ACancelIndex);
end;

function ShowMessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: array of string; const ADefaultIndex, ACancelIndex: Integer): Integer; overload;
begin
  Result := DialogMessage.ShowMessageDialog(AMessage, ADialogType, AButtons, ADefaultIndex, ACancelIndex);
end;

function ShowMessageDialog(const AMessage, ATitle: string; const ADialogType: TMsgDlgType; const AButtons: array of string): Integer; overload;
begin
  Result := DialogMessage.ShowMessageDialog(AMessage, ATitle, ADialogType, AButtons);
end;

function ShowMessageDialog(const AMessage: string; const ADialogType: TMsgDlgType; const AButtons: array of string): Integer; overload;
begin
  Result := DialogMessage.ShowMessageDialog(AMessage, ADialogType, AButtons);
end;

procedure ShowMessageDialog(const AMessage, ATitle: string); overload;
begin
  DialogMessage.ShowMessageDialog(AMessage, ATitle);
end;

procedure ShowMessageDialog(const AMessage: string); overload;
begin
  DialogMessage.ShowMessageDialog(AMessage);
end;

function ConfirmMessage(const AMessage: string; AWarningIcon: Boolean): Boolean; overload;
begin
  Result := DialogMessage.ConfirmMessage(AMessage, AWarningIcon);
end;

function ConfirmMessage(const AMessage: string): Boolean; overload;
begin
  Result := DialogMessage.ConfirmMessage(AMessage);
end;

procedure ShowErrorMessage(AErrorMessage: string); overload;
begin
  DialogMessage.ShowErrorMessage(AErrorMessage);
end;

procedure ShowExceptionDialog(AErrorMessage: string); overload;
begin
  DialogMessage.ShowExceptionDialog(AErrorMessage);
end;

procedure ShowExceptionDialog(AException: Exception); overload;
begin
  DialogMessage.ShowExceptionDialog(AException);
end;

function ShowWaitMessage(const AMessage: string = ''): TUtilsMenssages; overload;
begin
  Result := DialogMessage.ShowWaitMessage(AMessage);
end;

function ShowWaitMessage(const AMessage: string; AProc: TProc): TUtilsMenssages; overload;
begin
  Result := DialogMessage.ShowWaitMessage(AMessage, AProc);
end;

function ShowWaitMessage(const AMessage: string; AFunc: TFunc<Boolean>): TUtilsMenssages; overload;
begin
  Result := DialogMessage.ShowWaitMessage(AMessage, AFunc);
end;

function CloseWaitMessage: TUtilsMenssages;
begin
  Result := DialogMessage.CloseWaitMessage;
end;

initialization

MsgDlgInstance;
DisableProcessWindowsGhosting;

finalization

MsgDlgInstance.InternalFree;

end.
