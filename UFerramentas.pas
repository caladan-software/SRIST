unit UFerramentas;

interface

uses
  Windows, SysUtils, Forms, Dialogs;

const
  chrNumeric = '0123456789';
  chrAlphabetic = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  chrSymbols = ' !"#$%&'#39'()*+,-./:;<=>?@[\]^_{|}~';

var
  AppHandled: Boolean;

function BoxMensagem(Msg: String; DlgType: TMsgDlgType; Buttons:
  TMsgDlgButtons; HelpCtx: Longint): Integer;
function NoPipe(strChars: String; maxLen: Integer): String;
function OnlyValidChars(strChars, strValidChars: String; numLength: Integer): String;
function ValBR(Value: Extended; Decimals: Integer): String;

implementation

function BoxMensagem(Msg: String; DlgType: TMsgDlgType; Buttons:
  TMsgDlgButtons; HelpCtx: Longint): Integer;
var
  ipCaption: PWideChar;
  uType: Cardinal;
begin
  case DlgType of
    mtInformation  : ipCaption := 'Informa��o';
    mtWarning      : ipCaption := 'Aten��o';
    mtError        : ipCaption := 'Erro';
    mtConfirmation : ipCaption := 'Confirma��o';
  else
    ipCaption := PWideChar(Application.Title);
  end;

  uType := 0;

  case DlgType of
    mtCustom       : Inc(uType, MB_ICONEXCLAMATION);
    mtInformation  : Inc(uType, MB_ICONINFORMATION);
    mtWarning      : Inc(uType, MB_ICONWARNING);
    mtError        : Inc(uType, MB_ICONSTOP);
    mtConfirmation : Inc(uType, MB_ICONQUESTION);
  end;

  if ( Buttons = [mbOK] ) then Inc(uType, MB_OK);
  if ( Buttons = [mbOK, mbCancel] ) or ( Buttons = mbOKCancel ) then Inc(uType, MB_OKCANCEL);
  if ( Buttons = [mbAbort, mbRetry, mbIgnore] ) or ( Buttons = mbAbortRetryIgnore ) then Inc(uType, MB_ABORTRETRYIGNORE);
  if ( Buttons = [mbYes, mbNo, mbCancel] ) or ( Buttons = mbYesNoCancel ) then Inc(uType, MB_YESNOCANCEL);
  if ( Buttons = [mbYes, mbNo] ) then Inc(uType, MB_YESNO);
  if ( Buttons = [mbRetry, mbCancel] ) then Inc(uType, MB_RETRYCANCEL);
  if ( Buttons = [mbHelp] ) then Inc(uType, MB_HELP);

  AppHandled := true;

  Inc(uType, MB_TASKMODAL);

  if ( uType = 0 ) or ( HelpCtx > 0 ) then
    Result := MessageDlg(Msg, DlgType, Buttons, HelpCtx)
  else
    Result := MessageBox(Application.Handle, PWideChar(Msg), ipCaption, uType);

  AppHandled := false;
end;

function LimpaASC(TEXTOBASE: String): String;
var
  StrTemp: String;
begin
  StrTemp := TEXTOBASE;

  StrTemp := StringReplace(StrTemp, '&', 'e', [rfReplaceAll]);
  //--- vogal a acentuada
  StrTemp := StringReplace(StrTemp, '�', 'a', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'A', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'a', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'A', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'a', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'A', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'a', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'A', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'a', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'A', [rfReplaceAll]);
  //--- vogal e acentuada
  StrTemp := StringReplace(StrTemp, '�', 'e', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'E', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'e', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'E', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'e', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'E', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'e', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'E', [rfReplaceAll]);
  //--- vogal i acentuada
  StrTemp := StringReplace(StrTemp, '�', 'i', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'I', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'i', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'I', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'i', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'I', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'i', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'I', [rfReplaceAll]);
  //--- vogal o acentuada
  StrTemp := StringReplace(StrTemp, '�', 'o', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'O', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'o', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'O', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'o', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'O', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'o', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'O', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'o', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'O', [rfReplaceAll]);
  //--- vogal u acentuada
  StrTemp := StringReplace(StrTemp, '�', 'u', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'U', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'u', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'U', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'u', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'U', [rfReplaceAll]);
  StrTemp := StringReplace(StrTemp, '�', 'u', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'U', [rfReplaceAll]);
  //--- cedilha
  StrTemp := StringReplace(StrTemp, '�', 'c', [rfReplaceAll]); StrTemp := StringReplace(StrTemp, '�', 'C', [rfReplaceAll]);

  Result := StrTemp;
end;

function NoPipe(strChars: String; maxLen: Integer): String;
var
  strTemp: String;
begin
  strTemp := Trim(strChars);
  strTemp := StringReplace(strTemp, '|', '/', [rfReplaceAll]);
  strTemp := LimpaASC(strTemp);
  if ( maxLen > Length(strTemp) ) then strTemp := Copy(strTemp, 1, maxLen);
  Result := strTemp;
end;

function OnlyValidChars(strChars, strValidChars: String; numLength: Integer): String;
var
  strTemp: String;
  ii: Integer;
begin
  strTemp := strChars;
  for ii := Length(strTemp) downto 1 do
    begin
      if Pos(Copy(strTemp, ii, 1), strValidChars) <= 0 then
        Delete(strTemp, ii, 1);
    end;
    if ( numLength > 0 ) and ( Length(strTemp) > numLength ) then
      strTemp := Copy(strTemp, 1, numLength);
    Result := strTemp;
end;

function ValBR(Value: Extended; Decimals: Integer): String;
var
  strTemp: String;
begin
  strTemp := Format('%.' + IntToStr(Decimals) + 'f', [Value]);
  with FormatSettings do
    begin
      strTemp := StringReplace(strTemp, ThousandSeparator, '', [rfReplaceAll]);
      strTemp := StringReplace(strTemp, DecimalSeparator, ',', [rfReplaceAll]);
    end;
  Result := strTemp;
end;

end.

