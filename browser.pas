unit browser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Buttons, Vcl.OleCtrls, SHDocVw, System.ImageList, Vcl.ImgList,
  Vcl.ExtCtrls, Vcl.ToolWin;

type
  TFormBrowser = class(TForm)
    ToolBar1: TToolBar;
    Panel: TPanel;
    Page: TPageControl;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    PageSetupDialog1: TPageSetupDialog;
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    WebBrowser1: TWebBrowser;
    SpeedButton1: TSpeedButton;
    File1: TMenuItem;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Back: TToolButton;
    Forward: TToolButton;
    Home: TToolButton;
    Refresh: TToolButton;
    Stop: TToolButton;
    Search: TToolButton;
    Close: TToolButton;
    Favorites: TToolButton;
    Open: TMenuItem;
    SaveAs: TMenuItem;
    Properties: TMenuItem;
    View: TMenuItem;
    Print: TMenuItem;
    WordSearch: TMenuItem;
    Settings: TMenuItem;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BackClick(Sender: TObject);
    procedure ForwardClick(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure SearchClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure HomeClick(Sender: TObject);
    procedure FavoritesClick(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure ViewClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure WordSearchClick(Sender: TObject);
    procedure SettingsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WebBrowser1NavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure WebBrowser1NewWindow2(ASender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure WebBrowser1StatusTextChange(ASender: TObject;
      const Text: WideString);
    procedure WebBrowser1TitleChange(ASender: TObject; const Text: WideString);
    procedure PageChange(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure WebBrowser1CommandStateChange(ASender: TObject; Command: Integer;
      Enable: WordBool);
    procedure FormActivate(Sender: TObject);
  private
    Browsers: TList;
    forwardCounter: integer;
    backCounter: integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBrowser: TFormBrowser;

implementation

uses Unit1;
{$R *.dfm}

procedure TFormBrowser.BackClick(Sender: TObject);
begin
  //forwardCounter := forwardCounter + 1;
  //Forward.Enabled := True;
  //backCounter := backCounter - 1;
  //if backCounter = 0 then
  //  Back.Enabled := false;
  WebBrowser1.GoBack;
end;

procedure TFormBrowser.CloseClick(Sender: TObject);
var
  a:string;
begin
  if Page.PageCount>2 then
  begin
    Page.Pages[Page.TabIndex].Destroy;
    Page.TabIndex:=Page.PageCount-2;
    Browsers.Delete(Browsers.Count-1);
  end
  else
  if Page.PageCount=2 then
  begin
    //TWebBrowser(Browsers.Last).Navigate(blank);
    //Page.Pages[Page.PageCount-2].Caption := blank;
  end;
end;

procedure TFormBrowser.Edit1Enter(Sender: TObject);
var
  a:string;
begin
  TWebBrowser(Browsers[Page.TabIndex]).Navigate(Self.Edit1.Text);
  Page.ActivePage.Caption:='Загрузка..';
  a := Edit1.Text;
  ComboBox1.Items.Add(a);
end;

procedure TFormBrowser.FavoritesClick(Sender: TObject);
var
  a:string;
  i:integer;
  t:boolean;
begin
  t := true;
  a:=Edit1.Text;
   for i := 0 to Form1.Setcombobox.Items.Count do
      if a=Form1.Setcombobox.Items[i] then
      begin
        t := false;
        break;
      end;

  if t = True then
    Form1.SetComboBox.Items.Add(a)
  else
  begin
    MessageBox(handle, PChar('You`re already added this link to favorites tab'),PChar('Favorites'), MB_ICONASTERISK+MB_OK);
  end

end;

procedure TFormBrowser.FormActivate(Sender: TObject);
  var
    i:integer;
begin
  for i := 0 to Form1.Setcombobox.Items.Count do
    Form1.SetComboBox.Items.Delete(i);
end;

procedure TFormBrowser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormBrowser.ComboBox1.Items.SaveToFile(ExtractFilePath(application.ExeName)+'history.txt');
  Form1.SetComboBox.Items.SaveToFile(ExtractFilePath(application.ExeName)+'favorite.txt');
end;

procedure TFormBrowser.FormCreate(Sender: TObject);
var
  i:integer;
begin
  //Forward.Enabled := false;
  //Back.Enabled := false;
  //for i := 0 to Form1.SetComboBox.Items.Count do

  Browsers:=TList.Create;
  Browsers.Add(WebBrowser1);
  WebBrowser1.Navigate('https://google.com');
  if FileExists(ExtractFilePath(application.ExeName)+'history.txt') then
    FormBrowser.ComboBox1.Items.LoadFromFile(ExtractFilePath(application.ExeName)+'history.txt');
end;

procedure TFormBrowser.ForwardClick(Sender: TObject);
begin
  //forwardCounter := forwardCounter - 1;
  //if forwardCounter = 0 then
  // forward.Enabled := False;
  //backCounter := backCounter + 1;
  //Back.Enabled := True;
  WebBrowser1.GoForward;
end;

procedure TFormBrowser.HomeClick(Sender: TObject);
begin
  WebBrowser1.Navigate(Form1.EdHomePage.Text);
end;

procedure TFormBrowser.OpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    WebBrowser1.Navigate(OpenDialog1.FileName)
end;

procedure TFormBrowser.PageChange(Sender: TObject);
var
	tab: TTabSheet;
	wl,wb: TWebBrowser;
begin
	if Page.TabIndex=Page.PageCount-1 then
	begin
		tab:=TTabSheet.Create(Page);
		tab.PageControl := Page;
		//tab.Caption := blank;
		tab.PageIndex := Page.PageCount-2;
		Page.TabIndex := tab.PageIndex;
		wl := TWebBrowser(Browsers.last);
		wb := TWebBrowser.Create(tab);
		with TWinControl(wb) do
		begin
			parent := tab;
			visible := true;
			width := wl.Width;
			height := wl.Height;
			left := wl.Left;
			top := wl.Top;
			Align := wl.Align;
		end;
		wb.OnDocumentComplete := self.WebBrowser1DocumentComplete;
		Browsers.Add(wb);
	end
	else
	begin
		Edit1.Text := TWebBrowser(Browsers[Page.TabIndex]).LocationURL;
  end;
end;

procedure TFormBrowser.PrintClick(Sender: TObject);
var
  PostData, Headers: OLEvariant;
begin
  WebBrowser1.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DODEFAULT, PostData, Headers);
end;

procedure TFormBrowser.RefreshClick(Sender: TObject);
begin
  WebBrowser1.Refresh;
end;

procedure TFormBrowser.SaveAsClick(Sender: TObject);
begin
  WebBrowser1.ExecWB(OLECMDID_SAVEAS, OLECMDEXECOPT_DODEFAULT);
end;

procedure TFormBrowser.SearchClick(Sender: TObject);
var
  a:string;
begin
  //backCounter := backCounter + 1;
  //back.Enabled := True;
  TWebBrowser(Browsers[Page.TabIndex]).Navigate(Self.Edit1.Text);
  Page.ActivePage.Caption:='Загрузка..';
  a := Edit1.Text;
  ComboBox1.Items.Add(a);
end;

procedure TFormBrowser.SettingsClick(Sender: TObject);
begin
  Form1.ShowModal;
end;

procedure TFormBrowser.StopClick(Sender: TObject);
begin
  WebBrowser1.Stop;
end;

procedure TFormBrowser.ViewClick(Sender: TObject);
begin
  WebBrowser1.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT);
end;

procedure TFormBrowser.WebBrowser1CommandStateChange(ASender: TObject;
  Command: Integer; Enable: WordBool);
begin
  case Command of
    CSC_NAVIGATEBACK: Back.Enabled := Enable;
    CSC_NAVIGATEFORWARD: Forward.Enabled := Enable;
  end;
end;

procedure TFormBrowser.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  Page.ActivePage.Caption := copy(TWebBrowser(ASender). LocationName,1,23);
	Edit1.Text := TWebBrowser(ASender).LocationUrl;
end;

procedure TFormBrowser.WebBrowser1NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  if ComboBox1.Items.IndexOf(ComboBox1.Text) <> -1 then
  else
    ComboBox1.Items.Add(WebBrowser1.LocationURL);
end;

procedure TFormBrowser.WebBrowser1NewWindow2(ASender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
	newForm: TFormBrowser;
begin
	ppdisp := WebBrowser1.DefaultDispatch;
	newForm := TFormBrowser.Create(self);
	newForm.Show;
	ppdisp := newForm.WebBrowser1.DefaultDispatch;
end;

procedure TFormBrowser.WebBrowser1StatusTextChange(ASender: TObject;
  const Text: WideString);
begin
  StatusBar1.SimpleText := Text;
  ComboBox1.Text := WebBrowser1.LocationURL;
end;

procedure TFormBrowser.WebBrowser1TitleChange(ASender: TObject;
  const Text: WideString);
begin
  Edit1.Text:=WebBrowser1.locationURL;
end;

procedure TFormBrowser.WordSearchClick(Sender: TObject);
begin
  WebBrowser1.ExecWB(OLECMDID_FIND, OLECMDEXECOPT_DODEFAULT);
end;

end.
