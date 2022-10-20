unit uDmPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.FMXUI.Wait, REST.Types,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope,FMX.ListView.Types,FireDAC.Phys.PG,FireDAC.Phys.PGDef,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.SqlExpr;

type
  TDmPrincipal = class(TDataModule)
    QryPessoas: TFDQuery;
    Conn: TFDConnection;
    QryPessoasidpessoa: TLargeintField;
    QryPessoasflnatureza: TSmallintField;
    QryPessoasdsdocumento: TWideStringField;
    QryPessoasnmprimeiro: TWideStringField;
    QryPessoasnmsegundo: TWideStringField;
    QryPessoasdtregistro: TDateField;
    QryEndereco: TFDQuery;
    QryEndereco_Integracao: TFDQuery;
    QryEnderecoidendereco: TLargeintField;
    QryEnderecoidpessoa: TLargeintField;
    QryEnderecodscep: TWideStringField;
    QryEndereco_Integracaoidendereco: TLargeintField;
    QryEndereco_Integracaodsuf: TWideStringField;
    QryEndereco_Integracaonmcidade: TWideStringField;
    QryEndereco_Integracaonmbairro: TWideStringField;
    QryEndereco_Integracaonmlogradouro: TWideStringField;
    QryEndereco_Integracaodscomplemento: TWideStringField;
    QrySequencia: TFDQuery;
    QrySequenciamax: TLargeintField;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    QryDetalhe: TFDQuery;
    QryDetalheidpessoa: TLargeintField;
    QryDetalheflnatureza: TSmallintField;
    QryDetalhedsdocumento: TWideStringField;
    QryDetalhenmprimeiro: TWideStringField;
    QryDetalhenmsegundo: TWideStringField;
    QryDetalhedtregistro: TDateField;
    QryDetalheidendereco: TLargeintField;
    QryDetalheidpessoa_1: TLargeintField;
    QryDetalhedscep: TWideStringField;
    QryDetalheidendereco_1: TLargeintField;
    QryDetalhedsuf: TWideStringField;
    QryDetalhenmcidade: TWideStringField;
    QryDetalhenmbairro: TWideStringField;
    QryDetalhenmlogradouro: TWideStringField;
    QryDetalhedscomplemento: TWideStringField;
    QryDetalheidendereco_2: TLargeintField;
    QryDetalheidpessoa_2: TLargeintField;
    QryDetalhedscep_1: TWideStringField;
    QryDetalheidendereco_3: TLargeintField;
    QryDetalhedsuf_1: TWideStringField;
    QryDetalhenmcidade_1: TWideStringField;
    QryDetalhenmbairro_1: TWideStringField;
    QryDetalhenmlogradouro_1: TWideStringField;
    QryDetalhedscomplemento_1: TWideStringField;
    QryExcluirPessoa: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddPessoas(Nome: String; Codigo: Integer);
    procedure CarregarPessoas(Pesquisa: String);
    function SomenteNumero(str: string): string;
    procedure NovaPessoa;
    { Public declarations }
  end;

var
  DmPrincipal: TDmPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uCadatro_Pessoas;

{$R *.dfm}

procedure TDmPrincipal.DataModuleCreate(Sender: TObject);
begin
  Conn.Connected := True;
end;

function TDmPrincipal.SomenteNumero(str : string) : string;
var
    x : integer;
begin
    Result := '';
    for x := 0 to Length(str) - 1 do
        if (str.Chars[x] In ['0'..'9']) then
            Result := Result + str.Chars[x];
end;

procedure TDmPrincipal.NovaPessoa;
begin
  DmPrincipal.QryPessoas.CLose;
  DmPrincipal.QryPessoas.Open;

  DmPrincipal.QryEndereco.Close;
  DmPrincipal.QryEndereco.Open;

  DmPrincipal.QryEndereco_Integracao.Close;
  DmPrincipal.QryEndereco_Integracao.Open;
end;

procedure TDmPrincipal.AddPessoas(Nome: String; Codigo: Integer);
begin
  with FrmCad_Pessoas.ListViewPessoas.Items.Add do
    begin
      TagString  := Codigo.ToString;

      TListItemText(Objects.FindDrawable('txtNome')).Text         := Nome;
      TListItemText(Objects.FindDrawable('txtCodigo')).Text       := Codigo.ToString;
    end;
end;

procedure TDmPrincipal.CarregarPessoas(Pesquisa : String);
begin
   DmPrincipal.QryPessoas.Close;
   DmPrincipal.QryPessoas.SQL.Clear;

   if pesquisa = '' then
     DmPrincipal.QryPessoas.SQL.Add('select * from pessoa')
   else
     DmPrincipal.QryPessoas.SQL.Add('select * from pessoa where pessoa.nmprimeiro like '+#39+pesquisa+#39);

   DmPrincipal.QryPessoas.Open;
end;


end.
