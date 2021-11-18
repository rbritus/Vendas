inherited FrmCadastroPessoa: TFrmCadastroPessoa
  Caption = 'Cadastrar Pessoa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object Label2: TLabel
        Left = 40
        Top = 86
        Width = 35
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 713
        Top = 86
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
        Width = 22
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtNome: TEdit
        Left = 40
        Top = 108
        Width = 625
        Height = 24
        TabOrder = 1
      end
      object ToggleSwitch1: TToggleSwitch
        Left = 713
        Top = 108
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
      inline FrameAdicaoEndereco: TFrameAdicaoEndereco
        Left = 40
        Top = 164
        Width = 760
        Height = 180
        TabOrder = 3
        ExplicitLeft = 40
        ExplicitTop = 164
        inherited pnlFundo: TPanel
          inherited pnlConteudo: TPanel
            inherited DBCtrlGrid1: TDBCtrlGrid
              Top = 6
              ExplicitTop = 6
            end
          end
        end
      end
      object edtCPF: TMaskEdit
        Left = 40
        Top = 34
        Width = 169
        Height = 24
        TabOrder = 0
        Text = ''
      end
      inline FrameAdicaoTelefone: TFrameAdicaoTelefone
        Left = 40
        Top = 357
        Width = 760
        Height = 180
        TabOrder = 4
        ExplicitLeft = 40
        ExplicitTop = 357
      end
    end
  end
end
