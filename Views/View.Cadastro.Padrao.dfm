inherited FrmCadastroPadrao: TFrmCadastroPadrao
  Caption = 'FrmCadastroPadrao'
  Constraints.MaxWidth = 840
  Constraints.MinWidth = 840
  WindowState = wsNormal
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 50
      Height = 590
      Margins.Top = 0
      TabOrder = 1
      ExplicitTop = 50
      ExplicitHeight = 590
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
      TabOrder = 0
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
      object btnCadastrar: TButton
        AlignWithMargins = True
        Left = 5
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
        ImageIndex = 0
        Images = imgListaBotoes32
        ParentFont = False
        TabOrder = 1
        OnClick = btnCadastrarClick
        OnEnter = btnCadastrarEnter
        OnExit = btnCadastrarExit
        OnMouseEnter = btnCadastrarMouseEnter
        OnMouseLeave = btnCadastrarMouseLeave
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
  end
end
