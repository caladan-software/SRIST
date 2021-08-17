unit UDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Mask, DB, ADODB,
  DBClient, StrUtils, MidasLib, Math, pngimage;

type
  TDocumentos = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DBCheckBox1: TDBCheckBox;
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label2: TLabel;
    DBEdit6: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    DBRadioGroup2: TDBRadioGroup;
    DBLookupComboBox2: TDBLookupComboBox;
    T411: TClientDataSet;
    T411CODIGO: TStringField;
    T411DESCRICAO: TStringField;
    DT411: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    DBLookupComboBox3: TDBLookupComboBox;
    Consulta: TImage;
    procedure FormActivate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure T411AfterOpen(DataSet: TDataSet);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBNavigator1BeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ConsultaClick(Sender: TObject);
  private
    procedure RefreshView(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Documentos: TDocumentos;

implementation

{$R *.dfm}

uses
  UDados, UFerramentas;

var
  isAdding, isEditing: Boolean;

procedure TDocumentos.FormActivate(Sender: TObject);
begin
  if not T411.Active then
    begin
      T411.CreateDataSet;
      T411.Open;
    end;

  DBLookupComboBox2.ListSource := DT411;
  DBLookupComboBox2.ListField := 'DESCRICAO';
  DBLookupComboBox2.KeyField := 'CODIGO';

  RefreshView(Sender);
end;

procedure TDocumentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //if T411.Active then T411.Close;
end;

procedure TDocumentos.RefreshView(Sender: TObject);
var
  i, j: Integer;
begin
  isAdding := ( DBNavigator1.DataSource.State = dsInsert );
  isEditing := ( DBNavigator1.DataSource.State in [dsInsert, dsEdit] );

  DBGrid1.Enabled := not isEditing;

  for i := 0 to Panel1.ControlCount - 1 do
    begin
      if ( Panel1.Controls[i] is TDBEdit ) or
         ( Panel1.Controls[i] is TDBCheckBox ) or
         ( Panel1.Controls[i] is TDBComboBox ) or
         ( Panel1.Controls[i] is TDBRadioGroup ) or
         ( Panel1.Controls[i] is TDBLookupComboBox ) then
           Panel1.Controls[i].Enabled := isEditing;

      if ( Panel1.Controls[i] is TGroupBox ) then
        begin
          for j := 0 to (Panel1.Controls[i] as TGroupBox).ControlCount - 1 do
            if ( (Panel1.Controls[i] as TGroupBox).Controls[j] is TDBEdit ) or
               ( (Panel1.Controls[i] as TGroupBox).Controls[j] is TDBCheckBox ) or
               ( (Panel1.Controls[i] as TGroupBox).Controls[j] is TDBLookupComboBox ) then
                 (Panel1.Controls[i] as TGroupBox).Controls[j].Enabled := isEditing;
        end;

      if ( Panel1.Controls[i] is TDBRadioGroup ) then
        begin
          for j := 0 to (Panel1.Controls[i] as TDBRadioGroup).ControlCount - 1 do
            (Panel1.Controls[i] as TDBRadioGroup).Controls[j].Enabled := isEditing;
        end;
    end;

  if isEditing then
    begin
      DBCheckBox1Click(Sender);
      DBRadioGroup1Change(Sender);
    end;

  Consulta.Visible := isEditing and ( DBRadioGroup1.ItemIndex = 1);

  Dados.NavigatorRefresh(DBNavigator1);

  if isEditing then
    DBCheckBox1.SetFocus
  else
    Panel1.SetFocus;
end;

procedure TDocumentos.ConsultaClick(Sender: TObject);
var
  QryMov: TADOQuery;
  QTD, ICMS_TOT, VAL_ICMS: Double;
begin
  VAL_ICMS := 0;

  QryMov := TADOQuery.Create(nil);

  QryMov.Connection := Dados.Conn;

  QryMov.SQL.Append('SELECT');
  QryMov.SQL.Append('SUM(IIF(IND_OPER = ''0'', QTD, -QTD)) AS QTD, ');
  QryMov.SQL.Append('SUM(IIF(IND_OPER = ''0'', ICMS_TOT, -ICMS_TOT)) AS ICMS_TOT');
  QryMov.SQL.Append('FROM Documentos');
  QryMov.SQL.Append('WHERE COD_ITEM = :COD_ITEM AND DATA < :DATA');

  QryMov.Parameters.ParamByName('COD_ITEM').Value := Dados.TDocumentos.FieldByName('COD_ITEM').Value;
  QryMov.Parameters.ParamByName('DATA').Value := Dados.TDocumentos.FieldByName('DATA').Value;

  QryMov.Open;

  if QryMov.Active then
    begin
      if not QryMov.Eof then
        begin
          QryMov.First;

          QTD := QryMov.FieldByName('QTD').AsFloat;
          ICMS_TOT := QryMov.FieldByName('ICMS_TOT').AsCurrency;

          if ( QTD > 0) and ( ICMS_TOT > 0 ) then VAL_ICMS := ICMS_TOT / QTD;
        end;

      QryMov.Close;
    end;

  QryMov.Free;

  VAL_ICMS := Dados.TDocumentos.FieldByName('QTD').AsFloat * VAL_ICMS;
  VAL_ICMS := RoundTo(VAL_ICMS, -2);

  if ( VAL_ICMS <= 0 ) then
    ShowMessage('Sem sugest�o. Verifique a data, o item e quantidade informada!')
  else
  if ( BoxMensagem(Format('Sugest�o... Usar %.2f?', [VAL_ICMS]), mtConfirmation, mbYesNo, 0) = mrYes ) then
    Dados.TDocumentos.FieldByName('ICMS_TOT').Value := VAL_ICMS;
end;

procedure TDocumentos.DBCheckBox1Click(Sender: TObject);
begin
  DBEdit1.Enabled := isEditing and DBCheckBox1.Checked;
  DBLookupComboBox1.Enabled := isEditing and not DBCheckBox1.Checked;
  DBLookupComboBox2.Enabled := isEditing and not DBCheckBox1.Checked;
  DBEdit3.Enabled := isEditing and not DBCheckBox1.Checked;
  DBEdit4.Enabled := isEditing and not DBCheckBox1.Checked;
  DBEdit5.Enabled := isEditing and not DBCheckBox1.Checked;
end;

procedure TDocumentos.DBGrid1TitleClick(Column: TColumn);
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

procedure TDocumentos.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
var
  Entrada, Saida, Devolucao: Boolean;
begin
  if ( Button = nbDelete ) and
     ( BoxMensagem('Excluir o registro corrente?', mtConfirmation, mbYesNo, 0) <> mrYes ) then
      Abort
  else
  if ( Button = nbPost ) then
    begin
      if ( DBRadioGroup1.ItemIndex < 0 ) then
        Dados.TDocumentos.FieldByName('IND_OPER').NewValue := '1';

      //---

      Entrada := ( DBRadioGroup1.ItemIndex = 0 );
      Saida := ( DBRadioGroup1.ItemIndex = 1 );

      Devolucao := AnsiEndsStr('411', DBEdit9.Text);

      (*
      //--- ENTRADA ou DEVOLU��O DE ENTRADA

      if ( Entrada and not Devolucao ) or ( Saida and Devolucao ) then
        begin
          Dados.TDocumentos.FieldByName('VL_CONFR').NewValue := 0;
          Dados.TDocumentos.FieldByName('COD_LEGAL').NewValue := 0;
        end;

      //--- SA�DA

      if ( Saida and not Devolucao ) then
        Dados.TDocumentos.FieldByName('ICMS_TOT').NewValue := Null;
      *)
    end;
end;

procedure TDocumentos.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  RefreshView(Sender);
end;

procedure TDocumentos.DBRadioGroup1Change(Sender: TObject);
begin
  Consulta.Visible := isEditing and ( DBRadioGroup1.ItemIndex = 1);
  //DBRadioGroup2.Enabled := isEditing and ( DBRadioGroup1.ItemIndex > 0 );
end;

procedure TDocumentos.T411AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.IsEmpty then
    Exit;

  T411.Append;
  T411CODIGO.Value := '01';
  T411DESCRICAO.Value := 'Nota Fiscal';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '1B';
  T411DESCRICAO.Value := 'Nota Fiscal Avulsa';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '02';
  T411DESCRICAO.Value := 'Nota Fiscal de Venda a Consumidor';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '2D';
  T411DESCRICAO.Value := 'Cupom Fiscal emitido por ECF';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '2E';
  T411DESCRICAO.Value := 'Bilhete de Passagem emitido por ECF';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '04';
  T411DESCRICAO.Value := 'Nota Fiscal de Produtor';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '06';
  T411DESCRICAO.Value := 'Nota Fiscal/Conta de Energia El�trica';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '07';
  T411DESCRICAO.Value := 'Nota Fiscal de Servi�o de Transporte';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '08';
  T411DESCRICAO.Value := 'Conhecimento de Transporte Rodovi�rio de Cargas';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '8B';
  T411DESCRICAO.Value := 'Conhecimento de Transporte de Cargas Avulso';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '09';
  T411DESCRICAO.Value := 'Conhecimento de Transporte Aquavi�rio de Cargas';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '10';
  T411DESCRICAO.Value := 'Conhecimento A�reo';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '11';
  T411DESCRICAO.Value := 'Conhecimento de Transporte Ferrovi�rio de Cargas';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '13';
  T411DESCRICAO.Value := 'Bilhete de Passagem Rodovi�rio';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '14';
  T411DESCRICAO.Value := 'Bilhete de Passagem Aquavi�rio';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '15';
  T411DESCRICAO.Value := 'Bilhete de Passagem e Nota de Bagagem';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '17';
  T411DESCRICAO.Value := 'Despacho de Transporte';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '16';
  T411DESCRICAO.Value := 'Bilhete de Passagem Ferrovi�rio';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '18';
  T411DESCRICAO.Value := 'Resumo de Movimento Di�rio';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '20';
  T411DESCRICAO.Value := 'Ordem de Coleta de Cargas';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '21';
  T411DESCRICAO.Value := 'Nota Fiscal de Servi�o de Comunica��o';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '22';
  T411DESCRICAO.Value := 'Nota Fiscal de Servi�o de Telecomunica��o';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '23';
  T411DESCRICAO.Value := 'GNRE';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '24';
  T411DESCRICAO.Value := 'Autoriza��o de Carregamento e Transporte';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '25';
  T411DESCRICAO.Value := 'Manifesto de Carga';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '26';
  T411DESCRICAO.Value := 'Conhecimento de Transporte Multimodal de Cargas';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '27';
  T411DESCRICAO.Value := 'Nota Fiscal/Conta de Fornecimento de �gua Canalizada';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '28';
  T411DESCRICAO.Value := 'Nota Fiscal/Conta de Fornecimento de G�s Canalizado';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '29';
  T411DESCRICAO.Value := 'Manifesto de V�o';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '30';
  T411DESCRICAO.Value := 'Bilhete/Recibo do Passageiro';
  T411.Post;

  T411.Append;
  T411CODIGO.Value := '55';
  T411DESCRICAO.Value := 'Nota Fiscal Eletr�nica';
  T411.Post;
end;

procedure TDocumentos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = #13 ) then
    begin
      repeat
        SelectNext(ActiveControl, true, true);
      until ActiveControl.TabStop;
      Key := #0;
    end;
end;

end.

