program ACA;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazmouseandkeyinput, bitmaps, client, colour_conv, dtm, dtmutil, files,
  finder, fontloader, iomanager, mmath, mufasabase, mufasatypes,
  mufasatypesutil, ocr, ocrutil,{$IFDEF MSWINDOWS}os_windows,{$ELSE} os_linux,{$ENDIF} tpa, dcpbase64,
  DCPblockciphers, DCPconst, DCPcrypt2, ACA_main, aca_types, aca_utils,
  aca_base
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

