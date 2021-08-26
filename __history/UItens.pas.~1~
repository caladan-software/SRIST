unit UItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Mask, DB, ADODB, MidasLib;

type
  TItens = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    qryMov: TADOQuery;
    dsMov: TDataSource;
    DBGrid2: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RefreshView(Sender: TObject);
    procedure Extrato;
  public
    { Public declarations }
  end;

var
  Itens: TItens;

implementation

{$R *.dfm}

uses
  UDados, UFerramentas;

procedure TItens.FormActivate(Sender: TObject);
begin
  RefreshView(Sender);
end;

procedure TItens.FormCreate(Sender: TObject);
begin
  Left := MinLeft;
  Width := MaxWidth;
end;

procedure TItens.RefreshView(Sender: TObject);
var
  isAdding, isEditing: Boolean;
  i: Integer;
begin
  isAdding := ( DBNavigator1.DataSource.State = dsInsert );
  isEditing := ( DBNavigator1.DataSource.State in [dsInsert, dsEdit] );

  DBGrid1.Enabled := not isEditing;

  for i := 0 to Panel1.ControlCount - 1 do
    begin
      if ( Panel1.Controls[i] is TDBEdit ) or
         ( Panel1.Controls[i] is TDBComboBox ) then
           Panel1.Controls[i].Enabled := isEditing;
    end;

  Extrato;

  Dados.NavigatorRefresh(DBNavigator1);

  if isEditing then
    DBEdit1.SetFocus
  else
    Panel1.SetFocus;
end;

procedure TItens.DBGrid1CellClick(Column: TColumn);
begin
  Extrato;
end;

procedure TItens.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Extrato;
end;

procedure TItens.DBGrid1TitleClick(Column: TColumn);
var
  Table: TADOTable;
begin
  if ( Column.Field.FieldKind <> fkData ) then Exit;

  Table := (DBGrid1.DataSource.DataSet as TADOTable);

  Table.IndexFieldNames := StringReplace(Table.IndexFieldNames, ';' + Column.FieldName, '', [rfReplaceAll, rfIgnoreCase]);
  Table.IndexFieldNames := StringReplace(Table.IndexFieldNames, Column.FieldName + ';', '', [rfReplaceAll, rfIgnoreCase]);

  Table.IndexFieldNames := Column.FieldName + ';' + Table.IndexFieldNames;
  Table.Requery;
end;

procedure TItens.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  if ( Button = nbDelete ) and
     ( BoxMensagem('Excluir o registro corrente?', mtConfirmation, mbYesNo, 0) <> mrYes ) then
      Abort
  else
  if ( Button = nbPost ) then
    begin

    end;
end;

procedure TItens.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  RefreshView(Sender);
end;

procedure TItens.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = #13 ) then
    begin
      Key := #0;
      SelectNext(ActiveControl, true, true);
    end;
end;

procedure TItens.FormResize(Sender: TObject);
const
  MaxGridWidth: Integer = 416;
begin
  Panel1.Width := Width div 2;
  if DBGrid2.Width < MaxGridWidth then
    DBGrid2.Width := Panel1.ClientWidth - DBGrid2.Left - 10;
  if DBGrid2.Width >= MaxGridWidth then
    begin
      Panel1.Width := Panel1.Width - ( DBGrid2.Width - MaxGridWidth );
      DBGrid2.Width := MaxGridWidth;
      Panel1.ClientWidth := DBGrid2.Width + DBGrid2.Left + 10;
    end;
end;

procedure TItens.Extrato;
var
  DataInicial, DataFinal: String;
begin
  DataInicial := 'DATESERIAL(YEAR(D.DATA), MONTH(D.DATA), 1)';
  DataFinal := 'DATESERIAL(YEAR(D.DATA), MONTH(D.DATA) + 1, 0)';
  
  if QryMov.Active then
    QryMov.Close;

  QryMov.SQL.Clear;
  QryMov.Parameters.Clear;

  if ( Dados.TItens.FieldByName('COD_ITEM').Value <> Null ) then
    begin
      QryMov.SQL.Append('SELECT YEAR(D.DATA) AS ANO, MONTH(D.DATA) AS MES,');
      QryMov.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', QTD, -QTD)) FROM Documentos I WHERE I.COD_ITEM = D.COD_ITEM AND I.DATA < ' + DataInicial + ') AS QTD_INI,');
      QryMov.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', ICMS_TOT, -ICMS_TOT)) FROM Documentos I WHERE I.COD_ITEM = D.COD_ITEM AND I.DATA < ' + DataInicial + ') AS ICMS_TOT_INI,');
      QryMov.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', QTD, -QTD)) FROM Documentos F WHERE F.COD_ITEM = D.COD_ITEM AND F.DATA <= ' + DataFinal + ') AS QTD_FIM,');
      QryMov.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', ICMS_TOT, -ICMS_TOT)) FROM Documentos F WHERE F.COD_ITEM = D.COD_ITEM AND F.DATA <= ' + DataFinal + ') AS ICMS_TOT_FIM');
      QryMov.SQL.Append('FROM Documentos D');
      QryMov.SQL.Append('WHERE D.COD_ITEM = :COD_ITEM');
      QryMov.SQL.Append('GROUP BY D.COD_ITEM, YEAR(D.DATA), MONTH(D.DATA)');
      QryMov.SQL.Append('ORDER BY 1, 2');

      QryMov.Parameters.ParamByName('COD_ITEM').Value := Dados.TItens.FieldByName('COD_ITEM').Value;

      QryMov.Open;
      
      QryMov.FieldByName('ANO').DisplayWidth := 5;
      QryMov.FieldByName('MES').DisplayWidth := 3;
      (QryMov.FieldByName('QTD_INI') as TFloatField).DisplayFormat := '#####0.###';
      (QryMov.FieldByName('ICMS_TOT_INI') as TBCDField).DisplayFormat := '########0.00';
      (QryMov.FieldByName('QTD_FIM') as TFloatField).DisplayFormat := '#####0.###';
      (QryMov.FieldByName('ICMS_TOT_FIM') as TBCDField).DisplayFormat := '########0.00';

      QryMov.FieldByName('ICMS_TOT_INI').DisplayWidth := 15;
      QryMov.FieldByName('ICMS_TOT_FIM').DisplayWidth := 15;
    end;
end;

end.

