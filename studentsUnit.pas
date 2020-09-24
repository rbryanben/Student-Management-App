unit studentsUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Colors,CardUnit,
  IdBaseComponent, IdMailBox,searchBox;

type
  TstudentsFrame = class(TFrame)
    classDetail: TImage;
    studentsDetail: TImage;
    dateDetail: TImage;
    gradeString: TLabel;
    teacherString: TLabel;
    studentsInteger: TLabel;
    studentsString: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    pupilsLabel: TLabel;
    top: TLayout;
    cardPort: TGridLayout;
    otherLayout: TLayout;
    moreitemsLabel: TLabel;
    makeUsBeterLabel: TLabel;
    port: TVertScrollBox;
    addPupil: TButton;
    feedback: TButton;
    procedure addPupilClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TstudentsFrame.addPupilClick(Sender: TObject);
var
   layout : TLayout;
   searchbox : TAddPupilFrame ;
begin
   layout := TLayout.Create(cardPort);
   layout.Parent := Port ;
   layout.Align := TAlignLayout(0);
   layout.Position.x := otherLayout.Position.X - 500;
   layout.Position.Y := otherLayout.position.Y + 15 ;
   layout.Width  := 497 ;
   layout.Height := 120 ;


   searchbox := TAddPupilFrame.Create(layout);
   searchbox.parent := layout ;
   searchbox.Align := talignlayout(1) ;



end;


end.
