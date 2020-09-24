#Imports
import sqlite3 ;

#creating connection object and cursor
con = sqlite3.connect('bin.sqlite3');
cur = con.cursor();

#function to create tables
def CreateTables():
    #time
    cur.execute("""CREATE TABLE time(
    id int AUTO INCREMENT PRIMARY KEY NOT NULL,
    term int NOT NULL,
    year int NOT NULL
    ) """);
    #teacher
    cur.execute("""CREATE TABLE teacher(
    id int AUTONUMBER PRIMARY KEY NOT NULL ,
    name text NOT NULL,
    surname text NOT NULL,
    password text NOT NULL,
    contact text NOT NULL,
    mail text NOT NULL,
    picture BLOB
    ) """);
    #student
    cur.execute("""CREATE TABLE student(
    id int AUTONUMBER PRIMARY KEY NOT NULL ,
    name text NOT NULL,
    surname text NOT NULL,
    password text NOT NULL,
    age int NOT NULL,
    dob text NOT NULL,
    sex text NOT NULL,
    picture BLOB
    ) """);
    #grade
    cur.execute("CREATE TABLE grade(id text NOT NULL PRIMARY KEY)");
    #class dependences = time, teacher,grade (3)
    cur.execute("""CREATE TABLE class(
    id int AUTO INCREMENT PRIMARY KEY NOT NULL,
    teacher int NOT NULL,
    time int NOT NULL,
    grade text NOT NULL,
    FOREIGN KEY(teacher) REFERENCES teacher(id),
    FOREIGN KEY(time) REFERENCES time(id),
    FOREIGN KEY(grade) REFERENCES grade(id)
    ) """);
    cur.execute("PRAGMA FOREIGN_KEYS = 3 ");
    #enrollment dependencies = student and class (2)
    cur.execute("""CREATE TABLE enrollment(
    id AUTONUMBER PRIMARY KEY,
    student int NOT NULL,
    class int NOT NULL,
    FOREIGN KEY(student) REFERENCES student(id)
    FOREIGN KEY(class) REFERENCES class(id)
    ) """);
    cur.execute("PRAGMA FOREIGN_KEYS = 2 ");
    #subject dependencies = class (1)
    cur.execute("""CREATE TABLE subject (
    id AUTONUMBER PRIMARY KEY,
    class int NOT NULL,
    subject text NOT NULL,
    FOREIGN KEY(class) REFERENCES class(id)
    ) """);
    cur.execute("PRAGMA FOREIGN_KEYS = 2 ");
    #test dependencies = subject(1)
    cur.execute("""CREATE TABLE test(
    id AUTONUMBER,
    subject int NOT NULL,
    marks int NOT NULL,
    FOREIGN KEY(subject) REFERENCES subject(id)
    ) """);
    cur.execute("PRAGMA FOREIGN_KEYS = 1 ");
    #assessment dependencies = test and student (2)
    cur.execute("""CREATE TABLE assessment(
    id AUTONUMBER PRIMARY KEY,
    student int NOT NULL,
    test int NOT NULL,
    subject int NOT NULL,
    mark int NOT NULL,
    FOREIGN KEY(subject) REFERENCES subject(id),
    FOREIGN KEY(student) REFERENCES student(id)
    )""");
    cur.execute("PRAGMA FOREIGN_KEYS = 2 ");
#check if tables exist
try:
    CreateTables();
    con.commit();
except sqlite3.OperationalError:
    cur.execute("PRAGMA FOREIGN_KEYS = 5");

#cur.execute("INSERT INTO class(id,teacher,time,grade) VALUES (1,'RENIAS',1,'grade 1')");
con.commit();


