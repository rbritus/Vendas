inherited FrameAdicaoTelefone: TFrameAdicaoTelefone
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      inherited DBCtrlGrid1: TDBCtrlGrid
        object edtTipoEndereco: TDBText [0]
          Left = 18
          Top = 17
          Width = 73
          Height = 17
          DataField = 'TIPO_TELEFONE_CUSTOM'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtNumero: TDBText [1]
          Left = 97
          Top = 17
          Width = 154
          Height = 17
          DataField = 'NUMERO'
          DataSource = dscDados
        end
        object edtObservacao: TDBText [2]
          Left = 366
          Top = 17
          Width = 276
          Height = 17
          DataField = 'OBSERVACAO'
          DataSource = dscDados
        end
        object lblCEP: TLabel [3]
          Left = 268
          Top = 17
          Width = 92
          Height = 16
          Caption = 'OBSERVA'#199#195'O:'
        end
      end
    end
    inherited pnlTitulo: TPanel
      inherited lblTitulo: TLabel
        Width = 72
        Caption = 'Telefone'
        ExplicitWidth = 72
      end
    end
  end
end
