inherited FrmCadastroListaPessoa: TFrmCadastroListaPessoa
  Caption = 'Pessoas'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 13
  inherited pnlFundo: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited pnlConteudo: TScrollBox
      TabOrder = 1
    end
    inherited pnlMenu: TPanel
      TabOrder = 2
      StyleElements = [seFont, seClient, seBorder]
      inherited pnlBarraLateralBotao: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited FrameFiltroPesquisa1: TFrameFiltroPesquisa
      TabOrder = 0
      inherited pnlFundo: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited pnlConteudo: TPanel
          StyleElements = [seFont, seClient, seBorder]
          inherited pnlFiltros: TPanel
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited pnlPesquisa: TPanel
          StyleElements = [seFont, seClient, seBorder]
          inherited edtPesquisa: TEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
      end
    end
  end
end
