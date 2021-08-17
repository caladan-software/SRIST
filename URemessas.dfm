object Remessas: TRemessas
  Left = 0
  Top = 0
  Caption = 'Remessas'
  ClientHeight = 201
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object List_Arquivos: TListBox
    Left = 0
    Top = 0
    Width = 121
    Height = 182
    Align = alLeft
    ItemHeight = 13
    TabOrder = 0
    OnClick = List_ArquivosClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 182
    Width = 477
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Texto: TMemo
    Left = 121
    Top = 0
    Width = 356
    Height = 182
    Align = alClient
    Lines.Strings = (
      'Texto')
    ReadOnly = True
    TabOrder = 2
    OnClick = TextoClick
    OnKeyUp = TextoKeyUp
  end
end
