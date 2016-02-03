unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Math, TAGraph, TASeries, TAMultiSeries,
  TAIntervalSources, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin, ColorBox, ComCtrls, EditBtn, TAGanttSeries, TACustomSeries, TASources,
  TATools, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnDeleteIndex: TButton;
    Chart: TChart;
    CbYInverted: TCheckBox;
    CbRotated: TCheckBox;
    CbRTL: TCheckBox;
    CbMarks: TCheckBox;
    CbShowGanttInLegend: TCheckBox;
    CbBarBrushStyle: TComboBox;
    CbBarBrushColor: TColorBox;
    CbLegendMultiplicity: TComboBox;
    CbShowLegend: TCheckBox;
    CbGridX: TCheckBox;
    CbGridY: TCheckBox;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1DataPointDragTool1: TDataPointDragTool;
    EdLinkStartBreak: TDateEdit;
    DateTimeIntervalChartSource: TDateTimeIntervalChartSource;
    EdLinkBetwTasksBackward: TFloatSpinEdit;
    EdLinkIndexFrom: TSpinEdit;
    EdLinkIndexTo: TSpinEdit;
    EdLinkBetwTasksForward: TDateEdit;
    EdLinkStartOffset: TFloatSpinEdit;
    EdLinkEndOffset: TFloatSpinEdit;
    EdLinkEndBreak: TDateEdit;
    GbBarBrush: TGroupBox;
    GbLinkEditor: TGroupBox;
    GbLegend: TGroupBox;
    GbGeneral: TGroupBox;
    GbMarks: TGroupBox;
    GroupBox1: TGroupBox;
    GbDeleteLink: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelsChartSource: TListChartSource;
    SidePanel: TPanel;
    EdDeleteIndex: TSpinEdit;
    EdLinkLineWidth: TSpinEdit;
    EdBreakDistance: TSpinEdit;
    procedure BtnDeleteIndexClick(Sender: TObject);
    procedure CbBarBrushColorChange(Sender: TObject);
    procedure CbBarBrushStyleChange(Sender: TObject);
    procedure CbGridXChange(Sender: TObject);
    procedure CbGridYChange(Sender: TObject);
    procedure CbMarksChange(Sender: TObject);
    procedure CbRotatedChange(Sender: TObject);
    procedure CbRTLChange(Sender: TObject);
    procedure CbShowGanttInLegendChange(Sender: TObject);
    procedure CbShowLegendChange(Sender: TObject);
    procedure CbYInvertedChange(Sender: TObject);
    procedure CbLegendMultiplicityChange(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure EdBreakDistanceChange(Sender: TObject);
    procedure EdLinkBetwTasksForwardAcceptDate(Sender: TObject;
      var ADate: TDateTime; var AcceptDate: Boolean);
    procedure EdLinkBetwTasksForwardButtonClick(Sender: TObject);
    procedure EdLinkBetwTasksForwardEditingDone(Sender: TObject);
    procedure EdLinkEndBreakAcceptDate(Sender: TObject; var ADate: TDateTime;
      var AcceptDate: Boolean);
    procedure EdLinkEndBreakButtonClick(Sender: TObject);
    procedure EdLinkEndBreakEditingDone(Sender: TObject);
    procedure EdLinkStartBreakAcceptDate(Sender: TObject; var ADate: TDateTime;
      var AcceptDate: Boolean);
    procedure EdLinkStartBreakButtonClick(Sender: TObject);
    procedure EdLinkStartBreakEditingDone(Sender: TObject);
    procedure EdLinkBetwTasksBackwardChange(Sender: TObject);
    procedure EdLinkEndOffsetChange(Sender: TObject);
    procedure EdLinkIndexFromChange(Sender: TObject);
    procedure EdLinkIndexToChange(Sender: TObject);
    procedure EdLinkLineWidthChange(Sender: TObject);
    procedure EdLinkStartOffsetChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    FGanttSeries: TGanttSeries;
    FLinkIndex: Integer;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  TACustomSource, TAChartUtils, TALegend;

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

procedure TForm1.BtnDeleteIndexClick(Sender: TObject);
begin
  if InRange(EdDeleteIndex.Value, 0, FGanttSeries.Count-1) then
    FGanttSeries.Delete(EdDeleteIndex.Value);
end;

procedure TForm1.CbBarBrushColorChange(Sender: TObject);
begin
  FGanttSeries.BarBrush.Color := CbBarbrushColor.Selected;
end;

procedure TForm1.CbBarBrushStyleChange(Sender: TObject);
begin
  FGanttSeries.BarBrush.Style := TBrushStyle(CbBarBrushStyle.ItemIndex);
end;

procedure TForm1.CbGridXChange(Sender: TObject);
begin
  Chart.BottomAxis.Grid.Visible := CbGridX.Checked;
end;

procedure TForm1.CbGridYChange(Sender: TObject);
begin
  Chart.LeftAxis.Grid.Visible := CbGridY.Checked;
end;

procedure TForm1.CbLegendMultiplicityChange(Sender: TObject);
begin
  FGanttSeries.Legend.Multiplicity := TLegendMultiplicity(CbLegendMultiplicity.ItemIndex);
end;

procedure TForm1.CbMarksChange(Sender: TObject);
begin
  FGanttSeries.Marks.Visible := CbMarks.Checked;
end;

procedure TForm1.CbRotatedChange(Sender: TObject);
begin
  if CbRotated.Checked then
  begin
    FGanttSeries.AxisIndexX := 0;
    FGanttSeries.AxisIndexY := 1;
    Chart.BottomAxis.Marks.Source := DateTimeIntervalChartSource;
    Chart.LeftAxis.Marks.Source := LabelsChartSource;
  end else
  begin
    FGanttSeries.AxisIndexX := 1;
    FGanttSeries.AxisIndexY := 0;
    Chart.LeftAxis.Marks.Source := DateTimeIntervalChartSource;
    Chart.BottomAxis.Marks.Source := LabelsChartSource;
  end;
end;

procedure TForm1.CbRTLChange(Sender: TObject);
begin
  if CbRTL.Checked then
    Chart.BiDiMode := bdRightToLeft
  else
    Chart.BiDiMode := bdLeftToRight;
end;

procedure TForm1.CbShowGanttInLegendChange(Sender: TObject);
begin
  FGanttSeries.ShowInLegend := CbShowGanttInLegend.Checked;
end;

procedure TForm1.CbShowLegendChange(Sender: TObject);
begin
  Chart.Legend.Visible := CbShowLegend.Checked;
end;

procedure TForm1.CbYInvertedChange(Sender: TObject);
begin
  Chart.LeftAxis.Inverted := CbYInverted.Checked;
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

procedure TForm1.EdBreakDistanceChange(Sender: TObject);
begin
  FGanttSeries.BreakDistance := EdBreakDistance.Value;
end;

procedure TForm1.EdLinkEndBreakAcceptDate(Sender: TObject; var ADate: TDateTime;
  var AcceptDate: Boolean);
begin
  FGanttSeries.Links[FLinkIndex].EndBreak := ADate;
end;

procedure TForm1.EdLinkEndBreakButtonClick(Sender: TObject);
begin
  if EdLinkEndBreak.Text = '' then
    EdLinkEndBreak.Date := FGanttSeries.StartValue[FGanttSeries.Links[FLinkIndex].IndexTo];
end;

procedure TForm1.EdLinkEndBreakEditingDone(Sender: TObject);
begin
  if EdLinkStartBreak.Text = '' then
    FGanttSeries.Links[FLinkIndex].EndBreak := NaN else
    FGanttSeries.Links[FLinkIndex].EndBreak := StrToDate(EdLinkEndBreak.Text);
end;

procedure TForm1.EdLinkStartBreakButtonClick(Sender: TObject);
begin
  if EdLinkStartBreak.Text = '' then
    EdLinkStartBreak.Date := FGanttSeries.EndValue[FGanttSeries.Links[FLinkIndex].IndexFrom];
end;

procedure TForm1.EdLinkStartBreakEditingDone(Sender: TObject);
begin
  if EdLinkStartBreak.Text = '' then
    FGanttSeries.Links[FLinkIndex].StartBreak := NaN else
    FGanttSeries.Links[FLinkIndex].StartBreak := StrToDate(EdLinkStartBreak.Text);
end;

procedure TForm1.EdLinkBetwTasksBackwardChange(Sender: TObject);
begin
  FGanttSeries.Links[FLinkIndex].BetweenTaskValueBack := EdLinkBetwTasksBackward.Value;
end;

procedure TForm1.EdLinkBetwTasksForwardAcceptDate(Sender: TObject;
  var ADate: TDateTime; var AcceptDate: Boolean);
begin
  FGanttSeries.Links[FLinkIndex].BetweenTaskValueFore := ADate;
end;

procedure TForm1.EdLinkBetwTasksForwardButtonClick(Sender: TObject);
begin
  if EdLinkBetwTasksForward.Text = '' then
    EdLinkBetwTasksForward.Date := (
      FGanttSeries.EndValue[FGanttSeries.links[FLinkIndex].IndexFrom] +
      FGanttSeries.StartValue[FGanttSeries.Links[FLinkIndex].IndexTo] ) / 2;
end;

procedure TForm1.EdLinkBetwTasksForwardEditingDone(Sender: TObject);
begin
  if EdLinkBetwTasksForward.Text = '' then
    FGanttSeries.Links[FLinkIndex].BetweenTaskValueFore := NaN else
    FGanttSeries.Links[FLinkIndex].BetweenTaskValueFore := StrToDate(EdLinkBetwTasksForward.Text);
end;

procedure TForm1.EdLinkEndOffsetChange(Sender: TObject);
begin
  FGanttSeries.Links[FLinkIndex].EndOffset := EdLinkEndOffset.Value;
end;

procedure TForm1.EdLinkIndexFromChange(Sender: TObject);
begin
  FGanttSeries.Links[FLinkIndex].IndexFrom := EdLinkIndexFrom.Value;
end;

procedure TForm1.EdLinkIndexToChange(Sender: TObject);
begin
  FGanttSeries.Links[FLinkIndex].IndexTo := EdLinkIndexTo.Value;
end;

procedure TForm1.EdLinkLineWidthChange(Sender: TObject);
begin
  FGanttSeries.Links[FLinkIndex].PenWidth := EdLinkLineWidth.Value;
end;

procedure TForm1.EdLinkStartOffsetChange(Sender: TObject);
begin
  FGanttSeries.Links[FLinkIndex].StartOffset := EdLinkStartOffset.Value;
end;

procedure TForm1.EdLinkStartBreakAcceptDate(Sender: TObject; var ADate: TDateTime;
  var AcceptDate: Boolean);
begin
  FGanttSeries.Links[FLinkIndex].StartBreak := ADate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  d: TDate;
  i: Integer;
  i1, i2, i3, i4, i5, i6, i7: Integer;
  c1, c2, c3: Integer;
begin
  // Create the series and set some properties
  FGanttSeries := TGanttSeries.Create(self);

  FGanttSeries.Title := 'Gantt series';
  FGanttSeries.BarBrush.Style := bsHorizontal;
  FGanttSeries.LinkPen.Color := clRed;
  FGanttSeries.LinkPen.Width := 3;
  FGanttSeries.Marks.LinkPen.Visible := false;

  d := date();

  // ------------- Add Gantt bars ----------------

  // Specify only background color
  i1 := FGanttSeries.AddGantt(d,    d+5, 0, 'Planung', clSkyBlue);
  // Specify background color, pattern and pattern color
  i2 := FGanttSeries.AddGantt(d+12, d+15, 1, 'Phase 1', clYellow, bsDiagCross, clBlue);
  // Missing pattern color --> use BarBrush.Color
  i3 := FGanttSeries.AddGantt(d+5,  d+20, 2, 'Prüfung', clBlue, bsCross);
  // Missing pattern color --> if solid fill, use background color
  i4 := FGanttSeries.AddGantt(d+15, d+20, 3, 'Phase 2', clGreen, bsSolid);
  // Missing background color (clTAColor) --> use BarBrush.Color
  i5 := FGanttSeries.AddGantt(d+25, d+40, 4, 'Phase 3', clTAColor, bsSolid);
  // Missing background color, no fill --> draw only border of bar
  i6 := FGanttSeries.AddGantt(d+42, d+45, 5, 'Phase 4', clTAColor, bsClear);
  // No color --> use BarBrush
  i7 := FGanttSeries.AddGantt(d+46, d+50, 6, 'Abschluss');

  // -------------- Add Gantt links --------------

  FGanttSeries.AddLink(i1, i2);   // Use default connector pen
  FGanttSeries.AddLink(i2, i3);
  FGanttSeries.AddLink(i3, i4);
  FGanttSeries.AddLink(i4, i5);
  FGanttSeries.AddLink(i5, i6);
  FGanttSeries.AddLink(i6, i7);
  FGanttSeries.AddLink(i7, 100);   // non-existing index

  // Use custom pens and paths for some link lines
  c2 := FGanttSeries.AddLink(i2, i4, clBlue, psSolid, 3);
  FGanttSeries.Links[c2].StartBreak := FGanttSeries.EndValue[i2] + 7.5;
  FGanttSeries.Links[c2].EndBreak := FGanttSeries.StartValue[i4] - 1;
  FGanttSeries.Links[c2].BetweenTaskValueBack := 2.6;

  // This link can be modified in the gui
  FLinkIndex := FGanttSeries.AddLink(i2, i6, clGreen, psSolid, 3);
  FGanttSeries.Links[FLinkIndex].BetweenTaskValueFore := FGanttSeries.EndValue[i2] + 9;

  // Prepare marks
  FGanttSeries.Marks.Style := smsLabel;
  FGanttSeries.Marks.Visible := false;
  // This allows to show the marks in the legend using lmPoint Multiplicity
  // without showing the marks at the series.

  // Add series to chart
  Chart.AddSeries(FGanttSeries);

  // Axis labels
  // The builtin source does not work with rotated axes --> copy to second ListSource
  // such that x coordinate is used also for y axis.
  CopySourceForMarks(FGanttSeries.ListSource, LabelsChartSource);

  Chart.LeftAxis.Marks.Style := smsLabel;
  Chart.LeftAxis.Marks.LabelFont.Orientation := 0;
  Chart.LeftAxis.Marks.Source := DateTimeIntervalChartSource;
  Chart.BottomAxis.Marks.Style := smsLabel;
  Chart.BottomAxis.Marks.Source := LabelsChartSource;

  // Rotate series by 90!  -- see also CbRotatedChange().
  FGanttSeries.AxisIndexX := 0;
  FGanttSeries.AxisIndexY := 1;
  Chart.LeftAxis.Marks.Source := LabelsChartSource;
  Chart.BottomAxis.Marks.Source := DateTimeIntervalChartSource;
  Chart.LeftAxis.Marks.Style := smsLabel;

  // Adapt controls to show the series properties
  CbShowLegend.Checked := Chart.Legend.Visible;
  CbShowGanttInLegend.Checked := FGanttSeries.Legend.Visible;
  CbBarBrushColor.Selected := FGanttSeries.BarBrush.Color;
  CbBarBrushStyle.ItemIndex := ord(FGanttSeries.Barbrush.Style);
  EdLinkLineWidth.Value := FGanttSeries.Links[FLinkIndex].PenWidth;
  EdLinkIndexFrom.Value := FGanttSeries.Links[FLinkIndex].IndexFrom;
  EdLinkIndexTo.Value := FGanttSeries.Links[FLinkIndex].IndexTo;
  EdLinkBetwTasksBackward.Value := FGanttSeries.Links[FLinkIndex].BetweenTaskValueBack;
  if IsNaN(FGanttSeries.Links[FLinkIndex].BetweenTaskValueFore) then
    EdLinkBetwTasksForward.Text := '' else
    EdLinkBetwTasksForward.Text := FormatDateTime('dd/mm', FGanttSeries.Links[FLinkIndex].BetweenTaskValueFore);
  if IsNaN(FGanttSeries.Links[FLinkIndex].StartBreak) then
    EdLinkStartBreak.Text := '' else
    EdLinkStartBreak.Text := FormatDateTime('dd/mm' ,FGanttSeries.Links[FLinkIndex].StartBreak);
  if IsNaN(FGanttSeries.Links[FLinkIndex].EndBreak) then
    EdLinkEndBreak.Text := '' else
    EdLinkEndBreak.Text := FormatDateTime('dd/mm', FGanttSeries.Links[FLinkIndex].EndBreak);
  EdBreakDistance.Value := FGanttSeries.BreakDistance;

  // Some properties, could be done in the OI as well
  ChartToolset1DatapointDragTool1.KeepDistance := true;
end;

end.

