unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, DB, eventlog, FileUtil,
  DBDateTimePicker, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  DBCtrls, Buttons, DBExtCtrls, ExtCtrls, XMLPropStorage;

type

  { TForm1 }

  TForm1 = class(TForm)
    DSDay: TDataSource;
    DSYear: TDataSource;
    DSMonth: TDataSource;
    DSMedikamente: TDataSource;
    DBCheckBox1: TDBCheckBox;
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
    StatusBar1: TStatusBar;
    TrayIcon1: TTrayIcon;
    XMLPropStorage1: TXMLPropStorage;
    procedure DBLookupComboBox1Change(Sender: TObject);

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);

    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure StoreFormState(Sender: TObject);
    procedure RestoreFormState(Sender: TObject);
    procedure XMLPropStorage1RestoreProperties(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
uses uMediEdit, Unit3, udm1;

{ TForm1 }


procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  MyForm: TFormMediEdit;
begin
  if DM1.QDay.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QDay.ApplyUpdates;

  MyForm := TFormMediEdit.Create(nil);
  try
    MyForm.ShowModal;
  finally
    MyForm.Free;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  MyForm3: TForm3;
begin

  if DM1.QDay.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QDay.ApplyUpdates;

  MyForm3 := TForm3.Create(nil);
  try
    MyForm3.ShowModal;
  finally
    MyForm3.Free;
  end;
  DM1.QDay.Active := True;
  DM1.QYear.Active := True;
  DM1.QMonth.Active := True;
  DM1.QMedikamente.Active := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  DirStr: string;
begin

  {Testen ob Directory existiert wenn nicht erstelle Directory}
  if not DirectoryExists('./sql') then
    DirStr := 'sql';
  CreateDir(DirStr);

  if not DirectoryExists('./img') then
    DirStr := 'img';
  CreateDir(DirStr);

  if not DirectoryExists('./ini') then
    DirStr := 'ini';
  CreateDir(DirStr);

  if not DirectoryExists('./log') then
    DirStr := 'log';
  CreateDir(DirStr);

  EventLog1.FileName := './log/CrashReport.txt';
  EventLog1.Active := True;

  XMLPropStorage1.FileName := './ini/MainForm.ini';
  XMLPropStorage1.Restore;

  {schliesst Verbindung zu SQLite Datenbanken }
  //SQLite3Connection1.Close;

  {Öffnet Datenbank Datei migränetagebuch}
  {Testet Datenbank Connection}
  DM1.DatabaseName := './sql/migraenetagebuch.sql3db';
  if DM1.TestAndOpenDB then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';

  {Erstellen der Tabellen ins Datenmodul ausgelagert}

  // Oeffnet Verbindung für Form 1 Daten.
  DM1.QDay.Active := True;
  DM1.QYear.Active := True;
  DM1.QMonth.Active := True;
  DM1.QMedikamente.Active := True;
end;

procedure TForm1.FormHide(Sender: TObject);
begin
  TrayIcon1.Visible := True;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  if DM1.QDay.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QDay.ApplyUpdates;
  DM1.QDay.Active := False;

  Form1.EventLog1.Active := False;

  Form1.EventLog1.Free;

end;

procedure TForm1.DBLookupComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.RestoreFormState(Sender: TObject);
begin
end;

procedure TForm1.XMLPropStorage1RestoreProperties(Sender: TObject);
begin

end;

procedure TForm1.StoreFormState(Sender: TObject);

begin

end;

end.
