inherited FrmListaSelecaoEntidade: TFrmListaSelecaoEntidade
  Caption = 'FrmListaSelecaoEntidade'
  ClientHeight = 400
  Constraints.MaxHeight = 400
  Constraints.MaxWidth = 840
  Position = poDesigned
  OnClose = FormClose
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    Height = 400
    ExplicitHeight = 407
    inherited pnlConteudo: TPanel
      Top = 38
      Height = 362
      ExplicitHeight = 404
      object grdLista: TDBGrid
        Left = 0
        Top = 3
        Width = 840
        Height = 359
        Align = alClient
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object pnlMenu: TPanel
      Left = 0
      Top = 0
      Width = 840
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      ExplicitTop = 8
      object SpeedButton5: TSpeedButton
        AlignWithMargins = True
        Left = 40
        Top = 5
        Width = 25
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        GroupIndex = 1
        Caption = 'X'
        ImageIndex = 0
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        OnClick = SpeedButton5Click
      end
      object SpeedButton6: TSpeedButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 25
        Height = 25
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        GroupIndex = 1
        Caption = 'OK'
        ImageIndex = 0
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        OnClick = SpeedButton6Click
      end
      object pnlBarraLateralBotao: TPanel
        Left = 0
        Top = 30
        Width = 25
        Height = 5
        BevelOuter = bvNone
        Color = 16744448
        ParentBackground = False
        TabOrder = 0
        Visible = False
      end
    end
  end
end
