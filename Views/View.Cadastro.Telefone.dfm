inherited FrmCadastroTelefone: TFrmCadastroTelefone
  Caption = 'Cadastrar Telefone'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object lblTipoTelefone: TLabel
        Left = 40
        Top = 14
        Width = 26
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblNumero: TLabel
        Left = 40
        Top = 85
        Width = 49
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblObservacao: TLabel
        Left = 40
        Top = 159
        Width = 77
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Observa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object cmbTipoTelefone: TComboBox
        Left = 40
        Top = 33
        Width = 144
        Height = 24
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnChange = cmbTipoTelefoneChange
      end
      object edtObservacao: TEdit
        Left = 40
        Top = 181
        Width = 497
        Height = 24
        TabOrder = 2
      end
      object edtNumero: TMaskEdit
        Left = 40
        Top = 107
        Width = 145
        Height = 24
        TabOrder = 1
        Text = ''
      end
    end
  end
end
