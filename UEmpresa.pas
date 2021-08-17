unit UEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Mask, DB, ADODB, MidasLib;

type
  TEmpresa = class(TForm)
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure RefreshView(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Empresa: TEmpresa;

implementation

{$R *.dfm}

uses
  UDados, UFerramentas;

procedure TEmpresa.FormActivate(Sender: TObject);
begin
  if Dados.TEmpresa.IsEmpty then
    Dados.TEmpresa.Append;

  RefreshView(Sender);
end;

procedure TEmpresa.RefreshView(Sender: TObject);
var
  isAdding, isEditing: Boolean;
  i: Integer;
begin
  isAdding := ( DBNavigator1.DataSource.State = dsInsert );
  isEditing := ( DBNavigator1.DataSource.State in [dsInsert, dsEdit] );

  for i := 0 to Empresa.ControlCount - 1 do
    begin
      if ( Empresa.Controls[i] is TDBEdit ) or
         ( Empresa.Controls[i] is TDBComboBox ) then
           Empresa.Controls[i].Enabled := isEditing;
    end;

  Dados.NavigatorRefresh(DBNavigator1);
end;

procedure TEmpresa.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
var
  TmpValue: String;
begin
  if ( Button = nbPost ) then
    begin
      if ( Dados.TEmpresa.FieldByName('IE').NewValue <> Null ) then
        begin
          TmpValue := Dados.TEmpresa.FieldByName('IE').NewValue;
          TmpValue := OnlyValidChars(TmpValue, chrNumeric+chrAlphabetic, 14);
          Dados.TEmpresa.FieldByName('IE').NewValue := TmpValue;
        end;
    end;
end;

procedure TEmpresa.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  RefreshView(Sender);
end;

procedure TEmpresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = #13 ) then
    begin
      Key := #0;
      SelectNext(ActiveControl, true, true);
    end;
end;

end.

