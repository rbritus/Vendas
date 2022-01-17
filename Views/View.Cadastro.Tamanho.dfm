inherited FrmCadastroTamanho: TFrmCadastroTamanho
  Caption = 'Cadastrar Tamanho'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TScrollBox
      object Label2: TLabel
        Left = 40
        Top = 86
        Width = 74
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Abrevia'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 40
        Top = 159
        Width = 35
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 40
        Top = 12
        Width = 58
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Tamanho'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtAbreviacao: TEdit
        Left = 40
        Top = 108
        Width = 74
        Height = 24
        TabOrder = 1
      end
      object tswAtivo: TToggleSwitch
        Left = 40
        Top = 181
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        FrameColor = clDefault
        ParentFont = False
        State = tssOn
        StateCaptions.CaptionOn = 'Sim'
        StateCaptions.CaptionOff = 'N'#227'o'
        TabOrder = 2
        ThumbColor = clHighlight
      end
      object edtTamanho: TEdit
        Left = 40
        Top = 34
        Width = 300
        Height = 24
        TabOrder = 0
      end
    end
  end
end
