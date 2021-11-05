inherited FrmCadastroPessoa: TFrmCadastroPessoa
  Caption = 'Cadastrar Pessoa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object Label4: TLabel
        Left = 40
        Top = 173
        Width = 752
        Height = 13
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '______________________________________________________________'
      end
      object Label2: TLabel
        Left = 48
        Top = 60
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
        Top = 108
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
      object Label1: TLabel
        Left = 48
        Top = 14
        Width = 20
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblEndereco: TLabel
        Left = 48
        Top = 164
        Width = 52
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 40
        Top = 349
        Width = 752
        Height = 13
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '______________________________________________________________'
      end
      object edtNome: TEdit
        Left = 48
        Top = 79
        Width = 614
        Height = 21
        TabOrder = 1
      end
      object ToggleSwitch1: TToggleSwitch
        Left = 48
        Top = 127
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
      inline FrameAdicaoEndereco: TFrameAdicaoEndereco
        Left = 40
        Top = 186
        Width = 760
        Height = 165
        TabOrder = 3
        ExplicitLeft = 40
        ExplicitTop = 186
        inherited pnlFundo: TPanel
          inherited pnlConteudo: TPanel
            inherited DBCtrlGrid1: TDBCtrlGrid
              Left = -8
              Top = 6
              ExplicitLeft = -8
              ExplicitTop = 6
            end
          end
        end
      end
      object edtCPF: TEdit
        Left = 48
        Top = 33
        Width = 169
        Height = 21
        TabOrder = 0
      end
    end
  end
end
