unit uanz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, TADbSource, TAGraph, TATools,
  TAIntervalSources, TANavigation, TASeries, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, ComCtrls, TACustomSource, TAMultiSeries, TATransformations,
  DateTimePicker;

type

  { TForm1 }

  TForm1 = class(TForm)
    BuQuery: TButton;
    Chart1: TChart;
    ChartAxisTransformations1: TChartAxisTransformations;
    ChartAxisTransformations1AutoScaleAxisTransform1: TAutoScaleAxisTransform;
    ohlcSeries: TOpenHighLowCloseSeries;
    ChartToolset1: TChartToolset;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    DS1: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BuQueryClick(Sender: TObject);
    procedure DbChartSource1GetItem(ASender: TDbChartSource;
      var AItem: TChartDataItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
    DBSourceList: TList;
    procedure PrepareChart;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses uDM1;

{ TForm1 }

procedure TForm1.BuQueryClick(Sender: TObject);
begin
  DM1.ShowData1(DateTimePicker1.Date);
  PrepareChart;
end;

procedure TForm1.DbChartSource1GetItem(ASender: TDbChartSource;
  var AItem: TChartDataItem);
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBSourceList := TList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DBSourceList.Free;
end;

procedure TForm1.PrepareChart;
var
  aCS: TDbChartSource;
  ax: integer;
  yOpen, yClose, yHigh, yLow: Double;
  aLabel : string;
begin
  //DBSourceList.Clear;
  ohlcSeries.Clear;
  DM1.QTestDaten.First;
  while not DM1.QTestDaten.EOF do
  begin
    ax := DM1.QTestDaten.FieldByName('Intens').AsInteger;
    yOpen := DM1.QTestDaten.FieldByName('Start').AsDateTime;
    yHigh := yOpen;
    yLow := DM1.QTestDaten.FieldByName('Ende').AsDateTime;
    yClose := yLow;
    aLabel := DateToStr(yOpen);
    ohlcSeries.AddXOHLC(ax, yOpen, yHigh, yLow, yClose, aLabel);
    DM1.QTestDaten.Next;
  end;
  ohlcSeries.Mode := TOHLCMode.mCandleStick;
  // Chart1.LeftAxis.Marks.Source := ohlcSeries.ListSource;
end;

end.

