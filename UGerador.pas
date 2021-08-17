unit UGerador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DateUtils, DB, ADODB, MidasLib, StrUtils;

type
  TGerador = class(TForm)
    Label1: TLabel;
    edCOD_FIN: TRadioGroup;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edPERIODO: TComboBox;
    Label3: TLabel;
    btOk: TButton;
    Button2: TButton;
    qryAnos: TADOQuery;
    dsAnos: TDataSource;
    edANO: TDBLookupComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure AnyChange(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure ShowCheckBoxes(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Gerador: TGerador;

implementation

{$R *.dfm}

uses
  UDados, UFerramentas;

const
  COD_VER: String = '01';

var
  isRunning: Boolean;

procedure TGerador.FormActivate(Sender: TObject);
begin
  if not qryAnos.Active then
    qryAnos.Open
  else
    qryAnos.Requery();

  AnyChange(Sender);

  ShowCheckBoxes(Sender);
end;

procedure TGerador.AnyChange(Sender: TObject);
begin
  btOk.Enabled := ( edCOD_FIN.ItemIndex >= 0 ) and
                  ( edPERIODO.ItemIndex >= 0 ) and
                  ( edANO.KeyValue <> Null );

  ShowCheckBoxes(Sender);
end;

procedure TGerador.btOkClick(Sender: TObject);
var
  TXT: TextFile;
  Arquivo, PERIODO, COD_FIN, ICMS_TOT, VL_CONFR, COD_LEGAL: String;
  DataInicial, DataFinal: TDateTime;
  Entrada, Saida, Devolucao: Boolean;
begin
  PERIODO := Format('%.*d', [2, edPERIODO.ItemIndex]);

  Arquivo := 'SRIST-' + edANO.Text + '-' + PERIODO + '.txt';

  if ( BoxMensagem('Confirmar a gera��o do arquivo?', mtConfirmation, mbYesNo, 0) = mrYes ) and
     ( ( not FileExists(Arquivo) ) or ( BoxMensagem('Arquivo ' + Arquivo + ' j� existe.'#13'Sobrescrever?', mtConfirmation, mbYesNo, 0) = mrYes ) ) then
      begin
        isRunning := True;

        btOk.Enabled := False;

        //---

        AssignFile(TXT, Arquivo);
        {$I-} Rewrite(TXT); {$I+}
        if ( IOResult = 0 ) then
          begin
            if ( PERIODO = '00' ) then PERIODO := '';

            PERIODO := PERIODO + edANO.Text;

            if ( Dados.TEmpresa.State in [dsInsert, dsEdit] ) then
              Dados.TEmpresa.Cancel;

            Dados.TEmpresa.Requery();

            COD_FIN := Format('%.*d', [2, edCOD_FIN.ItemIndex]);

            WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s|%s|%s',
                         ['0000',
                          PERIODO,
                          NoPipe(Dados.TEmpresa.FieldByName('NOME').AsString, 0),
                          NoPipe(Dados.TEmpresa.FieldByName('CNPJ').AsString, 14),
                          NoPipe(Dados.TEmpresa.FieldByName('IE').AsString, 14),
                          NoPipe(Dados.TEmpresa.FieldByName('COD_MUN').AsString, 7),
                          COD_VER, COD_FIN]));

            //---

            WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s|%s|%s',
                         ['0150',
                          NoPipe('000000', 60),
                          NoPipe(Dados.TEmpresa.FieldByName('NOME').AsString, 0),
                          NoPipe('1058', 5),
                          NoPipe(Dados.TEmpresa.FieldByName('CNPJ').AsString, 14),
                          NoPipe('', 11),
                          NoPipe(Dados.TEmpresa.FieldByName('IE').AsString, 14),
                          NoPipe(Dados.TEmpresa.FieldByName('COD_MUN').AsString, 7)]));

            //---

            if ( edPERIODO.ItemIndex > 0 ) then
              begin
                DataInicial := EncodeDate(edANO.KeyValue, edPERIODO.ItemIndex, 1);
                DataFinal := EncodeDate(edANO.KeyValue, edPERIODO.ItemIndex, DaysInAMonth(edANO.KeyValue, edPERIODO.ItemIndex));
              end
            else
              begin
                DataInicial := EncodeDate(edANO.KeyValue, 1, 1);
                DataFinal := EncodeDate(edANO.KeyValue, 12, 31);
              end;

            //---

            if Dados.TmpQry.Active then
              Dados.TmpQry.Close;

            Dados.TmpQry.SQL.Clear;
            Dados.TmpQry.Parameters.Clear;

            Dados.TmpQry.SQL.Append('SELECT DISTINCT P.* FROM Documentos D');
            Dados.TmpQry.SQL.Append('LEFT JOIN Participantes P ON P.COD_PART = D.COD_PART');
            Dados.TmpQry.SQL.Append('WHERE D.DATA BETWEEN :Inicial AND :Final');
            Dados.TmpQry.SQL.Append('AND ELETRO = :Eletronico');
            Dados.TmpQry.SQL.Append('ORDER BY P.COD_PART');

            Dados.TmpQry.Parameters.ParamByName('Inicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('Final').Value := DataFinal;

            Dados.TmpQry.Parameters.ParamByName('Eletronico').Value := False;

            if isRunning then Dados.TmpQry.Open;

            if Dados.TmpQry.Active then
              begin
                if not Dados.TmpQry.IsEmpty then
                  begin
                    Dados.TmpQry.First;

                    while not Dados.TmpQry.Eof do
                      begin
                        WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s|%s|%s',
                                     ['0150',
                                      NoPipe(Dados.TmpQry.FieldByName('COD_PART').AsString, 60),
                                      NoPipe(Dados.TmpQry.FieldByName('NOME').AsString, 0),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_PAIS').AsString, 5),
                                      NoPipe(Dados.TmpQry.FieldByName('CNPJ').AsString, 14),
                                      NoPipe(Dados.TmpQry.FieldByName('CPF').AsString, 11),
                                      NoPipe(Dados.TmpQry.FieldByName('IE').AsString, 14),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_MUN').AsString, 7)]));

                        Application.ProcessMessages;

                        if not isRunning then
                          Dados.TmpQry.Last;

                        Dados.TmpQry.Next;
                      end;
                  end;

                Dados.TmpQry.Close;
              end;

            //---

            if Dados.TmpQry.Active then
              Dados.TmpQry.Close;

            Dados.TmpQry.SQL.Clear;
            Dados.TmpQry.Parameters.Clear;

            Dados.TmpQry.SQL.Append('SELECT DISTINCT I.* FROM Documentos D');
            Dados.TmpQry.SQL.Append('LEFT JOIN Itens I ON I.COD_ITEM = D.COD_ITEM');
            Dados.TmpQry.SQL.Append('WHERE D.DATA BETWEEN :Inicial AND :Final');
            Dados.TmpQry.SQL.Append('ORDER BY I.COD_ITEM');

            Dados.TmpQry.Parameters.ParamByName('Inicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('Final').Value := DataFinal;

            if isRunning then Dados.TmpQry.Open;

            if Dados.TmpQry.Active then
              begin
                if not Dados.TmpQry.IsEmpty then
                  begin
                    Dados.TmpQry.First;

                    while not Dados.TmpQry.Eof do
                      begin
                        WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s|%s|%s',
                                     ['0200',
                                      NoPipe(Dados.TmpQry.FieldByName('COD_ITEM').AsString, 60),
                                      NoPipe(Dados.TmpQry.FieldByName('DESCR_ITEM').AsString, 0),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_BARRA').AsString, 0),
                                      NoPipe(Dados.TmpQry.FieldByName('UNID_INV').AsString, 6),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_NCM').AsString, 8),
                                      ValBR(Dados.TmpQry.FieldByName('ALIQ_ICMS').AsFloat, 2),
                                      NoPipe(Dados.TmpQry.FieldByName('CEST').AsString, 7)]));

                        Application.ProcessMessages;

                        if not isRunning then
                          Dados.TmpQry.Last;

                        Dados.TmpQry.Next;
                      end;
                  end;

                Dados.TmpQry.Close;
              end;

            //---

            if Dados.TmpQry.Active then
              Dados.TmpQry.Close;

            Dados.TmpQry.SQL.Clear;
            Dados.TmpQry.Parameters.Clear;

            Dados.TmpQry.SQL.Append('SELECT D.COD_ITEM,');
            Dados.TmpQry.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', QTD, -QTD)) FROM Documentos I WHERE I.COD_ITEM = D.COD_ITEM AND I.DATA < :QInicial) AS QTD_INI,');
            Dados.TmpQry.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', ICMS_TOT, -ICMS_TOT)) FROM Documentos I WHERE I.COD_ITEM = D.COD_ITEM AND I.DATA < :IInicial) AS ICMS_TOT_INI,');
            Dados.TmpQry.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', QTD, -QTD)) FROM Documentos F WHERE F.COD_ITEM = D.COD_ITEM AND F.DATA <= :QFinal) AS QTD_FIM,');
            Dados.TmpQry.SQL.Append('(SELECT SUM(IIF(IND_OPER = ''0'', ICMS_TOT, -ICMS_TOT)) FROM Documentos F WHERE F.COD_ITEM = D.COD_ITEM AND F.DATA <= :IFinal) AS ICMS_TOT_FIM');
            Dados.TmpQry.SQL.Append('FROM Documentos D');
            Dados.TmpQry.SQL.Append('WHERE D.DATA BETWEEN :Inicial AND :Final');
            Dados.TmpQry.SQL.Append('GROUP BY D.COD_ITEM');
            Dados.TmpQry.SQL.Append('ORDER BY D.COD_ITEM');

            Dados.TmpQry.Parameters.ParamByName('QInicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('QFinal').Value := DataFinal;

            Dados.TmpQry.Parameters.ParamByName('IInicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('IFinal').Value := DataFinal;

            Dados.TmpQry.Parameters.ParamByName('Inicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('Final').Value := DataFinal;

            if isRunning then Dados.TmpQry.Open;

            if Dados.TmpQry.Active then
              begin
                if not Dados.TmpQry.IsEmpty then
                  begin
                    Dados.TmpQry.First;

                    while not Dados.TmpQry.Eof do
                      begin
                        WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s',
                                     ['1050',
                                      NoPipe(Dados.TmpQry.FieldByName('COD_ITEM').AsString, 60),
                                      ValBR(Dados.TmpQry.FieldByName('QTD_INI').AsFloat, 3),
                                      ValBR(Dados.TmpQry.FieldByName('ICMS_TOT_INI').AsFloat, 2),
                                      ValBR(Dados.TmpQry.FieldByName('QTD_FIM').AsFloat, 3),
                                      ValBR(Dados.TmpQry.FieldByName('ICMS_TOT_FIM').AsFloat, 2)]));

                        Application.ProcessMessages;

                        if not isRunning then
                          Dados.TmpQry.Last;

                        Dados.TmpQry.Next;
                      end;
                  end;

                Dados.TmpQry.Close;
              end;

            //--- REGISTRO 1100 - REGISTRO DE DOCUMENTO FISCAL ELETR�NICO PARA
            //--- FINS DE RESSARCIMENTO DE SUBSTITUI��O TRIBUT�RIA OU ANTECIPA��O

            if Dados.TmpQry.Active then
              Dados.TmpQry.Close;

            Dados.TmpQry.SQL.Clear;
            Dados.TmpQry.Parameters.Clear;

            Dados.TmpQry.SQL.Append('SELECT * FROM Documentos D');
            Dados.TmpQry.SQL.Append('WHERE ELETRO = :Eletronico AND D.DATA BETWEEN :Inicial AND :Final');

            if CheckBox1.Checked then
              begin
                //--- N�o relacionar os registros de opera��es de entrada
                Dados.TmpQry.SQL.Append('AND IND_OPER <> :Operacao');
                Dados.TmpQry.Parameters.ParamByName('Operacao').Value := '0';
              end;

            Dados.TmpQry.SQL.Append('ORDER BY D.DATA, D.COD_ITEM');

            Dados.TmpQry.Parameters.ParamByName('Eletronico').Value := True;
            Dados.TmpQry.Parameters.ParamByName('Inicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('Final').Value := DataFinal;

            if isRunning then Dados.TmpQry.Open;

            if Dados.TmpQry.Active then
              begin
                if not Dados.TmpQry.IsEmpty then
                  begin
                    Dados.TmpQry.First;

                    while not Dados.TmpQry.Eof do
                      begin
                        Entrada := ( Dados.TmpQry.FieldByName('IND_OPER').AsString = '0' );
                        Saida := ( Dados.TmpQry.FieldByName('IND_OPER').AsString = '1' );

                        Devolucao := AnsiEndsStr('411', Dados.TmpQry.FieldByName('CFOP').AsString);

                        ICMS_TOT := ValBR(Dados.TmpQry.FieldByName('ICMS_TOT').AsFloat, 2);
                        VL_CONFR := ValBR(Dados.TmpQry.FieldByName('VL_CONFR').AsFloat, 2);
                        COD_LEGAL := Dados.TmpQry.FieldByName('COD_LEGAL').AsString;

                        if ( Entrada and not Devolucao ) or ( Saida and Devolucao ) then
                          begin
                            VL_CONFR := '';
                            COD_LEGAL := '0';
                          end;

                        if ( Saida and not Devolucao ) then
                          ICMS_TOT := '';

                        if Entrada and CheckBox2.Checked then
                          begin
                            //--- N�o informar o total do ICMS nos registro de opera��es de entrada
                            ICMS_TOT := '';
                          end;

                        WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s',
                                     ['1100',
                                      NoPipe(Dados.TmpQry.FieldByName('CHV_DOC').AsString, 44),
                                      FormatDateTime('ddmmyyyy', Dados.TmpQry.FieldByName('DATA').AsDateTime),
                                      Format('%.3d', [Dados.TmpQry.FieldByName('NUM_ITEM').AsInteger]),
                                      NoPipe(Dados.TmpQry.FieldByName('IND_OPER').AsString, 1),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_ITEM').AsString, 60),
                                      NoPipe(Dados.TmpQry.FieldByName('CFOP').AsString, 4),
                                      ValBR(Dados.TmpQry.FieldByName('QTD').AsFloat, 3),
                                      ICMS_TOT,
                                      VL_CONFR,
                                      NoPipe(COD_LEGAL, 1)]));

                        Application.ProcessMessages;

                        if not isRunning then
                          Dados.TmpQry.Last;

                        Dados.TmpQry.Next;
                      end;
                  end;

                Dados.TmpQry.Close;
              end;

            //--- REGISTRO 1200 - REGISTRO DE DOCUMENTO FISCAL N�O-ELETR�NICO
            //--- PARA FINS DE RESSARCIMENTO DE SUBSTITUI��O TRIBUT�RIA - SP

            if Dados.TmpQry.Active then
              Dados.TmpQry.Close;

            Dados.TmpQry.SQL.Clear;
            Dados.TmpQry.Parameters.Clear;

            Dados.TmpQry.SQL.Append('SELECT * FROM Documentos D');
            Dados.TmpQry.SQL.Append('WHERE ELETRO = :Eletronico AND D.DATA BETWEEN :Inicial AND :Final');

            if CheckBox1.Checked then
              begin
                //--- N�o relacionar os registros de opera��es de entrada
                Dados.TmpQry.SQL.Append('AND IND_OPER <> :Operacao');
                Dados.TmpQry.Parameters.ParamByName('Operacao').Value := '0';
              end;

            Dados.TmpQry.SQL.Append('ORDER BY D.DATA, D.COD_ITEM');

            Dados.TmpQry.Parameters.ParamByName('Eletronico').Value := False;
            Dados.TmpQry.Parameters.ParamByName('Inicial').Value := DataInicial;
            Dados.TmpQry.Parameters.ParamByName('Final').Value := DataFinal;

            if isRunning then Dados.TmpQry.Open;

            if Dados.TmpQry.Active then
              begin
                if not Dados.TmpQry.IsEmpty then
                  begin
                    Dados.TmpQry.First;

                    while not Dados.TmpQry.Eof do
                      begin
                        Entrada := ( Dados.TmpQry.FieldByName('IND_OPER').AsString = '0' );
                        Saida := ( Dados.TmpQry.FieldByName('IND_OPER').AsString = '1' );

                        Devolucao := AnsiEndsStr('411', Dados.TmpQry.FieldByName('CFOP').AsString);

                        ICMS_TOT := ValBR(Dados.TmpQry.FieldByName('ICMS_TOT').AsFloat, 2);
                        VL_CONFR := ValBR(Dados.TmpQry.FieldByName('VL_CONFR').AsFloat, 2);
                        COD_LEGAL := Dados.TmpQry.FieldByName('COD_LEGAL').AsString;

                        if ( Entrada and not Devolucao ) or ( Saida and Devolucao ) then
                          begin
                            VL_CONFR := '';
                            COD_LEGAL := '0';
                          end;

                        if ( Saida and not Devolucao ) then
                          ICMS_TOT := '';

                        if Entrada and CheckBox2.Checked then
                          begin
                            //--- N�o informar o total do ICMS nos registro de opera��es de entrada
                            ICMS_TOT := '';
                          end;

                        WriteLn(TXT, Format('%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s',
                                     ['1200',
                                      NoPipe(Dados.TmpQry.FieldByName('COD_PART').AsString, 60),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_MOD').AsString, 2),
                                      NoPipe(Dados.TmpQry.FieldByName('ECF_FAB').AsString, 21),
                                      NoPipe(Dados.TmpQry.FieldByName('SER').AsString, 3),
                                      Format('%.9d', [Dados.TmpQry.FieldByName('NUM_DOC').AsInteger]),
                                      Format('%.3d', [Dados.TmpQry.FieldByName('NUM_ITEM').AsInteger]),
                                      NoPipe(Dados.TmpQry.FieldByName('IND_OPER').AsString, 1),
                                      FormatDateTime('ddmmyyyy', Dados.TmpQry.FieldByName('DATA').AsDateTime),
                                      NoPipe(Dados.TmpQry.FieldByName('CFOP').AsString, 4),
                                      NoPipe(Dados.TmpQry.FieldByName('COD_ITEM').AsString, 60),
                                      ValBR(Dados.TmpQry.FieldByName('QTD').AsFloat, 3),
                                      ICMS_TOT,
                                      VL_CONFR,
                                      NoPipe(COD_LEGAL, 1)]));

                        Application.ProcessMessages;

                        if not isRunning then
                          Dados.TmpQry.Last;

                        Dados.TmpQry.Next;
                      end;
                  end;

                Dados.TmpQry.Close;
              end;

            //---

            CloseFile(TXT);

            if isRunning then
              ShowMessage('Arquivo ' + Arquivo + ' gerado!')
            else
              begin
                DeleteFile(Arquivo);
                ShowMessage('Gera��o cancelada.'#13'Arquivo ' + Arquivo + ' deletado!');
              end;
          end;

        isRunning := False;
      end;
end;

procedure TGerador.Button2Click(Sender: TObject);
begin
  isRunning := False;

  Close;
end;

procedure TGerador.ShowCheckBoxes(Sender: TObject);
begin
  CheckBox1.Enabled := not CheckBox2.Checked;
  CheckBox2.Enabled := not CheckBox1.Checked;
end;

end.

