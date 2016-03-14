unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, db, XMLConf, eventlog, FileUtil, Forms,
  Controls, Graphics, Dialogs, ComCtrls, DbCtrls, DBGrids, Buttons, EditBtn,
  Calendar, XMLPropStorage, Menus;

type

  { TFormEditMedi }

  TFormEditMedi = class(TForm)
    DSMedikamente: TDataSource;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    DBNavigator1: TDBNavigator;
    DBText1: TDBText;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    XMLConfig1: TXMLConfig;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
<<<<<<< HEAD
    procedure FormDestroy(Sender: TObject);
=======
    procedure FormShow(Sender: TObject);
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure StoreFormState(Sender: TObject);
    procedure RestoreFormState(Sender: TObject);

  private
    { private declarations }
    procedure AppException(Sender: TObject; E: Exception);
  public
    { public declarations }
  end;

var
  FormEditMedi: TFormEditMedi;

implementation

{$R *.lfm}

 uses
   uDM1;

{ TFormEditMedi }

procedure TFormEditMedi.FormCreate(Sender: TObject);
var
  DirStr: string;
begin
  EventLog1.FileName:='./log/CrashReport.txt';
    EventLog1.Active:=True;
 {Testet Datenbank Connection}
 DM1.DatabaseName:='./sql/migraenetagebuch.sql3db';
 if DM1.TestAndOpenDB then
   StatusBar1.Panels.Add.Text:='Verbindung hergestellt';
 DM1.QMedikamente.Active:=true;
 // RestoreFormState(self);
end;

<<<<<<< HEAD
procedure TFormEditMedi.FormDestroy(Sender: TObject);
begin
=======
  Application.OnException:=@AppException;

{Testet Datenbank Connection}
Form1.SQLite3Connection1.Open;
if Form1.SQLite3Connection1.Connected then
StatusBar1.Panels.Add.Text:='Verbindung hergestellt';

SQLQuery1.Close;
SQLQuery1.active:=false;

SQLQuery1.DataBase.DatabaseName:='Form1.SQLite3Connection1.DatabaseName';
SQLQuery1.ReadOnly:=FALSE;
// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery1.SQL.Text:='Select * FROM tblMedikamente';
SQLQuery1.Open;
SQLQuery1.Active:=True;

 RestoreFormState(self);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  {Testet Datenbank Connection}
Form1.SQLite3Connection1.Open;
if Form1.SQLite3Connection1.Connected then
StatusBar1.Panels.Add.Text:='Verbindung hergestellt';

SQLQuery1.Close;
SQLQuery1.active:=false;
SQLQuery1.DataBase.DatabaseName:='Form1.SQLite3Connection1.DatabaseName';
SQLQuery1.ReadOnly:=FALSE;
// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery1.SQL.Text:='Select * FROM tblMedikamente';
SQLQuery1.Open;
SQLQuery1.Active:=True;
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc

end;

procedure TFormEditMedi.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
<<<<<<< HEAD
  if DM1.QMedikamente.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QMedikamente.ApplyUpdates;
  DM1.QMedikamente.Active:=false;
  CloseAction:=caFree;
  // FormEditMedi.EventLog1.Active:=False;
  // FormEditMedi.EventLog1.Free; // Das gehört dem Formular !!!
  // FormEditMedi.StoreFormState(self);
=======

//SQLQuery1.UpdateSQL.BeginUpdate;

  //SQLQuery1.UpdateSQL.EndUpdate;
 // SQLQuery1.UpdateRecord;
  Form2.SQLQuery1.ApplyUpdates;
  Form2.SQLQuery1.active:=False;
  Form2.StoreFormState(self);
   Form1.Show;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  {Testet Datenbank Connection}
Form1.SQLite3Connection1.Open;
if Form1.SQLite3Connection1.Connected then
StatusBar1.Panels.Add.Text:='Verbindung hergestellt';

SQLQuery1.Close;
SQLQuery1.active:=false;
SQLQuery1.DataBase.DatabaseName:='Form1.SQLite3Connection1.DatabaseName';
SQLQuery1.ReadOnly:=FALSE;
// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery1.SQL.Text:='Select * FROM tblMedikamente';
SQLQuery1.Open;
SQLQuery1.Active:=True;

 RestoreFormState(self);
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
end;

procedure TFormEditMedi.SpeedButton2Click(Sender: TObject);
begin
<<<<<<< HEAD
  FormEditMedi.Close; // Ruft später selbst FormClose auf
=======
  //SQLQuery1.UpdateSQL.BeginUpdate;

  //SQLQuery1.UpdateSQL.EndUpdate;
 // SQLQuery1.UpdateRecord;
 // Form2.SQLQuery1.ApplyUpdates;
//  Form2.SQLQuery1.active:=False;
  Form2.StoreFormState(self);
  Form2.Close;
   Form1.Show;
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
end;

procedure TFormEditMedi.SpeedButton3Click(Sender: TObject);
begin
<<<<<<< HEAD
  if DM1.QMedikamente.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QMedikamente.ApplyUpdates;
=======
  SQLQuery1.SQL.Text := 'UPDATE * FROM tblMedikamente';
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
end;

procedure TFormEditMedi.RestoreFormState(Sender: TObject);
var
  LastWindowState: TWindowState;
begin
  with XMLConfig1 do begin
    xmlconfig1.Filename:='./ini/window2.ini';
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

procedure TFormEditMedi.StoreFormState(Sender: TObject);

begin
  with XMLConfig1 do begin
    xmlconfig1.Filename:='./ini/window2.ini';
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
 procedure TForm2.AppException(Sender: TObject; E: Exception);
var
  sLogFile: String;
  f: Text;
  DirStr: string;
begin
if not DirectoryExists('./log') then
   DirStr:= 'log';
  CreateDir(DirStr);

  sLogFile:='./log/crashreport.log';
  if not FileExists(sLogFile) then
  begin
    AssignFile(f, sLogFile);
    ReWrite(f);
  end
  else
  begin
    AssignFile(f, sLogFile);
    Append(f)
  end;
  WriteLn(f, formatdatetime('yyyy mm dd hh:nn:ss',now)+#9+'Exception:'+E.Message);
  DumpExceptionBackTrace(f);
  CloseFile(f);
end;


end.

