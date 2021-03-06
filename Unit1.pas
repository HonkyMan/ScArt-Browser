unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    HomePage: TLabel;
    Favour: TLabel;
    edHomepage: TEdit;
    Setcombobox: TComboBox;
    OkHP: TButton;
    favOk: TButton;
    procedure OkHPClick(Sender: TObject);
    procedure favOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses browser;

procedure TForm1.favOkClick(Sender: TObject);
begin
  FormBrowser.WebBrowser1.Navigate(Setcombobox.Text);
  Form1.Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetComboBox.Items.SaveToFile(ExtractFilePath(application.ExeName)+' favorite.txt');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(application.ExeName)+'favorite.txt') then
    Form1.Setcombobox.Items.LoadFromFile(ExtractFilePath(application. ExeName)+'favorite.txt');
end;

procedure TForm1.OkHPClick(Sender: TObject);
begin
  FormBrowser.WebBrowser1.Navigate(edHomepage.Text);
  Form1.Close;
end;

end.
