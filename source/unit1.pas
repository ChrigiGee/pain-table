unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, db, XMLConf, eventlog, FileUtil,
  DBDateTimePicker, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DbCtrls, Buttons, DBExtCtrls, ExtCtrls, XMLPropStorage;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DBDateEdit3: TDBDateEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox10: TDBLookupComboBox;
    DBLookupComboBox11: TDBLookupComboBox;
    DBLookupComboBox12: TDBLookupComboBox;
    DBLookupComboBox13: TDBLookupComboBox;
    DBLookupComboBox14: TDBLookupComboBox;
    DBLookupComboBox15: TDBLookupComboBox;
    DBLookupComboBox16: TDBLookupComboBox;
    DBLookupComboBox17: TDBLookupComboBox;
    DBLookupComboBox18: TDBLookupComboBox;
    DBLookupComboBox19: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox20: TDBLookupComboBox;
    DBLookupComboBox21: TDBLookupComboBox;
    DBLookupComboBox22: TDBLookupComboBox;
    DBLookupComboBox23: TDBLookupComboBox;
    DBLookupComboBox24: TDBLookupComboBox;
    DBLookupComboBox25: TDBLookupComboBox;
    DBLookupComboBox26: TDBLookupComboBox;
    DBLookupComboBox27: TDBLookupComboBox;
    DBLookupComboBox28: TDBLookupComboBox;
    DBLookupComboBox29: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox30: TDBLookupComboBox;
    DBLookupComboBox31: TDBLookupComboBox;
    DBLookupComboBox32: TDBLookupComboBox;
    DBLookupComboBox33: TDBLookupComboBox;
    DBLookupComboBox34: TDBLookupComboBox;
    DBLookupComboBox35: TDBLookupComboBox;
    DBLookupComboBox36: TDBLookupComboBox;
    DBLookupComboBox37: TDBLookupComboBox;
    DBLookupComboBox38: TDBLookupComboBox;
    DBLookupComboBox39: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox40: TDBLookupComboBox;
    DBLookupComboBox41: TDBLookupComboBox;
    DBLookupComboBox42: TDBLookupComboBox;
    DBLookupComboBox43: TDBLookupComboBox;
    DBLookupComboBox44: TDBLookupComboBox;
    DBLookupComboBox45: TDBLookupComboBox;
    DBLookupComboBox46: TDBLookupComboBox;
    DBLookupComboBox47: TDBLookupComboBox;
    DBLookupComboBox48: TDBLookupComboBox;
    DBLookupComboBox49: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox50: TDBLookupComboBox;
    DBLookupComboBox51: TDBLookupComboBox;
    DBLookupComboBox52: TDBLookupComboBox;
    DBLookupComboBox53: TDBLookupComboBox;
    DBLookupComboBox54: TDBLookupComboBox;
    DBLookupComboBox55: TDBLookupComboBox;
    DBLookupComboBox56: TDBLookupComboBox;
    DBLookupComboBox57: TDBLookupComboBox;
    DBLookupComboBox58: TDBLookupComboBox;
    DBLookupComboBox59: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox60: TDBLookupComboBox;
    DBLookupComboBox61: TDBLookupComboBox;
    DBLookupComboBox62: TDBLookupComboBox;
    DBLookupComboBox63: TDBLookupComboBox;
    DBLookupComboBox64: TDBLookupComboBox;
    DBLookupComboBox65: TDBLookupComboBox;
    DBLookupComboBox66: TDBLookupComboBox;
    DBLookupComboBox67: TDBLookupComboBox;
    DBLookupComboBox68: TDBLookupComboBox;
    DBLookupComboBox69: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBLookupComboBox70: TDBLookupComboBox;
    DBLookupComboBox71: TDBLookupComboBox;
    DBLookupComboBox72: TDBLookupComboBox;
    DBLookupComboBox73: TDBLookupComboBox;
    DBLookupComboBox74: TDBLookupComboBox;
    DBLookupComboBox75: TDBLookupComboBox;
    DBLookupComboBox76: TDBLookupComboBox;
    DBLookupComboBox77: TDBLookupComboBox;
    DBLookupComboBox78: TDBLookupComboBox;
    DBLookupComboBox79: TDBLookupComboBox;
    DBLookupComboBox8: TDBLookupComboBox;
    DBLookupComboBox80: TDBLookupComboBox;
    DBLookupComboBox81: TDBLookupComboBox;
    DBLookupComboBox82: TDBLookupComboBox;
    DBLookupComboBox83: TDBLookupComboBox;
    DBLookupComboBox84: TDBLookupComboBox;
    DBLookupComboBox85: TDBLookupComboBox;
    DBLookupComboBox86: TDBLookupComboBox;
    DBLookupComboBox87: TDBLookupComboBox;
    DBLookupComboBox88: TDBLookupComboBox;
    DBLookupComboBox89: TDBLookupComboBox;
    DBLookupComboBox9: TDBLookupComboBox;
    DBLookupComboBox90: TDBLookupComboBox;
    DBLookupComboBox91: TDBLookupComboBox;
    DBLookupComboBox92: TDBLookupComboBox;
    DBLookupComboBox93: TDBLookupComboBox;
    DBLookupComboBox94: TDBLookupComboBox;
    DBLookupComboBox95: TDBLookupComboBox;
    DBLookupComboBox96: TDBLookupComboBox;
    DBLookupComboBox97: TDBLookupComboBox;
    DBLookupComboBox98: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    DBRadioGroup1: TDBRadioGroup;
    EventLog1: TEventLog;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label8: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label9: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StatusBar1: TStatusBar;
    TrayIcon1: TTrayIcon;
    XMLConfig1: TXMLConfig;
     procedure DBComboBox1Change(Sender: TObject);
     procedure EventLog1GetCustomCategory(Sender: TObject; var Code: Word);
     procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
     procedure FormCreate(Sender: TObject);
     procedure FormHide(Sender: TObject);
     procedure FormResize(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SQLite3Connection1AfterConnect(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure StoreFormState(Sender: TObject);
        procedure RestoreFormState(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
uses unit2,Unit3;
{ TForm1 }


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
StoreFormState(self);
Form2.Show;
  Form1.Hide;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
 StoreFormState(self);
Form3.Show;
Form1.Hide;
end;

procedure TForm1.SQLite3Connection1AfterConnect(Sender: TObject);
begin

end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin

end;


procedure TForm1.FormCreate(Sender: TObject);
var
  DirStr: string;
begin

EventLog1.FileName:='./log/CrashReport.txt';
  EventLog1.Active:=True;


{Testen ob Directory existiert wenn nicht erstelle Directory}
  if not DirectoryExists('./sql') then
   DirStr:= 'sql';
  CreateDir(DirStr);

  if not DirectoryExists('./img') then
   DirStr:= 'img';
  CreateDir(DirStr);

  if not DirectoryExists('./ini') then
   DirStr:= 'ini';
   CreateDir(DirStr);

  if not DirectoryExists('./log') then
   DirStr:= 'log';
  CreateDir(DirStr);


{schliesst Verbindung zu SQLite Datenbanken }
  SQLite3Connection1.Close;

    {Öffnet Datenbank Datei migränetagebuch}
    SQLite3Connection1.DatabaseName:='./sql/migraenetagebuch.sql3db';
  SQLTransaction1.Database:=SQLite3Connection1;
  SQLQuery1.Transaction:=SQLTransaction1;
  SQLite3Connection1.Open;

  {erstellt die Tabellle DateTime}

  SQLQuery1.SQL.text := 'CREATE TABLE IF NOT EXISTS tblDateTime (ID INTEGER PRIMARY KEY,Jahr Date, Monat Date, aktDatum Date, "Printed" VARCHAR(15), "00.00" VARCHAR(10), "00.15" VARCHAR(25),"00.30" VARCHAR(25),"00.45" VARCHAR(25),"01.00" VARCHAR(25),"01.15" VARCHAR(25),"01.30" VARCHAR(25),"01.45" VARCHAR(25),"02.00" VARCHAR(25),"02.15" VARCHAR(25),"02.30" VARCHAR(25),"02.45" VARCHAR(25),"03.00" VARCHAR(25),"03.15" VARCHAR(25),"03.30" VARCHAR(25),"03.45" VARCHAR(25),"04.00" VARCHAR(25),"04.15" VARCHAR(25),"04.30" VARCHAR(25),"04.45" VARCHAR(25),"05.00" VARCHAR(25),"05.15" VARCHAR(25),"05.30" VARCHAR(25),"05.45" VARCHAR(25),"06.00" VARCHAR(25),"06.15" VARCHAR(25),"06.30" VARCHAR(25),"06.45" VARCHAR(25),"07.00" VARCHAR(25),"07.15" VARCHAR(25),"07.30" VARCHAR(25),"07.45" VARCHAR(25),"08.00" VARCHAR(25),"08.15" VARCHAR(25),"08.30" VARCHAR(25),"08.45" VARCHAR(25),"09.00" VARCHAR(25),"09.15" VARCHAR(25),"09.30" VARCHAR(25),"09.45" VARCHAR(25),"10.00" VARCHAR(25),"10.15" VARCHAR(25),"10.30" VARCHAR(25),"10.45" VARCHAR(25),"11.00" VARCHAR(25),"11.15" VARCHAR(25),"11.30" VARCHAR(25),"11.45" VARCHAR(25),"12.00" VARCHAR(25),"12.15" VARCHAR(25),"12.30" VARCHAR(25),"12.45" VARCHAR(25),"13.00" VARCHAR(25),"13.15" VARCHAR(25),"13.30" VARCHAR(25),"13.45" VARCHAR(25),"14.00" VARCHAR(25),"14.15" VARCHAR(25),"14.30" VARCHAR(25),"14.45" VARCHAR(25),"15.00" VARCHAR(25),"15.15" VARCHAR(25),"15.30" VARCHAR(25),"15.45" VARCHAR(25),"16.00" VARCHAR(25),"16.15" VARCHAR(25),"16.30" VARCHAR(25),"16.45" VARCHAR(25),"17.00" VARCHAR(25),"17.15" VARCHAR(25),"17.30" VARCHAR(25),"17.45" VARCHAR(25),"18.00" VARCHAR(25),"18.15" VARCHAR(25),"18.30" VARCHAR(25),"18.45" VARCHAR(25),"19.00" VARCHAR(25),"19.15" VARCHAR(25),"19.30" VARCHAR(25),"19.45" VARCHAR(25),"20.00" VARCHAR(25),"20.15" VARCHAR(25),"20.30" VARCHAR(25),"20.45" VARCHAR(25),"21.00" VARCHAR(25),"21.15" VARCHAR(25),"21.30" VARCHAR(25),"21.45" VARCHAR(25),"22.00" VARCHAR(25),"22.15" VARCHAR(25),"22.30" VARCHAR(25),"22.45" VARCHAR(25),"23.00" VARCHAR(25),"23.15" VARCHAR(25),"23.30" VARCHAR(25),"23.45" VARCHAR(25))';
  SQLQuery1.ExecSQL;
  SQLTransaction1.commit;

{erstellt die Tabelle Jahr}
SQLQuery2.SQL.text := 'CREATE TABLE IF NOT EXISTS tblJahr (ID INTEGER Primary KEY, Jahr Date)';
SQLQuery2.ExecSQL;
SQLTransaction1.commit;

{erstellt die Tabelle Monat}
SQLQuery3.SQL.text := 'CREATE TABLE IF NOT EXISTS tblMonth (ID INTEGER Primary KEY, Monat Date)';
SQLQuery3.ExecSQL;
SQLTransaction1.commit;

SQLQuery4.SQL.text := 'CREATE TABLE IF NOT EXISTS tblMedikamente (ID INTEGER Primary KEY, Medikament VARCHAR(25), Image BLOB)';
SQLQuery4.ExecSQL;
SQLTransaction1.commit;

{Löscht die Tabelle Jahr}
SQLQuery2.SQL.Text:='DROP TABLE IF EXISTS tblJahr';
SQLQuery2.ExecSQL;
SQLTransaction1.commit;

{Erstellt Tabelle Jahr und für diverse Jahre als Einträge hinzu}
SQLQuery2.SQL.text := 'CREATE TABLE IF NOT EXISTS tblJahr ( ID INTEGER Primary KEY, Jahr VARCHAR(6))';
SQLQuery2.ExecSQL;
SQLTransaction1.commit;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2010")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2011")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2012")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2013")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2014")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2015")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2016")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2017")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2018")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2019")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2020")';
SQLQuery2.ExecSQL;
SQLQuery2.SQL.text := 'INSERT INTO tblJahr VALUES (NULL, "2009")';
SQLQuery2.ExecSQL;
SQLTransaction1.commit;


{Löscht die Tabelle Monat}
SQLQuery3.SQL.Text:='DROP TABLE IF EXISTS tblMonth';
SQLQuery3.ExecSQL;
SQLTransaction1.commit;

{Erstellt Tabelle Monat und für diverse Monate als Einträge hinzu}
SQLQuery3.SQL.text := 'CREATE TABLE IF NOT EXISTS tblMonth (ID INTEGER Primary KEY, Month VARCHAR(25))';
SQLQuery3.ExecSQL;
SQLTransaction1.commit;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Januar")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Februar")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "März")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "April")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Mai")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Juni")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Juli")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "August")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "September")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Oktober")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "November")';
SQLQuery3.ExecSQL;
SQLQuery3.SQL.text := 'INSERT INTO tblMonth VALUES (NULL, "Dezember")';
SQLQuery3.ExecSQL;
SQLTransaction1.commit;


{Testet Datenbank Connection}
SQLite3Connection1.Open;
if SQLite3Connection1.Connected then
StatusBar1.Panels.Add.Text:='Verbindung hergestellt';

SQLQuery1.Close;
SQLQuery1.SQL.text:='SELECT * FROM tblDateTime';
SQLQuery1.Open;

SQLQuery2.Close;
SQLQuery2.SQL.text:='SELECT * FROM tblJahr';
SQLQuery2.Open;

SQLQuery3.Close;
SQLQuery3.SQL.text:='SELECT * FROM tblMonth';
SQLQuery3.Open;

SQLQuery1.Close;
SQLQuery1.DataBase.DatabaseName:='SQLite3Connection1.DatabaseName';
//SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery1.SQL.Text:='Select * FROM tblDateTime';
SQLQuery1.Open;
SQLQuery1.Active:=True;

SQLQuery2.Close;
SQLQuery2.DataBase.DatabaseName:='SQLite3Connection1.DatabaseName';
// SQLQuery2.FileName:='migraenetagebuch.sql3db';
SQLQuery2.SQL.Text:='Select * FROM tblJahr';
SQLQuery2.Open;
SQLQuery2.Active:=True;

SQLQuery3.Close;
SQLQuery3.DataBase.DatabaseName:='SQLite3Connection1.DatabaseName';
// SQLQuery3.FileName:='migraenetagebuch.sql3db';
SQLQuery3.SQL.Text:='Select * FROM tblMonth';
SQLQuery3.Open;
SQLQuery3.Active:=True;

RestoreFormState(self);

end;

procedure TForm1.FormHide(Sender: TObject);
begin
  TrayIcon1.Visible:=True;
   StoreFormState(self);
end;

procedure TForm1.FormResize(Sender: TObject);
begin

end;

procedure TForm1.DBComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.EventLog1GetCustomCategory(Sender: TObject; var Code: Word);
begin

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
Form1.EventLog1.Active:=False;

 Form1.EventLog1.Free;

Form2.SQLQuery1.ApplyUpdates;
 Form1.StoreFormState(self);
 Form2.StoreFormState(self);
 Form3.StoreFormState(self);

end;

procedure TForm1.RestoreFormState(Sender: TObject);
var
  LastWindowState: TWindowState;
begin
  with XMLConfig1 do begin
    xmlconfig1.Filename:='./ini/window1.ini';

    LastWindowState := TWindowState(GetValue('WindowState', Integer(WindowState)));

    if LastWindowState = wsMaximized then begin
      WindowState := wsNormal;
      BoundsRect := Bounds(
        GetValue('RestoredLeft', RestoredLeft),
        GetValue('RestoredTop', RestoredTop),
        GetValue('RestoredWidth', RestoredWidth),
        GetValue('RestoredHeight', RestoredHeight));
      WindowState := wsMaximized;
    end else begin
      WindowState := wsNormal;
      BoundsRect := Bounds(
        GetValue('NormalLeft', Left),
        GetValue('NormalTop', Top),
        GetValue('NormalWidth', Width),
        GetValue('NormalHeight', Height));
       end;
end;
     end;

procedure TForm1.StoreFormState(Sender: TObject);

begin
  with XMLConfig1 do begin
    xmlconfig1.Filename:='./ini/window1.ini';
    SetValue('NormalLeft', Left);
    SetValue('NormalTop', Top);
    SetValue('NormalWidth', Width);
    SetValue('NormalHeight', Height);

    SetValue('RestoredLeft', RestoredLeft);
    SetValue('RestoredTop', RestoredTop);
    SetValue('RestoredWidth', RestoredWidth);
    SetValue('RestoredHeight', RestoredHeight);

    SetValue('WindowState', Integer(WindowState));

end;

   end;
end.

