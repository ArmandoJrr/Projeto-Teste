object DataModule1: TDataModule1
  Height = 298
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
    Left = 144
    Top = 72
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'D:\Projetos\TestePG\Win32\Debug'
    Left = 144
    Top = 160
  end
end
