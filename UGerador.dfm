object Gerador: TGerador
  Left = 0
  Top = 0
  Caption = 'Gerador'
  ClientHeight = 202
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 169
    Height = 16
    Caption = 'Vers'#227'o do leiaute n'#186' 1.0.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edCOD_FIN: TRadioGroup
    Left = 10
    Top = 35
    Width = 221
    Height = 105
    Caption = 'Finalidade da Entrega'
    Items.Strings = (
      'Remessa regular'
      'Remessa requerida por intima'#231#227'o'
      'Remessa para substitui'#231#227'o do anterior')
    TabOrder = 0
    OnClick = AnyChange
  end
  object GroupBox1: TGroupBox
    Left = 242
    Top = 35
    Width = 166
    Height = 71
    Caption = 'Apura'#231#227'o'
    TabOrder = 1
    object Label2: TLabel
      Left = 10
      Top = 20
      Width = 36
      Height = 13
      Caption = 'Per'#237'odo'
      FocusControl = edPERIODO
    end
    object Label3: TLabel
      Left = 95
      Top = 20
      Width = 19
      Height = 13
      Caption = 'Ano'
    end
    object edPERIODO: TComboBox
      Left = 10
      Top = 35
      Width = 76
      Height = 21
      Style = csDropDownList
      DropDownCount = 13
      TabOrder = 0
      OnChange = AnyChange
      Items.Strings = (
        'Exerc'#237'cio'
        'Janeiro'
        'Fevereiro'
        'Mar'#231'o'
        'Abril'
        'Maio'
        'Junho'
        'Julho'
        'Agosto'
        'Setembro'
        'Outubro'
        'Novembro'
        'Dezembro')
    end
    object edANO: TDBLookupComboBox
      Left = 95
      Top = 35
      Width = 61
      Height = 21
      KeyField = 'Ano'
      ListField = 'Ano'
      ListSource = dsAnos
      TabOrder = 1
      OnClick = AnyChange
    end
  end
  object btOk: TButton
    Left = 242
    Top = 115
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btOkClick
  end
  object Button2: TButton
    Left = 333
    Top = 115
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 10
    Top = 150
    Width = 346
    Height = 17
    Caption = 'N'#227'o relacionar os registros de opera'#231#245'es de entrada'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = AnyChange
  end
  object CheckBox2: TCheckBox
    Left = 10
    Top = 170
    Width = 346
    Height = 17
    Caption = 
      'N'#227'o informar o total do ICMS nos registro de opera'#231#245'es de entrad' +
      'a'
    TabOrder = 5
    OnClick = AnyChange
  end
  object qryAnos: TADOQuery
    Connection = Dados.Conn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT YEAR(DATA) AS Ano FROM Documentos'
      'ORDER BY 1 DESC')
    Left = 305
    Top = 10
  end
  object dsAnos: TDataSource
    DataSet = qryAnos
    Left = 350
    Top = 10
  end
end
