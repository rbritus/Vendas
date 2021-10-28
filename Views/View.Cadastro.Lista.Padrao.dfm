inherited FrmCadastroListaPadrao: TFrmCadastroListaPadrao
  Caption = 'FrmCadastroListaPadrao'
  Constraints.MaxWidth = 840
  Constraints.MinWidth = 840
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 38
      Height = 602
      ExplicitTop = 38
      ExplicitHeight = 602
      object grdLista: TDBGrid
        Left = 0
        Top = 3
        Width = 840
        Height = 599
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = grdListaDblClick
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
