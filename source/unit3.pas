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
    DSYear: TDataSource;
    DSMonth: TDataSource;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    EventLog1: TEventLog;
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

  {Testet Datenbank Connection}
  if DM1.TestAndOpenDB then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';

  {Testet Datenbank Connection}
  DM1.DatabaseName := './sql/migraenetagebuch.sql3db';
  if DM1.TestAndOpenDB then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';
  DM1.QYear.Active := True;
  DM1.QMonth.Active := True;

end;



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

end.
