program ProjetoAltec;

uses
  Vcl.Forms,
  uCadCli in 'uCadCli.pas' {frmCadCli},
  uPesqEnd in 'uPesqEnd.pas',
  uSendEmail in 'uSendEmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadCli, frmCadCli);
  Application.Run;
end.
