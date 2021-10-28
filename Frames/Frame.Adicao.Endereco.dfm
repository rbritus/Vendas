inherited FrameAdicaoEndereco: TFrameAdicaoEndereco
  Width = 760
  Height = 165
  ExplicitWidth = 760
  ExplicitHeight = 165
  inherited pnlFundo: TPanel
    Width = 760
    Height = 165
    ExplicitWidth = 760
    ExplicitHeight = 165
    inherited pnlConteudo: TPanel
      Width = 760
      Height = 130
      ExplicitWidth = 760
      ExplicitHeight = 130
      inherited DBCtrlGrid1: TDBCtrlGrid
        Width = 760
        Height = 126
        Align = alCustom
        PanelHeight = 42
        PanelWidth = 743
        RowCount = 3
        ExplicitWidth = 760
        ExplicitHeight = 126
        object edtTipoEndereco: TDBText [0]
          Left = 16
          Top = 6
          Width = 90
          Height = 17
          DataField = 'TIPO_ENDERECO_CUSTOM'
          DataSource = dscDados
        end
        object edtCEP: TDBText [1]
          Left = 110
          Top = 6
          Width = 90
          Height = 17
          DataField = 'CEP'
          DataSource = dscDados
        end
        object edtEndereco: TDBText [2]
          Left = 16
          Top = 24
          Width = 337
          Height = 17
          DataField = 'LOGRADOURO'
          DataSource = dscDados
        end
        object edtNumero: TDBText [3]
          Left = 381
          Top = 24
          Width = 30
          Height = 17
          DataField = 'NUMERO'
          DataSource = dscDados
        end
        object lblNumero: TLabel [4]
          Left = 359
          Top = 24
          Width = 16
          Height = 13
          Caption = 'N'#186'.'
        end
        object edtCidade: TDBText [5]
          Left = 432
          Top = 24
          Width = 200
          Height = 17
          Alignment = taRightJustify
          DataField = 'CIDADE'
          DataSource = dscDados
        end
        object edtEstado: TDBText [6]
          Left = 649
          Top = 24
          Width = 30
          Height = 17
          DataField = 'ESTADO'
          DataSource = dscDados
        end
        object lblTraco: TLabel [7]
          Left = 637
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
        inherited Panel3: TPanel
          Left = 683
          Height = 42
          ExplicitLeft = 683
          ExplicitHeight = 42
          inherited imgBtnExcluir: TImage
            Top = 8
            ExplicitTop = 8
          end
          inherited imgBtnAlterar: TImage
            Top = 8
            ExplicitTop = 8
          end
        end
      end
    end
    inherited pnlMenu: TPanel
      Width = 760
      ExplicitWidth = 760
    end
  end
  inherited imgListaBotoes: TImageList
    Top = 136
  end
end
