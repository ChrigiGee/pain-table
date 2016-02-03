unit uanz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, TADbSource, TAGraph, TATools,
  TAIntervalSources, TANavigation, TASeries, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, ComCtrls, Grids, TACustomSource, TAMultiSeries,
  TATransformations, TASources, TAGanttSeries, TACustomSeries, DateTimePicker, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    BuQuery: TButton;
    BuGrid: TButton;
    BuChart: TButton;
    Chart1: TChart;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1DataPointDragTool1: TDataPointDragTool;
    ChartToolset1: TChartToolset;
    DateTimeIntervalChartSource: TDateTimeIntervalChartSource;
    LabelsChartSource: TListChartSource;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    DS1: TDataSource;
    ListChartSource1: TListChartSource;
    PageControl1: TPageControl;
    SG1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure BuChartClick(Sender: TObject);
    procedure BuGridClick(Sender: TObject);
    procedure BuQueryClick(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure DbChartSource1GetItem(ASender: TDbChartSource;
      var AItem: TChartDataItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
    DBSourceList: TList;
    FGanttSeries: TGanttSeries;
    procedure PrepareChart;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses uDM1, TAChartUtils, TALegend;

procedure CopySourceForMarks(ASource: TCustomChartSource; ADest: TListChartSource);
var
  i, j: Integer;
begin
  ADest.BeginUpdate;
  try
    ADest.Clear;
    ADest.YCount := ASource.YCount;
    for i := 0 to ASource.Count - 1 do
      with ASource[i]^ do begin
        j := ADest.Add(X, X, Text, Color);  // use x twice!
        ADest.SetYList(j, YList);
      end;
    if ADest.Sorted and not ASource.IsSorted then ADest.Sort;
  finally
    ADest.EndUpdate;
  end;
end;


{ TForm1 }

procedure TForm1.BuQueryClick(Sender: TObject);
begin
  DM1.ShowData1(DateTimePicker1.Date);
end;

procedure TForm1.ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
  APoint: TPoint);
var
  ser: TChartSeries;
  idx: Integer;
begin
  ser := TChartSeries(TDatapointClickTool(ATool).Series);
  idx := TDataPointClickTool(ATool).PointIndex;
  if ser = nil then exit;
  ShowMessage(Format('Series "%s": Datapoint #%d', [ser.Title, idx]));
end;

procedure TForm1.BuGridClick(Sender: TObject);
var
  i: Integer;
  MyCol : TGridColumn;
begin
  SG1.RowCount:= 12;
//  SG1.ColCount:= 25;
  for i:= 0 to SG1.RowCount-1 do
  begin
    // Beschriftung erzeugen
    SG1.Cells[0,i]:= 'Row' + IntToStr(i);
    SG1.RowHeights[i] := 40;
  end;
  //for i:= 1 to SG1.ColCount-1 do
  //begin
  //  // Beschriftung erzeugen
  //  SG1.Cells[i,0]:= 'Col' + IntToStr(i);
  //end;

  SG1.Columns.Clear;
  for i:= 0 to 25  do
  begin
    MyCol := SG1.Columns.Add;
    MyCol.Width:=20;
    MyCol.Index:=i;
    MyCol.Title.Font.Orientation:=900;
//    MyCol.Title.Font.Color:=clRed;
    MyCol.Title.Layout:=tlBottom;
    MyCol.Title.Caption := 'Col' + IntToStr(i);
  end;

end;

procedure TForm1.BuChartClick(Sender: TObject);
begin
  PrepareChart;
end;

procedure TForm1.DbChartSource1GetItem(ASender: TDbChartSource;
  var AItem: TChartDataItem);
begin
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBSourceList := TList.Create;
  FGanttSeries:=nil;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if FGanttSeries <> nil then
  begin
    FGanttSeries.Clear;
    FGanttSeries.Free;
  end;
  DBSourceList.Free;
end;

procedure TForm1.PrepareChart;
var
  aCS: TDbChartSource;
  ax: integer;
  yOpen, yClose, yHigh, yLow: Double;
  aLabel : string;
begin
  if FGanttSeries <> nil then
  begin
    FGanttSeries.Clear;
    FGanttSeries.Free;
  end;
  FGanttSeries := TGanttSeries.Create(self);
  FGanttSeries.Title := 'Gantt series';
  FGanttSeries.BarBrush.Style := bsHorizontal;
  FGanttSeries.LinkPen.Color := clRed;
  FGanttSeries.LinkPen.Width := 3;
  FGanttSeries.Marks.LinkPen.Visible := false;


  //DBSourceList.Clear;
  DM1.QTestDaten.First;
  while not DM1.QTestDaten.EOF do
  begin
    ax := DM1.QTestDaten.FieldByName('Intens').AsInteger;
    yOpen := DM1.QTestDaten.FieldByName('Start').AsDateTime;
    yLow := DM1.QTestDaten.FieldByName('Ende').AsDateTime;
    aLabel := 'Schmerz ' + IntToStr(ax);
    FGanttSeries.AddGantt(yOpen,yLow, ax, aLabel, clSkyBlue);
    DM1.QTestDaten.Next;
  end;

  // Prepare marks
  FGanttSeries.Marks.Style := smsLabel;
  FGanttSeries.Marks.Visible := false;
  // This allows to show the marks in the legend using lmPoint Multiplicity
  // without showing the marks at the series.

  // Add series to Chart1
  Chart1.AddSeries(FGanttSeries);
  // Axis labels
  // The builtin source does not work with rotated axes --> copy to second ListSource
  // such that x coordinate is used also for y axis.
  CopySourceForMarks(FGanttSeries.ListSource, LabelsChartSource);

  Chart1.LeftAxis.Marks.Style := smsLabel;
  Chart1.LeftAxis.Marks.LabelFont.Orientation := 0;
  Chart1.LeftAxis.Marks.Source := DateTimeIntervalChartSource;
  Chart1.BottomAxis.Marks.Style := smsLabel;
  Chart1.BottomAxis.Marks.Source := LabelsChartSource;

  // Rotate series by 90!  -- see also CbRotatedChange().
  FGanttSeries.AxisIndexX := 0;
  FGanttSeries.AxisIndexY := 1;
  Chart1.LeftAxis.Range.Max:= 11;
  Chart1.LeftAxis.Range.Min:= 0;
  Chart1.LeftAxis.Marks.Source := ListChartSource1;//LabelsChartSource;

  Chart1.BottomAxis.Marks.Source := DateTimeIntervalChartSource;
  Chart1.LeftAxis.Marks.Style := smsLabel;


    // Some properties, could be done in the OI as well
  ChartToolset1DatapointDragTool1.KeepDistance := true;


end;

end.

