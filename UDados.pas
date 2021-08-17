unit UDados;

interface

uses
  SysUtils, Classes, Dialogs, ComObj, DBCtrls, DB, ADODB, ADOX_TLB;

type
  TDados = class(TDataModule)
    Conn: TADOConnection;
    TmpCmd: TADOCommand;
    TmpQry: TADOQuery;
    TEmpresa: TADOTable;
    DEmpresa: TDataSource;
    TParticipantes: TADOTable;
    DParticipantes: TDataSource;
    TItens: TADOTable;
    DItens: TDataSource;
    TDocumentos: TADOTable;
    DDocumentos: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure ClearNullsBeforePost(DataSet: TDataSet);
    procedure TDocumentosAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    var
      ACEDB, SQLDB,
      CfgDriver, CfgServer, CfgUsername, CfgPassword, CfgDatabase: String;
      CfgWinSecurity, Office2007, Office2010: Boolean;
    function CreateConnectionString(DRIVER, SERVER: String; WIS: Boolean;
                                    UID, PWD, DATABASE: String): String;
    procedure CreateAccessDatabase(DATABASE: String);
    procedure CheckDatabase(Connection: TADOConnection);
    function OpenDatabase(Connection: TADOConnection; IncludingTables: Boolean): Boolean;
    procedure CloseDatabase(Connection: TADOConnection);
    procedure NavigatorRefresh(Navigator: TDbNavigator);
    procedure SetFieldDefs;
    procedure SetIndexFieldNames;
  end;

var
  Dados: TDados;
  MaxWidth, MaxHeight, MinLeft, MinTop: Integer;

implementation

{$R *.dfm}

procedure TDados.DataModuleCreate(Sender: TObject);
var
  Providers: TStrings;
begin
  Providers := TStringList.Create;

  GetProviderNames(Providers);

  Office2007 := ( Providers.IndexOf('Microsoft.Access.OLEDB.10.0') > 0 );
  Office2010 := ( Providers.IndexOf('Microsoft.ACE.OLEDB.12.0') > 0 );

  if ( Providers.IndexOf('Microsoft.Jet.OLEDB.4.0') > 0 ) then ACEDB := 'Microsoft.Jet.OLEDB.4.0';
  if ( Providers.IndexOf('Microsoft.Access.OLEDB.10.0') > 0 ) then ACEDB := 'Microsoft.Access.OLEDB.10.0';
  if ( Providers.IndexOf('Microsoft.ACE.OLEDB.12.0') > 0 ) then ACEDB := 'Microsoft.ACE.OLEDB.12.0';

  if ( Providers.IndexOf('SQLOLEDB') > 0 ) then SQLDB := 'SQLOLEDB';
  if ( Providers.IndexOf('SQLNCLI') > 0 ) then SQLDB := 'SQLNCLI';
  if ( Providers.IndexOf('SQLNCLI10') > 0 ) then SQLDB := 'SQLNCLI10';
  if ( Providers.IndexOf('SQLNCLI11') > 0 ) then SQLDB := 'SQLNCLI11';

  Providers.Free;

  ACEDB := 'Microsoft.Jet.OLEDB.4.0'; Office2007 := False; Office2010 := False;

  CfgDriver := 'ACCESS';
  CfgDatabase := 'SRIST.mdb';
end;

function TDados.CreateConnectionString(DRIVER, SERVER: String; WIS: Boolean;
                                       UID, PWD, DATABASE: String): String;
var
  ConnString, PROVIDER: String;
begin
  ConnString := '';

  if DRIVER = 'ACCESS' then PROVIDER := ACEDB;
  if DRIVER = 'SQLSERVER' then PROVIDER := SQLDB;

  ConnString := 'Provider=' + PROVIDER + ';';

  if SERVER <> '' then
    begin
      ConnString := ConnString + 'Data Source=' + SERVER + ';';
      if DATABASE <> '' then ConnString := ConnString + 'Initial Catalog=' + DATABASE + ';';
    end
  else
  if DATABASE <> '' then ConnString := ConnString + 'Data Source=' + DATABASE + ';';

  if WIS then
    ConnString := ConnString + 'Integrated Security=SSPI;'
  else
    begin
      if UID <> '' then ConnString := ConnString + 'User ID=' + UID + ';';
      if PWD <> '' then ConnString := ConnString + 'Password=' + PWD + ';Persist Security Info=True;';
    end;

  if ( Pos('DBF', UpperCase(ExtractFileExt(DATABASE))) > 0 ) then
    begin
      ConnString := ConnString + 'Extended Properties="dBASE IV;";';
    end;

  if ( Pos('XLS', UpperCase(ExtractFileExt(DATABASE))) > 0 ) then
    begin
      ConnString := ConnString + 'Extended Properties="Excel ';

      if Office2007 or Office2010 then
        begin
          if Office2010 then ConnString := ConnString + '12.0'
          else ConnString := ConnString + '10.0';

          if LowerCase(ExtractFileExt(DATABASE)) = '.xlsx' then ConnString := ConnString + ' Xml';
          if LowerCase(ExtractFileExt(DATABASE)) = '.xlsm' then ConnString := ConnString + ' Macro';

          ConnString := ConnString + ';';
        end
      else
        ConnString := ConnString + '8.0;';

      ConnString := ConnString + '";';
    end;

  Result := ConnString;
end;

procedure TDados.CreateAccessDatabase(DATABASE: String);
var
  Catalog: _Catalog;
  CS: String;
begin
  Catalog := CreateCOMObject(StringToGUID('ADOX.Catalog')) as _Catalog;

  CS := 'Provider=' + ACEDB + ';' +
        'Data Source=' + DATABASE +';' +
        'Jet OLEDB:Engine Type=5';

  if FileExists(DATABASE) then DeleteFile(DATABASE);

  Catalog.Create(CS);

  Catalog := nil;
end;

procedure TDados.CheckDatabase(Connection: TADOConnection);
var
  DBTables: TStrings;
  DBCmd: TADOCommand;
begin
  if Connection.Connected then
    begin
      DBTables := TStringList.Create;

      DBCmd := TADOCommand.Create(nil);

      try
        DBCmd.Connection := Connection;

        Connection.GetTableNames(DBTables, False);

        if ( DBTables.IndexOf('Empresa') < 0 ) then
          begin
            DBCmd.CommandText := 'CREATE TABLE Empresa ( ' +
                                 'NOME VARCHAR(255) NULL, ' +
                                 'CNPJ VARCHAR(14) NULL, ' +
                                 'IE VARCHAR(14) NULL, ' +
                                 'COD_MUN VARCHAR(7) NULL )';
            DBCmd.Execute;
          end;

        if ( DBTables.IndexOf('Participantes') < 0 ) then
          begin
            DBCmd.CommandText := 'CREATE TABLE Participantes ( ' +
                                 'COD_PART VARCHAR(60) NOT NULL PRIMARY KEY, ' +
                                 'NOME VARCHAR(255) NULL, ' +
                                 'COD_PAIS INT NULL, ' +
                                 'CNPJ VARCHAR(14) NULL, ' +
                                 'CPF VARCHAR(11) NULL, ' +
                                 'IE VARCHAR(14) NULL, ' +
                                 'COD_MUN VARCHAR(7) NULL )';
            DBCmd.Execute;
          end;

        if ( DBTables.IndexOf('Itens') < 0 ) then
          begin
            DBCmd.CommandText := 'CREATE TABLE Itens ( ' +
                                 'COD_ITEM VARCHAR(60) NOT NULL PRIMARY KEY, ' +
                                 'DESCR_ITEM VARCHAR(255) NULL, ' +
                                 'COD_BARRA VARCHAR(255) NULL, ' +
                                 'UNID_INV VARCHAR(6) NULL, ' +
                                 'COD_NCM VARCHAR(8) NULL, ' +
                                 'ALIQ_ICMS REAL NULL, ' +
                                 'CEST VARCHAR(7) NULL )';
            DBCmd.Execute;
          end;

        if ( DBTables.IndexOf('Documentos') < 0 ) then
          begin
            DBCmd.CommandText := 'CREATE TABLE Documentos ( ' +
                                 'ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, ' +
                                 'ELETRO BIT NULL, ' +
                                 'CHV_DOC VARCHAR(44) NULL, ' +
                                 'COD_PART VARCHAR(60) NULL, ' +
                                 'COD_MOD VARCHAR(2) NULL, ' +
                                 'ECF_FAB VARCHAR(21) NULL, ' +
                                 'SER VARCHAR(3) NULL, ' +
                                 'NUM_DOC INT NULL, ' +
                                 'NUM_ITEM INT NULL, ' +
                                 'IND_OPER VARCHAR(1) NULL, ' +
                                 'DATA DATETIME NULL, ' +
                                 'CFOP VARCHAR(4) NULL, ' +
                                 'COD_ITEM VARCHAR(60) NULL, ' +
                                 'QTD REAL NULL, ' +
                                 'ICMS_TOT MONEY NULL, ' +
                                 'VL_CONFR MONEY NULL, ' +
                                 'COD_LEGAL VARCHAR(1) NULL, ' +
                                 'CONSTRAINT FK_Docs_Item ' +
                                 'FOREIGN KEY ( COD_ITEM ) ' +
                                 'REFERENCES Itens ( COD_ITEM ) ' +
                                 'ON DELETE CASCADE ' +
                                 'ON UPDATE CASCADE )';
            DBCmd.Execute;
          end;
      except on E: Exception do
         MessageDlg(E.Message, mtError, [mbOk], E.HelpContext);
      end;

      DBCmd.Free;

      DBTables.Free;
    end;
end;

function TDados.OpenDatabase(Connection: TADOConnection; IncludingTables: Boolean): Boolean;
begin
  Connection.Connected := False; Connection.LoginPrompt := False;

  Connection.ConnectionString := CreateConnectionString(CfgDriver, CfgServer,
                                                        CfgWinSecurity,
                                                        CfgUsername, CfgPassword,
                                                        CfgDatabase);

  try
    if ( CfgDriver = 'ACCESS' ) and ( not FileExists(CfgDatabase) ) then
      CreateAccessDatabase(CfgDatabase);

    Connection.Open;

    if Connection.Connected then
      begin
        CheckDatabase(Connection);

        if IncludingTables then
          begin
            TEmpresa.Open;
            TParticipantes.Open;
            TItens.Open;

            TDocumentos.Open;
          end;
      end;
  except on E: Exception do
     MessageDlg(E.Message, mtError, [mbOk], E.HelpContext);
  end;

  Result := Connection.Connected;
end;

procedure TDados.CloseDatabase(Connection: TADOConnection);
begin
  if Connection.Connected then
    begin
      if TEmpresa.Active then
        TEmpresa.Close;

      if TParticipantes.Active then
        TParticipantes.Close;

      if TItens.Active then
        TItens.Close;

      if TDocumentos.Active then
        TDocumentos.Close;

      Connection.Close;
    end;
end;

procedure TDados.NavigatorRefresh(Navigator: TDbNavigator);
begin
  with Navigator, DataSource do
    begin
      Controls[0].Enabled := not ( DataSet.Bof or
                                 ( State in [dsInsert, dsEdit] ) or
                                 ( DataSet.RecNo = 1 ) ); //nbFirst
      Controls[1].Enabled := Controls[0].Enabled; //nbPrior
      Controls[2].Enabled := not ( DataSet.Eof or
                                 ( State in [dsInsert, dsEdit] ) or
                                 ( DataSet.RecNo = DataSet.RecordCount ) ); //nbNext
      Controls[3].Enabled := Controls[2].Enabled; //nbLast
      Controls[4].Enabled := not ( State in [dsInsert, dsEdit] ); //nbInsert
      Controls[5].Enabled := not ( DataSet.IsEmpty or
                                 ( State in [dsInsert, dsEdit] ) ); //nbDelete
      Controls[6].Enabled := Controls[5].Enabled; //nbEdit
      Controls[7].Enabled := ( State in [dsInsert, dsEdit] ); //nbPost
      Controls[8].Enabled := Controls[7].Enabled; //nbCancel
      Controls[9].Enabled := Controls[4].Enabled; //nbRefresh
    end;
end;

procedure TDados.SetFieldDefs;
begin
  TEmpresa.FieldByName('CNPJ').EditMask := '99999999999999;0; ';
  TEmpresa.FieldByName('COD_MUN').EditMask := '9999999;0; ';

  TParticipantes.FieldByName('COD_PART').DisplayWidth := 15;
  TParticipantes.FieldByName('NOME').DisplayWidth := 50;
  TParticipantes.FieldByName('COD_PAIS').EditMask := '99999;0; ';
  TParticipantes.FieldByName('CNPJ').EditMask := '99999999999999;0; ';
  TParticipantes.FieldByName('CPF').EditMask := '99999999999;0; ';
  TParticipantes.FieldByName('COD_MUN').EditMask := '9999999;0; ';

  TItens.FieldByName('COD_ITEM').DisplayWidth := 15;
  TItens.FieldByName('DESCR_ITEM').DisplayWidth := 50;
  TItens.FieldByName('COD_BARRA').DisplayWidth := 15;
  with (TItens.FieldByName('ALIQ_ICMS') as TFloatField) do
    begin
      DisplayFormat := '##0.##%';
      EditFormat := '##0.##;1; ';
    end;
  TItens.FieldByName('CEST').EditMask := '9999999;0; ';

  with (TDocumentos.FieldByName('ELETRO') as TBooleanField) do
    begin
      DisplayValues := 'Sim;N�o';
    end;
  TDocumentos.FieldByName('COD_PART').DisplayWidth := 15;
  with (TDocumentos.FieldByName('NUM_ITEM') as TIntegerField) do
    begin
      EditFormat := '##0;1; ';
      MinValue := 1;
      MaxValue := 999;
    end;
  with (TDocumentos.FieldByName('DATA') as TDateTimeField) do
    begin
      DisplayFormat := 'dd/mm/yyyy';
      EditMask := '!99/99/9999;1; ';
    end;
  TDocumentos.FieldByName('COD_ITEM').DisplayWidth := 15;
  TDocumentos.FieldByName('CFOP').EditMask := '9999;0; ';
  with (TDocumentos.FieldByName('QTD') as TFloatField) do
    begin
      DisplayFormat := '#####0.###';
      EditFormat := '#####0.###;1; ';
    end;
  with (TDocumentos.FieldByName('ICMS_TOT') as TBCDField) do
    begin
      DisplayFormat := '########0.00';
      EditFormat := '########0.00;1; ';
    end;
  with (TDocumentos.FieldByName('VL_CONFR') as TBCDField) do
    begin
      DisplayFormat := '########0.00';
      EditFormat := '########0.00;1; ';
    end;
end;

procedure TDados.SetIndexFieldNames;
begin
  TParticipantes.IndexFieldNames := 'NOME;COD_PART';
  TItens.IndexFieldNames := 'DESCR_ITEM;COD_ITEM';
  TDocumentos.IndexFieldNames := 'ID;DATA;COD_ITEM';
end;

procedure TDados.TDocumentosAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('ELETRO').Value := True;
  DataSet.FieldByName('COD_LEGAL').Value := 4;
end;

procedure TDados.ClearNullsBeforePost(DataSet: TDataSet);
var
  i: Integer;
  DataType: TDataType;
  FielName: String;
begin
  if DataSet.Tag > 0 then Exit;

  for i := 0 to DataSet.FieldDefs.Count - 1 do
    begin
      DataType := DataSet.FieldDefs.Items[i].DataType;
      FielName := DataSet.FieldDefs.Items[i].Name;

      if (DataType in [ftDate, ftDateTime]) and
         (FormatDateTime('yyyymmdd', DataSet.FieldByName(FielName).AsDateTime) = '18991230') then
           DataSet.FieldByName(FielName).Clear
      else
      if (DataType in [ftString, ftMemo, ftWideString]) and
         (DataSet.FieldByName(FielName).AsString = '') then
           DataSet.FieldByName(FielName).Clear
      else
      if (DataType in [ftFloat, ftCurrency, ftBCD]) and
         DataSet.FieldByName(FielName).IsNull then
           DataSet.FieldByName(FielName).Value := 0;
    end;
end;

end.

