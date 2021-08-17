object Abertura: TAbertura
  Left = 0
  Top = 0
  Caption = 'Abertura'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuPrincipal
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 77
    Height = 33
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 20
    Top = 65
    Width = 37
    Height = 16
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object MenuPrincipal: TMainMenu
    Left = 105
    Top = 15
    object mEmpresa: TMenuItem
      Caption = 'Empresa'
      OnClick = MenuClick
    end
    object mParticipantes: TMenuItem
      Caption = 'Participantes'
      OnClick = MenuClick
    end
    object mItens: TMenuItem
      Caption = 'Itens'
      OnClick = MenuClick
    end
    object mDocumentos: TMenuItem
      Caption = 'Documentos'
      OnClick = MenuClick
    end
    object mGerador: TMenuItem
      Caption = 'Gerador'
      OnClick = MenuClick
    end
    object mRemessas: TMenuItem
      Caption = 'Remessas'
      OnClick = MenuClick
    end
  end
end
