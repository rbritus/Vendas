inherited FrameAdicaoPadrao: TFrameAdicaoPadrao
  inherited pnlFundo: TPanel
    inherited pnlConteudo: TPanel
      Top = 44
      Height = 197
      ExplicitTop = 44
      ExplicitHeight = 197
      object DBCtrlGrid1: TDBCtrlGrid
        Left = 0
        Top = 3
        Width = 800
        Height = 194
        Align = alClient
        AllowDelete = False
        AllowInsert = False
        DataSource = dscDados
        PanelHeight = 48
        PanelWidth = 783
        TabOrder = 0
        RowCount = 4
        Visible = False
        object Panel3: TPanel
          Left = 696
          Top = 0
          Width = 87
          Height = 48
          Align = alRight
          BevelOuter = bvNone
          Caption = 'Panel2'
          UseDockManager = False
          ShowCaption = False
          TabOrder = 0
          StyleElements = [seFont, seClient]
          object imgBtnExcluir: TImage
            Left = 45
            Top = 8
            Width = 32
            Height = 32
            Cursor = crHandPoint
            Hint = 'Excluir registro'
            ParentShowHint = False
            Picture.Data = {
              0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000020
              000000200806000000737A7AF40000000473424954080808087C086488000000
              0970485973000000EC000000EC01792871BD0000001974455874536F66747761
              7265007777772E696E6B73636170652E6F72679BEE3C1A000003D04944415458
              85AD97DF4F1C5514C73F67661796DD858215824D4DAC494D4C4CB1B540D0972D
              F547105F4A6C823EF4C9C4C4177DD327346A62FA4278E9837F80D6C6C6FA4041
              2AD48D09524AB5B5A64F35D48894AA010BCC74978599E303B3EC2E3F76EE367C
              934966CE7CEFF99E7BCFBD67CE088698EF6AAFAB5ED16E153A055A509E40A807
              40B98FF087AADC40B89CCD462E368E8F2F9BF89530C2D2F1B6A72C781FE805E2
              86F13E00CE7A969CDEF3FDE4ED870A403B3A6ADCB8FF09E8BB40C45078335681
              818417EF93743A6B1CC0E24BED076D4FBF4178E621854BA070C58A783D89919F
              E74203705F3C7A587D6B04A17137C48BF0174877726CF2E68E0104331F2F276E
              B73D4FF4F537B67DB77AFE2CDED59FCA07E1696B323D752F6FB0F2379A4AC56C
              5FBF0E9B79B4A717D9DB88CEDD2DB9646F23D19EDE724301F6139141EDE8A8C9
              1B3636976B673E055A36A862117DED042412251EEC96C378BF5CC39F9B2DB1CB
              A34DD8478E12ED3D556257D7616DF05B503F30F09C135FFB00F81082140447ED
              56714092AC2536F039521D0B9B5559E84A96EC7B6FA34EA12C0838EAE9C1647A
              EA5E042038E725474D9D65326FBD591894AC35A81AF9C194086EF33A2996F401
              EFC87C577B5D754EE7082932F1F3DF21F50D66FAFF2DF0E0645718CDCD64A38F
              59D52BDA1D260EA0CB8B46E2EBDC25135A2216CBBD6AA9D069E474C9C869C035
              0EB6D392E29D5F0E45B3F2676758BD706EE379F5C239FCD99902B74CFE4B2187
              2CE08009B57859D72E0D913BD38FBA0EEA3AE4CEF4B37669685B6E5979783202
              D41905509C82FC99F675AB8D8A52B0C70AE7044E9D0AF6C0B2690AD64BB19967
              C3655DE71AAFC0A205DC316156B0ACC65C85694B556E9839AD2405C6DC5F2D84
              CBBBECD43C5865CCCA783583801B4AAE240033AE9BF1E3C356533AED005F853B
              2DE4D56ADE87343C82D4C4D6AFFA06ACE67D05B2C18951952F9BD2694720E884
              7CBD0544771C2116899171B08293EB7960DB5BEF7D1FF795174AEAC236C84544
              9F8E8D4E4D5B0041EB3C503E64BFF4139B17DC74AFCB4B61E2A0D21F1B9D9A86
              A2962CE1C5FB14AE941D6790DB308EC244A27AFEA3FC73A1034AA7B34EAAF504
              B65C051EDF6EB0776D12FD7B4B675D027FE6CF72F2776D8D9C94E1DF57367437
              539CE3ED87402F02FBCB2A558E19C4EE4E8E4EFC566CDCF22D488E4DDED4AAD5
              23C08FBBA5AC3081A76D9BC5B70D00A076F8FABF89AA859715FD18931AB13372
              A09F25AB168E15FF0B1423B4CD7452ADCD62499F0AA78044183F80ABE81751E1
              747EB7EF04D33E977F52A9648DED76831C13E159940310FC9EC37D843B0AD741
              7FC8AC25868202178AFF014FC4981A440169470000000049454E44AE426082}
            ShowHint = True
            OnClick = imgBtnExcluirClick
          end
          object imgBtnAlterar: TImage
            Left = 7
            Top = 8
            Width = 32
            Height = 32
            Cursor = crHandPoint
            Hint = 'Alterar registro'
            Center = True
            ParentShowHint = False
            Picture.Data = {
              0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000020
              000000200806000000737A7AF40000000473424954080808087C086488000000
              0970485973000000EC000000EC01792871BD0000001974455874536F66747761
              7265007777772E696E6B73636170652E6F72679BEE3C1A000003444944415458
              85C5974D68545714C77FE766329338211A2512B516BFA20644D35AA4054DFAA6
              206A44A410D08D0B5111378220862E82B485E2A6BA950ABAF10BC1955ADA62C6
              0FD02042ABD185A62629F5232AF811E725332F3373BA784EE74D32C98C9927F9
              EFEEBDE79EDFFF5DEE3DF73EA1486927D5C4832D2011445680CE03A6BD1F7E03
              D287E85FA01D18E7A2ACE65D3179A520F87A6831693D00B2059852A4DF41E034
              70489A13DD1332A037A86438F403B0170814091EA961942368A25D2CE2451BD0
              ABA17AE03CB06C82E091193B91C0B7D234F8ACA001BD5AFE1998DF805A7FE0FF
              EB31A22DD2E4DCF5769A5C78A8DE5778E5426FEB13542E6A345C97D78046A940
              39E71BBCB615BEB803B377E79A30A90B7A83CA510630A11F1156F80207083780
              0460D16198B5D333A02B4956B4655A0299A3C67D26BEDBB39AB905E27D30D009
              F30EC2A76DA049B8DD08437F67A262A403F562D9FD2ED03DE73EC0B7C2926390
              B6A16B13F41D041486BABD70802ACA92EDC01ED14EAA49849E517C91C9AFDA56
              587A3CFB1D291BEE6D86B7D7C79A6153969865DCF25A227CE656587A2277114D
              0584E68C372B4C2AB8C180444A82D7B6C2925F40CAB27D9A8287BBE0C5990293
              2562DC8BA504B877D9BDF0E7278B48A0CB0DE8FCC98103C8820050ED1F7C273C
              3FF52199A69AC2311F0D0EB8957060B2E0C05B03D23B4970407B8CFB8C9A20FC
              C18E12E00072C780768C1B337DFDE822A32978B01D5E9C2E010EA85E36A49C0B
              803D66D0EB3FE0D13E48C546C0CF9606071B757E35621103F297ACB9FB61DAD7
              F0F428F47EE7271C8453621173AF63F70D781F28CF0604E1AB7F2050035D1BE1
              CD15A889C0ABDF4B87838391065913EF3100D29CE846399213521371E1C95750
              D5E8DEE9FEC001F959D6C47BC0F328D52815986014E44B00666C024DC0EB0ED0
              619FC0007A13DBB16403891C03AE89701D26790B98EB23D1ABA724CD2AF966E8
              49A623A7148B65F723BA1178FC11E0FF82AEF3C24719009026E72E52FE3970CD
              3FB6DE241D5825CD4ED7C891BC979134C55E6227D622F23DE3D588C27250F909
              DBB1C4B2FBF3B20A65D068B88EB2643BCA36205C24D8064E62E45066B78FA582
              06B246A8C2045B402CD04690F9E4FC9E6B2FC89FA051D2CEA5F705AEA0FE036C
              B4374024B3061C0000000049454E44AE426082}
            ShowHint = True
            OnClick = imgBtnAlterarClick
          end
          object Panel4: TPanel
            Left = 0
            Top = 2
            Width = 1
            Height = 46
            Align = alCustom
            BevelOuter = bvNone
            Color = -1
            ParentBackground = False
            TabOrder = 0
          end
        end
      end
    end
    object pnlMenu: TPanel
      Left = 0
      Top = 0
      Width = 800
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object SpeedButton5: TSpeedButton
        AlignWithMargins = True
        Left = 49
        Top = 5
        Width = 34
        Height = 34
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        GroupIndex = 1
        Caption = 'X'
        ImageIndex = 0
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        Visible = False
        OnMouseEnter = SpeedButton5MouseEnter
        OnMouseLeave = SpeedButton5MouseLeave
        ExplicitLeft = 47
      end
      object btnAdicionar: TSpeedButton
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 34
        Height = 34
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        GroupIndex = 1
        ImageIndex = 3
        Images = imgListaBotoes32
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6710886
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 10
        OnClick = btnAdicionarClick
        OnMouseEnter = btnAdicionarMouseEnter
        OnMouseLeave = btnAdicionarMouseLeave
      end
      object pnlBarraLateralBotao: TPanel
        Left = 5
        Top = 38
        Width = 34
        Height = 5
        BevelOuter = bvNone
        Color = 16744448
        ParentBackground = False
        TabOrder = 0
        Visible = False
      end
    end
  end
  inherited imgListaBotoes16: TImageList
    Left = 104
    Top = 88
    Bitmap = {
      494C010100000800040010001000FFFFFFFF2100FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000}
  end
  inherited imgListaBotoes32: TImageList
    Left = 176
    Top = 88
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 8
    Top = 89
  end
  object dscDados: TDataSource
    DataSet = cdsDados
    Left = 48
    Top = 89
  end
end
