unit frm_medi;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, db, XMLConf, eventlog, FileUtil, Forms,
  Controls, Graphics, Dialogs, ComCtrls, DbCtrls, DBGrids, Buttons, EditBtn,
  Calendar, XMLPropStorage, Menus;

type

  { TForm2 }

  TForm2 = class(TForm)
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    DBNavigator1: TDBNavigator;
    DBText1: TDBText;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SQLQuery1: TSQLQuery;
    StatusBar1: TStatusBar;
    XMLConfig1: TXMLConfig;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  Form2: TForm2;

implementation

{$R *.lfm}
 uses
   {implementiert unit1 für die form1
   oder die weiteren Unit's für Logging Errors}
   frm_mgr,
   frm_moth_and_year;
{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
var
  DirStr: string;
begin

  Application.OnException:=@AppException;

{Testet Datenbank Connection}
Form1.SQLite3Connection1.Open;
if Form1.SQLite3Connection1.Connected then
StatusBar1.Panels.Add.Text:='Verbindung hergestellt';

SQLQuery1.Close;
SQLQuery1.active:=false;
SQLQuery1.Options:=[sqoAutoCommit];
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

 RestoreFormState(self);
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

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
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
  //SQLQuery1.UpdateSQL.BeginUpdate;

  //SQLQuery1.UpdateSQL.EndUpdate;
 // SQLQuery1.UpdateRecord;
 // Form2.SQLQuery1.ApplyUpdates;
//  Form2.SQLQuery1.active:=False;
  Form2.StoreFormState(self);
  Form2.Close;
   Form1.Show;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
  SQLQuery1.SQL.Text := 'UPDATE * FROM tblMedikamente';
end;

procedure TForm2.RestoreFormState(Sender: TObject);
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

procedure TForm2.StoreFormState(Sender: TObject);

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

