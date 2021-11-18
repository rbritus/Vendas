inherited FrmListaSelecaoEntidade: TFrmListaSelecaoEntidade
  Caption = 'Selecionar'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 139
      Height = 501
      ExplicitTop = 139
      ExplicitHeight = 501
      object grdLista: TDBGrid
        Left = 0
        Top = 3
        Width = 840
        Height = 498
        Align = alClient
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnDblClick = grdListaDblClick
        OnKeyPress = grdListaKeyPress
      end
    end
    object pnlMenu: TPanel
      Left = 0
      Top = 0
      Width = 840
      Height = 50
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object btnCancelar: TButton
        AlignWithMargins = True
        Left = 55
        Top = 5
        Width = 40
        Height = 40
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ImageAlignment = iaCenter
        ImageIndex = 2
        Images = imgListaBotoes32
        ParentFont = False
        TabOrder = 2
        OnClick = btnCancelarClick
        OnEnter = btnCancelarEnter
        OnExit = btnCancelarExit
        OnMouseEnter = btnCancelarMouseEnter
        OnMouseLeave = btnCancelarMouseLeave
      end
      object btnConfirmar: TButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 40
        Height = 40
        Hint = 'Utilizar registro selecionado.'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ImageAlignment = iaCenter
        ImageIndex = 0
        Images = imgListaBotoes32
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnConfirmarClick
        OnEnter = btnConfirmarEnter
        OnExit = btnConfirmarExit
        OnMouseEnter = btnConfirmarMouseEnter
        OnMouseLeave = btnConfirmarMouseLeave
      end
      object pnlBarraLateralBotao: TPanel
        Left = 5
        Top = 45
        Width = 40
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
      Top = 50
      Width = 840
      Height = 86
      Align = alTop
      TabOrder = 2
      ExplicitTop = 50
      inherited pnlFundo: TPanel
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
