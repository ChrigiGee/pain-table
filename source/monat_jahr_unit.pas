unit monat_jahr_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, DB, eventlog, XMLConf, FileUtil,
  DBDateTimePicker, ZDataset, Forms, Controls, Graphics, Dialogs, DBCtrls,
  DBGrids, DBExtCtrls, Buttons, ComCtrls;

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
    XMLConfig1: TXMLConfig;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SQLite3Connection1AfterConnect(Sender: TObject);
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
  schmerz_tabelle_unit,
  medikamente_unit, TLoggerUnit, TLevelUnit, TFileAppenderUnit;


{ TForm3 }

procedure TForm3.SQLite3Connection1AfterConnect(Sender: TObject);
begin

end;

procedure TForm3.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TForm3.DataSource2DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TLogger.freeInstances;
  Form3.StoreFormState(self);
  Form1.Show;

end;

procedure TForm3.FormCreate(Sender: TObject);
var
  DirStr: string;
  logger: TLogger;
begin

  Application.OnException := @AppException;

  logger := TLogger.getInstance;
  logger.setLevel(TLevelUnit.ALL);
  logger.addAppender(TFileAppender.Create('.\log\crashreport2.log'));

  {Testet Datenbank Connection}
  Form1.ZConnection1.Connect;
  if Form1.ZConnection1.Connected then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';
  {
// Schliesse SQLQuerry und weise Datenbank hinzu
SQLQuery1.Close;
SQLQuery1.Active:=False;
SQLQuery1.DataBase.DatabaseName:='Form1.ZConnection1.DatabaseName';
SQLQuery1.ReadOnly:=FALSE;

// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery1.SQL.Text:='Select * FROM tblJahr';
SQLQuery1.ReadOnly:=FALSE;

SQLQuery1.Active:=True;
SQLQuery1.Open;
 }
{
// Schliesse Querry und weise Datenbank hinzu
SQLQuery2.Close;
SQLQuery2.active:=false;
SQLQuery2.DataBase.DatabaseName:='Form1.ZConnection1.DatabaseName';
SQLQuery2.ReadOnly:=FALSE;

// SQLQuery1.FileName:='migraenetagebuch.sql3db';
SQLQuery2.SQL.Text:='Select * FROM tblMonth';
SQLQuery2.ReadOnly:=FALSE;

SQLQuery2.Open;
SQLQuery2.Active:=True;
 }

  RestoreFormState(self);
end;

procedure TForm3.SpeedButton3Click(Sender: TObject);
begin
  ZQuery1.ApplyUpdates;
  TLogger.freeInstances;

  Form1.Show;
  Form3.Destroy;
end;

procedure TForm3.RestoreFormState(Sender: TObject);
var
  LastWindowState: TWindowState;
begin
  with XMLConfig1 do
  begin
    xmlconfig1.Filename := './ini/window3.ini';

    LastWindowState := TWindowState(GetValue('WindowState', integer(WindowState)));

    if LastWindowState = wsMaximized then
    begin
      WindowState := wsNormal;
      BoundsRect := Bounds(GetValue('RestoredLeft', RestoredLeft),
        GetValue('RestoredTop', RestoredTop),
        GetValue('RestoredWidth', RestoredWidth),
        GetValue('RestoredHeight', RestoredHeight));
      WindowState := wsMaximized;
    end
    else
    begin
      WindowState := wsNormal;
      BoundsRect := Bounds(GetValue('NormalLeft', Left),
        GetValue('NormalTop', Top), GetValue('NormalWidth', Width),
        GetValue('NormalHeight', Height));
    end;
  end;
end;

procedure TForm3.StoreFormState(Sender: TObject);

begin
  with XMLConfig1 do
  begin
    xmlconfig1.Filename := './ini/window3.ini';
    SetValue('NormalLeft', Left);
    SetValue('NormalTop', Top);
    SetValue('NormalWidth', Width);
    SetValue('NormalHeight', Height);

    SetValue('RestoredLeft', RestoredLeft);
    SetValue('RestoredTop', RestoredTop);
    SetValue('RestoredWidth', RestoredWidth);
    SetValue('RestoredHeight', RestoredHeight);

    SetValue('WindowState', integer(WindowState));

  end;

end;

procedure TForm3.AppException(Sender: TObject; E: Exception);
var
  sLogFile: string;
  f: Text;
  DirStr: string;
  logger: TLogger;
begin
  if not DirectoryExists('./log') then
    DirStr := 'log';
  CreateDir(DirStr);

  logger := TLogger.getInstance;
  logger.setLevel(TLevelUnit.ALL);
  logger.addAppender(TFileAppender.Create('./log/crashreport2.log'));

  sLogFile := './log/crashreport.log';
  if not FileExists(sLogFile) then
  begin
    AssignFile(f, sLogFile);
    ReWrite(f);
  end
  else
  begin
    AssignFile(f, sLogFile);
    Append(f);
  end;
  WriteLn(f, formatdatetime('yyyy mm dd hh:nn:ss', now) + #9 + 'Exception:' + E.Message);
  DumpExceptionBackTrace(f);
  CloseFile(f);
end;

end.
