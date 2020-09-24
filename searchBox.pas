unit searchBox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Colors, FMX.Controls.Presentation, FMX.Edit, FMX.Objects,foundUnit,databaseUnit,
  FMX.Layouts, FMX.Ani,variableUnit;

type
  TaddPupilFrame = class(TFrame)
    searchImage: TImage;
    searchText: TEdit;
    backColor: TColorBox;
    port: TVertScrollBox;
    Layout1: TLayout;
    close: TImage;
    openAnime1: TFloatAnimation;
    procedure searchImageClick(Sender: TObject);
    procedure closeClick(Sender: TObject);
    procedure searchTextTyping(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TaddPupilFrame.closeClick(Sender: TObject);
begin
   self.Free;
end;

procedure TaddPupilFrame.searchImageClick(Sender: TObject);
var
   temp : TFoundFrame ;
   layout : TLayout ;
begin
  //searching database
  database.studentQuery.SQL.Text := 'SELECT * FROM student WHERE name= :id ' ;
  database.studentQuery.ParamByName('id').Value := SearchText.Text ;
  database.studentQuery.open;
  database.studentQuery.First;
  while not database.studentQuery.Eof do begin
    //creating layout
    layout := TLayout.Create(port);
    layout.Parent := port ;
    layout.Align := TAlignLayout(1);
    layout.Height := 23 ;
    layout.Margins.Top := 2 ;

    //creating frame
    temp := TFoundFrame.Create(layout);
    temp.Parent := layout ;
    temp.nameLabel.Text := database.studentQuery.FieldByName('name').AsString;
    temp.surnameLabel.Text := database.studentQuery.FieldByName('surname').AsString;
    database.studentQuery.Next;
  end;


end;

procedure TaddPupilFrame.searchTextTyping(Sender: TObject);
var
   temp : TFoundFrame ;
   layout : TLayout ;
   count : integer ;
   exists : boolean ;
begin
   openAnime1.Enabled := true ;
   openAnime1.Start;
  //searching database
  database.studentQuery.SQL.Text := 'SELECT * FROM student WHERE name= :id ' ;
  database.studentQuery.ParamByName('id').Value := SearchText.Text ;
  database.studentQuery.open;
  database.studentQuery.First;
  while not database.studentQuery.Eof do begin
    for count := 1 to dataholder.numberOfStudents do begin
      if (database.studentQuery.FieldByName('id').AsInteger = dataholder.classArray[count]) then begin
        exists := true ;
      end;
    end;

    //creating layout
  if exists <> true then begin
    layout := TLayout.Create(port);
    layout.Parent := port ;
    layout.Align := TAlignLayout(1);
    layout.Height := 23 ;
    layout.Margins.Top := 2 ;

    //creating frame
    temp := TFoundFrame.Create(layout);
    temp.Parent := layout ;
    temp.nameLabel.Text := database.studentQuery.FieldByName('name').AsString;
    temp.surnameLabel.Text := database.studentQuery.FieldByName('surname').AsString;
    temp.idlabel.text := 'ID '+ database.studentQuery.FieldByName('id').AsString;
    temp.studentID :=  database.studentQuery.FieldByName('id').AsInteger ;

  end;
  database.studentQuery.Next;
end;

end;
end.
