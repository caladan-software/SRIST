object Empresa: TEmpresa
  Left = 0
  Top = 0
  Caption = 'Empresa'
  ClientHeight = 122
  ClientWidth = 450
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
    Width = 85
    Height = 13
    Caption = 'Nome Empresarial'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 10
    Top = 50
    Width = 25
    Height = 13
    Caption = 'CNPJ'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 165
    Top = 50
    Width = 87
    Height = 13
    Caption = 'Inscri'#231#227'o Estadual'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 318
    Top = 50
    Width = 94
    Height = 13
    Caption = 'C'#243'digo do Munic'#237'pio'
    FocusControl = DBEdit4
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 97
    Width = 450
    Height = 25
    DataSource = Dados.DEmpresa
    VisibleButtons = [nbEdit, nbPost, nbCancel, nbRefresh]
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
  object DBEdit1: TDBEdit
    Left = 10
    Top = 25
    Width = 429
    Height = 21
    DataField = 'NOME'
    DataSource = Dados.DEmpresa
    TabOrder = 1
    OnKeyPress = FormKeyPress
  end
  object DBEdit2: TDBEdit
    Left = 10
    Top = 65
    Width = 121
    Height = 21
    DataField = 'CNPJ'
    DataSource = Dados.DEmpresa
    TabOrder = 2
    OnKeyPress = FormKeyPress
  end
  object DBEdit3: TDBEdit
    Left = 165
    Top = 65
    Width = 121
    Height = 21
    DataField = 'IE'
    DataSource = Dados.DEmpresa
    TabOrder = 3
    OnKeyPress = FormKeyPress
  end
  object DBEdit4: TDBEdit
    Left = 318
    Top = 65
    Width = 121
    Height = 21
    DataField = 'COD_MUN'
    DataSource = Dados.DEmpresa
    TabOrder = 4
    OnKeyPress = FormKeyPress
  end
end
