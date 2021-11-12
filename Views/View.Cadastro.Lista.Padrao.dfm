inherited FrmCadastroListaPadrao: TFrmCadastroListaPadrao
  Caption = 'FrmCadastroListaPadrao'
  Constraints.MaxWidth = 840
  Constraints.MinWidth = 840
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 133
      Height = 507
      ExplicitTop = 133
      ExplicitHeight = 507
      object grdLista: TDBGrid
        Left = 0
        Top = 3
        Width = 840
        Height = 504
        Align = alClient
        Ctl3D = True
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = grdListaDblClick
        OnKeyPress = grdListaKeyPress
      end
    end
    object pnlMenu: TPanel
      Left = 0
      Top = 0
      Width = 840
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object SpeedButton5: TSpeedButton
        AlignWithMargins = True
        Left = 49
        Top = 5
        Width = 34
        Height = 34
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
        Visible = False
        OnMouseEnter = SpeedButton5MouseEnter
        OnMouseLeave = SpeedButton5MouseLeave
      end
      object btnAdicionar: TSpeedButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 34
        Height = 34
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        GroupIndex = 1
        ImageIndex = 1
        Images = imgListaBotoes32
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        OnClick = btnAdicionarClick
        OnMouseEnter = btnAdicionarMouseEnter
        OnMouseLeave = btnAdicionarMouseLeave
      end
      object pnlBarraLateralBotao: TPanel
        Left = 5
        Top = 38
        Width = 34
        Height = 5
        BevelOuter = bvNone
        Color = 16744448
        ParentBackground = False
        TabOrder = 0
        Visible = False
      end
    end
    inline FrameFiltroPesquisa1: TFrameFiltroPesquisa
      Left = 0
      Top = 44
      Width = 840
      Height = 86
      Align = alTop
      TabOrder = 2
      ExplicitTop = 44
      inherited pnlFundo: TPanel
        ExplicitHeight = 86
        inherited pnlConteudo: TPanel
          ExplicitHeight = 29
          inherited pnlFiltros: TPanel
            ExplicitHeight = 29
          end
        end
        inherited pnlPesquisa: TPanel
          inherited edtPesquisa: TEdit
            OnEnter = FrameFiltroPesquisa1edtPesquisaEnter
            OnExit = FrameFiltroPesquisa1edtPesquisaExit
          end
        end
      end
    end
  end
end
