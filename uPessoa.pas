unit uPessoa;

interface
  type
    TPessoa = class

    FId_pessoa : Integer;
    FNome      : String;
    FSobrenome : String;
    FDocumento : String;
    FNatureza  : String;

    public

    property Id_pessoa     : Integer read FId_pessoa write FId_pessoa;
    property Nome          : String  read FNome      write FNome;
    property Sobrenome     : String  read FSobrenome write FSobrenome;
    property Documento     : String  read FDocumento write FDocumento;
    property Natureza      : String  read FNatureza  write FNatureza;
  end;

implementation

end.
