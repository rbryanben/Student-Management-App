unit cardUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Colors, FMX.Controls.Presentation, FMX.Ani,databaseUnit;

type
  TcardFrame = class(TFrame)
    bodyPanel: TPanel;
    Rectangle1: TRectangle;
    topColor: TColorBox;
    picture: TCircle;
    nameLabel: TLabel;
    surnameLabel: TLabel;
    Line1: TLine;
    attendanceLabel: TLabel;
    attendanceB: TRectangle;
    rightbarAttendanceB: TRectangle;
    attendance: TRectangle;
    mathsLabel: TLabel;
    englishLabel: TLabel;
    scienceLabel: TLabel;
    computersLabel: TLabel;
    englishB: TRectangle;
    rightbarEnglishB: TRectangle;
    english: TRectangle;
    scienceB: TRectangle;
    rightbarScienceB: TRectangle;
    science: TRectangle;
    computersB: TRectangle;
    rightbarComputersB: TRectangle;
    computers: TRectangle;
    mathsB: TRectangle;
    rightbarMathsB: TRectangle;
    maths: TRectangle;
    continuousassessmentLabel: TLabel;
    name: TLabel;
    surname: TLabel;
    ageLabel: TLabel;
    genderLabel: TLabel;
    age: TLabel;
    gender: TLabel;
    attendanceAnime: TFloatAnimation;
    computersAnime: TFloatAnimation;
    mathsAnime: TFloatAnimation;
    englishAnime: TFloatAnimation;
    scienceAnime: TFloatAnimation;
    deleteCard1: TImage;
    procedure SetData(names,surnames,genders,ages : string ; attendancei,mathsi,englishi,sciencei,computersi : integer);
    procedure deleteCard1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    studentID : integer ;
  end;

implementation

{$R *.fmx}

procedure TcardFrame.deleteCard1Click(Sender: TObject);
var
   result : integer ;
begin
   //query
   database.enrollmentQuery.SQL.Text := 'DELETE FROM enrollment WHERE student= :studentID' ;
   database.enrollmentQuery.ParamByName('studentID').Value := studentID ;
   database.enrollmentQuery.ExecSQL();
   self.Free;
   inc(database.pending);
   showmessage('updated on next login');
end;

procedure TCardFrame.SetData(names: string; surnames: string; genders: string; ages: string; attendancei: Integer; mathsi: Integer; englishi: Integer; sciencei : integer ; computersi: Integer);
begin
  name.Text := names ;
  surname.Text := surnames ;
  gender.Text := genders ;
  age.Text := ages ;

  attendanceAnime.StopValue := attendancei ;
  attendanceAnime.Start;

  mathsAnime.StopValue := mathsi ;
  mathsAnime.Start;

  englishAnime.StopValue := englishi ;
  englishAnime.Start;

  scienceAnime.StopValue := sciencei ;
  scienceAnime.Start;

  computersAnime.StopValue := computersi ;
  computersAnime.Start;

end;

end.
