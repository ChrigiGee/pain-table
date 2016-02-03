unit TAGanttSeries;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Types, Math, fgl,
  TAChartUtils, TADrawUtils, TACustomSource, TASources, TACustomSeries,
  TALegend;

type
  EGanttError = class(EChartError);

  { TGanttLink - a connecting line between two bars

        FORWARD CONNECTION                 BACKWARD CONNECTION
        ------------------                 -------------------

           ^       +--------+               +--------+
   EndOffs |  +-->>| task 2 |          *-->>| task 2 |
           v  |    +--------+          |    +--------+    ^
              |                     <--|-->  endbreak     | y
           <--+--> x                   +------------------|------+
              |                                           v   <--|-->  startbreak
  +--------+  |    ^                                 +--------+  |
  | task 1 |--+    | StartOffset                     | task 1 |--+
  +--------+       v                                 +--------+

  Drawn for horizontal bar orientation. In case of vertical bar orientation,
  the quantities having an x name refer to the y coordinate, and vice versa.
  }
  TGanttLink = class
  private
    FIndexFrom: Integer;
    FIndexTo: Integer;
    FPenStyle: TPenStyle;
    FPenWidth: Integer;
    FPenColor: TColor;
    FStartBreak: Double;             // see "startbreak", backward only
    FEndBreak: Double;               // see "endbreak", backward only
    FBetweenTaskValueBack: Double;   // see "y", backward only
    FBetweenTaskValueFore: Double;   // see "x", forward only
    FStartOffset: Double;
    FEndOffset: Double;
    FOnChange: TNotifyEvent;
    procedure SetBetweenTaskValueBack(AValue: Double);
    procedure SetBetweenTaskValueFore(AValue: Double);
    procedure SetEndBreak(AValue: Double);
    procedure SetEndOffset(AValue: Double);
    procedure SetIndexFrom(AValue: Integer);
    procedure SetIndexTo(AValue: Integer);
    procedure SetPenColor(AValue: TColor);
    procedure SetPenStyle(AValue: TPenStyle);
    procedure SetPenWidth(AValue: Integer);
    procedure SetStartBreak(AValue: Double);
    procedure SetStartOffset(AValue: Double);
  protected
    procedure Changed;
  public
    constructor Create;
    property IndexFrom: Integer read FIndexFrom write SetIndexFrom;
    property IndexTo: Integer read FIndexTo write SetIndexTo;
    property PenColor: TColor read FPenColor write SetPenColor;
    property PenStyle: TPenStyle read FPenstyle write SetPenStyle;
    property PenWidth: Integer read FPenWidth write SetPenWidth;
    property BetweenTaskValueBack: Double read FBetweenTaskValueBack write SetBetweenTaskValueBack;
    property BetweenTaskValueFore: Double read FBetweenTaskValueFore write SetBetweenTaskValueFore;
    property StartBreak: Double read FStartBreak write SetStartBreak;
    property StartOffset: Double read FStartOffset write SetStartOffset;
    property EndBreak: Double read FEndBreak write SetEndBreak;
    property EndOffset: double read FEndOffset write SetEndOffset;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGanttLinkList = specialize TFPGObjectList<TGanttLink>;

  TGanttBrushList = specialize TFPGObjectlist<TBrush>;

  TGanttSeries = class(TBasicPointSeries)
  private
    FBarBrush: TBrush;
    FRelativeBarWidth: Double;
    FBarPen: TPen;
    FLinkPen: TPen;
    FBreakDistance: Double;
    FLinks: TGanttLinkList;
    FBrushList: TGanttBrushList;
    function GetBarImageRect(AIndex: Integer): TRect;
    function GetBarWidthPercent: Integer;
    function GetBreakDistance: Integer;
    function GetLinks(AIndex: Integer): TGanttLink;
    procedure SetBarBrush(AValue: TBrush);
    procedure SetBarWidthPercent(AValue: Integer);
    procedure SetBarPen(AValue: TPen);
    procedure SetBreakDistance(AValue: Integer);
    procedure SetLinkPen(AValue: TPen);
    procedure SetLinks(AIndex: Integer; AValue: TGanttLink);
    procedure SetSeriesColor(AValue: TColor);

  protected
    FMinTaskCounterRange: Double;
    function GetLabelDataPoint(AIndex: Integer): TDoublePoint; override;
    procedure GetLegendItems(AItems: TChartLegendItems); override;
    function GetSeriesColor: TColor; override;
    function MaybeRotate(AX, AY: Double): TPoint;
    procedure UpdateMinTaskCounterRange;
    function ValidLink(AIndex: Integer): Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddGantt(AStart, AEnd, ATaskIndex: Double; ATaskName: String;
      AColor: TColor = clTAColor; ABrushStyle: TBrushStyle = bsSolid;
      ABrushPattColor: TColor = clTAColor): Integer;
    function AddXY(AX, AY: Double; AXLabel: String = '';
      AColor: TColor = clTAColor): Integer; overload;
    function AddXY(AX, AY: Double; const AYList: array of Double;
      AXLabel: String = ''; AColor: TColor = clTAColor): Integer; overload;
    function AddY(AY: Double; ALabel: String = '';
      AColor: TColor = clTAColor): Integer; overload;
    function AddLink(ABarIndexFrom, ABarIndexTo: Integer;
      APenColor: TColor = clTAColor;
      APenStyle: TPenStyle = psSolid; APenWidth: Integer = 1): Integer;

  public
    procedure Assign(ASource: TPersistent); override;
    procedure Clear; override;
    procedure Delete(AIndex: Integer); override;
    procedure Draw(ADrawer: IChartDrawer); override;

    function Extent: TDoubleRect; override;
    function GetStartValue(AIndex: Integer): Double; inline;
    function GetEndValue(AIndex: Integer): Double; inline;
    function GetNearestPoint(const AParams: TNearestPointParams;
      out AResults: TNearestPointResults): Boolean; override;
//    function IsRotated: Boolean;

    procedure DeleteLink(AIndex: Integer);

    property Links[AIndex: Integer]: TGanttLink
      read GetLinks write SetLinks;
    property StartValue[AIndex: Integer]: Double
      read GetStartValue;
    property EndValue[AIndex: Integer]: Double
      read GetEndValue;

  published
    property BarBrush: TBrush
      read FBarBrush write SetBarBrush;
    property BarWidthPercent: Integer
      read GetBarWidthPercent write SetBarWidthPercent default 50;
    property BarPen: TPen
      read FBarPen write SetBarPen;
    property BreakDistance: Integer
      read GetBreakDistance write SetBreakDistance default 20;  // permille of extent
    property LinkPen: TPen
      read FLinkPen write SetLinkPen;
    property SeriesColor: TColor
      read GetSeriesColor write SetSeriesColor stored false default clRed;

    // inherited
    property AxisIndexX;
    property AxisIndexY;
    property Depth;
    property MarkPositions;
    property Source;
    property Styles;
  end;


implementation

uses
  FPCanvas, TAMath, TAGeometry;

{ This has been moved to TAMath }
function SafeEqual(A, B: Double): Boolean;
var
  ANaN, BNaN: Boolean;
begin
  ANaN := IsNaN(A);
  BNaN := IsNaN(B);
  if ANaN and BNaN then
    Result := true
  else if ANaN or BNaN then
    Result := false
  else
    Result := A = B;
end;


{ TGanttLink }

constructor TGanttLink.Create;
begin
  FIndexFrom := -1;
  FIndexTo := -1;
  FStartBreak := NaN;
  FEndBreak := NaN;
  FStartOffset := 0.0;
  FEndOffset := 0.0;
  FBetweenTaskValueBack := NaN;
  FBetweenTaskValueFore := NaN;
  FPenColor := clTAColor;
  FPenStyle := psSolid;
  FPenWidth := 1;
end;

procedure TGanttLink.Changed;
begin
  if Assigned(FOnChange) then FOnChange(self);
end;

procedure TGanttLink.SetBetweenTaskValueFore(AValue: Double);
begin
  if SafeEqual(AValue, FBetweenTaskValueFore) then exit;
  FBetweenTaskValueFore := AValue;
  Changed;
end;

procedure TGanttLink.SetBetweenTaskValueBack(AValue: Double);
begin
  if SafeEqual(AValue, FBetweenTaskValueBack) then exit;
  FBetweenTaskValueBack := AValue;
  Changed;
end;

procedure TGanttLink.SetEndBreak(AValue: Double);
begin
  if SafeEqual(AValue, FEndBreak) then exit;
  FEndBreak := AValue;
  Changed;
end;

procedure TGanttLink.SetEndOffset(AValue: Double);
begin
  if SafeEqual(AValue, FEndOffset) then exit;
  FEndOffset := AValue;
  Changed;
end;

procedure TGanttLink.SetIndexFrom(AValue: Integer);
begin
  if AValue = FIndexFrom then
    exit;
  FIndexFrom := AValue;
  Changed;
end;

procedure TGanttLink.SetIndexTo(AValue: Integer);
begin
  if AValue = FIndexTo then
    exit;
  FIndexTo := AValue;
  Changed;
end;

procedure TGanttLink.SetPenColor(AValue: TColor);
begin
  if AValue = FPenColor then
    exit;
  FPenColor := AValue;
  Changed;
end;

procedure TGanttLink.SetPenStyle(AValue: TPenStyle);
begin
  if AValue = FPenStyle then
    exit;
  FPenStyle := AValue;
  Changed;
end;

procedure TGanttLink.SetPenWidth(AValue: Integer);
begin
  if AValue = FPenWidth then
    exit;
  FPenWidth := AValue;
  Changed;
end;

procedure TGanttLink.SetStartBreak(AValue: Double);
begin
  if SafeEqual(AValue, FStartBreak) then exit;
  FStartBreak := AValue;
  Changed;
end;

procedure TGanttLink.SetStartOffset(AValue: Double);
begin
  if SafeEqual(AValue, FStartOffset) then exit;
  FStartOffset := AValue;
  Changed;
end;


{ TGanttLegendItemBrushRect }

type
  TGanttLegendItemBrushRect = class(TLegendItem)
  private
    FBrush: TFPCustomBrush;
    FPattColor: TColor;
    FBrushStyle: TBrushStyle;
  public
    constructor Create(ABrush: TFPCustomBrush; ABkColor, APattColor: TColor;
      AStyle: TBrushStyle; const AText: String);
    procedure Draw(ADrawer: IChartDrawer; const ARect: TRect); override;
  end;

constructor TGanttLegendItemBrushRect.Create(ABrush: TFPCustomBrush;
  ABkColor, APattColor: TColor; AStyle: TBrushStyle; const AText: String);
begin
  inherited Create(AText);
  Color := ABkColor;
  FBrush := ABrush;
  FPattColor := APattColor;
  FBrushStyle := AStyle;
end;

procedure TGanttLegendItemBrushRect.Draw(ADrawer: IChartDrawer; const ARect: TRect);
begin
  inherited Draw(ADrawer, ARect);
  if Color = clTAColor then begin
    if FBrushStyle = bsClear then
      ADrawer.SetBrushParams(bsClear, clTAColor)
    else
      ADrawer.Brush := FBrush as TBrush;
  end else
  if (FBrushStyle = bsSolid) then begin
    if FPattColor <> clTAColor then
      ADrawer.SetBrushParams(bsSolid, FPattColor) else
      ADrawer.SetBrushParams(bsSolid, Color);
  end else begin
    ADrawer.SetBrushParams(bsSolid, Color);
    ADrawer.FillRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    if FPattColor <> clTAColor then
      ADrawer.SetBrushParams(FBrushStyle, FPattColor) else
      ADrawer.SetBrushParams(FBrushStyle, FPColorToTColor(FBrush.FPColor));
  end;
  ADrawer.Rectangle(ARect);
end;


{ TGanttSeries }

constructor TGanttSeries.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLinks := TGanttLinkList.Create;
  FBrushList := TGanttBrushList.Create;

  FBarBrush := TBrush.Create;
  FBarBrush.OnChange := @StyleChanged;
  FBarBrush.Color := clRed;

  FBarPen := TPen.Create;
  FBarPen.OnChange := @StyleChanged;
  FBarPen.Color := clBlack;

  FLinkPen := TPen.Create;
  FLinkPen.OnChange := @StyleChanged;
  FLinkPen.Color := clBlack;

  FBreakDistance := 0.02;      // fraction of extent
  FRelativeBarWidth := 0.5;   // i.e.: 50%
end;

destructor TGanttSeries.Destroy;
begin
  FreeAndNil(FLinkPen);
  FreeAndNil(FBarPen);
  FreeAndNil(FBarBrush);
  FreeAndNil(FBrushList);
  FreeAndNil(FLinks);
  inherited Destroy;
end;

function TGanttSeries.AddGantt(AStart, AEnd, ATaskIndex: Double;
  ATaskName: String; AColor: TColor = clTAColor; ABrushStyle: TBrushStyle = bsSolid;
  ABrushPattColor: TColor = clTAColor): Integer;
var
  lBrush: TBrush;
begin
  if ListSource.YCount < 2 then ListSource.YCount := 2;
  Result := inherited AddXY(ATaskIndex, AStart, [AEnd-AStart], ATaskName, AColor);
  // NOTE: TAChart calculates the Extent in a cumulative way, i.e. adds all y values.
  // Therefore, we must only store in YList[0] the difference to the main y value.

  lBrush := TBrush.Create;
  lBrush.Style := ABrushStyle;
  lBrush.Color := ABrushPattColor;;
  // background color is stored in chartsource
  FBrushList.Add(lBrush);
end;

function TGanttSeries.AddLink(ABarIndexFrom, ABarIndexTo: Integer;
  APenColor: TColor = clTAColor; APenStyle: TPenStyle = psSolid;
  APenWidth: Integer = 1): Integer;
var
  link: TGanttLink;
  yback: Double;
begin
  link := TGanttLink.Create;
  link.FIndexFrom := ABarIndexFrom;
  link.FIndexTo := ABarIndexTo;
  link.FPenStyle := APenStyle;
  link.FPenColor := APenColor;
  link.FPenWidth := APenWidth;
  yback := (ABarIndexTo + ABarIndexFrom) / 2;
  link.FBetweenTaskValueBack := IfThen(Odd(ABarIndexTo - ABarIndexFrom), yback, yback - 0.5);
  link.OnChange := @StyleChanged;

  Result := FLinks.Add(link);
end;

function TGanttSeries.AddXY(AX, AY: Double; AXLabel: String = '';
  AColor: TColor = clTAColor): Integer;
begin
  Unused(AX, AY);
  Unused(AXLabel, AColor);
  raise Exception.Create('TAGanttSeries requires two y values');
end;

function TGanttSeries.AddXY(AX, AY: Double; const AYList: array of Double;
  AXLabel: String = ''; AColor: TColor = clTAColor): Integer;
begin
  if Length(AYList) <> 2 then
    raise Exception.Create('TAGanttSeries requires two y values');
  Result := AddGantt(AY, AYList[0], AX, AXLabel, AColor);
end;

function TGanttSeries.AddY(AY: Double; ALabel: String = '';
  AColor: TColor = clTAColor): Integer;
begin
  Unused(AY);
  Unused(ALabel, AColor);
  raise Exception.Create('TAGanttSeries requires two y values');
end;

procedure TGanttSeries.Assign(ASource: TPersistent);
var
  ser: TGanttSeries;
begin
  if ASource is TGanttSeries then
  begin
    ser := TGanttSeries(ASource);
    Self.BarBrush.Assign(ser.BarBrush);
    Self.BarPen.Assign(ser.BarPen);
    Self.BarWidthPercent := ser.BarWidthPercent;
    Self.LinkPen.Assign(ser.LinkPen);
    // to do: assign the new lists!
  end;
  inherited Assign(ASource);
end;

procedure TGanttSeries.Clear;
begin
  FLinks.Clear;
  FBrushList.Clear;
  inherited;
end;

procedure TGanttSeries.Delete(AIndex: Integer);
var
  i: Integer;
begin
  // Delete the connector which uses this index
  for i:= FLinks.Count-1 downto 0 do
    if (FLinks[i].FIndexFrom = AIndex) or (FLinks[i].FIndexTo = AIndex)
    then
      FLinks.Delete(i);

  // Adapt indexes of the remaining connectors
  for i := 0 to FLinks.Count-1 do begin
    if FLinks[i].FIndexFrom > AIndex then dec(FLinks[i].FIndexFrom);
    if FLinks[i].FIndexTo > AIndex then dec(FLinks[i].FIndexTo);
  end;

  // Delete brush and data point having this index
  FBrushList.Delete(AIndex);
  inherited Delete(AIndex);
end;

procedure TGanttSeries.DeleteLink(AIndex: Integer);
begin
  if ValidLink(AIndex) then FLinks.Delete(AIndex);
end;

procedure TGanttSeries.Draw(ADrawer: IChartDrawer);

  procedure DrawBar(ARect: TRect; ABkColor, APatternColor: TColor;
    AStyle: TBrushStyle);
  begin
    if ABkColor = clTAColor then begin
      if AStyle = bsClear then
        ADrawer.SetBrushParams(bsClear, clTAColor)
      else
        ADrawer.Brush := FBarBrush
    end else
    if (AStyle = bsSolid) then begin
      if APatternColor <> clTAColor then
        ADrawer.SetBrushParams(bsSolid, APatternColor) else
        ADrawer.SetBrushParams(bsSolid, ABkColor);
    end else begin
      ADrawer.SetBrushParams(bsSolid, ABkColor);
      ADrawer.FillRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      if APatternColor <> clTAColor then
        ADrawer.SetBrushParams(AStyle, APatternColor) else
        ADrawer.SetBrushParams(AStyle, FBarBrush.Color);
    end;
    ADrawer.Rectangle(ARect);
  end;

  procedure DrawLink(xstart, ystart, xend, yend, dxstart, dxend,
    xedge, yedge, yedgestart, yedgeend: Double);
  var
    Pstart, Pend: TPoint;
    P: Array of TPoint;
  begin
    Pstart := MaybeRotate(xstart+dxstart, ystart);
    Pend := MaybeRotate(xend+dxend, yend);
    if xstart = xend then
      ADrawer.Line(PStart, PEnd)
    else
    if (ystart < yend) then begin                      {                |   |        }
      SetLength(P, 4);                                 {                +---+ yend   }
      P[0] := Pstart;                                  {        xstart    |          }
      P[1] := MaybeRotate(xstart+dxstart, yedge);      {          + ------+  yedge   }
      P[2] := MaybeRotate(xend+dxend, yedge);          {          |     xend         }
      P[3] := Pend;                                    { ystart +---+                }
      ADrawer.Polyline(P, 0, 4);                       {        |   |                }
    end else begin
      SetLength(P, 6);
      P[0] := Pstart;                                  {                                }
      P[1] := MaybeRotate(xstart+dxstart, yedgestart); { yedgestart  +----+             }
      P[2] := MaybeRotate(xedge, yedgestart);          {             |    |  +---+      }
      P[3] := MaybeRotate(xedge, yedgeend);            {           +---+  |  |   |      }
      P[4] := MaybeRotate(xend+dxend, yedgeend);       {           |   |  |  |   |      }
      P[5] := Pend;                                    {           |   |  |  +---+      }
      ADrawer.PolyLine(P, 0, 6);                       {           +---+  |    |        }
    end;                                               {                  +----+  yedgeend }
  end;                                                 {                xedge           }

var
  i: Integer;
  xstart, xend, xedge: Double;
  ystart, yend: Double;
  yedge, yedgestart, yedgeend: Double;
  dxstart, dxend: Double;
  dist: Double;
  bs: TBrushStyle;
  bkclr, pattclr, penclr: TColor;
  istart, iend: Integer;
  pen: TPen;
  ext: TDoubleRect;
  R: TRect;
begin
  if IsEmpty then exit;

  ext := ParentChart.CurrentExtent;
  dist := IfThen(IsRotated, ext.b.x-ext.a.x, ext.b.y-ext.a.y) * FBreakDistance;

  // Draw link lines
  pen := TPen.Create;
  try
    for i:=0 to FLinks.Count-1 do begin
      istart := FLinks[i].FIndexFrom;
      iend := FLinks[i].FIndexTo;
      if not (InRange(istart, 0, Source.Count-1) and InRange(iend, 0, Source.Count-1)) then
        continue;
      xstart := AxisToGraphX(Source[istart]^.X);
      xend := AxisToGraphX(Source[iend]^.X);
      ystart := AxisToGraphY(GetEndValue(istart));
      yend := AxisToGraphY(GetStartValue(iend));
      penclr := FLinks[i].FPenColor;
      pen.Color := IfThen(penclr <> clTAColor, penclr, FLinkPen.Color);
      pen.Style := FLinks[i].PenStyle;
      pen.Width := FLinks[i].PenWidth;
      xedge := FLinks[i].BetweenTaskValueBack;
      if IsNaN(FLinks[i].BetweenTaskValueFore) then
        yedge := (ystart + yend) / 2 else
        yedge := FLinks[i].BetweenTaskValueFore;
      if IsNaN(FLinks[i].StartBreak) then
        yedgestart := ystart + dist else
        yedgestart := FLinks[i].StartBreak;
      if IsNaN(FLinks[i].EndBreak) then
        yedgeend := yend - dist else
        yedgeend := FLinks[i].EndBreak;
      dxstart := FLinks[i].FStartOffset;
      dxend := FLinks[i].FEndOffset;
      ADrawer.Pen := pen;
      DrawLink(xstart, ystart, xend, yend, dxstart, dxend,
        xedge, yedge, yedgestart, yedgeend);
    end;
  finally
    pen.Free;
  end;

  // Draw bars
  ADrawer.Pen := FBarPen;
  for i:=0 to Count-1 do begin
    R := GetBarImageRect(i);
    bs := FBrushList[i].Style;
    pattclr := FBrushList[i].Color;
    bkclr := Source[i]^.Color;
    DrawBar(R, bkclr, pattclr, bs);
  end;

  // Draw marks
  DrawLabels(ADrawer);
end;

{ Provide space for the cut-off halves of the first and last bar widths }
function TGanttSeries.Extent: TDoubleRect;
var
  i: Integer;
  delta: Double;
begin
  UpdateMinTaskCounterRange;
  delta := FMinTaskCounterRange * FRelativeBarWidth * 0.5;
  Result := inherited Extent;
  // Extent is not rotated: values on y, tasks on x
  result.a.x := Result.a.x - delta;
  result.b.x := Result.b.x + delta;
end;

function TGanttSeries.GetBarImageRect(AIndex: Integer): TRect;
var
  ystart, yend, x1, x2: Double;
  barwid: Double;
begin
  barwid := FRelativeBarWidth * 0.5;
  ystart := AxisToGraphY(GetStartValue(AIndex));
  yend := AxisToGraphY(GetEndValue(AIndex));
  x1 := AxisToGraphX(Source[AIndex]^.X - barwid);
  x2 := AxisToGraphX(Source[AIndex]^.X + barwid);
  Result.TopLeft := MaybeRotate(x1, ystart);
  Result.BottomRight := MaybeRotate(x2, yend);
  NormalizeRect(Result);
end;

function TGanttSeries.GetBarWidthPercent: Integer;
begin
  Result := round(FRelativeBarWidth * 100.0);
end;

function TGanttSeries.GetBreakDistance: Integer;
begin
  Result := Round(FBreakDistance * 1000);
end;

function TGanttSeries.GetLinks(AIndex: Integer): TGanttLink;
begin
  if ValidLink(AIndex) then
    Result := FLinks[AIndex] else
    Result := nil;
end;

function TGanttSeries.GetEndValue(AIndex: Integer): Double;
begin
  with Source[AIndex]^ do
    Result := Y + YList[0];
end;

function TGanttSeries.GetLabelDataPoint(AIndex: Integer): TDoublePoint;
begin
  if IsRotated then begin
    Result.Y := AxisToGraphX(Source[AIndex]^.X);
    Result.X := AxisToGraphY(GetEndValue(AIndex));
  end else begin
    Result.X := AxisToGraphX(Source[AIndex]^.X);
    Result.Y := AxisToGraphY(GetEndValue(AIndex));
  end;
end;

procedure TGanttSeries.GetLegendItems(AItems: TChartLegendItems);
var
  i: Integer;
  li: TLegendItem;
begin
  if Legend.Multiplicity = lmPoint then
    for i := 0 to Count - 1 do begin
      li := TGanttLegendItemBrushRect.Create(FBarBrush, Source[i]^.Color,
        FBrushList[i].Color, FBrushList[i].Style, LegendTextPoint(i));
      AItems.Add(li);
    end
  else
    GetLegendItemsRect(AItems, BarBrush);
end;

{ Adapted from TBasicPointSeries.GetNearestPoint }
function TGanttSeries.GetNearestPoint(const AParams: TNearestPointParams;
  out AResults: TNearestPointResults): Boolean;
var
  i: Integer;
  pt: TPoint;
  sp: TDoublePoint;
  R: TRect;
begin
  AResults.FDist := Sqr(AParams.FRadius) + 1;
  for i := 0 to Count - 1 do begin
    R := GetBarImageRect(i);
    InflateRect(R, AParams.FRadius, AParams.FRadius);
    if not PtinRect(R, AParams.FPoint) then
      continue;
    sp := Source[i]^.Point;
    if IsNan(sp) then continue;
    pt := ParentChart.GraphToImage(AxisToGraph(sp));
    AResults.FDist := AParams.FDistFunc(AParams.FPoint, pt);
    AResults.FIndex := i;
    AResults.FImg := pt;
    AResults.FValue := sp;
  end;
  Result := AResults.FIndex >= 0;
end;

function TGanttSeries.GetSeriesColor: TColor;
begin
  Result := FBarBrush.Color;
end;

function TGanttSeries.GetStartValue(AIndex: Integer): Double;
begin
  Result := Source[AIndex]^.Y;
end;
  {
function TGanttSeries.IsRotated: Boolean;
begin
  Result := not inherited IsRotated;
end;
   }

function TGanttSeries.MaybeRotate(AX, AY: Double): TPoint;
begin
  if IsRotated then
    Exchange(AX, AY);
  Result := ParentChart.GraphToImage(DoublePoint(AX, AY));
end;

procedure TGanttSeries.SetBarBrush(AValue: TBrush);
begin
  FBarBrush.Assign(AValue);
end;

procedure TGanttSeries.SetBarWidthPercent(AValue: Integer);
begin
  if (AValue < 1) or (AValue > 99) then
    raise EGanttError.Create('Wrong bar width percent');
  FRelativeBarWidth := AValue * 0.01;
  UpdateParentChart;
end;

procedure TGanttSeries.SetBarPen(AValue:TPen);
begin
  FBarPen.Assign(AValue);
end;

procedure TGanttSeries.SetBreakDistance(AValue: Integer);
begin
  if AValue = GetBreakDistance then exit;
  FBreakDistance := AValue * 0.001;
  UpdateParentChart;
end;

procedure TGanttSeries.SetLinkPen(AValue: TPen);
begin
  FLinkPen.Assign(AValue);
end;

procedure TGanttSeries.SetLinks(AIndex: Integer; AValue: TGanttLink);
begin
  if not ValidLink(AIndex) then
    exit;
  FLinks[AIndex] := AValue;
  UpdateParentChart;
end;

procedure TGanttSeries.SetSeriesColor(AValue: TColor);
begin
  FBarBrush.Color := AValue;
end;

procedure TGanttSeries.UpdateMinTaskCounterRange;
var
  task, prevtask: Double;
  i: Integer;
begin
  if Count < 2 then begin
    FMinTaskCounterRange := 1.0;
    exit;
  end;
  // unrotated: task counter values are on x
  task := Source[0]^.X;
  prevtask := Source[1]^.X;
  FMinTaskCounterRange := Abs(task- prevtask);
  for i := 2 to Count - 1 do begin
    task := Source[i]^.X;
    FMinTaskCounterRange := SafeMin(Abs(task - prevtask), FMinTaskCounterRange);
    prevtask := task;
  end;
end;

function TGanttSeries.ValidLink(AIndex: Integer): Boolean;
begin
  Result := InRange(AIndex, 0, FLinks.Count-1);
end;

end.

