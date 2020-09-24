object database: Tdatabase
  OldCreateOrder = False
  Height = 428
  Width = 617
  object connection: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'Sqlite'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver260.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver260.bpl'
      'FailIfMissing=True'
      
        'Database=C:\Users\rben\Desktop\student management app\database\b' +
        'in.sqlite3')
    Left = 16
    Top = 144
  end
  object studentQuery: TSQLQuery
    MaxBlobSize = 1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM student')
    SQLConnection = connection
    Left = 96
    Top = 144
  end
  object enrollmentQuery: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM enrollment')
    SQLConnection = connection
    Left = 96
    Top = 192
  end
end
