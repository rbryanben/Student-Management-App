unit foundUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Colors,databaseUnit,variableUnit;

type
  TfoundFrame = class(TFrame)
    backColor: TColorBox;
    nameLabel: TLabel;
    surnameLabel: TLabel;
    picture: TCircle;
    AddButton: TImage;
    idLabel: TLabel;
    procedure AddButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    studentID : integer ;
  end;

implementation


{$R *.fmx}


procedure TfoundFrame.AddButtonClick(Sender: TObject);
var
   records : integer ;
begin
   //counting enrollments
   database.enrollmentQuery.SQL.Text := 'SELECT * FROM enrollment' ;
   database.enrollmentQuery.Open;
   database.enrollmentQuery.First;
   while not database.enrollmentQuery.Eof do begin
     inc(records);
     database.enrollmentQuery.Next;
   end;


   //creating sql statement
   database.enrollmentQuery.SQL.Text := 'INSERT INTO enrollment (id,student,class) VALUES (:idV,:studentID,:classID) ' ;
   database.enrollmentQuery.ParamByName('idV').Value := records + 1 ;
   database.enrollmentQuery.ParamByName('studentID').Value := studentID ;
   database.enrollmentQuery.ParamByName('classid').Value := dataholder.classID;
   database.enrollmentQuery.ExecSQL();
   //feedback
   showmessage('updated on next login');
   inc(database.pending);
   self.Free;
end;


end.
