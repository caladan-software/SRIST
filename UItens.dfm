object Itens: TItens
  Left = 0
  Top = 0
  Caption = 'Itens'
  ClientHeight = 327
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 302
    Width = 745
    Height = 25
    DataSource = Dados.DItens
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
    Height = 302
    Align = alClient
    DataSource = Dados.DItens
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnKeyUp = DBGrid1KeyUp
    OnTitleClick = DBGrid1TitleClick
  end
  object Panel1: TPanel
    Left = 304
    Top = 0
    Width = 441
    Height = 302
    Align = alRight
    Constraints.MinWidth = 441
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 10
      Width = 73
      Height = 13
      Caption = 'C'#243'digo do Item'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 10
      Top = 50
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 10
      Top = 90
      Width = 77
      Height = 13
      Caption = 'C'#243'digo de Barra'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 10
      Top = 130
      Width = 91
      Height = 13
      Caption = 'Unidade de Medida'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 10
      Top = 170
      Width = 58
      Height = 13
      Caption = 'C'#243'digo NCM'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 10
      Top = 210
      Width = 82
      Height = 13
      Caption = 'Al'#237'quota de ICMS'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 10
      Top = 250
      Width = 141
      Height = 13
      Caption = 'C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
      FocusControl = DBEdit7
    end
    object DBEdit1: TDBEdit
      Left = 10
      Top = 25
      Width = 121
      Height = 21
      DataField = 'COD_ITEM'
      DataSource = Dados.DItens
      TabOrder = 0
      OnKeyPress = FormKeyPress
    end
    object DBEdit2: TDBEdit
      Left = 10
      Top = 65
      Width = 421
      Height = 21
      DataField = 'DESCR_ITEM'
      DataSource = Dados.DItens
      TabOrder = 1
      OnKeyPress = FormKeyPress
    end
    object DBEdit3: TDBEdit
      Left = 10
      Top = 105
      Width = 121
      Height = 21
      DataField = 'COD_BARRA'
      DataSource = Dados.DItens
      TabOrder = 2
      OnKeyPress = FormKeyPress
    end
    object DBEdit4: TDBEdit
      Left = 10
      Top = 145
      Width = 121
      Height = 21
      DataField = 'UNID_INV'
      DataSource = Dados.DItens
      TabOrder = 3
      OnKeyPress = FormKeyPress
    end
    object DBEdit5: TDBEdit
      Left = 10
      Top = 185
      Width = 121
      Height = 21
      DataField = 'COD_NCM'
      DataSource = Dados.DItens
      TabOrder = 4
      OnKeyPress = FormKeyPress
    end
    object DBEdit6: TDBEdit
      Left = 10
      Top = 225
      Width = 121
      Height = 21
      DataField = 'ALIQ_ICMS'
      DataSource = Dados.DItens
      TabOrder = 5
      OnKeyPress = FormKeyPress
    end
    object DBEdit7: TDBEdit
      Left = 10
      Top = 265
      Width = 121
      Height = 21
      DataField = 'CEST'
      DataSource = Dados.DItens
      TabOrder = 6
      OnKeyPress = FormKeyPress
    end
    object DBGrid2: TDBGrid
      Left = 160
      Top = 103
      Width = 271
      Height = 183
      Constraints.MaxWidth = 471
      DataSource = dsMov
      ReadOnly = True
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object qryMov: TADOQuery
    Connection = Dados.Conn
    CursorType = ctStatic
    Parameters = <>
    Left = 575
    Top = 10
  end
  object dsMov: TDataSource
    DataSet = qryMov
    Left = 620
    Top = 10
  end
end
