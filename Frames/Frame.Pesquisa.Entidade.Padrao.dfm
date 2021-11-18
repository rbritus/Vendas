inherited FramePesquisaEntidadePadrao: TFramePesquisaEntidadePadrao
  Width = 397
  Height = 47
  Constraints.MaxHeight = 47
  Constraints.MinHeight = 47
  ExplicitWidth = 397
  ExplicitHeight = 47
  inherited pnlFundo: TPanel
    Width = 397
    Height = 47
    ExplicitWidth = 372
    ExplicitHeight = 45
    inherited pnlConteudo: TPanel
      Width = 397
      Height = 47
      ExplicitWidth = 372
      ExplicitHeight = 51
      DesignSize = (
        397
        47)
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 92
        Height = 16
        Caption = 'Renomer label'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 0
        Top = 22
        Width = 351
        Height = 24
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        ExplicitWidth = 326
      end
      object btnInserir: TBitBtn
        Left = 352
        Top = 24
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '+'
        TabOrder = 1
        OnClick = btnInserirClick
        ExplicitLeft = 327
      end
      object btnExcluir: TBitBtn
        Left = 374
        Top = 24
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '-'
        TabOrder = 2
        OnClick = btnExcluirClick
        ExplicitLeft = 349
      end
    end
  end
  inherited imgListaBotoes16: TImageList
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
