unit databaseUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DbxSqlite, Data.FMTBcd, Data.DB,
  Data.SqlExpr;

type
  Tdatabase = class(TDataModule)
    connection: TSQLConnection;
    studentQuery: TSQLQuery;
    enrollmentQuery: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    pending : integer ;
  end;

var
  database: Tdatabase;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
