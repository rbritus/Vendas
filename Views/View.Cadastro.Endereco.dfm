inherited FrmCadastroEndereco: TFrmCadastroEndereco
  Caption = 'Cadastrar Endere'#231'o'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object Label1: TLabel
        Left = 48
        Top = 14
        Width = 23
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 48
        Top = 159
        Width = 60
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 574
        Top = 159
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
      object Label4: TLabel
        Left = 49
        Top = 233
        Width = 87
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 440
        Top = 233
        Width = 39
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 440
        Top = 318
        Width = 44
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 48
        Top = 85
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
      object btnConsultaCEP: TSpeedButton
        Left = 171
        Top = 33
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        ImageIndex = 0
        Images = imgListaBotoes16
        OnClick = btnConsultaCEPClick
      end
      object edtCEP: TMaskEdit
        Left = 48
        Top = 33
        Width = 120
        Height = 24
        TabOrder = 0
        Text = ''
      end
      object edtLogradouro: TEdit
        Left = 48
        Top = 181
        Width = 489
        Height = 24
        TabOrder = 2
      end
      object edtNumero: TEdit
        Left = 574
        Top = 181
        Width = 88
        Height = 24
        Alignment = taRightJustify
        TabOrder = 3
      end
      object edtComplemento: TEdit
        Left = 48
        Top = 255
        Width = 351
        Height = 24
        TabOrder = 4
      end
      object edtBairro: TEdit
        Left = 440
        Top = 255
        Width = 222
        Height = 24
        TabOrder = 5
      end
      inline FramePesquisaCidade: TFramePesquisaEntidadePadrao
        Left = 48
        Top = 315
        Width = 353
        Height = 47
        Constraints.MaxHeight = 47
        Constraints.MinHeight = 47
        TabOrder = 6
        ExplicitLeft = 48
        ExplicitTop = 315
        ExplicitWidth = 353
        inherited pnlFundo: TPanel
          Width = 353
          ExplicitWidth = 353
          inherited pnlConteudo: TPanel
            Width = 353
            ExplicitTop = 19
            ExplicitWidth = 353
            DesignSize = (
              353
              47)
            inherited Label1: TLabel
              Width = 43
              Caption = 'Cidade'
              ExplicitWidth = 43
            end
            inherited Edit1: TEdit
              Width = 307
              OnChange = FramePesquisaCidadeEdit1Change
              ExplicitWidth = 307
            end
            inherited btnInserir: TBitBtn
              Left = 308
              ExplicitLeft = 308
            end
            inherited btnExcluir: TBitBtn
              Left = 330
              ExplicitLeft = 330
            end
          end
        end
      end
      object edtEstado: TEdit
        Left = 440
        Top = 337
        Width = 50
        Height = 24
        TabStop = False
        ReadOnly = True
        TabOrder = 7
      end
      object cmbTipoEndereco: TComboBox
        Left = 49
        Top = 107
        Width = 144
        Height = 24
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited imgListaBotoes16: TImageList
    Left = 104
  end
end
