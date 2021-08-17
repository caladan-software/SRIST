unit URemessas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ComCtrls, StrUtils;

type
  TRemessas = class(TForm)
    List_Arquivos: TListBox;
    StatusBar1: TStatusBar;
    Texto: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TextoClick(Sender: TObject);
    procedure TextoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure List_ArquivosClick(Sender: TObject);
  private
    { Private declarations }
    procedure FindFiles(Sender: TObject);
    procedure OpenFile(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Remessas: TRemessas;

implementation

{$R *.dfm}

uses
  UDados, UFerramentas;

const
  R0000: Array[1..10] of String = ('REG', 'PERIODO', 'NOME', 'CNPJ', 'IE', 'COD_MUN', 'COD_VER', 'COD_FIN', '', '');
  R0150: Array[1..10] of String = ('REG', 'COD_PART', 'NOME', 'COD_PAIS', 'CNPJ', 'CPF', 'IE', 'COD_MUN', '', '');
  R0200: Array[1..10] of String = ('REG', 'COD_ITEM', 'DESCR_ITEM', 'COD_BARRA', 'UNID_INV', 'COD_NCM', 'ALIQ_ICMS', 'CEST', '', '');
  R1050: Array[1..10] of String = ('REG', 'COD_ITEM', 'QTD_INI', 'ICMS_TOT_INI', 'QTD_FIM', 'ICMS_TOT_FIM', '', '', '', '');
  R1100: Array[1..11] of String = ('REG', 'CHV_DOC', 'DATA', 'NUM_ITEM', 'IND_OPER', 'COD_ITEM', 'CFOP', 'QTD', 'ICMS_TOT', 'VL_CONFR', 'COD_LEGAL');
  R1200: Array[1..15] of String = ('REG', 'COD_PART', 'COD_MOD', 'ECF_FAB', 'SER', 'NUM_DOC', 'NUM_ITEM', 'IND_OPER', 'DATA', 'CFOP', 'COD_ITEM', 'QTD', 'ICMS_TOT', 'VL_CONFR', 'COD_LEGAL');

procedure TRemessas.FindFiles(Sender: TObject);
var
  FindResult: Integer;
  SearchRec: TSearchRec;
begin
  List_Arquivos.Clear;
  StatusBar1.SimpleText := '';

  FindResult := FindFirst('SRIST-????-??.txt', faAnyFile - faDirectory, SearchRec);

  while ( FindResult = 0 ) do
    begin
      List_Arquivos.Items.Append(SearchRec.Name);

      FindResult := FindNext(SearchRec);

      Application.ProcessMessages;
    end;

  FindClose(SearchRec);
end;

procedure TRemessas.FormActivate(Sender: TObject);
begin
  FindFiles(Sender);
end;

procedure TRemessas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  List_Arquivos.ItemIndex := -1;
  List_Arquivos.Clear;
  Texto.Clear;
end;

procedure TRemessas.FormCreate(Sender: TObject);
begin
  ClientWidth := ( MaxWidth div 3 ) * 2;
  ClientHeight := ( MaxHeight div 3 ) * 2;

  Texto.Clear;
  Texto.WordWrap := False;
  Texto.Font.Name := 'Courier New';
  Texto.Font.Pitch := fpFixed;
  Texto.ScrollBars := ssBoth;
end;

procedure TRemessas.List_ArquivosClick(Sender: TObject);
var
  i: Integer;
  TableName: String;
begin
  StatusBar1.SimpleText := '';

  Texto.Clear;

  i := List_Arquivos.ItemIndex;

  TableName := List_Arquivos.Items.Strings[i];

  Texto.Lines.LoadFromFile(TableName);
end;

procedure TRemessas.OpenFile(Sender: TObject);
begin
  FindFiles(Sender);
end;

procedure TRemessas.TextoClick(Sender: TObject);
var
  TableName, FieldName, FieldValue, Tipo: String;
  i, LineNumber, ColNumber, FieldNo, SelStart, SelLength: Integer;
begin
  i := List_Arquivos.ItemIndex;

  TableName := List_Arquivos.Items.Strings[i];

  LineNumber := SendMessage(Texto.Handle, EM_LINEFROMCHAR, -1, 0);
  ColNumber := Texto.SelStart - SendMessage(Texto.Handle, EM_LINEINDEX, LineNumber, 0);

  FieldNo := 1; SelStart := 1;
  for i := 1 to ColNumber do
    if Texto.Lines.Strings[LineNumber][i] = '|' then
      begin
        Inc(FieldNo);
        SelStart := i + 1;
      end;

  SelLength := PosEx('|', Texto.Lines.Strings[LineNumber], SelStart) - SelStart;
  if SelLength < 0 then
    SelLength := Length(Texto.Lines.Strings[LineNumber]) - SelStart + 1;

  Texto.HideSelection := False;
  Texto.SelStart := Texto.Perform(EM_LINEINDEX, LineNumber, 0) + SelStart - 1;
  Texto.SelLength := SelLength;

  ColNumber := SelStart - 1;

  FieldValue := Copy(Texto.Lines.Strings[LineNumber], SelStart, SelLength);

  Tipo := LeftStr(Texto.Lines.Strings[LineNumber], 4);

  if Tipo = '0000' then
    FieldName := R0000[FieldNo]
  else
  if Tipo = '0150' then
    FieldName := R0150[FieldNo]
  else
  if Tipo = '0200' then
    FieldName := R0200[FieldNo]
  else
  if Tipo = '1050' then
    FieldName := R1050[FieldNo]
  else
  if Tipo = '1100' then
    FieldName := R1100[FieldNo]
  else
  if Tipo = '1200' then
    FieldName := R1200[FieldNo];

  StatusBar1.SimpleText := Format('%s » Linha: %d; Coluna: %d; Largura: %d » ' +
                                  'Campo #%d: %s = %s', [TableName,
                                   LineNumber + 1, ColNumber + 1, SelLength,
                                   FieldNo, FieldName, FieldValue])
end;

procedure TRemessas.TextoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TextoClick(Sender);
end;

end.

