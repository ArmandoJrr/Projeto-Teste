object DmPessoa: TDmPessoa
  Height = 399
  Width = 509
  object RESTRequestEdicoes: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClientEdicoes
    Params = <>
    Resource = 'Pessoas'
    Response = RESTResponseEdicoes
    SynchronizedEvents = False
    Left = 280
    Top = 160
  end
  object RESTResponseEdicoes: TRESTResponse
    ContentType = 'application/json'
    Left = 168
    Top = 136
  end
  object RESTClientEdicoes: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:211/datasnap/rest/TServerMethods'
    Params = <>
    SynchronizedEvents = False
    Left = 72
    Top = 168
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = MemTablePessoas
    FieldDefs = <>
    Response = RESTResponseEdicoes
    Left = 168
    Top = 216
  end
  object MemTablePessoas: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'result'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 168
    Top = 296
  end
end
