inherited FrmCadastroEndereco: TFrmCadastroEndereco
  Caption = 'Cadastrar Endere'#231'o'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      object Label1: TLabel
        Left = 48
        Top = 14
        Width = 20
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 48
        Top = 108
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
      object Label3: TLabel
        Left = 574
        Top = 108
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
      object Label4: TLabel
        Left = 48
        Top = 156
        Width = 79
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 424
        Top = 156
        Width = 34
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 424
        Top = 211
        Width = 38
        Height = 13
        BiDiMode = bdLeftToRight
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 48
        Top = 60
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
      object edtCEP: TEdit
        Left = 48
        Top = 33
        Width = 120
        Height = 21
        TabOrder = 0
      end
      object btnConsultaCEP: TBitBtn
        Left = 171
        Top = 33
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        ImageIndex = 0
        Images = imgListaBotoes16
        TabOrder = 1
        OnClick = btnConsultaCEPClick
      end
      object edtLogradouro: TEdit
        Left = 48
        Top = 127
        Width = 505
        Height = 21
        TabOrder = 3
      end
      object edtNumero: TEdit
        Left = 574
        Top = 127
        Width = 88
        Height = 21
        TabOrder = 4
      end
      object edtComplemento: TEdit
        Left = 48
        Top = 175
        Width = 353
        Height = 21
        TabOrder = 5
      end
      object edtBairro: TEdit
        Left = 424
        Top = 175
        Width = 238
        Height = 21
        TabOrder = 6
      end
      inline FramePesquisaCidade: TFramePesquisaEntidadePadrao
        Left = 48
        Top = 211
        Width = 353
        Height = 45
        TabOrder = 7
        ExplicitLeft = 48
        ExplicitTop = 211
        ExplicitWidth = 353
        inherited pnlFundo: TPanel
          Width = 353
          ExplicitWidth = 353
          inherited pnlConteudo: TPanel
            Width = 353
            ExplicitWidth = 353
            inherited Label1: TLabel
              Width = 38
              Caption = 'Cidade'
              ExplicitWidth = 38
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
        Left = 424
        Top = 230
        Width = 50
        Height = 21
        TabStop = False
        ReadOnly = True
        TabOrder = 8
      end
      object cmbTipoEndereco: TComboBox
        Left = 48
        Top = 79
        Width = 144
        Height = 21
        TabOrder = 2
      end
    end
  end
  inherited imgListaBotoes16: TImageList
    Left = 104
  end
end
