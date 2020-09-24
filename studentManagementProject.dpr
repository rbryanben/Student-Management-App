program studentManagementProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  menuUnit in 'menuUnit.pas' {menuForm},
  studentsUnit in 'studentsUnit.pas' {studentsFrame: TFrame},
  cardUnit in 'cardUnit.pas' {cardFrame: TFrame},
  searchBox in 'searchBox.pas' {addPupilFrame: TFrame},
  foundUnit in 'foundUnit.pas' {foundFrame: TFrame},
  databaseUnit in 'databaseUnit.pas' {database: TDataModule},
  variableUnit in 'variableUnit.pas' {dataholder};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmenuForm, menuForm);
  Application.CreateForm(Tdatabase, database);
  Application.CreateForm(Tdataholder, dataholder);
  Application.Run;
end.
