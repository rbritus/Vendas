inherited FrameAdicaoEndereco: TFrameAdicaoEndereco
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      TabOrder = 1
      inherited DBCtrlGrid1: TDBCtrlGrid
        object edtTipoEndereco: TDBText [0]
          Left = 16
          Top = 2
          Width = 100
          Height = 17
          DataField = 'TIPO_ENDERECO_CUSTOM'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCEP: TDBText [1]
          Left = 170
          Top = 2
          Width = 77
          Height = 17
          DataField = 'CEP'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtEndereco: TDBText [2]
          Left = 16
          Top = 22
          Width = 337
          Height = 17
          DataField = 'LOGRADOURO'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtNumero: TDBText [3]
          Left = 381
          Top = 22
          Width = 30
          Height = 17
          DataField = 'NUMERO'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNumero: TLabel [4]
          Left = 359
          Top = 22
          Width = 19
          Height = 16
          Caption = 'N'#186'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCidade: TDBText [5]
          Left = 432
          Top = 22
          Width = 170
          Height = 17
          Alignment = taRightJustify
          DataField = 'CIDADE'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtEstado: TDBText [6]
          Left = 620
          Top = 22
          Width = 30
          Height = 17
          DataField = 'ESTADO'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTraco: TLabel [7]
          Left = 608
          Top = 24
          Width = 5
          Height = 13
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCEP: TLabel [8]
          Left = 137
          Top = 2
          Width = 28
          Height = 16
          Caption = 'CEP:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    inherited pnlMenu: TPanel
      TabOrder = 0
    end
    inherited pnlTitulo: TPanel
      inherited lblTitulo: TLabel
        Width = 75
        Caption = 'Endere'#231'o'
        ExplicitWidth = 75
      end
      inherited lblQuantidadeRegistros: TLabel
        Left = 80
        ExplicitLeft = 80
      end
    end
  end
  inherited imgListaBotoes16: TImageList
    Left = 408
    Top = 8
  end
  inherited imgListaBotoes32: TImageList
    Left = 464
    Top = 8
  end
  inherited cdsDados: TClientDataSet
    Left = 296
    Top = 9
  end
  inherited dscDados: TDataSource
    Left = 336
    Top = 9
  end
end
