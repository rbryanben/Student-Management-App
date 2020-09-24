unit menuUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.Colors,
  FMX.Ani, FMX.Effects, FMX.Filter.Effects,studentsUnit, FMX.Edit,
  Data.DbxSqlite, Data.FMTBcd, Data.DB, Data.SqlExpr, FMX.ScrollBox, FMX.Memo,cardunit,databaseUnit,VariableUnit;

type
  TmenuForm = class(TForm)
    ColorBox1: TColorBox;
    leftPanel: TLayout;
    backgroundImage: TImage;
    Layout: TLayout;
    buttonsPanel: TLayout;
    home: TLayout;
    homePanel: TPanel;
    icon: TImage;
    text: TLabel;
    students: TLayout;
    studentsPanel: TPanel;
    Image1: TImage;
    Label1: TLabel;
    calender: TLayout;
    calenderPanel: TPanel;
    Image2: TImage;
    Label2: TLabel;
    tests: TLayout;
    testsPanel: TPanel;
    Image3: TImage;
    Label3: TLabel;
    attendance: TLayout;
    attendancePanel: TPanel;
    Image4: TImage;
    Label4: TLabel;
    exams: TLayout;
    examsPanel: TPanel;
    Image5: TImage;
    Label5: TLabel;
    mail: TLayout;
    mailPanel: TPanel;
    Image6: TImage;
    Label6: TLabel;
    settings: TLayout;
    settingsPanel: TPanel;
    Image7: TImage;
    Label7: TLabel;
    exit: TLayout;
    exitPanel: TPanel;
    Image9: TImage;
    Label8: TLabel;
    window: TLayout;
    windowPanel: TPanel;
    Image8: TImage;
    Label9: TLabel;
    marker: TRectangle;
    profileHolder: TLayout;
    picture: TCircle;
    GradeText: TLabel;
    TeacherText: TLabel;
    StyleBook1: TStyleBook;
    rightPanel: TLayout;
    border: TLayout;
    pageInfo: TLabel;
    port: TLayout;
    browser: TWebBrowser;
    loginPort: TPanel;
    loginLabel: TLabel;
    passwordE: TEdit;
    usernameE: TEdit;
    loginButton: TButton;
    popIn: TFloatAnimation;
    popOut: TFloatAnimation;
    connection: TSQLConnection;
    classQuery: TSQLQuery;
    teacherQuery: TSQLQuery;
    enrollmentQuery: TSQLQuery;
    studentQuery: TSQLQuery;
    pendingLabel: TLabel;
    pendingCount: TLabel;
    pendingCheck: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure homePanelClick(Sender: TObject);
    procedure studentsPanelClick(Sender: TObject);
    procedure calenderPanelClick(Sender: TObject);
    procedure attendancePanelClick(Sender: TObject);
    procedure testsPanelClick(Sender: TObject);
    procedure examsPanelClick(Sender: TObject);
    procedure mailPanelClick(Sender: TObject);
    procedure settingsPanelClick(Sender: TObject);
    procedure exitPanelClick(Sender: TObject);
    procedure windowPanelClick(Sender: TObject);
    procedure browserSwitch(f : integer);
    procedure loginButtonClick(Sender: TObject);
    procedure GetAndSetData();
    procedure pendingCheckTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
    RTeacher = record
      teacherName,teacherSurname,teacherGrade : string;
      teacherID,teacherClassID,studentCount : integer ;
      studentIdArray : array[1..65] of integer ;
    end;

var
  menuForm: TmenuForm;
  home_server : string ;
  teacher : RTeacher ;


implementation

{$R *.fmx}

procedure TmenuForm.calenderPanelClick(Sender: TObject);
begin
  //marker
   marker.Position.Y := layout.Position.Y + calender.Position.Y + 10 ;
  //text
  pageInfo.Text := 'calender' ;
end;

procedure TmenuForm.FormCreate(Sender: TObject);
begin
//presets
home_server := 'localhost' ;
browser.URL := home_server ;
browser.Navigate;
//login panel
loginPort.Opacity := 0 ;
//profile holder
profileHolder.Opacity := 0 ;;
//button layout
homePanel.Opacity := 0 ;
studentsPanel.Opacity := 0 ;
calenderPanel.Opacity := 0 ;
attendancePanel.Opacity := 0 ;
testsPanel.Opacity := 0 ;
examsPanel.Opacity := 0 ;
mailPanel.Opacity := 0 ;
marker.Opacity := 0 ;
settingsPanel.Opacity := 0 ;
windowPanel.Opacity := 0;


end;

procedure TmenuForm.homePanelClick(Sender: TObject);
begin
   browserSwitch(1);
   //marker
   marker.Position.Y := layout.Position.Y + home.Position.Y + 10 ;
   //text
   pageInfo.Text := 'home' ;
end;

procedure TmenuForm.loginButtonClick(Sender: TObject);
begin
   //setting parametres
   teacherQuery.ParamByName('username').Value := usernameE.Text ;
   teacherQuery.ParamByName('password').Value := passwordE.Text ;
   teacherQuery.Open;
   teacherQuery.Refresh;
   //check if exists
   teacherQuery.First;
   if teacherQuery.IsEmpty then begin
      passwordE.Text := '' ;
      usernameE.Text := '' ;
      ShowMessage('failed: try again');
   end
   else begin
     popOut.Start;
      //profile holder
      profileHolder.Opacity := 1 ;;
      //button layout
      homePanel.Opacity := 1 ;
      studentsPanel.Opacity := 1 ;
      calenderPanel.Opacity := 1 ;
      attendancePanel.Opacity := 1 ;
      testsPanel.Opacity := 1 ;
      examsPanel.Opacity := 1 ;
      mailPanel.Opacity := 1 ;
      marker.Opacity := 1 ;
      settingsPanel.Opacity := 1 ;
      windowPanel.Opacity := 1;
      port.Enabled := true ;
      port.Visible := true ;
      pageInfo.Text := 'home' ;
      GetAndSetData();
   end;
end;

procedure TmenuForm.GetAndSetData();
var
    field : TField ;
    studentCount,blank : integer ;
begin
    //getting data  teacher query
    teacher.teacherName := teacherQuery.FieldByName('name').AsString;
    teacher.teacherSurname := teacherQuery.FieldByName('surname').AsString;
    try
        teacherQuery.SQL.Text := 'SELECT * FROM teacher where name= :name ' ;
        teacherQuery.ParamByName('name').Value := teacher.teacherName ;
        teacherQuery.Open;
        teacher.teacherID := teacherQuery.FieldByName('id').AsInteger;
    except end;
    teacherQuery.Close;
    //class query
    classQuery.ParamByName('teacherID').Value := teacher.teacherID ;
    classQUery.Open;
    classQuery.First;

    //getting data class query
    teacher.teacherGrade := classQuery.FieldByName('grade').AsString;
    if teacher.teacherGrade = ''  then begin
      teacher.teacherGrade := 'NO CLASS!' ;
    end;
    try
         teacher.teacherClassID := classQuery.FieldByName('id').AsInteger;
         dataholder.classID := teacher.teacherClassID ;
    except end;
    classQuery.Close;

    //setting data main form only
    teacherText.Text := teacher.teacherName + ' ' + teacher.teacherSurname;
    gradeText.Text := teacher.teacherGrade;

    //getting data in enrollment query
    enrollmentQuery.ParamByName('classid').Value := teacher.teacherClassID ;
    enrollmentQuery.Open;
    //count records
    while not enrollmentQuery.Eof do begin
       inc(studentCount);
       //getting student id and adding it to teacher students id array
       teacher.studentIdArray[studentCount] := enrollmentQuery.FieldByName('student').AsInteger ;
       dataholder.classArray[studentCount] := teacher.studentIdArray[studentCount] ;
       enrollmentQuery.Next;
    end;
    enrollmentQuery.Close;
    teacher.studentCount := studentCount ;
    dataholder.numberOfStudents := studentCount ;
    //setting data from enrollment query  main form only

end;

procedure TmenuForm.mailPanelClick(Sender: TObject);
begin
  //marker
   marker.Position.Y := layout.Position.Y + mail.Position.Y + 10 ;
  //text
  pageInfo.Text := 'mail' ;
end;

procedure TmenuForm.pendingCheckTimer(Sender: TObject);
begin
   if database.pending < 1 then begin
     pendingCount.Visible := false ;
     pendingLabel.Visible := false ;
   end
   else begin
     pendingCount.Visible := true ;
     pendingLabel.Visible := true ;
     pendingCount.Text := inttostr(database.pending);
   end;
end;

procedure TmenuForm.settingsPanelClick(Sender: TObject);
begin
  //marker
   marker.Position.Y := layout.Position.Y + settings.Position.Y + 10 ;
  //text
  pageInfo.Text := 'settings' ;
end;

procedure TmenuForm.testsPanelClick(Sender: TObject);
begin
  //marker
   marker.Position.Y := layout.Position.Y + tests.Position.Y + 10 ;
  //text
  pageInfo.Text := 'tests' ;
end;


procedure TmenuForm.windowPanelClick(Sender: TObject);
begin
if menuForm.WindowState = TWindowState(0) then begin
    menuForm.WindowState := TWindowState(2) ;
end
else begin
   menuForm.WindowState := TWindowState(0);
end;
end;

procedure TmenuForm.examsPanelClick(Sender: TObject);
begin
  //marker
   marker.Position.Y := layout.Position.Y + exams.Position.Y + 10 ;
  //text
  pageInfo.Text := 'exams' ;
end;

procedure TmenuForm.exitPanelClick(Sender: TObject);
begin
    showMessage('goodbye');
    close;
end;


procedure TmenuForm.attendancePanelClick(Sender: TObject);
begin
  //marker
   marker.Position.Y := layout.Position.Y + attendance.Position.Y + 10 ;
  //text
  pageInfo.Text := 'attendence' ;
end;

procedure TmenuForm.studentsPanelClick(Sender: TObject);
var
  studentsF : TStudentsFrame ;
  i : integer ;
  temp : TLayout ;
  tempCard : TCardFrame ;
begin
  //marker
   marker.Position.Y := layout.Position.Y + students.Position.Y + 10 ;
  //text
  pageInfo.Text := 'students' ;
  //disable browser
  browserSwitch(0);
  try
    studentsF.Free;
  except
  end;
  try
      studentsF := TStudentsFrame.Create(port);
      studentsF.Parent := port ;
      studentsF.gradeString.Text := teacher.teacherGrade ;
      studentsF.teacherString.Text := teacher.teacherName + ' ' + teacher.teacherSurname ;
      studentsF.studentsInteger.Text := inttostr(teacher.studentCount);
      //getting students
      if teacher.studentCount <> 0 then begin
          for i := 1 to teacher.studentCount do begin
             studentsF.cardPort.Height := studentsF.cardPort.Height + 150 ;
             //query student opening
             studentQuery.ParamByName('id').Value := teacher.studentIdArray[i] ;
             studentQuery.Open;
             studentQuery.Refresh;

             //creating card layout
             temp := TLayout.Create(studentsF.cardPort);
             temp.Parent := studentsF.cardPort ;
             temp.Align := TAlignLayout(9);

             //card
             tempCard := TCardFrame.Create(temp);
             tempCard.Parent := temp ;
             tempCard.Align := TAlignLayout(2) ;
             tempCard.studentID := studentQuery.FieldByName('id').AsInteger;
             //setting data from student id
             tempCard.SetData(studentQuery.FieldByName('name').AsString,studentQuery.FieldByName('surname').AsString,studentQuery.FieldByName('sex').AsString,studentQuery.FieldByName('age').AsString,0,0,0,0,0);

             temp.Name := 'card'+inttostr(i) ;
          end;
          studentQuery.Close;
      end;

  except 

  end;
  

end;

procedure TmenuForm.browserSwitch(f: Integer);
begin
  if f = 0 then begin
     browser.Visible := false ;
     browser.Enabled := false ;
  end
  else begin
     browser.Visible := true ;
     browser.Enabled := true ;
  end;
end;

end.
