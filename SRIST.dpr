program SRIST;

uses
  Forms,
  UAbertura in 'UAbertura.pas' {Abertura},
  UDados in 'UDados.pas' {Dados: TDataModule},
  UEmpresa in 'UEmpresa.pas' {Empresa},
  UParticipantes in 'UParticipantes.pas' {Participantes},
  UItens in 'UItens.pas' {Itens},
  UDocumentos in 'UDocumentos.pas' {Documentos},
  UGerador in 'UGerador.pas' {Gerador},
  UVersionInfo in 'UVersionInfo.pas',
  UFerramentas in 'UFerramentas.pas',
  URemessas in 'URemessas.pas' {Remessas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SRIST';
  Application.CreateForm(TAbertura, Abertura);
  Application.CreateForm(TDados, Dados);
  Application.CreateForm(TEmpresa, Empresa);
  Application.CreateForm(TParticipantes, Participantes);
  Application.CreateForm(TItens, Itens);
  Application.CreateForm(TDocumentos, Documentos);
  Application.CreateForm(TGerador, Gerador);
  Application.CreateForm(TRemessas, Remessas);
  Application.Run;
end.

