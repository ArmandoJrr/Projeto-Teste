unit uDmPessoa;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, JSON.Utils,  Json.Types, Json.Readers,
  System.JSon, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.JSON.Writers, REST.Utils, uFancyDialog,
  REST.Response.Adapter, DBXJSon;

  const
    C_BASEURL = 'http://localhost:211/datasnap/rest/';

    C_SMSERVICOS = 'TServerMethods';

type
  TDmPessoa = class(TDataModule)
    RESTRequestEdicoes: TRESTRequest;
    RESTResponseEdicoes: TRESTResponse;
    RESTClientEdicoes: TRESTClient;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    MemTablePessoas: TFDMemTable;
  private

    { Private declarations }
  public
    procedure EditarCadastro;
    procedure inserirEditarPessoa;
    procedure InserirEndereco;
    procedure ExcluirPessoa(ID: Integer);
    procedure InserirPessoa;
    procedure InserirEndComplemento(idendereco : Integer);
    { Public declarations }
  end;

var
  DmPessoa: TDmPessoa;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uCadatro_Pessoas, uDmPrincipal;

{$R *.dfm}

procedure TDmPessoa.InserirEndComplemento(idendereco: Integer);
var
  JO: TJSONObject;
  JA: TJSONArray;
begin
  RESTClientEdicoes.ResetToDefaults;
  RESTRequestEdicoes.ResetToDefaults;
  RESTResponseEdicoes.ResetToDefaults;

  JO := TJSONObject.Create;
  JO.AddPair('dsuf',           FrmCad_Pessoas.EdtUF.Text);
  JO.AddPair('nmcidade',       FrmCad_Pessoas.EdtCidade.Text);
  JO.AddPair('nmbairro',       FrmCad_Pessoas.EdtBairro.Text);
  JO.AddPair('nmlogradouro',   FrmCad_Pessoas.EdtEnd.Text);
  JO.AddPair('dscomplemento',  FrmCad_Pessoas.EdtComplemento.Text);
  JO.AddPair('idendereco',     FrmCad_Pessoas.IdPessoa.ToString);

  JA := TJSONArray.Create;
  JA.AddElement(Jo);

  RestClientEdicoes.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClientEdicoes.AcceptCharset := 'UTF-8, *;q=0.8';
  RestClientEdicoes.BaseURL := Format('http://%s:%s/datasnap/rest/TServerMethods', ['localhost', '211']);
  RestClientEdicoes.ContentType := CONTENTTYPE_APPLICATION_JSON;
  RESTRequestEdicoes.Resource := 'EnderecoIn';
  RestClientEdicoes.HandleRedirects := True;
  RestClientEdicoes.RaiseExceptionOn500 := False;
  RESTRequestEdicoes.Client := RestClientEdicoes;
  RESTRequestEdicoes.Method := TRESTRequestMethod.rmPOST;
  RESTRequestEdicoes.Body.ClearBody;
  RESTRequestEdicoes.Body.Add(JA.ToString, ContentTypeFromString('application/json'));
  RESTRequestEdicoes.Execute;
end;

procedure TDmPessoa.InserirEndereco;
var
  JO: TJSONObject;
  JA: TJSONArray;
begin
  RESTClientEdicoes.ResetToDefaults;
  RESTRequestEdicoes.ResetToDefaults;
  RESTResponseEdicoes.ResetToDefaults;

  JO := TJSONObject.Create;
  JO.AddPair('dscep',     FrmCad_Pessoas.EdtCEP.Text);
  JO.AddPair('idpessoa',  FrmCad_Pessoas.IdPessoa);

  JA := TJSONArray.Create;
  JA.AddElement(JO);

  RestClientEdicoes.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClientEdicoes.AcceptCharset := 'UTF-8, *;q=0.8';
  RestClientEdicoes.BaseURL := Format('http://%s:%s/datasnap/rest/TServerMethods', ['localhost', '211']);
  RestClientEdicoes.ContentType := CONTENTTYPE_APPLICATION_JSON;
  RESTRequestEdicoes.Resource := 'Endereco';
  RestClientEdicoes.HandleRedirects := True;
  RestClientEdicoes.RaiseExceptionOn500 := False;
  RESTRequestEdicoes.Client := RestClientEdicoes;
  RESTRequestEdicoes.Method := TRESTRequestMethod.rmPOST;
  RESTRequestEdicoes.Body.ClearBody;
  RESTRequestEdicoes.Body.Add(JA.toString, ContentTypeFromString('application/json'));
  RESTRequestEdicoes.Execute;
end;

procedure TDmPessoa.InserirPessoa;
var
  JO: TJSONObject;
  JA: TJSONArray;
  ParamData : String;
  DataAtual : TDate;
begin
  //Ajuste pra passar data.. Não funcionou passando NOW pro JSON..
  ParamData := DatetoStr(Now);
  StrToDate(ParamData);

  RESTClientEdicoes.ResetToDefaults;
  RESTRequestEdicoes.ResetToDefaults;
  RESTResponseEdicoes.ResetToDefaults;

  JO := TJSONObject.Create;
  if FrmCad_Pessoas.CBNaturezaPessoas.ItemIndex = 0 then
     JO.AddPair('flnatureza', TJSONNumber.Create(1)) //Pessoa física
  else
     JO.AddPair('flnatureza', TJSONNumber.Create(2)); //Pessoa jurídica

  JO.AddPair('dsdocumento', FrmCad_Pessoas.EdtDocumento.Text);
  JO.AddPair('nmprimeiro',  FrmCad_Pessoas.EdtNome.Text);
  JO.AddPair('nmsegundo',   FrmCad_Pessoas.EdtSobrenome.Text);
  JO.AddPair('dtregistro',  ParamData);

  JA := TJSONArray.Create;
  JA.AddElement(Jo);

  RestClientEdicoes.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClientEdicoes.AcceptCharset := 'UTF-8, *;q=0.8';
  RestClientEdicoes.BaseURL := Format('http://%s:%s/datasnap/rest/TServerMethods', ['localhost', '211']);
  RestClientEdicoes.ContentType := CONTENTTYPE_APPLICATION_JSON;
  RESTRequestEdicoes.Resource := 'Pessoas';
  RestClientEdicoes.HandleRedirects := True;
  RestClientEdicoes.RaiseExceptionOn500 := False;
  RESTRequestEdicoes.Client := RestClientEdicoes;
  RESTRequestEdicoes.Method := TRESTRequestMethod.rmPOST;
  RESTRequestEdicoes.Body.Add(JA.ToString, ContentTypeFromString('application/json'));
  RESTRequestEdicoes.Execute;
end;

procedure TDmPessoa.inserirEditarPessoa;
var
  JO: TJSONObject;
  JA: TJSONArray;
  ParamData : String;
  DataAtual : TDate;
begin
  //Ajuste pra passar data.. Não funcionou passando NOW pro JSON..
  ParamData := DatetoStr(Now);
  StrToDate(ParamData);

  RESTClientEdicoes.ResetToDefaults;
  RESTRequestEdicoes.ResetToDefaults;
  RESTResponseEdicoes.ResetToDefaults;

  JO := TJSONObject.Create;
  //Pessoa...
  if FrmCad_Pessoas.CBNaturezaPessoas.ItemIndex = 0 then
     JO.AddPair('flnatureza', TJSONNumber.Create(1)) //Pessoa física
  else
     JO.AddPair('flnatureza', TJSONNumber.Create(2)); //Pessoa jurídica

  JO.AddPair('dsdocumento', FrmCad_Pessoas.EdtDocumento.Text);
  JO.AddPair('nmprimeiro',  FrmCad_Pessoas.EdtNome.Text);
  JO.AddPair('nmsegundo',   FrmCad_Pessoas.EdtSobrenome.Text);
  JO.AddPair('dtregistro',  ParamData);

  //Endereço...
  JO.AddPair('dscep',     FrmCad_Pessoas.EdtCEP.Text);
  JO.AddPair('idpessoa',  FrmCad_Pessoas.IdPessoa);

  //Endereco Integracao
  JO.AddPair('dsuf',           FrmCad_Pessoas.EdtUF.Text);
  JO.AddPair('nmcidade',       FrmCad_Pessoas.EdtCidade.Text);
  JO.AddPair('nmbairro',       FrmCad_Pessoas.EdtBairro.Text);
  JO.AddPair('nmlogradouro',   FrmCad_Pessoas.EdtEnd.Text);
  JO.AddPair('dscomplemento',  FrmCad_Pessoas.EdtComplemento.Text);
  JO.AddPair('idendereco',     FrmCad_Pessoas.IdPessoa.ToString);

  JA := TJSONArray.Create;
  JA.AddElement(Jo);

  RestClientEdicoes.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClientEdicoes.AcceptCharset := 'UTF-8, *;q=0.8';
  RestClientEdicoes.BaseURL := Format('http://%s:%s/datasnap/rest/TServerMethods', ['localhost', '211']);
  RestClientEdicoes.ContentType := CONTENTTYPE_APPLICATION_JSON;

  if not FrmCad_Pessoas.EmEdicao then
  begin
    begin
      RESTRequestEdicoes.Resource := 'Total';
      RestClientEdicoes.HandleRedirects := True;
      RestClientEdicoes.RaiseExceptionOn500 := False;
      RESTRequestEdicoes.Client := RestClientEdicoes;
      RESTRequestEdicoes.Method := TRESTRequestMethod.rmPOST;
      RESTRequestEdicoes.Body.Add(JA.ToString, ContentTypeFromString('application/json'));
      RESTRequestEdicoes.Execute;
    end;
  end
  else
  begin
    RESTRequestEdicoes.Resource := 'Total';
    RestClientEdicoes.HandleRedirects := True;
    RestClientEdicoes.RaiseExceptionOn500 := False;
    RESTRequestEdicoes.Client := RestClientEdicoes;
    RESTRequestEdicoes.Method := TRESTRequestMethod.rmPUT;
    RESTRequestEdicoes.Body.Add(JA.ToString, ContentTypeFromString('application/json'));
    RESTRequestEdicoes.Execute;
  end;
end;

procedure TDmPessoa.EditarCadastro;
begin
//
end;

procedure TDmPessoa.ExcluirPessoa(ID : Integer);

begin
 try
  FrmCad_Pessoas.LimparCampos;

  DmPessoa.RESTClientEdicoes.ResetToDefaults;
  DmPessoa.RESTRequestEdicoes.ResetToDefaults;
  DmPessoa.RESTResponseEdicoes.ResetToDefaults;
  DmPessoa.RESTClientEdicoes.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  DmPessoa.RESTClientEdicoes.AcceptCharset := 'UTF-8, *;q=0.8';
  DmPessoa.RESTClientEdicoes.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '211']);
  DmPessoa.RESTClientEdicoes.ContentType := 'application/json';
  DmPessoa.RESTRequestEdicoes.Resource := 'TServerMethods/Pessoas/{idpessoa}';
  DmPessoa.RESTClientEdicoes.HandleRedirects := True;
  DmPessoa.RESTClientEdicoes.RaiseExceptionOn500 := False;
  DmPessoa.RESTRequestEdicoes.SynchronizedEvents := False;
  DmPessoa.RESTRequestEdicoes.Client   :=  DmPessoa.RESTClientEdicoes;
  DmPessoa.RESTRequestEdicoes.Response :=  DmPessoa.RESTResponseEdicoes;
  DmPessoa.RESTRequestEdicoes.Method   := rmDELETE;
  DmPessoa.RESTRequestEdicoes.Params.AddItem('idpessoa',ID.ToString,TRESTRequestParameterKind.pkURLSEGMENT, [], ctAPPLICATION_JSON);
  DmPessoa.RESTRequestEdicoes.Execute;

  FrmCad_Pessoas.TabAbas.GotoVisibleTab(0);

  FrmCad_Pessoas.Mensagem.Show(TIconDialog.Success, 'OK','Registro excluído!');
 except
  FrmCad_Pessoas.Mensagem.Show(TIconDialog.Error, 'Atenção!','Erro ao excluir!');
 end;
end;

end.
