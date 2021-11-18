inherited FrameFiltroPesquisa: TFrameFiltroPesquisa
  Width = 840
  Height = 86
  ExplicitWidth = 840
  ExplicitHeight = 86
  inherited pnlFundo: TPanel
    Width = 840
    Height = 86
    ExplicitWidth = 840
    ExplicitHeight = 86
    inherited pnlConteudo: TPanel
      Top = 57
      Width = 840
      Height = 29
      TabOrder = 1
      ExplicitTop = 57
      ExplicitWidth = 840
      ExplicitHeight = 29
      object pnlFiltros: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 840
        Height = 29
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clWhite
        Padding.Top = 3
        ParentBackground = False
        TabOrder = 0
      end
    end
    object pnlPesquisa: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 0
      Width = 836
      Height = 57
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Color = 16117996
      Padding.Top = 3
      ParentBackground = False
      TabOrder = 0
      object edtPesquisa: TEdit
        Left = 33
        Top = 18
        Width = 769
        Height = 27
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnChange = edtPesquisaChange
        OnKeyDown = edtPesquisaKeyDown
      end
    end
  end
end
