unit uServerMethods;

interface

uses  System.SysUtils, System.Classes, System.Json,
      DataSnap.DSProviderDataModuleAdapter,
      Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf,
      FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
      FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
      FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
      FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
      FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
      WEB.HTTPApp,Datasnap.DSHTTPWebBroker, DATA.DBXPlatform, iniFiles;

type
  TServerMethods = class(TDSServerModule)
    Conn: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    QryPessoas: TFDQuery;
    QryPessoasidpessoa: TLargeintField;
    QryPessoasflnatureza: TSmallintField;
    QryPessoasdsdocumento: TWideStringField;
    QryPessoasnmprimeiro: TWideStringField;
    QryPessoasnmsegundo: TWideStringField;
    QryPessoasdtregistro: TDateField;
    QryEndereco: TFDQuery;
    QryEnderecoidendereco: TLargeintField;
    QryEnderecoidpessoa: TLargeintField;
    QryEnderecodscep: TWideStringField;
    QryEndereco_Integracao: TFDQuery;
    QryEndereco_Integracaoidendereco: TLargeintField;
    QryEndereco_Integracaodsuf: TWideStringField;
    QryEndereco_Integracaonmcidade: TWideStringField;
    QryEndereco_Integracaonmbairro: TWideStringField;
    QryEndereco_Integracaonmlogradouro: TWideStringField;
    QryEndereco_Integracaodscomplemento: TWideStringField;
    QrySequencia: TFDQuery;
    QrySequenciamax: TLargeintField;
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
    QryAuxiliar: TFDQuery;
  private
    { Private declarations }
  public
    function Pessoas(nome: String) : TJsonArray;                 // GET
    function cancelPessoas(const idpessoa: integer): TJSONArray; // Delete
    function updateTotal : TJSONArray;                           // Insert
    function acceptTotal : TJSONArray;                           // Update
  end;

implementation


{$R *.dfm}

uses uWebModule;

{ TServerMethods1 }

function TServerMethods.Pessoas(nome: String) : TJsonArray;
var
i     : Integer;
JsonP : TJSONObject;
begin
   QryPessoas.Close;
   QryPessoas.SQL.Clear;

   if nome = '' then
     QryPessoas.SQL.Add('select * from pessoa')
   else
     QryPessoas.SQL.Add('select * from pessoa where pessoa.nmprimeiro like '+#39+nome+#39);

   QryPessoas.Open;

   if qryPessoas.Active = True then
   begin
      if QryPessoas.RecordCount > 0 then
      begin
        Result := TJSONArray.Create;

        while not Qrypessoas.Eof do
        begin
          JsonP := TJSONObject.Create;

          for I := 0 to Qrypessoas.FieldCount - 1 do
          begin
             if QryPessoas.Fields[i].IsNull then
             begin
               JsonP.AddPair(QryPessoas.Fields[i].DisplayName, 'nulo')
             end
             else
              JsonP.AddPair(QryPessoas.Fields[i].DisplayName, QryPessoas.Fields[i].AsString);
          end;

          Result.AddElement(JsonP);

          QryPessoas.Next;
        end;
      end;
   end;
end;

function TServerMethods.updateTotal : TJSONArray;

CONST
_SQL = 'INSERT INTO PESSOA (FLNATUREZA, DSDOCUMENTO, NMPRIMEIRO, NMSEGUNDO, DTREGISTRO) '+
        'VALUES (:NEW_FLNATUREZA, :NEW_DSDOCUMENTO, :NEW_NMPRIMEIRO, :NEW_NMSEGUNDO, :NEW_DTREGISTRO);';

_SQLENDERECO = 'INSERT INTO ENDERECO (DSCEP) VALUES (:NEW_DSCEP);';

var
LModule          : TWebModule;
vJsonReq         : TJSONArray;
vJson            : TJsonValue;
vNatureza        : Integer;
vDocumento       : String;
vPNome           : String;
vSNome           : String;
vData            : TDateTime;
vDSCEP           : String;
vidpessoa        : Integer;
vuf              : String;
vcidade          : String;
vbairro          : String;
vEnd             : String;
vComplemento     : String;
videndereco      : String;
begin
  LModule := GetDataSnapWebModule;

  if Lmodule.Request.Content.IsEmpty then        //Se n?o veio nada no Body..
  begin
    GetInvocationMetaData().ResponseCode := 204;
    Abort;
  end;

  vJsonReq := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LModule.Request.Content),0) as TJsonArray;

  for vJson in vJsonReq do
  begin
    vNatureza     := vJson.GetValue<integer>('flnatureza');
    vDocumento    := vJson.GetValue<String>('dsdocumento');
    vPNome        := vJson.GetValue<String>('nmprimeiro');
    vSNome        := vJson.GetValue<String>('nmsegundo');
    vData         := StrtoDate(vJson.GetValue<String>('dtregistro'));
    vDSCEP        := vJson.GetValue<String>('dscep');
    vidpessoa     := vJson.GetValue<Integer>('idpessoa');
    vuf           := vJson.GetValue<String>('dsuf');
    vcidade       := vJson.GetValue<String>('nmcidade');
    vbairro       := vJson.GetValue<String>('nmbairro');
    vEnd          := vJson.GetValue<String>('nmlogradouro');
    vComplemento  := vJson.GetValue<String>('dscomplemento');
    videndereco   := vJson.GetValue<String>('idendereco');
  end;

  with QryAuxiliar do   //PESSOA
  begin
    CLose;
    Sql.Clear;
    Sql.Text := _SQL;

    ParamByName('NEW_FLNATUREZA').AsInteger := vNatureza;
    ParamByName('NEW_DSDOCUMENTO').AsString := vDocumento;
    ParamByName('NEW_NMPRIMEIRO').AsString  := vPNome;
    ParamByName('NEW_NMSEGUNDO').AsString   := vSNome;
    ParamByName('NEW_DTREGISTRO').AsDate    := vData;

    ExecSQL;
  end;

  QrySequencia.Close;
  QrySequencia.Open;

  vidpessoa := QrySequenciamax.AsInteger;

  with QryAuxiliar do   //ENDERECO
  begin
    CLose;
    Sql.Clear;
    Sql.Text := 'INSERT INTO ENDERECO (dscep, idpessoa, idendereco) VALUES (:NEW_DSCEP,'+QuotedStr(vidpessoa.ToString)+','+QuotedStr(vidpessoa.ToString)+')';
    ParamByName('NEW_DSCEP').AsString         := vDSCEP;
    ExecSQL;
  end;

                       //Endereco Integra??o
  QryEndereco_Integracao.Close;
  QryEndereco_Integracao.Open;

  with QryEndereco_Integracao do
  begin
    Edit;
    FieldByName('idendereco').AsInteger   := vidpessoa;
    FieldByName('dsuf').AsString          := vuf;
    FieldByName('nmcidade').AsString      := vcidade;
    FieldByName('nmbairro').AsString      := vbairro;
    FieldByName('nmlogradouro').AsString  := vEnd;
    FieldByName('dscomplemento').AsString := vComplemento;
    Post;
  end;


  Result := TJSONArray.Create('Mensagem','Cadastro efetuado!');
end;

function TServerMethods.CancelPessoas(const idpessoa: integer): TJsonArray;
const
_DELETE = 'DELETE FROM PESSOA WHERE PESSOA.IDPESSOA = :IDPESSOA';
begin
 with QryAuxiliar do
  begin
    CLose;
    Sql.Clear;
    Sql.Text := _DELETE;
    ParamByName('IDPESSOA').AsInteger := idpessoa;
    ExecSQL;
  end;

  Result := TJSONArray.Create('Mensagem','Registro exclu?do com sucesso!');
end;

function TServerMethods.acceptTotal : TJSONArray;
CONST
_SQL = 'INSERT INTO PESSOA (FLNATUREZA, DSDOCUMENTO, NMPRIMEIRO, NMSEGUNDO, DTREGISTRO) '+
        'VALUES (:NEW_FLNATUREZA, :NEW_DSDOCUMENTO, :NEW_NMPRIMEIRO, :NEW_NMSEGUNDO, :NEW_DTREGISTRO);';

_SQLENDERECO = 'INSERT INTO ENDERECO (DSCEP) VALUES (:NEW_DSCEP);';

var
LModule          : TWebModule;
vJsonReq         : TJSONArray;
vJson            : TJsonValue;
vNatureza        : Integer;
vDocumento       : String;
vPNome           : String;
vSNome           : String;
vData            : TDateTime;
vDSCEP           : String;
vidpessoa        : Integer;
vuf              : String;
vcidade          : String;
vbairro          : String;
vEnd             : String;
vComplemento     : String;
videndereco      : String;
begin
  LModule := GetDataSnapWebModule;

  if Lmodule.Request.Content.IsEmpty then        //Se n?o veio nada no Body..
  begin
    GetInvocationMetaData().ResponseCode := 204;
    Abort;
  end;

  vJsonReq := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LModule.Request.Content),0) as TJsonArray;

  for vJson in vJsonReq do
  begin
    vNatureza     := vJson.GetValue<integer>('flnatureza');
    vDocumento    := vJson.GetValue<String>('dsdocumento');
    vPNome        := vJson.GetValue<String>('nmprimeiro');
    vSNome        := vJson.GetValue<String>('nmsegundo');
    vData         := StrtoDate(vJson.GetValue<String>('dtregistro'));
    vDSCEP        := vJson.GetValue<String>('dscep');
    vidpessoa     := vJson.GetValue<Integer>('idpessoa');
    vuf           := vJson.GetValue<String>('dsuf');
    vcidade       := vJson.GetValue<String>('nmcidade');
    vbairro       := vJson.GetValue<String>('nmbairro');
    vEnd          := vJson.GetValue<String>('nmlogradouro');
    vComplemento  := vJson.GetValue<String>('dscomplemento');
    videndereco   := vJson.GetValue<String>('idendereco');
  end;

  with QryAuxiliar do   //PESSOA
  begin
    CLose;
    Sql.Clear;
    Sql.Text := 'UPDATE PESSOA SET flnatureza = :NEW_FLNATUREZA, dsdocumento = :NEW_DSDOCUMENTO,  '+
                'nmprimeiro = :NEW_NMPRIMEIRO, nmsegundo = :NEW_NMSEGUNDO '+
                ' WHERE PESSOA.IDPESSOA = :IDPESSOA;';

    ParamByName('NEW_FLNATUREZA').AsInteger := vNatureza;
    ParamByName('NEW_DSDOCUMENTO').AsString := vDocumento;
    ParamByName('NEW_NMPRIMEIRO').AsString  := vPNome;
    ParamByName('NEW_NMSEGUNDO').AsString   := vSNome;
    ParamByName('IDPESSOA').AsInteger       := vidpessoa;
    ExecSQL;
  end;

  with QryAuxiliar do  //ENDERECO
  begin
    CLose;
    Sql.Clear;
    Sql.Text := 'UPDATE ENDERECO set dscep = :NEW_DSCEP where endereco.idendereco = '+QuotedStr(vidpessoa.ToString);
    ParamByName('NEW_DSCEP').AsString         := vDSCEP;
    ExecSQL;
  end;

                      //Endereco Integracao
  with QryEndereco_Integracao do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'UPDATE ENDERECO_INTEGRACAO SET dsuf = :NEW_UF, nmcidade = :NEW_CIDADE, '+
                                        'nmbairro = :NEW_BAIRRO, nmlogradouro = :NEW_LOGRADOURO, dscomplemento = :NEW_COMPLEMENTO '+
                                        ' WHERE ENDERECO_INTEGRACAO.IDENDERECO = '+QuotedStr(vidpessoa.ToString);

    ParamByName('NEW_UF').AsString            := vuf;
    ParamByName('NEW_CIDADE').AsString        := vcidade;
    ParamByName('NEW_BAIRRO').AsString        := vbairro;
    ParamByName('NEW_LOGRADOURO').AsString        := vEnd;
    ParamByName('NEW_COMPLEMENTO').AsString        := vComplemento;

    ExecSQL;
  end;


  Result := TJSONArray.Create('Mensagem','Cadastro Atualizado!!');
end;
end.

