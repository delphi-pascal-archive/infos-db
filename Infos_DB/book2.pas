unit book2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, StrUtils, ShellApi;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    Memo: TMemo;
    Quitter1: TMenuItem;
    rait1: TMenuItem;
    Date1: TMenuItem;
    procedure Quitter1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rait1Click(Sender: TObject);
    procedure Date1Click(Sender: TObject);
    procedure MemoDblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    procedure DoubleCLIK;
  end;

var
  Form2 : TForm2;

implementation

{$R *.dfm}

procedure TForm2.Quitter1Click(Sender: TObject);
begin
Memo.Lines.SaveToFile(caption);
close
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Memo.Align := alclient;
end;

procedure TForm2.rait1Click(Sender: TObject);
begin
if Memo.Focused then Memo.SelText := dupestring('_',35);
end;

procedure TForm2.Date1Click(Sender: TObject);
begin
if Memo.Focused then Memo.SelText := datetostr(date);
end;

procedure TForm2.DoubleClik;
var x,x9:string;
begin
x  := trim(Memo.SelText);
if x='' then exit;
ShellExecute(Handle,'Open',PChar(x),nil,nil,SW_HIDE)
end;

procedure TForm2.MemoDblClick(Sender: TObject);
begin
DoubleCliK
end;

end.
