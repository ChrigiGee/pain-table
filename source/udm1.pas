unit uDM1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, LazFileUtils,lazlogger;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    Con1: TSQLite3Connection;
    QMedikamente: TSQLQuery;
    SQLTran1: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    function CreateDB: Boolean;
    function CreateTables: Boolean;
    function DeleteDB: Boolean;
    function GetDatabase: string;
    procedure SetDatabase(AValue: string);
    { private declarations }
  public
    { public declarations }
    function TestAndOpenDB:Boolean;
    property DatabaseName: string read GetDatabase write SetDatabase;
  end;

var
  DM1: TDM1;

implementation

{$R *.lfm}

procedure TDM1.SetDatabase(AValue: string);
begin
  if Con1.DatabaseName=AValue then Exit;
  Con1.DatabaseName:=AValue;
end;

function TDM1.GetDatabase: string;
begin
  Result := Con1.DatabaseName;
end;

procedure TDM1.DataModuleCreate(Sender: TObject);
begin
  Con1.Options:= [scoApplyUpdatesChecksRowsAffected];
end;

function TDM1.CreateDB: Boolean;
var
  DirStr: String;
begin
  Result := false;
  {Wenn wir bereits verbunden sind, dann können wir dei DB nicht erzeugen}
  if Con1.Connected then
  begin
    DebugLn('Error: Already connected to the DB');
    exit; //-->
  end;
  {Testen ob Directory existiert wenn nicht erstelle Directory}
  DirStr:= ExtractFileDir(Con1.DatabaseName);
  if not DirectoryExists(DirStr) then
  begin
     CreateDir(DirStr);
  end;
  {Testen ob die Datei bereits vorhanden ist}
  if FileExists(Con1.DatabaseName) then
  begin
    DebugLn('Error: DB already exists');
    exit; //-->
  end;
  Con1.CreateDB;
  DebugLn('CreateDB finished');
  Result := CreateTables;
end;

function TDM1.TestAndOpenDB: Boolean;
begin
  Result := false;
  if Con1.Connected then
  begin
    DebugLn('Hint: DB already open');
    Result := Con1.Connected;
    exit; //==>
  end;
  if not FileExists(Con1.DatabaseName) then
  begin
    DebugLn('Hint: Create DB now');
    if not CreateDB then
    begin
      Result := false;
      exit; //==>
    end;
    if not CreateTables then
    begin
      Result := false;
      exit; //==>
    end;
  end;
  if not Con1.Connected then
  begin
    Con1.Connected:=true;
  end;
  Result := Con1.Connected;
end;

function TDM1.CreateTables: Boolean;
var
  SQL: String;
begin
  Result := false;
  if not Con1.Connected then
  begin
    DebugLn('Warning: DB not connected, try to connect');
    Con1.Connected:=true;
  end;
  // Todo
  SQL := 'CREATE TABLE IF NOT EXISTS tblMedikamente ' +
         '(ID INTEGER Primary KEY, Medikament VARCHAR(25), Image BLOB)';
  Con1.Transaction.StartTransaction;
  try
    Con1.ExecuteDirect(SQL);
    Con1.Transaction.Commit;
  except
    Con1.Transaction.Rollback;
    DebugLn('Error: Cannot create tblMedikamente');
  end;

  SQL := 'CREATE TABLE IF NOT EXISTS tblDateTime ' +
         '(ID INTEGER PRIMARY KEY,Jahr Date, Monat Date, aktDatum Date, '+
         '"Printed" VARCHAR(15), "00.00" VARCHAR(10), "00.15" VARCHAR(25),'+
         '"00.30" VARCHAR(25),"00.45" VARCHAR(25),"01.00" VARCHAR(25),'+
         '"01.15" VARCHAR(25),"01.30" VARCHAR(25),"01.45" VARCHAR(25),'+
         '"02.00" VARCHAR(25),"02.15" VARCHAR(25),"02.30" VARCHAR(25),'+
         '"02.45" VARCHAR(25),"03.00" VARCHAR(25),"03.15" VARCHAR(25),'+
         '"03.30" VARCHAR(25),"03.45" VARCHAR(25),"04.00" VARCHAR(25),'+
         '"04.15" VARCHAR(25),"04.30" VARCHAR(25),"04.45" VARCHAR(25),'+
         '"05.00" VARCHAR(25),"05.15" VARCHAR(25),"05.30" VARCHAR(25),'+
         '"05.45" VARCHAR(25),"06.00" VARCHAR(25),"06.15" VARCHAR(25),'+
         '"06.30" VARCHAR(25),"06.45" VARCHAR(25),"07.00" VARCHAR(25),'+
         '"07.15" VARCHAR(25),"07.30" VARCHAR(25),"07.45" VARCHAR(25),'+
         '"08.00" VARCHAR(25),"08.15" VARCHAR(25),"08.30" VARCHAR(25),'+
         '"08.45" VARCHAR(25),"09.00" VARCHAR(25),"09.15" VARCHAR(25),'+
         '"09.30" VARCHAR(25),"09.45" VARCHAR(25),"10.00" VARCHAR(25),'+
         '"10.15" VARCHAR(25),"10.30" VARCHAR(25),"10.45" VARCHAR(25),"11.00" VARCHAR(25),"11.15" VARCHAR(25),"11.30" VARCHAR(25),"11.45" VARCHAR(25),"12.00" VARCHAR(25),"12.15" VARCHAR(25),"12.30" VARCHAR(25),"12.45" VARCHAR(25),"13.00" VARCHAR(25),"13.15" VARCHAR(25),"13.30" VARCHAR(25),"13.45" VARCHAR(25),"14.00" VARCHAR(25),"14.15" VARCHAR(25),"14.30" VARCHAR(25),"14.45" VARCHAR(25),"15.00" VARCHAR(25),"15.15" VARCHAR(25),"15.30" VARCHAR(25),"15.45" VARCHAR(25),"16.00" VARCHAR(25),"16.15" VARCHAR(25),"16.30" VARCHAR(25),"16.45" VARCHAR(25),"17.00" VARCHAR(25),"17.15" VARCHAR(25),"17.30" VARCHAR(25),"17.45" VARCHAR(25),"18.00" VARCHAR(25),"18.15" VARCHAR(25),"18.30" VARCHAR(25),"18.45" VARCHAR(25),"19.00" VARCHAR(25),"19.15" VARCHAR(25),"19.30" VARCHAR(25),"19.45" VARCHAR(25),"20.00" VARCHAR(25),"20.15" VARCHAR(25),"20.30" VARCHAR(25),"20.45" VARCHAR(25),"21.00" VARCHAR(25),"21.15" VARCHAR(25),"21.30" VARCHAR(25),"21.45" VARCHAR(25),"22.00" VARCHAR(25),"22.15" VARCHAR(25),"22.30" VARCHAR(25),"22.45" VARCHAR(25),"23.00" VARCHAR(25),"23.15" VARCHAR(25),"23.30" VARCHAR(25),"23.45" VARCHAR(25))';

  Con1.Transaction.StartTransaction;
  try
    Con1.ExecuteDirect(SQL);
    Con1.Transaction.Commit;
  except
    Con1.Transaction.Rollback;
    DebugLn('Error: Cannot create tblDateTime');
  end;
end;

function TDM1.DeleteDB: Boolean;
begin
  Result := false;
  if Con1.Connected then
  begin
    DebugLn('Error: Already connected to the DB');
    exit;
  end;
  if not FileExists(Con1.DatabaseName) then
  begin
    DebugLn('Error: DB does not exists');
    exit;
  end;
  Con1.DropDB;
  Result := true;
  DebugLn('DeleteDB finished');
end;


end.

