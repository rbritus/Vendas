inherited FrmListaSelecaoEntidade: TFrmListaSelecaoEntidade
  Caption = 'Selecionar'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 147
      Height = 493
      ExplicitTop = 264
      ExplicitHeight = 379
      object grdLista: TDBGrid
        Left = 0
        Top = 3
        Width = 840
        Height = 490
        Align = alClient
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
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
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object btnCancelar: TSpeedButton
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
        ImageIndex = 2
        Images = imgListaBotoes32
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        OnClick = btnCancelarClick
        OnMouseEnter = btnCancelarMouseEnter
        OnMouseLeave = btnCancelarMouseLeave
        ExplicitLeft = 47
      end
      object btnConfirmar: TSpeedButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 34
        Height = 34
        Hint = 'Utilizar registro selecionado.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        GroupIndex = 1
        ImageIndex = 0
        Images = imgListaBotoes32
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Spacing = 10
        OnClick = btnConfirmarClick
        OnMouseEnter = btnConfirmarMouseEnter
        OnMouseLeave = btnConfirmarMouseLeave
      end
      object pnlBarraLateralBotao: TPanel
        Left = 7
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
      Height = 100
      Align = alTop
      TabOrder = 2
      ExplicitTop = 44
      inherited pnlFundo: TPanel
        inherited pnlConteudo: TPanel
          inherited pnlFiltros: TPanel
            ExplicitHeight = 50
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
  inherited imgListaBotoes16: TImageList
    Left = 120
    Top = 0
  end
end
