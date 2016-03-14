unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, DB, eventlog, XMLConf, FileUtil,
  DBDateTimePicker, Forms, Controls, Graphics, Dialogs, DBCtrls,
  DBGrids, DBExtCtrls, Buttons, ComCtrls, XMLPropStorage;

type

  { TForm3 }

  TForm3 = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Jahr: TDBText;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    XMLPropStorage1: TXMLPropStorage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
  Form3: TForm3;

implementation

{$R *.lfm}
uses
  Unit1,
  unit2,
  udm1,
  LazLogger;


{ TForm3 }

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  try
    if DM1.QYear.UpdateStatus <> TUpdateStatus.usUnmodified then
      DM1.QYear.ApplyUpdates;
    DM1.QYear.Active := False;
  except
    DM1.QYear.Active := True;
    DebugLn('Error: Cannot Close Form3 Year');
  end;

  try
    if DM1.QMonth.UpdateStatus <> TUpdateStatus.usUnmodified then
      DM1.QMonth.ApplyUpdates;
    DM1.QMonth.Active := False;
  except
    DM1.QMonth.Active := True;
    DebugLn('Error: Cannot Close Form3 Month');
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
var
  DirStr: string;
begin

  EventLog1.FileName := './log/CrashReport.txt';
  EventLog1.Active := True;

  XMLPropStorage1.FileName := './ini/Form3_Test.ini';
  XMLPropStorage1.Restore;

<<<<<<< HEAD
  {Testet Datenbank Connection}
  if DM1.TestAndOpenDB then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';

  {Testet Datenbank Connection}
  DM1.DatabaseName := './sql/migraenetagebuch.sql3db';
  if DM1.TestAndOpenDB then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';
  DM1.QYear.Active := True;
  DM1.QMonth.Active := True;

=======

 Form3.StoreFormState(self);
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
end;


<<<<<<< HEAD
=======
Application.OnException:=@AppException;


{Testet Datenbank Connection}
Form1.SQLite3Connection1.Open;
if Form1.SQLite3Connection1.Connected then
StatusBar1.Panels.Add.Text:='Verbindung hergestellt';
  {
// Schliesse SQLQuerry und weise Datenbank hinzu
SQLQuery1.Close;
SQLQuery1.Active:=False;
SQLQuery1.DataBase.DatabaseName:='Form1.SQLite3Connection1.DatabaseName';
SQLQuery1.ReadOnly:=FALSE;

// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery1.SQL.Text:='Select * FROM tblJahr';
SQLQuery1.Active:=True;
SQLQuery1.Open;
 }
{
// Schliesse Querry und weise Datenbank hinzu
SQLQuery2.Close;
SQLQuery2.active:=false;
SQLQuery2.DataBase.DatabaseName:='Form1.SQLite3Connection1.DatabaseName';
SQLQuery2.ReadOnly:=FALSE;

// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery2.SQL.Text:='Select * FROM tblMonth';
SQLQuery2.Open;
SQLQuery2.Active:=True;
 }

 RestoreFormState(self);
end;
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc

procedure TForm3.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm3.RestoreFormState(Sender: TObject);
begin


end;

procedure TForm3.StoreFormState(Sender: TObject);

begin

end;

<<<<<<< HEAD
=======
   end;
procedure TForm3.AppException(Sender: TObject; E: Exception);
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
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
end.
