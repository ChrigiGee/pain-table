unit Unit2;

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
    EventLog1: TEventLog;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SQLQuery1: TSQLQuery;
    StatusBar1: TStatusBar;
    XMLConfig1: TXMLConfig;

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure StoreFormState(Sender: TObject);
    procedure RestoreFormState(Sender: TObject);

  private
    { private declarations }
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
   unit1,
   unit3;
{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
var
  DirStr: string;
begin

EventLog1.FileName:='./log/CrashReport.txt';
  EventLog1.Active:=True;


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

Form2.EventLog1.Active:=False;
SQLQuery1.ApplyUpdates(0);
Form2.EventLog1.Free;
 Form2.StoreFormState(self);
 Form1.Show;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
  SQLQuery1.ApplyUpdates;
  Form1.Show;
  Form2.Close;
  Form2.StoreFormState(self);
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
  SQLQuery1.ApplyUpdates(0);
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



end.

