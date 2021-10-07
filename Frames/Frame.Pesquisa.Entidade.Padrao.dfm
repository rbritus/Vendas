inherited FramePadrao1: TFramePadrao1
  Width = 502
  Height = 101
  ExplicitWidth = 502
  ExplicitHeight = 101
  inherited pnlFundo: TPanel
    Width = 502
    Height = 101
    inherited pnlConteudo: TPanel
      Width = 502
      Height = 101
      ExplicitWidth = 513
      ExplicitHeight = 61
      object DBComboBox1: TDBComboBox
        Left = 8
        Top = 16
        Width = 145
        Height = 21
        TabOrder = 0
      end
    end
  end
  inherited imgListaBotoes: TImageList
    Left = 448
    Top = 40
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 440
  end
  object dsc: TDataSource
    DataSet = cds
    Left = 400
  end
end
