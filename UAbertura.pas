unit UAbertura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, MidasLib;

type
  TAbertura = class(TForm)
    MenuPrincipal: TMainMenu;
    mEmpresa: TMenuItem;
    mParticipantes: TMenuItem;
    mItens: TMenuItem;
    mDocumentos: TMenuItem;
    mGerador: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    mRemessas: TMenuItem;
    procedure MenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Abertura: TAbertura;

implementation

{$R *.dfm}

uses
  UDados, UEmpresa, UParticipantes, UItens, UDocumentos, UGerador, URemessas,
  UVersionInfo;

procedure TAbertura.FormCreate(Sender: TObject);
var
  VersionInfoList: TVersionInfo;
begin
  try
    MaxWidth := GetSystemMetrics(SM_CXSCREEN);
    MaxHeight := GetSystemMetrics(SM_CYMAXIMIZED) - 10;
    except
      MaxWidth := 800; MaxHeight := 572;
  end;

  Width := MaxWidth; Height := MaxHeight;

  MinLeft := ( MaxWidth - ClientWidth ) div 2;

  MaxWidth := ClientWidth;
  MaxHeight := ClientHeight;

  Position := poScreenCenter;

  Caption := Application.Title;

  //---

  VersionInfoList := TVersionInfo.Create(Self);

  try
    VersionInfoList.OpenFile(Application.ExeName);

    Caption := Format('%s versão %s', [Caption, VersionInfoList.FileVersion]);

    Label1.Caption := VersionInfoList.FileDescription;
    Label2.Caption := VersionInfoList.LegalCopyRight;

    VersionInfoList.Close;

    finally
      VersionInfoList.Free;
      inherited;
  end;

  Label2.Top := ClientHeight - Label2.Height - 20;
  Label2.Left := ClientWidth - Label2.Width - 20;
end;

procedure TAbertura.FormActivate(Sender: TObject);
begin
  if Dados.OpenDatabase(Dados.Conn, True) then
    begin
      Dados.SetFieldDefs;
      Dados.SetIndexFieldNames;
    end;
end;

procedure TAbertura.MenuClick(Sender: TObject);
begin
  if ( Sender = mEmpresa ) then
    Empresa.Show;
  if ( Sender = mParticipantes ) then
    Participantes.Show;
  if ( Sender = mItens ) then
    Itens.Show;
  if ( Sender = mDocumentos ) then
    Documentos.Show;
  if ( Sender = mGerador ) then
    Gerador.Show;
  if ( Sender = mRemessas ) then
    Remessas.Show;
end;

end.

