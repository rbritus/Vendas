inherited FrameAdicaoEndereco: TFrameAdicaoEndereco
  Width = 760
  Height = 180
  ExplicitWidth = 760
  ExplicitHeight = 180
  inherited pnlFundo: TPanel
    Width = 760
    Height = 180
    AutoSize = True
    ExplicitWidth = 760
    ExplicitHeight = 180
    inherited pnlConteudo: TPanel
      Width = 760
      Height = 98
      AutoSize = True
      TabOrder = 1
      ExplicitWidth = 760
      ExplicitHeight = 98
      inherited DBCtrlGrid1: TDBCtrlGrid
        Width = 760
        Height = 42
        Align = alCustom
        PanelHeight = 42
        PanelWidth = 743
        RowCount = 1
        ExplicitWidth = 760
        ExplicitHeight = 42
        object edtTipoEndereco: TDBText [0]
          Left = 16
          Top = 6
          Width = 100
          Height = 17
          DataField = 'TIPO_ENDERECO_CUSTOM'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCEP: TDBText [1]
          Left = 164
          Top = 6
          Width = 77
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
          Width = 170
          Height = 17
          Alignment = taRightJustify
          DataField = 'CIDADE'
          DataSource = dscDados
        end
        object edtEstado: TDBText [6]
          Left = 620
          Top = 24
          Width = 30
          Height = 17
          DataField = 'ESTADO'
          DataSource = dscDados
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
          Top = 6
          Width = 23
          Height = 13
          Caption = 'CEP:'
        end
        inherited Panel3: TPanel
          Left = 656
          Height = 42
          ExplicitLeft = 656
          ExplicitHeight = 42
          inherited imgBtnExcluir: TImage
            Top = 7
            ExplicitTop = 7
          end
          inherited imgBtnAlterar: TImage
            Top = 7
            ExplicitTop = 7
          end
        end
      end
    end
    inherited pnlMenu: TPanel
      Width = 760
      TabOrder = 0
      ExplicitWidth = 760
    end
    inherited pnlTitulo: TPanel
      Width = 760
      ExplicitWidth = 760
      inherited lblTitulo: TLabel
        Width = 52
        Caption = 'Endere'#231'o'
        ExplicitWidth = 52
      end
      inherited Label4: TLabel
        Width = 760
        ExplicitWidth = 760
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
