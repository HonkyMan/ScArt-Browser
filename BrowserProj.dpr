program BrowserProj;

uses
  Vcl.Forms,
  browser in 'browser.pas' {FormBrowser},
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormBrowser, FormBrowser);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
