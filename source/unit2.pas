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
    EventLog1: TEventLog;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    XMLConfig1: TXMLConfig;

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

procedure TFormEditMedi.FormDestroy(Sender: TObject);
begin

end;

procedure TFormEditMedi.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if DM1.QMedikamente.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QMedikamente.ApplyUpdates;
  DM1.QMedikamente.Active:=false;
  CloseAction:=caFree;
  // FormEditMedi.EventLog1.Active:=False;
  // FormEditMedi.EventLog1.Free; // Das gehört dem Formular !!!
  // FormEditMedi.StoreFormState(self);
end;

procedure TFormEditMedi.SpeedButton2Click(Sender: TObject);
begin
  FormEditMedi.Close; // Ruft später selbst FormClose auf
end;

procedure TFormEditMedi.SpeedButton3Click(Sender: TObject);
begin
  if DM1.QMedikamente.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QMedikamente.ApplyUpdates;
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



end.

