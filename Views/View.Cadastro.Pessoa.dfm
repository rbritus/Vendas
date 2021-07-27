inherited FrmCadastroPessoa: TFrmCadastroPessoa
  Caption = 'Cadastrar Pessoa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object Label1: TLabel
        Left = 48
        Top = 21
        Width = 13
        Height = 13
        Caption = 'ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 48
        Top = 77
        Width = 32
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 48
        Top = 131
        Width = 30
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtId: TEdit
        Left = 48
        Top = 40
        Width = 57
        Height = 21
        TabOrder = 0
      end
      object edtNome: TEdit
        Left = 48
        Top = 96
        Width = 614
        Height = 21
        TabOrder = 1
      end
      object ToggleSwitch1: TToggleSwitch
        Left = 48
        Top = 152
        Width = 77
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
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
    end
    inherited pnlMenuLateral: TPanel
      inherited SpeedButton6: TSpeedButton
        OnClick = SpeedButton6Click
      end
    end
  end
end
