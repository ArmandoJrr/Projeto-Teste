unit uCadatro_Pessoas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.ListBox, FMX.Edit, FMX.Effects, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, REST.Types,
  REST.Response.Adapter, REST.Client, Data.Bind.ObjectScope,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uFancyDialog,FireDAC.Phys.PG,
  FireDAC.Phys.PGDef;

type
  TFrmCad_Pessoas = class(TForm)
    TabAbas: TTabControl;
    TabPesquisar: TTabItem;
    TabCad: TTabItem;
    LayBottom: TLayout;
    RectCancelar: TRectangle;
    ShadowEffect14: TShadowEffect;
    Label16: TLabel;
    RectSalvar: TRectangle;
    ShadowEffect16: TShadowEffect;
    Label18: TLabel;
    RectExcluir: TRectangle;
    ShadowEffect7: TShadowEffect;
    lblExcluir: TLabel;
    LayCEP: TLayout;
    RectCEP: TRectangle;
    ShadowEffect3: TShadowEffect;
    EdtCEP: TEdit;
    LayDocumento: TLayout;
    RectDocumento: TRectangle;
    ShadowEffect6: TShadowEffect;
    EdtDocumento: TEdit;
    LayEndereco: TLayout;
    RectEnd: TRectangle;
    ShadowEffect4: TShadowEffect;
    EdtEnd: TEdit;
    LayNatureza: TLayout;
    RectNatureza: TRectangle;
    ShadowEffect5: TShadowEffect;
    CBNaturezaPessoas: TComboBox;
    LayNome: TLayout;
    RectNome: TRectangle;
    ShadowEffect2: TShadowEffect;
    EdtNome: TEdit;
    LaySobrenome: TLayout;
    RectSobrenome: TRectangle;
    ShadowEffect1: TShadowEffect;
    EdtSobrenome: TEdit;
    LayTop: TLayout;
    LabTitulo: TLabel;
    LayTopo: TLayout;
    Rect: TRectangle;
    ShadowEffect8: TShadowEffect;
    EditConsulta: TEdit;
    RectPesquisar: TRectangle;
    Label1: TLabel;
    ListViewPessoas: TListView;
    Layout1: TLayout;
    Label2: TLabel;
    Image1: TImage;
    LayCidade: TLayout;
    RectCidade: TRectangle;
    ShadowEffect9: TShadowEffect;
    EdtCidade: TEdit;
    VertScrollBox1: TVertScrollBox;
    Rectangle1: TRectangle;
    ShadowEffect10: TShadowEffect;
    EdtUF: TEdit;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    ShadowEffect11: TShadowEffect;
    EdtBairro: TEdit;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    ShadowEffect12: TShadowEffect;
    EdtComplemento: TEdit;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    MemTable: TFDMemTable;
    procedure RectCancelarClick(Sender: TObject);
    procedure RectSalvarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectPesquisarClick(Sender: TObject);
    procedure EdtDocumentoTyping(Sender: TObject);
    procedure EdtCEPTyping(Sender: TObject);
    procedure EdtCEPExit(Sender: TObject);
    procedure ListViewPessoasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure RectExcluirClick(Sender: TObject);
  private
    EmEdicao  : Boolean;
    Mensagem: TFancyDialog;
    procedure ConsultarCEP(cep: string);
    procedure LimparCampos;
    procedure GravarPessoa;
    procedure ThreadPessoasTerminate(Sender: TObject);
    procedure GravarEndereco;
    procedure GravarEnderecoIntegracao;
    procedure ExcluirPessoa(ID: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCad_Pessoas: TFrmCad_Pessoas;

implementation

{$R *.fmx}

uses uDmPrincipal, uFormat;

procedure TFrmCad_Pessoas.EdtCEPExit(Sender: TObject);
begin
  if EdtCEP.Text <> '' then
    ConsultarCep(EdtCEP.Text);
end;

procedure TFrmCad_Pessoas.EdtCEPTyping(Sender: TObject);
begin
   Formatar(edtCEP, TFormato.CEP);
end;

procedure TFrmCad_Pessoas.EdtDocumentoTyping(Sender: TObject);
begin
  Formatar(EdtDocumento, TFormato.CNPJorCPF);
end;

procedure TFrmCad_Pessoas.FormCreate(Sender: TObject);
begin
  Mensagem := TFancyDialog.Create(FrmCad_Pessoas);
  TabAbas.GotoVisibleTab(0);
end;

procedure TFrmCad_Pessoas.ConsultarCEP(cep: string);
begin

   if SomenteNumero(edtCEP.Text).Length <> 8 then
    begin
        Mensagem.Show(TIconDialog.Error, 'Aten��o!','CEP inv�lido');
        Exit;
    end;

    try
      RESTRequest.Resource := SomenteNumero(edtCEP.Text) + '/json';
      RESTRequest.Execute;

      if RESTRequest.Response.StatusCode = 200 then
      begin
          if RESTRequest.Response.Content.IndexOf('erro') > 0 then
              Mensagem.Show(TIconDialog.Error, 'Aten��o!','CEP n�o encontrado!')
          else
          begin
              with MemTable do
              begin
                EdtCidade.Text      := FieldByName('localidade').AsString;
                EdtUF.Text          := FieldByName('uf').AsString;
                EdtEnd.Text         := FieldByName('logradouro').AsString;
                EdtBairro.Text      := FieldByName('bairro').AsString;
                EdtComplemento.Text := FieldByName('complemento').AsString;
              end;
          end;
      end
      else
          Mensagem.Show(TIconDialog.Error, 'Aten��o!','Erro ao consultar CEP!');
    except
        Mensagem.Show(TIconDialog.Error, 'Aten��o!','Erro ao consultar CEP!');
    end;
end;

procedure TFrmCad_Pessoas.Image1Click(Sender: TObject);
var
t : TThread;
begin
  T := TThread.CreateAnonymousThread(procedure
  begin
     DmPrincipal.NovaPessoa;

     T.Synchronize(TThread.Current, procedure
     begin
       LimparCampos;
       TabAbas.GotoVisibleTab(1);
     end);

  end);

  T.Start;
end;

procedure TFrmCad_Pessoas.LimparCampos;
begin
  EdtNome.Text        := EmptyStr;
  EdtSobrenome.Text   := EmptyStr;
  EdtCEP.Text         := EmptyStr;
  EdtEnd.Text         := EmptyStr;
  EdtDocumento.Text   := EmptyStr;
  EdtCidade.Text      := EmptyStr;
  EdtUF.Text          := EmptyStr;
  EdtBairro.Text      := EmptyStr;
  EdtComplemento.Text := EmptyStr;
end;

procedure TFrmCad_Pessoas.ListViewPessoasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
   DmPrincipal.QryDetalhe.Close;
   DmPrincipal.QryDetalhe.ParamByName('codigo').asInteger := AItem.TagString.ToInteger;;
   DmPrincipal.QryDetalhe.Open;

   if  DmPrincipal.QryDetalhe.IsEmpty then
   Exit;

   EmEdicao := True;

   EdtNome.Text        := DmPrincipal.QryDetalhenmprimeiro.AsString;
   EdtSobrenome.Text   := DmPrincipal.QryDetalhenmsegundo.AsString;
   EdtCEP.Text         := DmPrincipal.QryDetalhedscep.AsString;
   EdtEnd.Text         := DmPrincipal.QryDetalhenmlogradouro.AsString;
   EdtDocumento.Text   := DmPrincipal.QryDetalhedsdocumento.AsString;
   EdtCidade.Text      := DmPrincipal.QryDetalhenmcidade.AsString;
   EdtUF.Text          := DmPrincipal.QryDetalhedsuf.AsString;
   EdtBairro.Text      := DmPrincipal.QryDetalhenmbairro.AsString;
   EdtComplemento.Text := DmPrincipal.QryDetalhedscomplemento.AsString;

   TabAbas.GotoVisibleTab(1);
end;

procedure TFrmCad_Pessoas.RectCancelarClick(Sender: TObject);
begin
  LimparCampos;
  TabAbas.GotoVisibleTab(0);
end;

procedure TFrmCad_Pessoas.ExcluirPessoa(ID : Integer);
begin
  try
   DmPrincipal.QryExcluirPessoa.Close;
   DmPrincipal.QryExcluirPessoa.ParamByName('pessoa').AsInteger := ID;
   DmPrincipal.QryExcluirPessoa.ExecSql;

   LimparCampos;

   TabAbas.GotoVisibleTab(0);

   Mensagem.Show(TIconDialog.Success, 'OK','Registro exclu�do!');
  except
    Mensagem.Show(TIconDialog.Error, 'Aten��o!','Erro ao excluir!');
  end;
end;

procedure TFrmCad_Pessoas.RectExcluirClick(Sender: TObject);
begin
  ExcluirPessoa(DmPrincipal.QryDetalheIdPessoa.AsInteger);

  RectPesquisarClick(Sender);
end;

procedure TFrmCad_Pessoas.ThreadPessoasTerminate(Sender: TObject);
begin
    if Sender is TThread then
    begin
        if Assigned(TThread(Sender).FatalException) then
        begin
            showmessage(Exception(TThread(sender).FatalException).Message);
            exit;
        end;
    end;

    with DmPrincipal.QryPessoas do
    begin
        ListViewPessoas.items.Clear;
        ListViewPessoas.BeginUpdate;

        First;

        while NOT Eof do
        begin
          DmPrincipal.AddPessoas(DmPrincipal.QryPessoasnmprimeiro.AsString,
                                 DmPrincipal.QryPessoasidpessoa.AsInteger);

          Next;
        end;

        ListViewPessoas.EndUpdate;
    end;
end;

procedure TFrmCad_Pessoas.RectPesquisarClick(Sender: TObject);
var
    t : TThread;
begin
    t := TThread.CreateAnonymousThread(procedure
    begin
       DmPrincipal.CarregarPessoas(EditConsulta.Text);
    end);

    t.OnTerminate := ThreadPessoasTerminate;
    t.Start;
end;

procedure TFrmCad_Pessoas.GravarEndereco;
begin
   try
       if emEdicao then
       begin
         DmPrincipal.QryEndereco.Close;
         DmPrincipal.QryEndereco.SQL.Clear;
         DmPrincipal.QryEndereco.SQL.Add('select * from endereco where idendereco = :id');
         DmPrincipal.QryEndereco.ParamByName('id').AsInteger  := DmPrincipal.QryDetalheidpessoa.AsInteger;
         DmPrincipal.QryEndereco.Open;

         with  DmPrincipal.QryEndereco do
         begin
           Edit;
           DmPrincipal.QryEnderecodscep.AsString           := EdtCEP.Text;
           Post;
         end;
       end
       else
       begin
         DmPrincipal.QrySequencia.Close;
         DmPrincipal.QrySequencia.Open;

         with  DmPrincipal.QryEndereco do
         begin
           Edit;
           DmPrincipal.QryEnderecoidendereco.AsInteger     :=  DmPrincipal.QrySequenciaMax.AsInteger;
           DmPrincipal.QryEnderecoidpessoa.AsInteger       :=  DmPrincipal.QrySequenciaMax.AsInteger;
           DmPrincipal.QryEnderecodscep.AsString           := EdtCEP.Text;
           Post;
         end;
       end;
   except
      Mensagem.Show(TIconDialog.Error, 'Aten��o!','Erro ao gravar endere�o!');
   end;
end;

procedure TFrmCad_Pessoas.GravarEnderecoIntegracao;
begin
   try
     if EmEdicao then
     begin
         DmPrincipal.QryEndereco_Integracao.Close;
         DmPrincipal.QryEndereco_Integracao.SQL.Clear;
         DmPrincipal.QryEndereco_Integracao.SQL.Add('select * from endereco_integracao where idendereco = :id');
         DmPrincipal.QryEndereco_Integracao.ParamByName('id').AsInteger  := DmPrincipal.QryDetalheidpessoa.AsInteger;
         DmPrincipal.QryEndereco_Integracao.Open;

         with  DmPrincipal.QryEndereco_Integracao do
         begin
           Edit;
           DmPrincipal.QryEndereco_Integracao.FieldByName('dsuf').AsString            := EdtUF.Text;
           DmPrincipal.QryEndereco_Integracao.FieldByName('nmcidade').AsString        := EdtCidade.Text;
           DmPrincipal.QryEndereco_Integracao.FieldByName('nmbairro').AsString        := EdtBairro.Text;
           DmPrincipal.QryEndereco_Integracao.FieldByName('nmlogradouro').AsString    := EdtEnd.Text;
           DmPrincipal.QryEndereco_Integracao.FieldByName('dscomplemento').AsString   := EdtComplemento.Text;
           Post;
         end;
     end
     else
     begin
       with  DmPrincipal.QryEndereco_Integracao do
       begin
         Edit;
         DmPrincipal.QryEndereco_Integracao.FieldByName('idendereco').AsInteger     := DmPrincipal.QrySequenciamax.AsInteger;
         DmPrincipal.QryEndereco_Integracao.FieldByName('dsuf').AsString            := EdtUF.Text;
         DmPrincipal.QryEndereco_Integracao.FieldByName('nmcidade').AsString        := EdtCidade.Text;
         DmPrincipal.QryEndereco_Integracao.FieldByName('nmbairro').AsString        := EdtBairro.Text;
         DmPrincipal.QryEndereco_Integracao.FieldByName('nmlogradouro').AsString    := EdtEnd.Text;
         DmPrincipal.QryEndereco_Integracao.FieldByName('dscomplemento').AsString   := EdtComplemento.Text;
         Post;
       end;
     end;
   except
      Mensagem.Show(TIconDialog.Error, 'Aten��o!','Erro ao gravar endere�o integra��o!');
   end;
end;

procedure TFrmCad_Pessoas.GravarPessoa;
begin
   try
     if EmEdicao then
     begin
       DmPrincipal.QryPessoas.Close;
       DmPrincipal.QryPessoas.SQL.Clear;
       DmPrincipal.QryPessoas.SQL.Add('select * from pessoa where idpessoa = :id');
       DmPrincipal.QryPessoas.ParamByName('id').AsInteger  := DmPrincipal.QryDetalheidpessoa.AsInteger;
       DmPrincipal.QryPessoas.Open;
     end;

     DmPrincipal.QryPessoas.Edit;

     if CBNaturezaPessoas.ItemIndex = 0 then
        DmPrincipal.QryPessoas.FieldByName('flnatureza').AsInteger := 1 //Pessoa f�sica
     else
        DmPrincipal.QryPessoas.FieldByName('flnatureza').AsInteger := 2; //Pessoa jur�dica

     DmPrincipal.QryPessoas.FieldByName('dsdocumento').AsString    := EdtDocumento.Text;
     DmPrincipal.QryPessoas.FieldByName('nmprimeiro').AsString     := EdtNome.Text;
     DmPrincipal.QryPessoas.FieldByName('nmsegundo').AsString      := EdtSobrenome.Text;
     DmPrincipal.QryPessoas.FieldByName('dtregistro').AsDateTime   := Now;
     DmPrincipal.QryPessoas.Post;
   except
       Mensagem.Show(TIconDialog.Error, 'Aten��o!','Erro ao gravar!!');
   end;
end;

procedure TFrmCad_Pessoas.RectSalvarClick(Sender: TObject);
begin
  if ((EdtCEP.Text = '') or (EdtEnd.Text = '')) then
  begin
    Mensagem.Show(TIconDialog.Error, 'Aten��o!','CEP ou Endere�o est� v�zio!');
    Abort;
  end
  else
  begin
    GravarPessoa;

    GravarEndereco;

    GravarEnderecoIntegracao;

    TabAbas.GotoVisibleTab(0);

    Mensagem.Show(TIconDialog.Success, 'Ok','Dados salvos!');

    RectPesquisarClick(Sender);
  end;
end;

end.