object DmPrincipal: TDmPrincipal
  OnCreate = DataModuleCreate
  Height = 106
  Width = 386
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
    Top = 24
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'D:\Projetos\TestePG\Win32\Debug'
    Left = 272
    Top = 24
  end
end
