unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, lazlogger, uDM1;

type

  { TForm1 }

  TForm1 = class(TForm)
    BuCreateDB: TButton;
    BuDeleteDB: TButton;
    BuCreateTable: TButton;
    BuGenData: TButton;
    BuShowData: TButton;
    procedure BuCreateDBClick(Sender: TObject);
    procedure BuCreateTableClick(Sender: TObject);
    procedure BuDeleteDBClick(Sender: TObject);
    procedure BuGenDataClick(Sender: TObject);
    procedure BuShowDataClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BuCreateDBClick(Sender: TObject);
begin
  DebugLn('BuCreateDBClick');
  DM1.CreateDB;
end;

procedure TForm1.BuCreateTableClick(Sender: TObject);
begin
  DebugLn('BuCreateTableClick');
  DM1.CreateTables;
end;

procedure TForm1.BuDeleteDBClick(Sender: TObject);
begin
  DebugLn('BuDeleteDBClick');
  DM1.DeleteDB;
end;

procedure TForm1.BuGenDataClick(Sender: TObject);
begin
  DM1.DummyData;
end;

procedure TForm1.BuShowDataClick(Sender: TObject);
begin

end;

end.

