program Migraenetagebuch;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, Unit1, Unit2,
<<<<<<< HEAD
  Unit3,uDM1, uMediEdit
=======
  Unit3, laz_synapse
>>>>>>> b8408906f64c6381921985f76a0f602ffb623dbc
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

