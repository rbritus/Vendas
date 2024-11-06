inherited FrmCadastroPessoa: TFrmCadastroPessoa
  Caption = 'Cadastrar Pessoa'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 13
  inherited pnlFundo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited pnlConteudo: TScrollBox
      object Label2: TLabel
        Left = 40
        Top = 86
        Width = 35
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 713
        Top = 86
        Width = 35
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 40
        Top = 12
        Width = 22
        Height = 16
        BiDiMode = bdLeftToRight
        Caption = 'CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtNome: TEdit
        Left = 40
        Top = 108
        Width = 625
        Height = 24
        TabOrder = 1
      end
      object tswAtivo: TToggleSwitch
        Left = 713
        Top = 108
        Height = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
        Top = 152
        Width = 760
        Height = 180
        AutoSize = True
        TabOrder = 3
        ExplicitLeft = 40
        ExplicitTop = 152
        inherited pnlFundo: TPanel
          StyleElements = [seFont, seClient, seBorder]
          inherited pnlConteudo: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited DBCtrlGrid1: TDBCtrlGrid
              Top = 6
              ExplicitTop = 6
              inherited edtTipoEndereco: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtCEP: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtEndereco: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtNumero: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited lblNumero: TLabel
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtCidade: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtEstado: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited lblTraco: TLabel
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited lblCEP: TLabel
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited pnlBotoes: TPanel
                StyleElements = [seFont, seClient]
                inherited Panel4: TPanel
                  StyleElements = [seFont, seClient, seBorder]
                end
              end
            end
          end
          inherited pnlMenu: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited pnlBarraLateralBotao: TPanel
              StyleElements = [seFont, seClient, seBorder]
            end
          end
          inherited pnlTitulo: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited lblTitulo: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label4: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited lblQuantidadeRegistros: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
          end
        end
      end
      object edtCPF: TMaskEdit
        Left = 40
        Top = 34
        Width = 169
        Height = 24
        TabOrder = 0
        Text = ''
      end
      inline FrameAdicaoTelefone: TFrameAdicaoTelefone
        Left = 40
        Top = 345
        Width = 760
        Height = 180
        TabOrder = 4
        ExplicitLeft = 40
        ExplicitTop = 345
        inherited pnlFundo: TPanel
          StyleElements = [seFont, seClient, seBorder]
          inherited pnlConteudo: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited DBCtrlGrid1: TDBCtrlGrid
              inherited edtTipoEndereco: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtNumero: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtObservacao: TDBText
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited lblCEP: TLabel
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited pnlBotoes: TPanel
                StyleElements = [seFont, seClient]
                inherited Panel4: TPanel
                  StyleElements = [seFont, seClient, seBorder]
                end
              end
            end
          end
          inherited pnlMenu: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited pnlBarraLateralBotao: TPanel
              StyleElements = [seFont, seClient, seBorder]
            end
          end
          inherited pnlTitulo: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited lblTitulo: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label4: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited lblQuantidadeRegistros: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
          end
        end
      end
    end
    inherited pnlMenu: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited pnlBarraLateralBotao: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
end
