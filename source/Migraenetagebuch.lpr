program Migraenetagebuch;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, zcomponent, schmerz_tabelle_unit, medikamente_unit,
  monat_jahr_unit, laz_synapse, ssl_openssl, my_mail_unit, TConfiguratorUnit,
  log4fpc
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  TConfiguratorUnit.doBasicConfiguration;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.

