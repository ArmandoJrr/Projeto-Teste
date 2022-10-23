unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, iniFiles, System.IOUtils,
  winsock,controls, forms, dialogs;

type
  TDmPrincipal = class(TDataModule)
    Conn: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function CarregarConfig(Section, Name, Value: string): string;
    procedure SalvarConfig(Section, Name, Value: string);
    { Public declarations }
  end;

var
  DmPrincipal: TDmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmPrincipal.CarregarConfig(Section, Name, Value: string): string;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(System.IOUtils.TPath.GetDocumentsPath + System.SysUtils.PathDelim + 'Config.ini');
  try
    Result := ini.ReadString(Section, Name, Value);
  finally
    ini.Free;
  end;
end;

procedure TDmPrincipal.DataModuleCreate(Sender: TObject);
var
ini : TIniFile;
nomeBanco  : String;
UserBanco  : String;
SenhaBanco : String;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');

    nomeBanco  := ini.ReadString('Banco', 'NomeBD','');
    UserBanco  := ini.ReadString('Banco', 'User','');
    SenhaBanco := ini.ReadString('Banco', 'Senha','');

    Conn.Params.Database := nomeBanco;
    Conn.Params.UserName := UserBanco;
    Conn.Params.Password := SenhaBanco;

    Conn.Connected := True;
  except
    ShowMessage('Configure o arquivo ini para a conexão com o banco!');
  end;
end;

procedure TDmPrincipal.SalvarConfig(Section, Name, Value: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(System.IOUtils.TPath.GetDocumentsPath + System.SysUtils.PathDelim + 'Config.ini');
  try
    ini.WriteString(Section, Name, Value);
  finally
    ini.Free;
  end;
end;

end.
