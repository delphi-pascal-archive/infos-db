unit Unit1;

{ --- Historique

1.0 : première version "jouable"
1.1 : Ajouté µFiches et DoubleCLIC
1.1b : FormStyle : Fsnormal
1.2 : ajouter menu Executer  et Quitter et déplacer CAT,RUB et TIT
1.3 : Ajout Fonction CHERCHE, ajout DATE et TRAIT
1.4 : ajouté recherche de [xxx] par appel avec $xxx  (mot clé unique)
1.5 modifié Create pour nouveau fichier
}
//====================================================================
              interface
//====================================================================

//--------------------------------------------------------------------
uses
  Windows,
  dialogs,
  Classes,
  Controls,
  Forms, Menus, StdCtrls, SysUtils, ShellApi,
  SYSTUS
;

const Version = '1.5'; INFOSversion = 'INFOS ' + version;

//--------------------------------------------------------------------
type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Fichiers1: TMenuItem;
    LCAT: TListBox;
    LRUB: TListBox;
    LTIT: TListBox;
    bCHERCHE: TButton;
    eCHERCHE: TEdit;
    M1: TMemo;
    Ajouter1: TMenuItem;
    Modifier1: TMenuItem;
    Suypprimer1: TMenuItem;
    Charger1: TMenuItem;
    Sauver1: TMenuItem;
    Sauversous1: TMenuItem;
    Quitter2: TMenuItem;
    LX: TListBox;
    O1: TOpenDialog;
    S1: TSaveDialog;
    Executer1: TMenuItem;
    Quitter1: TMenuItem;
    rait1: TMenuItem;
    Date1: TMenuItem;
    propos1: TMenuItem;
    Effacer1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Quitter2Click(Sender: TObject);
    procedure LCATClick(Sender: TObject);
    procedure LRUBClick(Sender: TObject);
    procedure LTITClick(Sender: TObject);
    procedure Ajouter1Click(Sender: TObject);
    procedure Sauver1Click(Sender: TObject);
    procedure Modifier1Click(Sender: TObject);
    procedure Suypprimer1Click(Sender: TObject);
    procedure Charger1Click(Sender: TObject);
    procedure Sauversous1Click(Sender: TObject);
    procedure M1DblClick(Sender: TObject);
    procedure Executer1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure rait1Click(Sender: TObject);
    procedure Date1Click(Sender: TObject);
    procedure bCHERCHEClick(Sender: TObject);
    procedure propos1Click(Sender: TObject);
    procedure Effacer1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    procedure QUITTER;
    procedure INIT;
    Procedure ChargeLCAT;
    procedure ChargeLRUB(C:string);
    procedure ChargeLTIT(C:string; R:string);
    procedure ChgTIT(TIT:string);
    procedure ChgM1(n:integer);
    procedure DoubleCLIC;
    procedure Modifier;
    procedure MicroMemo(x:string);
  end;

//--------------------------------------------------------------------
var
  Form1: TForm1;
  FIC  : string;
  FLAG : boolean;
  CAT  : string;
  RUB  : string;
  TIT  : string;
  NUM  : integer;

//====================================================================
              implementation

uses book2;
//====================================================================

{$R *.dfm}

//---------------------------------------
function TriMaj(z:string):string;
begin
result := trim(uppercase(z));
end;
//---------------------------------------
function MOT(Z:string; n:integer=1):string;
var x,v:integer;  g,h:string;
begin
v := 0;
h := trim(z);
repeat
    if h=''
       then begin g:=''; v:=n end
       else begin
            x := pos(' ',h);
            if x=0   // un seul mot
               then begin g := h;  h:=''; end
               else begin
                    g := copy(h,1,x-1);
                    h := trim(copy(h,x,length(h)));
                    end;
            inc(v);
            end;
until v=n;
result := trim(g);
end;

//------------------------------------------------------------------------------
procedure TForm1.Quitter2Click(Sender: TObject); begin QUITTER end;
procedure TForm1.Quitter1Click(Sender: TObject); begin QUITTER end;
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
    begin QUITTER end;
procedure TForm1.QUITTER;
begin
if FLAG then SVG(LX,FIC);
application.Terminate
end;

//------------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
begin
setbounds(200,100,900,600);
FIC := 'nouveau';
if paramcount>0
   then FIC := paramstr(1)
   else if O1.Execute then FIC := O1.FileName;
FIC := extension(FIC,'ifo');
if not FileExists(FIC) then
   begin
   ADD(LX,'_EnCours;INDEX;vide;___________________________________;xx');
   SVG(LX,FIC);
   end;
CHG(LX,FIC);
FLAG := false;
caption := INFOSVersion + FIC;
INIT;
end;

//------------------------------------------------------------------------------
procedure Tform1.INIT;
begin
ChargeLCAT;
ChargeLRUB(CAT);
ChargeLTIT(CAT,RUB);
end;

//------------------------------------------------------------------------------
procedure Tform1.ChargeLCAT;
var i,j,n:integer;  C,H:string;
begin
RAZ(LCAT);
for i:=0 to DER(LX) do
    begin
    H := LIG(LX,i);
    C := TriMaj(getH(H,0));
    if QTE(LCAT)=0
       then ADD(LCAT,C)
       else begin
            n := -1;
            for j:=0 to DER(LCAT) do if LIG(LCAT,j)=C then n := j;
            if n=-1 then ADD(LCAT,C);
            end;
    end;
CAT := LIG(LCAT,0);
NDX(LCAT,0)
end;

//------------------------------------------------------------------------------
procedure Tform1.ChargeLRUB(C:string);
var i,j,n:integer;  R,H:string;
begin
C := uppercase(C);
CAT := C;
RAZ(LRUB);
for i:=0 to DER(LX) do
    begin
    H := LIG(LX,i);
    if TriMaj(getH(H,0))=C then
       begin
       R := TriMaj(getH(H,1));
       if QTE(LCAT)=0
          then ADD(LRUB,R)
          else begin
                n := -1;
                for j:=0 to DER(LRUB) do if LIG(LRUB,j)=R then n := j;
                if n=-1 then ADD(LRUB,R);
                end;
       end;
    end;
RUB := LIG(LRUB,0);
NDX(LRUB,0)
end;

//------------------------------------------------------------------------------
procedure TForm1.LCATClick(Sender: TObject);
begin
CAT := LIG(LCAT,IDX(LCAT));
ChargeLRUB(CAT);
ChargeLTIT(CAT,RUB);
end;

//------------------------------------------------------------------------------
procedure Tform1.ChargeLTIT(C:string; R:string);
var i:integer;  T,H:string;
begin
C := uppercase(C);
R := uppercase(R);
CAT := C;
RUB := R;
RAZ(LTIT);
for i:=0 to DER(LX) do
    begin
    H := LIG(LX,i);
    if (TriMaj(getH(H,0))=C) and (TriMaj(getH(H,1))=R) then
       begin
       T := justg(getH(H,2),36) + ';' + inttostr(i);
       ADD(LTIT,T);
       end;
    end;
TIT := LIG(LTIT,0);
NDX(LTIT,0);
ChgTIT(TIT);
end;

//------------------------------------------------------------------------------
procedure TForm1.LRUBClick(Sender: TObject);
begin
RUB := LIG(LRUB,IDX(LRUB));
ChargeLTIT(CAT,RUB);
end;

//------------------------------------------------------------------------------
procedure Tform1.ChgTIT(TIT:string);
var n:integer;
begin
n := getH(TIT,1);
ChgM1(n);
end;

//------------------------------------------------------------------------------
procedure TForm1.ChgM1(n:integer);
var H:string;
begin
H := LIG(LX,n);
EFF(M1); ChgH(M1,H); VIS(M1);
end;


//------------------------------------------------------------------------------
procedure TForm1.LTITClick(Sender: TObject);
var H,g:string;
begin
H := LIG(LTIT,IDX(LTIT));
NUM := getH(H,1);
ChgM1(NUM);
H := LIG(LX,NUM);
g := geth(H,0);
ChargeLCAT;
NDX(LCAT,XOF(LCAT,g));
ChargeLRUB(g);
g := geth(H,1);
NDX(LRUB,XOF(LRUB,g));
end;

//------------------------------------------------------------------------------
procedure TForm1.Ajouter1Click(Sender: TObject);
var i:integer; C,R,T,H:string;
begin
H := SvgH(M1);
if (QteH(H)<3)    or
   (trim(geth(h,0))='') or
   (trim(geth(h,1))='') or
   (trim(geth(h,2))='')
   then begin
        msg('Il faut au moins 3 lignes valides !');
        exit
        end;
C := getH(H,0);                       // new CAT
R := getH(H,1);                       // new RUB
T := LIG(LTIT,idx(LTIT));             // ex TIT
T := getH(H,2);
ADD(LX,H);
FLAG := true;
INIT;
NDX(LCAT,XOF(LCAT,C));
CAT := C;
ChargeLRUB(CAT);
NDX(LRUB,XOF(LRUB,R));
RUB := R;
ChargeLTIT(CAT,RUB);
for i:=0 to DER(LTIT) do
    begin
    H := LIG(LTIT,i);
    if GetH(H,0)=T then
       begin
       NDX(LTIT,i);
       TIT := LIG(LTIT,i);
       NUM := getH(TIT,1);
       ChgM1(NUM);
       end;
    end;
end;

//------------------------------------------------------------------------------
procedure TForm1.Sauver1Click(Sender: TObject);
begin
SVG(LX,FIC);
FLAG := false;
end;

//------------------------------------------------------------------------------
procedure TForm1.Modifier1Click(Sender: TObject); begin Modifier end;
procedure TForm1.Modifier;
var i,n:integer; C,R,T,H:string;
begin
H := SvgH(M1);
if (QteH(H)<3)    or
   (trim(geth(h,0))='') or
   (trim(geth(h,1))='') or
   (trim(geth(h,2))='')
   then begin
        msg('Il faut au moins 3 lignes valides !');
        exit
        end;
C := getH(H,0);                       // new CAT
R := getH(H,1);                       // new RUB
T := LIG(LTIT,idx(LTIT));             // ex TIT
n := GETH(T,1);						          	// NUM
T := trimaj(getH(H,2));
ECR(LX,N,H);
FLAG := true;
INIT;
NDX(LCAT,XOF(LCAT,C));
CAT := C;
ChargeLRUB(CAT);
NDX(LRUB,XOF(LRUB,R));
RUB := R;
ChargeLTIT(CAT,RUB);
for i:=0 to DER(LTIT) do
    begin
    H := LIG(LTIT,i); C := trimaj(geth(H,0));
    if C=T then
       begin
       NDX(LTIT,i);
       TIT := geth(h,0);
       NUM := getH(h,1);
       ChgM1(NUM);
       exit;
       end;
    end;
end;

//------------------------------------------------------------------------------
procedure TForm1.Suypprimer1Click(Sender: TObject);
var n:integer;  h:string;
begin
if OUINON('Supprimer cette fiche') then
   begin
   h := LIG(LTIT,IDX(LTIT));
   n := getH(H,1);
   DEL(LX,n);
   INIT;
   end;
end;

//------------------------------------------------------------------------------
procedure TForm1.Charger1Click(Sender: TObject);
var f:string;
begin
if FLAG then SVG(LX,FIC);
FLAG := false;
if O1.Execute then f := O1.FileName;
if trim(f)='' then exit;
FIC := extension(f,'ifo');
if not FileExists(FIC) then
   begin
   RAZ(LX);
   ADD(LX,'_EnCours;INDEX;vide;___________________________________;xx');
   SVG(LX,FIC);
   end;
CHG(LX,FIC);
FLAG := false;
caption := INFOSVersion + FIC;
INIT;
end;

//------------------------------------------------------------------------------
procedure TForm1.Sauversous1Click(Sender: TObject);
begin
if FLAG then SVG(LX,FIC);
FLAG := false;
S1.FileName := FIC;
if S1.Execute then
   begin
   FIC := extension(S1.FileName,'ifo');
   SVG(LX,FIC);
   caption := INFOSVersion + FIC;
   end;
end;

//------------------------------------------------------------------------------
procedure TForm1.M1DblClick(Sender: TObject);     begin DoubleCLIC  end;
procedure TForm1.Executer1Click(Sender: TObject); begin DOUBLECLIC  end;
procedure TForm1.DoubleClic;
var x,g,h,r9,t9:string; n,i:integer;
begin
x  := trim(M1.SelText);
if x='' then exit;
//-------------------------------------- 1 - Test si µXXXX
if x[1]='µ' then
   begin
   MicroMemo(x);
   exit
   end;
//-------------------------------------- 1 - Test si $mot clé unique ([xxx])
// mot clé appelé par double clic sur $xxx
if x[1]='$' then
   begin
   g := '[' + copy(MOT(x),2,99) + ']'; g:=majus(g);
   for i:=0 to DER(LX) do
       begin
       h := majus(LIG(LX,i));
       n := pos(G,h);
       if n>0 then
          begin
          ChargeLCAT;
          CAT := geth(h,0); NDX(LCAT,XOF(LCAT,CAT));
          r9  := geth(h,1); ChargeLRUB(CAT); NDX(LRUB,XOF(LRUB,r9)); RUB := r9;
          T9  := justg(getH(H,2),36) + ';' + inttostr(i);
          ChargeLTIT(CAT,RUB);
          NDX(LTIT,XOF(LTIT,t9));  TIT := t9;
          ChgM1(i);
          exit
          end;
       end;
    exit
    end;
//-------------------------------------- 2 - test si autre IFO
if pos('.ifo',x)>0 then
   begin
   if fileExists(x) then
      begin
      if FLAG then SVG(LX,FIC);
      FIC := x;
      CHG(LX,FIC);
      INIT;
      FLAG := false;
      caption := INFOSVersion + FIC;
      exit
      end;
   end;
ShellExecute(Handle,'Open',PChar(x),nil,nil,SW_HIDE)
end;

//-----------------------------------------------------
procedure Tform1.MicroMemo(x:string);
begin
Form2.Memo.Clear;
if fileExists(x) then Form2.Memo.Lines.LoadFromFile(x);
Form2.caption := x;
Form2.show
end;

//-----------------------------------------------------
procedure TForm1.rait1Click(Sender: TObject);
begin
if M1.Focused then M1.SelText := dup('_',35);
end;

//-----------------------------------------------------
procedure TForm1.Date1Click(Sender: TObject);
begin
if M1.Focused then begin M1.SelText := datetostr(date); exit end;
end;

//-----------------------------------------------------
procedure TForm1.bCHERCHEClick(Sender: TObject);
var i:integer; G,H,Z:string;
begin
G := TriMaj(eCHERCHE.Text);
if G='' then exit;
NDX(LCAT,-1);
NDX(LRUB,-1);
RAZ(LTIT);
RAZ(M1);
for i:=0 to DER(LX) do
    begin
    h := LIG(LX,i); z := uppercase(H);
    if pos(G,Z)>0 then ADD(LTIT, justg(getH(h,2),36) + ';' + inttostr(i));
    end;
if QTE(LTIT)>0 then
   begin
   NDX(LTIT,0);
   H := LIG(LTIT,IDX(LTIT));
   NUM := getH(H,1);
   ChgM1(NUM);
   H := LIG(LX,NUM);
   g := geth(H,0);
   ChargeLCAT;
   NDX(LCAT,XOF(LCAT,g));
   ChargeLRUB(g);
   g := geth(H,1);
   NDX(LRUB,XOF(LRUB,g));
   end;
end;

procedure TForm1.propos1Click(Sender: TObject);
begin
msg3(INFOSversion,versionSystus,'RD-nov 2010');
end;

procedure TForm1.Effacer1Click(Sender: TObject);
begin
RAZ(M1);
end;

end.
