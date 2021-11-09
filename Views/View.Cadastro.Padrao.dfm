inherited FrmCadastroPadrao: TFrmCadastroPadrao
  Caption = 'FrmCadastroPadrao'
  Constraints.MaxWidth = 840
  Constraints.MinWidth = 840
  WindowState = wsNormal
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 44
      Height = 596
      Margins.Top = 0
      TabOrder = 1
      ExplicitTop = 44
      ExplicitHeight = 596
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
      TabOrder = 0
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
      object btnCadastrar: TSpeedButton
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
        ImageIndex = 0
        Images = imgListaBotoes32
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        OnClick = btnCadastrarClick
        OnMouseEnter = btnCadastrarMouseEnter
        OnMouseLeave = btnCadastrarMouseLeave
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
  end
end
