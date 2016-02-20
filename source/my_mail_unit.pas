unit my_mail_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DCPrc4, DCPrc6, DCPripemd160, DCPsha1, Forms,
  Controls, Graphics, Dialogs, IniPropStorage, EditBtn, MaskEdit, StdCtrls,
  INIFiles, XMLConf;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    DCP_rc4_1: TDCP_rc4;
    DCP_rc6_1: TDCP_rc6;
    DCP_ripemd160_1: TDCP_ripemd160;
    DCP_sha1_1: TDCP_sha1;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Memo1: TMemo;
    XMLConfig1: TXMLConfig;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit2Change(Sender: TObject);
    procedure StoreFormState(Sender: TObject);
    procedure RestoreFormState(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;

implementation

uses
  schmerz_tabelle_unit, medikamente_unit, monat_jahr_unit,
  TLoggerUnit, TLevelUnit, TFileAppenderUnit;

{$R *.lfm}

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);

var
  INI: TINIFile;
  fromMail, toMail, smtp, UserName, Passwort, port: string;
  i: integer;
  Cipher: TDCP_rc4;
  KeyStr: string;
begin

  if MaskEdit1.Text = MaskEdit2.Text then
    try
      INI := TINIFile.Create('./ini/crashreport.ini');
      fromMail := Edit1.Text;
      smtp := Edit2.Text;
      port := ComboBox1.Text;
      UserName := Edit3.Text;
      Passwort := MaskEdit1.Text;
      Memo1.Text := Passwort;

      KeyStr := toMail;

      //if InputQuery('Passphrase','Enter passphrase',KeyStr) then  // get the passphrase

      Cipher := TDCP_rc4.Create(Self);
      Cipher.InitStr(KeyStr, TDCP_sha1);
      // initialize the cipher with a hash of the passphrase
      for i := 0 to Memo1.Lines.Count - 1 do       // encrypt the contents of the memo
        Memo1.Lines[i] := Cipher.EncryptString(Memo1.Lines[i]);
      Cipher.Burn;
      Cipher.Free;

      Passwort := Memo1.Text;

      INI.WriteString('INIDB', 'fromMail', fromMail);
      //INI.WriteString('INIDB', 'toMail', toMail);
      INI.WriteString('INIDB', 'smtp', smtp);
      INI.WriteString('INIDB', 'port', port);
      INI.WriteString('INIDB', 'User', UserName);
      INI.WriteString('INIDB', 'Password', Passwort);

    except

      ShowMessage('Leider stimmen die Kennworte nicht überein Bitte neu Eingeben');
    end;
  Form4.Close;

end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  StoreFormState(self);
  TLogger.freeInstances;
  Form1.Show;
  Close;
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  logger: TLogger;
begin
  MaskEdit1.MaxLength := 50;
  MaskEdit2.MaxLength := 50;
  RestoreFormState(self);

  logger := TLogger.getInstance;
  logger.setLevel(TLevelUnit.ALL);
  logger.addAppender(TFileAppender.Create('./log/crashreport2.log'));
end;

procedure TForm4.MaskEdit2Change(Sender: TObject);
begin
  if MaskEdit1.Text = MaskEdit2.Text then
    try
      Button1.Enabled := True;
    except
      Button1.Enabled := False;
    end;
end;

procedure TForm4.RestoreFormState(Sender: TObject);
var
  LastWindowState: TWindowState;
begin
  with XMLConfig1 do
  begin
    xmlconfig1.Filename := './ini/window4.ini';

    LastWindowState := TWindowState(GetValue('WindowState', integer(WindowState)));

    if LastWindowState = wsMaximized then
    begin
      WindowState := wsNormal;
      BoundsRect := Bounds(GetValue('RestoredLeft', RestoredLeft),
        GetValue('RestoredTop', RestoredTop),
        GetValue('RestoredWidth', RestoredWidth),
        GetValue('RestoredHeight', RestoredHeight));
      WindowState := wsMaximized;
    end
    else
    begin
      WindowState := wsNormal;
      BoundsRect := Bounds(GetValue('NormalLeft', Left),
        GetValue('NormalTop', Top), GetValue('NormalWidth', Width),
        GetValue('NormalHeight', Height));
    end;
  end;
end;

procedure TForm4.StoreFormState(Sender: TObject);

begin
  with XMLConfig1 do
  begin
    xmlconfig1.Filename := './ini/window4.ini';
    SetValue('NormalLeft', Left);
    SetValue('NormalTop', Top);
    SetValue('NormalWidth', Width);
    SetValue('NormalHeight', Height);

    SetValue('RestoredLeft', RestoredLeft);
    SetValue('RestoredTop', RestoredTop);
    SetValue('RestoredWidth', RestoredWidth);
    SetValue('RestoredHeight', RestoredHeight);

    SetValue('WindowState', integer(WindowState));

  end;

end;

end.
