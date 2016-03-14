unit uMediEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, eventlog, DB, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, DBCtrls, Buttons, ComCtrls, XMLPropStorage, StdCtrls, ExtDlgs, uDM1;

type

  { TFormMediEdit }

  TFormMediEdit = class(TForm)
    Button1: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    DBImage2: TDBImage;
    DBNavigator1: TDBNavigator;
    DBText1: TDBText;
    DSMedikamente: TDataSource;
    EventLog1: TEventLog;
    BuSaveExit: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    XMLPropStorage1: TXMLPropStorage;
    procedure Button1Click(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BuSaveExitClick(Sender: TObject);
    procedure XMLPropStorage1RestoreProperties(Sender: TObject);
    procedure XMLPropStorage1SaveProperties(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMediEdit: TFormMediEdit;

implementation

{$R *.lfm}

{ TFormMediEdit }

procedure TFormMediEdit.FormCreate(Sender: TObject);
var
  DirStr: string;
begin
  if not DirectoryExists('./ini') then
  begin
    DirStr := 'ini';
    CreateDir(DirStr);
  end;
  XMLPropStorage1.FileName := './ini/FormMediEdit.ini';
  XMLPropStorage1.Restore;

  if not DirectoryExists('./log') then
  begin
    DirStr := 'log';
    CreateDir(DirStr);
  end;
  EventLog1.FileName := './log/CrashReport.txt';
  EventLog1.Active := True;
  {Testet Datenbank Connection}
  DM1.DatabaseName := './sql/migraenetagebuch.sql3db';
  if DM1.TestAndOpenDB then
    StatusBar1.Panels.Add.Text := 'Verbindung hergestellt';
  DM1.QMedikamente.Active := True;
end;

procedure TFormMediEdit.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    DBImage1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;



procedure TFormMediEdit.FormDestroy(Sender: TObject);
begin
  if DM1.QMedikamente.UpdateStatus <> TUpdateStatus.usUnmodified then
    DM1.QMedikamente.ApplyUpdates;
  DM1.QMedikamente.Active := False;
end;

procedure TFormMediEdit.BuSaveExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMediEdit.XMLPropStorage1RestoreProperties(Sender: TObject);
begin
  // Hier kann man den Storage lesen

end;

procedure TFormMediEdit.XMLPropStorage1SaveProperties(Sender: TObject);

// Hier kann man den Storage schreiben
begin

end;

end.


