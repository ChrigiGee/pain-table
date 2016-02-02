unit uDM1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, lazlogger, LazFileUtils;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    Con1: TSQLite3Connection;
    QTestDaten: TSQLQuery;
    SQLTran1: TSQLTransaction;
  private
    { private declarations }
  public
    { public declarations }
    function CreateDB:Boolean;
    function CreateTables:Boolean;
    function DeleteDB:Boolean;
    function DummyData:Boolean;
    procedure ShowData1(Datum: TDateTime);

  end;

var
  DM1: TDM1;

implementation

{$R *.lfm}

uses math;

{ TDM1 }

function TDM1.CreateDB: Boolean;
begin
  Result := false;
  if Con1.Connected then
  begin
    DebugLn('Error: Already connected to the DB');
    exit;
  end;
  if FileExistsUTF8(Con1.DatabaseName) then
  begin
    DebugLn('Error: DB already exists');
    exit;
  end;
  Con1.CreateDB;
  DebugLn('CreateDB finished');
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
  SQL := 'CREATE TABLE Schmerz (' +
    'SchmerzID INT NOT NULL,' +
    '  Intens INT NOT NULL,' +
    '  Start TIMESTAMP NOT NULL,' +
    '  Ende TIMESTAMP,' +
    '  Bemerkung VARCHAR(0)' +
    ');';
   Con1.Transaction.StartTransaction;
   try
     Con1.ExecuteDirect(SQL);
     Con1.Transaction.Commit;
   except
     Con1.Transaction.Rollback;
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
  if not FileExistsUTF8(Con1.DatabaseName) then
  begin
    DebugLn('Error: DB does not exists');
    exit;
  end;
  Con1.DropDB;
  Result := true;
  DebugLn('DeleteDB finished');
end;

function TDM1.DummyData: Boolean;
const
  BaseDate = '01.01.2016';
  BaseMinute: double = 1.0 / 24.0 / 60.0;
var
  SQL: String;
  i: Integer;
  AktDate : TDateTime;
  tempf : float;
  tempd : Integer;
  tempi , j: Integer;
  MyFormats : TFormatSettings;
begin
  Result := false;
  Randomize;
  if not Con1.Connected then
  begin
    DebugLn('Warning: DB not connected, try to connect');
    Con1.Connected:=true;
  end;
  MyFormats.DecimalSeparator:='.';
  Con1.Transaction.StartTransaction;
  try
    for i:= 0 to 364 do
    begin
      for j:= 0 to RandomRange(1,10) do
      begin
        AktDate := StrToDate(BaseDate) + i;
        tempf := randg(0.5,0.25);
        tempd := RandomRange(15,300);
        tempi := RandomRange(1,10);
        SQL := 'INSERT INTO Schmerz (SchmerzID, Intens, Start, Ende, Bemerkung )' +
          ' VALUES ('+IntToStr(i)+' , ' +
                     IntToStr(tempi) +', '+
                     FloatToStr(AktDate + tempf,MyFormats ) + ' , ' +
                     FloatToStr(AktDate + tempf + tempd*BaseMinute, MyFormats ) + ' , ' +
                     '"Wert'+IntToStr(i)+'" );';
        Con1.ExecuteDirect(SQL);
      end;
    end;
    Con1.Transaction.Commit;
    Result := true;
  except
    Con1.Transaction.Rollback;
    DebugLn('Error: DummyData failed');
  end;
  DebugLn('DummyData finished');

end;

procedure TDM1.ShowData1(Datum:TDateTime);
var
  SQL: String;
  MyFormats : TFormatSettings;
begin
  if not Con1.Connected then
  begin
    DebugLn('Warning: DB not connected, try to connect');
    Con1.Connected:=true;
  end;

  if QTestDaten.Active then
   QTestDaten.Close;
  SQL := 'SELECT SchmerzID, Intens, Start, Ende, Bemerkung FROM Schmerz ';
  if Datum <> 0 then
  begin
    Datum := float(trunc(Datum));
    SQL := SQL + ' WHERE Start BETWEEN ' + FloatToStr(Datum ,MyFormats ) +
                 ' AND ' + FloatToStr(Datum + 1.0 ,MyFormats )
  end;
  QTestDaten.SQL.Clear;
  QTestDaten.SQL.Add(SQL);
  QTestDaten.Open;
  DebugLn('ShowData1 finished');
end;

end.

