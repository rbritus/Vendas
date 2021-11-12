inherited FrmCadastroTelefone: TFrmCadastroTelefone
  Caption = 'FrmCadastroTelefone'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object lblTipoTelefone: TLabel
        Left = 48
        Top = 14
        Width = 24
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblNumero: TLabel
        Left = 48
        Top = 62
        Width = 44
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblObservacao: TLabel
        Left = 48
        Top = 108
        Width = 67
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Observa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object cmbTipoTelefone: TComboBox
        Left = 49
        Top = 33
        Width = 144
        Height = 21
        TabOrder = 0
        OnChange = cmbTipoTelefoneChange
      end
      object edtObservacao: TEdit
        Left = 48
        Top = 127
        Width = 497
        Height = 21
        TabOrder = 2
      end
      object edtNumero: TMaskEdit
        Left = 48
        Top = 81
        Width = 145
        Height = 21
        TabOrder = 1
        Text = ''
      end
    end
  end
end
