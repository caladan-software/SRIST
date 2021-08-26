object Dados: TDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 243
  Width = 332
  object Conn: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\AronB\Docu' +
      'ments\Projects\Delphi\SRIST\SRIST.mdb;Persist Security Info=Fals' +
      'e;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 20
    Top = 20
  end
  object TmpCmd: TADOCommand
    Connection = Conn
    Parameters = <>
    Left = 20
    Top = 70
  end
  object TmpQry: TADOQuery
    Connection = Conn
    Parameters = <>
    Left = 20
    Top = 120
  end
  object TEmpresa: TADOTable
    Connection = Conn
    CursorType = ctStatic
    BeforePost = ClearNullsBeforePost
    TableName = 'Empresa'
    Left = 100
    Top = 20
  end
  object DEmpresa: TDataSource
    DataSet = TEmpresa
    Left = 155
    Top = 20
  end
  object TParticipantes: TADOTable
    Connection = Conn
    CursorType = ctStatic
    BeforePost = ClearNullsBeforePost
    TableName = 'Participantes'
    Left = 100
    Top = 70
  end
  object DParticipantes: TDataSource
    DataSet = TParticipantes
    Left = 155
    Top = 70
  end
  object TItens: TADOTable
    Connection = Conn
    CursorType = ctStatic
    BeforePost = ClearNullsBeforePost
    TableName = 'Itens'
    Left = 100
    Top = 120
  end
  object DItens: TDataSource
    DataSet = TItens
    Left = 155
    Top = 120
  end
  object TDocumentos: TADOTable
    Connection = Conn
    CursorType = ctStatic
    AfterInsert = TDocumentosAfterInsert
    BeforePost = ClearNullsBeforePost
    TableName = 'Documentos'
    Left = 100
    Top = 170
  end
  object DDocumentos: TDataSource
    DataSet = TDocumentos
    Left = 155
    Top = 170
  end
end
