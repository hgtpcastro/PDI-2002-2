object ConexaoFireDac: TConexaoFireDac
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=E:\Viasoft\Dados\Firebird\POLLI\POLLI.FDB'
      'User_Name=VIASOFT'
      'Password=153'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'CharacterSet=ISO8859_1'
      'DriverID=FB')
    LoginPrompt = False
    Left = 88
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 88
    Top = 88
  end
end
