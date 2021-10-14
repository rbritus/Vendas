inherited FramePesquisaEntidadePadrao: TFramePesquisaEntidadePadrao
  Width = 372
  Height = 45
  ExplicitWidth = 372
  ExplicitHeight = 45
  inherited pnlFundo: TPanel
    Width = 372
    Height = 45
    ExplicitWidth = 377
    ExplicitHeight = 45
    inherited pnlConteudo: TPanel
      Width = 372
      Height = 45
      ExplicitWidth = 377
      ExplicitHeight = 45
      DesignSize = (
        372
        45)
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 68
        Height = 13
        Caption = 'Renomer label'
      end
      object Edit1: TEdit
        Left = 0
        Top = 19
        Width = 326
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
      object btnInserir: TBitBtn
        Left = 327
        Top = 19
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '+'
        TabOrder = 1
      end
      object btnExcluir: TBitBtn
        Left = 349
        Top = 19
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '-'
        TabOrder = 2
      end
    end
  end
  inherited imgListaBotoes: TImageList
    Left = 160
    Top = 65528
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 65528
  end
  object dsc: TDataSource
    DataSet = cds
    Left = 192
    Top = 65528
  end
end
