object Participantes: TParticipantes
  Left = 0
  Top = 0
  Caption = 'Participantes'
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
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 302
    Width = 745
    Height = 25
    DataSource = Dados.DParticipantes
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
    DataSource = Dados.DParticipantes
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
    Width = 441
    Height = 302
    Align = alRight
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 10
      Width = 113
      Height = 13
      Caption = 'C'#243'digo de Identifica'#231#227'o'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 10
      Top = 50
      Width = 139
      Height = 13
      Caption = 'Nome Pessoal ou Empresarial'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 10
      Top = 90
      Width = 70
      Height = 13
      Caption = 'C'#243'digo do Pa'#237's'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 10
      Top = 130
      Width = 25
      Height = 13
      Caption = 'CNPJ'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 10
      Top = 170
      Width = 19
      Height = 13
      Caption = 'CPF'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 10
      Top = 210
      Width = 87
      Height = 13
      Caption = 'Inscri'#231#227'o Estadual'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 10
      Top = 250
      Width = 94
      Height = 13
      Caption = 'C'#243'digo do Munic'#237'pio'
      FocusControl = DBEdit7
    end
    object DBEdit1: TDBEdit
      Left = 10
      Top = 25
      Width = 121
      Height = 21
      DataField = 'COD_PART'
      DataSource = Dados.DParticipantes
      TabOrder = 0
      OnKeyPress = FormKeyPress
    end
    object DBEdit2: TDBEdit
      Left = 10
      Top = 65
      Width = 421
      Height = 21
      DataField = 'NOME'
      DataSource = Dados.DParticipantes
      TabOrder = 1
      OnKeyPress = FormKeyPress
    end
    object DBEdit3: TDBEdit
      Left = 10
      Top = 105
      Width = 121
      Height = 21
      DataField = 'COD_PAIS'
      DataSource = Dados.DParticipantes
      TabOrder = 2
      OnKeyPress = FormKeyPress
    end
    object DBEdit4: TDBEdit
      Left = 10
      Top = 145
      Width = 121
      Height = 21
      DataField = 'CNPJ'
      DataSource = Dados.DParticipantes
      TabOrder = 3
      OnKeyPress = FormKeyPress
    end
    object DBEdit5: TDBEdit
      Left = 10
      Top = 185
      Width = 121
      Height = 21
      DataField = 'CPF'
      DataSource = Dados.DParticipantes
      TabOrder = 4
      OnKeyPress = FormKeyPress
    end
    object DBEdit6: TDBEdit
      Left = 10
      Top = 225
      Width = 121
      Height = 21
      DataField = 'IE'
      DataSource = Dados.DParticipantes
      TabOrder = 5
      OnKeyPress = FormKeyPress
    end
    object DBEdit7: TDBEdit
      Left = 10
      Top = 265
      Width = 121
      Height = 21
      DataField = 'COD_MUN'
      DataSource = Dados.DParticipantes
      TabOrder = 6
      OnKeyPress = FormKeyPress
    end
  end
end
