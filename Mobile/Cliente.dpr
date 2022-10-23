program Cliente;

uses
  System.StartUpCopy,
  FMX.Forms,
  uCadatro_Pessoas in 'View\uCadatro_Pessoas.pas' {FrmCad_Pessoas},
  uDmPrincipal in 'DM\uDmPrincipal.pas' {DmPrincipal: TDataModule},
  uFormat in '..\uFormat.pas',
  uFancyDialog in '..\uFancyDialog.pas',
  uDmPessoa in 'DM\uDmPessoa.pas' {DmPessoa: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCad_Pessoas, FrmCad_Pessoas);
  Application.CreateForm(TFrmCad_Pessoas, FrmCad_Pessoas);
  Application.CreateForm(TDmPrincipal, DmPrincipal);
  Application.CreateForm(TDmPessoa, DmPessoa);
  Application.Run;
end.
