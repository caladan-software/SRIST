unit UParticipantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Mask, DB, ADODB, MidasLib;

type
  TParticipantes = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label7: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    procedure RefreshView(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Participantes: TParticipantes;

implementation

{$R *.dfm}

uses
  UDados, UFerramentas;

procedure TParticipantes.FormActivate(Sender: TObject);
begin
  RefreshView(Sender);
end;

procedure TParticipantes.RefreshView(Sender: TObject);
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

  Dados.NavigatorRefresh(DBNavigator1);

  if isEditing then
    DBEdit1.SetFocus
  else
    Panel1.SetFocus;
end;

procedure TParticipantes.DBGrid1TitleClick(Column: TColumn);
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

procedure TParticipantes.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
var
  TmpValue: String;
begin
  if ( Button = nbDelete ) and
     ( BoxMensagem('Excluir o registro corrente?', mtConfirmation, mbYesNo, 0) <> mrYes ) then
      Abort
  else
  if ( Button = nbPost ) then
    begin
      if ( Dados.TParticipantes.FieldByName('IE').NewValue <> Null ) then
        begin
          TmpValue := Dados.TParticipantes.FieldByName('IE').NewValue;
          TmpValue := OnlyValidChars(TmpValue, chrNumeric+chrAlphabetic, 14);
          Dados.TParticipantes.FieldByName('IE').NewValue := TmpValue;
        end;
    end;
end;

procedure TParticipantes.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  RefreshView(Sender);
end;

procedure TParticipantes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = #13 ) then
    begin
      Key := #0;
      SelectNext(ActiveControl, true, true);
    end;
end;

end.

