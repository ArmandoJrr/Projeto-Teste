object ServerMethods: TServerMethods
  Height = 288
  Width = 677
  object Conn: TFDConnection
    Params.Strings = (
      'Database=bancopg'
      'User_Name=postgres'
      'Password=102030'
      'Server=127.0.0.1'
      'Port=2020'
      'DriverID=PG')
    LoginPrompt = False
    Left = 88
    Top = 32
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'D:\Projetos\TestePG\Win32\Debug'
    Left = 560
    Top = 32
  end
  object QryPessoas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select * from pessoa where 1 = 2')
    Left = 56
    Top = 216
    object QryPessoasidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryPessoasflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object QryPessoasdsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object QryPessoasnmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object QryPessoasnmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object QryPessoasdtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object QryEndereco: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select * from endereco where 1 = 2')
    Left = 296
    Top = 216
    object QryEnderecoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryEnderecoidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
    end
    object QryEnderecodscep: TWideStringField
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
  end
  object QryEndereco_Integracao: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select * from endereco_integracao where 1 = 2')
    Left = 176
    Top = 216
    object QryEndereco_Integracaoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryEndereco_Integracaodsuf: TWideStringField
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object QryEndereco_Integracaonmcidade: TWideStringField
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object QryEndereco_Integracaonmbairro: TWideStringField
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object QryEndereco_Integracaonmlogradouro: TWideStringField
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object QryEndereco_Integracaodscomplemento: TWideStringField
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
  object QrySequencia: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select max(idpessoa) from pessoa')
    Left = 400
    Top = 216
    object QrySequenciamax: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'max'
      Origin = 'max'
      ReadOnly = True
    end
  end
  object QryDetalhe: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select * , endereco.* , endereco_integracao.* from pessoa '
      'inner join endereco on (endereco.idpessoa = pessoa.idpessoa)'
      
        'inner join endereco_integracao on (endereco_integracao.idenderec' +
        'o = endereco.idendereco) where pessoa.idpessoa = :codigo')
    Left = 504
    Top = 216
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QryDetalheidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryDetalheflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object QryDetalhedsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object QryDetalhenmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object QryDetalhenmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object QryDetalhedtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
    object QryDetalheidendereco: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco'
      Origin = 'idendereco'
    end
    object QryDetalheidpessoa_1: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idpessoa_1'
      Origin = 'idpessoa'
    end
    object QryDetalhedscep: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
    object QryDetalheidendereco_1: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco_1'
      Origin = 'idendereco'
    end
    object QryDetalhedsuf: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object QryDetalhenmcidade: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object QryDetalhenmbairro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object QryDetalhenmlogradouro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object QryDetalhedscomplemento: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
    object QryDetalheidendereco_2: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco_2'
      Origin = 'idendereco'
    end
    object QryDetalheidpessoa_2: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idpessoa_2'
      Origin = 'idpessoa'
    end
    object QryDetalhedscep_1: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscep_1'
      Origin = 'dscep'
      Size = 15
    end
    object QryDetalheidendereco_3: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco_3'
      Origin = 'idendereco'
    end
    object QryDetalhedsuf_1: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dsuf_1'
      Origin = 'dsuf'
      Size = 50
    end
    object QryDetalhenmcidade_1: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmcidade_1'
      Origin = 'nmcidade'
      Size = 100
    end
    object QryDetalhenmbairro_1: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmbairro_1'
      Origin = 'nmbairro'
      Size = 50
    end
    object QryDetalhenmlogradouro_1: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmlogradouro_1'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object QryDetalhedscomplemento_1: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscomplemento_1'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
  object QryAuxiliar: TFDQuery
    Connection = Conn
    Left = 592
    Top = 216
  end
end
