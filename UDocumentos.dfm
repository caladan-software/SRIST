object Documentos: TDocumentos
  Left = 0
  Top = 0
  Caption = 'Documentos'
  ClientHeight = 392
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 367
    Width = 845
    Height = 25
    DataSource = Dados.DDocumentos
    Align = alBottom
    Hints.Strings = (
      'Primeiro registro'
      'Registro anterior'
      'Pr'#243'ximo registro'
      #218'ltimo registro'
      'Inserir registro'
      'Excluir registro'
      'Editar registro'
      'Gravar edi'#231#227'o'
      'Cancelar edi'#231#227'o'
      'Atualizar dados')
    TabOrder = 0
    BeforeAction = DBNavigator1BeforeAction
    OnClick = DBNavigator1Click
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 304
    Height = 367
    Align = alClient
    DataSource = Dados.DDocumentos
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object Panel1: TPanel
    Left = 304
    Top = 0
    Width = 541
    Height = 367
    Align = alRight
    TabOrder = 2
    object Label2: TLabel
      Left = 10
      Top = 95
      Width = 106
      Height = 13
      Caption = 'N'#186' Sequencial do Item'
      FocusControl = DBEdit6
    end
    object Label8: TLabel
      Left = 10
      Top = 150
      Width = 23
      Height = 13
      Caption = 'Data'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 145
      Top = 150
      Width = 62
      Height = 13
      Caption = 'C'#243'digo Fiscal'
    end
    object Label10: TLabel
      Left = 10
      Top = 190
      Width = 22
      Height = 13
      Caption = 'Item'
      FocusControl = DBLookupComboBox3
    end
    object Label11: TLabel
      Left = 10
      Top = 235
      Width = 56
      Height = 13
      Caption = 'Quantidade'
      FocusControl = DBEdit11
    end
    object Label12: TLabel
      Left = 10
      Top = 275
      Width = 94
      Height = 13
      Caption = 'Valor Total do ICMS'
      FocusControl = DBEdit12
    end
    object Label13: TLabel
      Left = 10
      Top = 315
      Width = 91
      Height = 13
      Caption = 'Valor de Confronto'
      FocusControl = DBEdit13
    end
    object Consulta: TImage
      Left = 135
      Top = 280
      Width = 16
      Height = 16
      Cursor = crHandPoint
      Hint = 'Clique para consultar valor do ICMS'
      AutoSize = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
        001008060000001FF3FF61000000097048597300000B1300000B1301009A9C18
        00000A4F6943435050686F746F73686F70204943432070726F66696C65000078
        DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A21
        09104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E4
        21A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C
        9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD
        230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C
        01808401C07491384B08801400407A8E42A600404601809D98265300A0040060
        CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365
        884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B7
        00C0CE100BB200080C00305188852900047B0060C8232378008499001446F257
        3CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B
        14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0E
        AECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2F
        B31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F8
        7E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3C
        FCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB7
        0BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2
        FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F700
        00F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44
        242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036
        844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051
        688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801
        628A58238E08179985F821C14804128B2420C9881451224B91354831528A5420
        55481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543
        B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F
        3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056
        AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A820
        1C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23
        D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223
        E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421
        F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DD
        A8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A
        681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583
        C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F99
        6F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB54
        8FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A8
        6F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B
        0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352
        F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931
        655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A
        275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477
        BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806
        B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E184
        91B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE
        9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDF
        B7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346
        AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806
        DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D
        5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613
        CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BD
        E44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E
        593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F91
        57ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8
        B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FB
        F87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC
        90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F
        8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3E
        AA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDF
        FCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C
        884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C
        2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A
        9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585
        B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B26765
        5766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A586
        4B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54F
        ABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D
        4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF
        99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40D
        DF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A4
        54F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB
        5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203
        FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D55
        8D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A
        429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794A
        F354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F
        6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6D
        EA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4
        BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727
        EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7
        068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743
        CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5
        FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE4
        7C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB0000000467
        414D410000B18E7CFB5193000002904944415478DA9DD35B4853711CC0F1EF99
        9B4EDDE64CCD39EC225D104B3035D09240EBA5B7EE4619D94B6005218A61BDE4
        5382048144D183469787A8870A8454AC872C2891A62E4271646ECE9C9795DBD9
        749773FA6B3DE4AD87FEF03B8773CE9F0FE7F7FBFF7E92AAAA2CAEC76995E27A
        59441EFF5E23221A383D797FE141FA0BF052DC60C094A58510680D10F143D82B
        3EAABF23C6043E47949E5B7E4E8E9B97032AA5CDC21791560CFA8D1074C0ECC0
        1F4001F92778051A9A85131E6925505407136DB8A4229E7F482012D591643222
        0765ACC6310E6EB111EF1E048D8A543EB90A907B8A9989219ABA72283B748EF5
        9959040281C53FF038ECB8073BA9DAF000A2E135806DA534772591B2FB2205F9
        79CC87C2CCCFCFA1D168501585CFDDED6C95EFB0D73CB00660B652F7A684E335
        B7498A83B9A8A86138824E2BA146C24CBB4719EE6EE1BCB56555C04F38125F63
        3FA3293C5C4D726C98184942923402D0125522C8BE599C3DCFB860B917902AA6
        12970332795571B5AD724CEDF59B226B51A8C5EC95C5BBA81C1E9793FE774FA9
        D037CA0230AC4CA1EC2EAD4F5E3125E573E4E83164D9876F561C99BAC0881AF4
        F65292DCC6CEE87B04B04A0D8AAF1174BEE4467B2ED64D3B282BDB2F10BF40FC
        D8FBFBF07C1FE54AF643E2A5D01A40DE59D1383682C97BE8F894C8DB8FDF16B6
        906131624E98673A68C1A88C5099F18284CAF15580ED0744FBCE80A5040C9BC4
        11B8457C15BB3404832A8F3AD7E10D9849D3B9F832AE4F6E6A6AFAB11448CD82
        A454B0EE8304D1CA8A47348D4BCC80180F258ACBE1A6C35EC898C7874EA7B3D5
        D75FDDB5749822510389262D99390248112F83A2F83ED0C50A4834C59493D7F6
        14C59B7E49D3D7672336565F2DFDC738DB1A87CAF5E99B0BB287871DD5BF0033
        CC46EF2BF9B09B0000000049454E44AE426082}
      OnClick = ConsultaClick
    end
    object DBCheckBox1: TDBCheckBox
      Left = 10
      Top = 10
      Width = 151
      Height = 17
      Caption = 'Documento Fiscal Eletr'#244'nico'
      DataField = 'ELETRO'
      DataSource = Dados.DDocumentos
      TabOrder = 0
      OnClick = DBCheckBox1Click
      OnKeyPress = FormKeyPress
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 35
      Width = 261
      Height = 56
      Caption = 'Chave'
      TabOrder = 1
      object DBEdit1: TDBEdit
        Left = 10
        Top = 20
        Width = 241
        Height = 21
        DataField = 'CHV_DOC'
        DataSource = Dados.DDocumentos
        TabOrder = 0
        OnKeyPress = FormKeyPress
      end
    end
    object GroupBox2: TGroupBox
      Left = 280
      Top = 10
      Width = 246
      Height = 186
      Caption = 'Documento N'#227'o Eletr'#244'nico'
      TabOrder = 2
      object Label3: TLabel
        Left = 10
        Top = 20
        Width = 57
        Height = 13
        Caption = 'Participante'
        FocusControl = DBLookupComboBox1
      end
      object Label4: TLabel
        Left = 10
        Top = 60
        Width = 34
        Height = 13
        Caption = 'Modelo'
        FocusControl = DBLookupComboBox2
      end
      object Label5: TLabel
        Left = 10
        Top = 100
        Width = 91
        Height = 13
        Caption = 'N'#186' de S'#233'rie do ECF'
        FocusControl = DBEdit3
      end
      object Label6: TLabel
        Left = 10
        Top = 140
        Width = 24
        Height = 13
        Caption = 'S'#233'rie'
        FocusControl = DBEdit4
      end
      object Label7: TLabel
        Left = 115
        Top = 140
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
        FocusControl = DBEdit5
      end
      object DBEdit3: TDBEdit
        Left = 10
        Top = 115
        Width = 226
        Height = 21
        DataField = 'ECF_FAB'
        DataSource = Dados.DDocumentos
        TabOrder = 2
        OnKeyPress = FormKeyPress
      end
      object DBEdit4: TDBEdit
        Left = 10
        Top = 155
        Width = 61
        Height = 21
        DataField = 'SER'
        DataSource = Dados.DDocumentos
        TabOrder = 3
        OnKeyPress = FormKeyPress
      end
      object DBLookupComboBox2: TDBLookupComboBox
        Left = 10
        Top = 75
        Width = 226
        Height = 21
        DataField = 'COD_MOD'
        DataSource = Dados.DDocumentos
        DropDownWidth = 300
        KeyField = 'CODIGO'
        ListField = 'DESCRICAO'
        TabOrder = 1
        OnKeyPress = FormKeyPress
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 10
        Top = 35
        Width = 226
        Height = 21
        DataField = 'COD_PART'
        DataSource = Dados.DDocumentos
        DropDownWidth = 300
        KeyField = 'COD_PART'
        ListField = 'NOME'
        ListSource = Dados.DParticipantes
        TabOrder = 0
        OnKeyPress = FormKeyPress
      end
      object DBEdit5: TDBEdit
        Left = 115
        Top = 155
        Width = 121
        Height = 21
        DataField = 'NUM_DOC'
        DataSource = Dados.DDocumentos
        TabOrder = 4
        OnKeyPress = FormKeyPress
      end
    end
    object DBEdit6: TDBEdit
      Left = 10
      Top = 110
      Width = 111
      Height = 21
      DataField = 'NUM_ITEM'
      DataSource = Dados.DDocumentos
      TabOrder = 3
      OnKeyPress = FormKeyPress
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 135
      Top = 95
      Width = 136
      Height = 46
      Caption = 'Tipo de Opera'#231#227'o'
      Columns = 2
      DataField = 'IND_OPER'
      DataSource = Dados.DDocumentos
      Items.Strings = (
        'Entrada'
        'Sa'#237'da')
      TabOrder = 4
      Values.Strings = (
        '0'
        '1')
      OnChange = DBRadioGroup1Change
    end
    object DBEdit8: TDBEdit
      Left = 10
      Top = 165
      Width = 121
      Height = 21
      DataField = 'DATA'
      DataSource = Dados.DDocumentos
      TabOrder = 5
      OnKeyPress = FormKeyPress
    end
    object DBEdit9: TDBEdit
      Left = 145
      Top = 165
      Width = 121
      Height = 21
      DataField = 'CFOP'
      DataSource = Dados.DDocumentos
      TabOrder = 6
      OnKeyPress = FormKeyPress
    end
    object DBEdit11: TDBEdit
      Left = 10
      Top = 250
      Width = 121
      Height = 21
      DataField = 'QTD'
      DataSource = Dados.DDocumentos
      TabOrder = 8
      OnKeyPress = FormKeyPress
    end
    object DBEdit12: TDBEdit
      Left = 10
      Top = 290
      Width = 121
      Height = 21
      DataField = 'ICMS_TOT'
      DataSource = Dados.DDocumentos
      TabOrder = 9
      OnKeyPress = FormKeyPress
    end
    object DBEdit13: TDBEdit
      Left = 10
      Top = 330
      Width = 121
      Height = 21
      DataField = 'VL_CONFR'
      DataSource = Dados.DDocumentos
      TabOrder = 10
      OnKeyPress = FormKeyPress
    end
    object DBRadioGroup2: TDBRadioGroup
      Left = 170
      Top = 235
      Width = 315
      Height = 121
      Caption = 'Enquadramento Legal de Ressarcimento no Art. 269 do RICMS'
      DataField = 'COD_LEGAL'
      DataSource = Dados.DDocumentos
      Items.Strings = (
        'N'#227'o ensejadora de ICMS-ST'
        'Ensejadora na hip'#243'tese do Inciso I'
        'Ensejadora na hip'#243'tese do Inciso II'
        'Ensejadora na hip'#243'tese do Inciso III'
        'Ensejadora na hip'#243'tese do Inciso IV')
      TabOrder = 11
      Values.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4')
    end
    object DBLookupComboBox3: TDBLookupComboBox
      Left = 10
      Top = 205
      Width = 516
      Height = 21
      DataField = 'COD_ITEM'
      DataSource = Dados.DDocumentos
      DropDownWidth = 300
      KeyField = 'COD_ITEM'
      ListField = 'DESCR_ITEM'
      ListSource = Dados.DItens
      TabOrder = 7
      OnKeyPress = FormKeyPress
    end
  end
  object T411: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = T411AfterOpen
    Left = 220
    Top = 20
    object T411CODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 2
    end
    object T411DESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
  object DT411: TDataSource
    DataSet = T411
    Left = 275
    Top = 20
  end
end
