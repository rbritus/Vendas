inherited FrameAdicaoTelefone: TFrameAdicaoTelefone
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      inherited DBCtrlGrid1: TDBCtrlGrid
        object edtTipoEndereco: TDBText [0]
          Left = 16
          Top = 22
          Width = 57
          Height = 17
          DataField = 'TIPO_TELEFONE_CUSTOM'
          DataSource = dscDados
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtNumero: TDBText [1]
          Left = 72
          Top = 22
          Width = 169
          Height = 17
          DataField = 'NUMERO'
          DataSource = dscDados
        end
        object edtObservacao: TDBText [2]
          Left = 325
          Top = 22
          Width = 316
          Height = 17
          DataField = 'OBSERVACAO'
          DataSource = dscDados
        end
        object lblCEP: TLabel [3]
          Left = 257
          Top = 22
          Width = 62
          Height = 13
          Caption = 'Observa'#231#227'o:'
        end
      end
    end
    inherited pnlTitulo: TPanel
      inherited lblTitulo: TLabel
        Width = 49
        Caption = 'Telefone'
        ExplicitWidth = 49
      end
    end
  end
end
