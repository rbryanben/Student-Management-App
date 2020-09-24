unit variableUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  Tdataholder = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    classID : integer ;
    classArray : array[1..60]of integer ;
    numberOfStudents : integer ;
  end;

var
  dataholder: Tdataholder;

implementation

{$R *.fmx}



end.
