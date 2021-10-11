//==============================================================================
     Unit SYSTUS;  // compil de gestH et de ALIAS
//==============================================================================
    INTERFACE
//==============================================================================
{ historique :
  /1 : Compilation de
      -  AliasVersion = '/4'; (08/01/2010)
      -  Gest Hversion 4      (28/01/2010)
  /2 : ajouté MSG2 et MSG3
}

uses StdCtrls,ExtCtrls,StrUtils,SysUtils,graphics,dialogs,classes,controls;

const   SystusVersion = '/2';   // 07/11/2010
        VersionSYSTUS = 'SYSTUS version ' + SystusVersion;
        marron    = clmaroon;  // $000080;
        rouge     = clRed;     // $0000ff;
        orange    = $00a5ff;   // clOrange  
        jaune     = clyellow;  // $00ffff;
        olive     = clOlive;   // $008080;
        pourpre   = clpurple;  // $800080;
        violet    = clfuchsia; // $ff00ff;
        vertclair = cllime;    // $00ff00;
        vert      = clgreen;   // $008000;
        marine    = clnavy;    // $800000;
        bleu      = clblue;    // $ff0000;
        cyan      = claqua;    // $ffff00;
        teal      = clteal;    // $808000;
        noir      = clblack;   // $000000;
        blanc     = clwhite;   // $ffffff;
        gris      = clgray;    // $808080;
        argent    = clsilver;  // $c0c0c0;

        Gras         :TFontStyles = [fsbold];
        Maigre       :TFontStyles = [];
        Italique     :TFontStyles = [fsitalic];
        GrasItalique :TFontStyles = [fsbold,fsitalic];

type str4  = string[4];

//========================== Procédures et functions =================

{*DER}   // renvoie le dernier n° de ligne valide (count - 1)
function DER(var O:TlistBox):integer;   overload
function DER(var O:TComboBox):integer;  overload
function DER(var O:TMemo):integer;      overload
//-------------------------------------------------------------------
{*IDX}   // renvoie l'index courant (itemindex)
function IDX(var O:TListBox):integer;   overload
function IDX(var O:TComboBox):integer;  overload
function IDX(var O:Tmemo):integer;      overload
//-------------------------------------------------------------------
{*LIG}    // renvoie le texte de la ligne n
function  LIG(var O:TlistBox; n:integer):string;   overload
function  LIG(var O:TComboBox; n:integer):string;  overload
function  LIG(var O:TMemo; n:integer):string;      overload
//-------------------------------------------------------------------
{*QTE}    // renvoie le nombre de lignes  (count)
function QTE(var O:TlistBox):integer;   overload
function QTE(var O:TComboBox):integer;  overload
function QTE(var O:TMemo):integer;      overload
//-------------------------------------------------------------------
{*TXT}    // renvoie le texte de la ligne courante
function  TXT(var O:TListBox):string;   overload
function  TXT(var O:TComboBox):string;  overload
function  TXT(var O:TMemo):string;      overload
//-------------------------------------------------------------------
{*XOF}    // renvoie 1er n° ligne comportant la chaine z (endroit quelconque, si e<>1)
function  XOF(var O:TListBox; z:string; e:integer=1):integer;  overload
function  XOF(var O:TComboBox; z:string; e:integer=1):integer; overload
function  XOF(var O:Tmemo; z:string; e:integer=1):integer;     overload
          // si e = 1 ou omis : indexof
          // si e = 0 : endroit quelconque
//-------------------------------------------------------------------
{ADD}     // ajoute la chaine Z à liste/memo
procedure ADD(var O:TlistBox; z:string);   overload
procedure ADD(var O:Tmemo; z:string);      overload
procedure ADD(var O:TcomboBox; z:string);  overload
procedure ADD(var O:Tedit; z:string);      overload
//-------------------------------------------------------------------
{CHG}     // Charge liste/memo avec contenu du fichier fic
Procedure CHG(var O:Tlistbox; fic:string);   overload
Procedure CHG(var O:Tmemo; fic:string);      overload
Procedure CHG(var O:TcomboBox; fic:string);  overload
//-------------------------------------------------------------------
{ECR}     // remplace la ligne n par la chaine Z
procedure ECR(var O:TListBox; n:integer; z:string);   overload
procedure ECR(var O:TComboBox; n:integer; z:string);  overload
procedure ECR(var O:TMemo; n:integer; z:string);      overload
procedure ECR(var O:TEdit; z:string);                 overload
//-------------------------------------------------------------------
{NDX}     // Positionne l'index courant à n
procedure NDX(var O:TlistBox; n:integer);   overload
procedure NDX(var O:TComboBox; n:integer);  overload
//-------------------------------------------------------------------
{RAZ}     // clear Liste/mémo
Procedure RAZ(var O:Tlistbox);   overload
Procedure RAZ(var O:Tmemo);      overload
Procedure RAZ(var O:TcomboBox);  overload
Procedure RAZ(var O:Tedit);      overload
Procedure RAZ(var O:Tbutton);    overload
Procedure RAZ(var O:Tpanel);     overload
//-------------------------------------------------------------------
{SVG}     // Sauvegarde Liste/memo dans le fichier fic
Procedure SVG(var O:Tlistbox; fic:string);    overload
Procedure SVG(var O:Tmemo; fic:string);       overload
Procedure SVG(var O:TcomboBox; fic:string);   overload
//-------------------------------------------------------------------
{VIS}     // Liste/memo/bouton/panel/edit = visible, placé au dessus
Procedure VIS(var O:Tlistbox);   overload
Procedure VIS(var O:Tmemo);      overload
Procedure VIS(var O:TcomboBox);  overload
Procedure VIS(var O:Tpanel);     overload
Procedure VIS(var O:Tedit);      overload
Procedure VIS(var O:Tbutton);    overload
Procedure VIS(var O:Timage);     overload
//-------------------------------------------------------------------
{EFF}     // Liste/memo/bouton/panel/edit = invisible
Procedure EFF(var O:Tlistbox);   overload
Procedure EFF(var O:Tmemo);      overload
Procedure EFF(var O:TcomboBox);  overload
Procedure EFF(var O:Tpanel);     overload
Procedure EFF(var O:Tedit);      overload
Procedure EFF(var O:Tbutton);    overload
Procedure EFF(var O:Timage);     overload
//-------------------------------------------------------------------
{ChgH}    // charge Liste/memo avec une chaine de type GestH
procedure ChgH(var O:Tlistbox; H:string);    overload 
procedure ChgH(var O:Tmemo; H:string);       overload
procedure ChgH(var O:TcomboBox; H:string);   overload 
//-------------------------------------------------------------------
{SvgH}    // renvoie le contenu de Liste/memo dans une chaine de type GestH
function  SvgH(var O:Tlistbox):string;     overload
function  SvgH(var O:Tmemo):string;        overload
function  SvgH(var O:TcomboBox):string;    overload 
//-------------------------------------------------------------------
{Style}   // modifie le style de la fonte de l'objet
procedure Style(var O:Tlistbox;  S:TFontStyles);  overload
procedure Style(var O:TCombobox; S:TFontStyles);  overload
procedure Style(var O:TMemo;     S:TFontStyles);  overload
procedure Style(var O:TPanel;    S:TFontStyles);  overload
procedure Style(var O:TButton;   S:TFontStyles);  overload
procedure Style(var O:Tedit;     S:TFontStyles);  overload
procedure Style(var O:Tlabel;    S:TFontStyles);  overload
//-------------------------------------------------------------------
{Taille}   // modifie la taille de la fonte de l'objet
procedure Taille(var O:Tlistbox;  n:integer); overload
procedure Taille(var O:TCombobox; n:integer); overload
procedure Taille(var O:TMemo;     n:integer); overload
procedure Taille(var O:TPanel;    n:integer); overload
procedure Taille(var O:TButton;   n:integer); overload
procedure Taille(var O:Tedit;     n:integer); overload
procedure Taille(var O:Tlabel;    n:integer); overload
//-------------------------------------------------------------------
{INS} // insère une ligne après la ligne l, avec chaine Z
procedure INS(var O:Tlistbox;  l:integer; z:string);  overload
procedure INS(var O:Tcombobox; l:integer; z:string);  overload
procedure INS(var O:Tmemo;     l:integer; z:string);  overload
//-------------------------------------------------------------------
{DEL} // supprime la ligne n
procedure DEL(var O:Tlistbox;  l:integer);  overload
procedure DEL(var O:Tcombobox; l:integer);  overload
procedure DEL(var O:Tmemo;     l:integer);  overload
//-------------------------------------------------------------------
{AFF}     //  remplace le caption/text par Z
procedure AFF(var O:TPanel;  z:string);  overload
procedure AFF(var O:TButton; z:string);  overload
procedure AFF(var O:TLabel;  z:string);  overload
procedure AFF(var O:TEdit;   z:string);  overload
//-------------------------------------------------------------------
{FILTRE}  // crée le "filter" : filtre(O,'Tous','*') -> 'Tous (*.*)|*.*'
procedure Filtre(var O:TopenDialog; Z:string; e:string); overload
procedure Filtre(var O:TsaveDialog; Z:string; e:string); overload
//-------------------------------------------------------------------

{==========  functions et procedures diverses ============================== }

function  OuiNon(Q:string):boolean; //renvoie true si répondu OUI à question Q
function  NonOui(Q:string):boolean; //renvoie true si répondu NON à question Q
Function  JustG(T:string; N:byte):string;  // renvoie chaine T avec N carac justifiée à gauche
Function  JustD(T:string; N:byte):string;  // renvoie chaine T avec N carac justifiée à droite
Function  JustC(T:string; N:byte):string;  // renvoie chaine T avec N carac justifiée au centre
procedure Msg(t:string);
procedure Msg2(t1,t2:string);
procedure Msg3(t1,t2,t3:string);
Function  Len(z:string):integer;           // lenght;
Function  Dup(c:char; n:integer):string;   // dupestring
Function  Int(z:string):integer;           // strtoint
Function  Str(n:integer):string;           // inttostr
function  Min(N1,N2:integer):integer;
function  Max(N1,N2:integer):integer;
procedure Lim(var N:integer; Nmin,Nmax:integer); //renvoie N limité Nmin et Nmax
function  Minus(z:string):string; // lowercase
function  Majus(z:string):string; // Uppercase
function  Extension(fic:string; ext:string):string;

///===================================== GestH ==================================================
function  ZV(Z:variant):variant;
procedure RAZH(var h:string);                       // h = ''
function  QTEH(h:string):integer;                   // nbre de champs
function  DERH(h:string):integer;                   // n° du dernier champ (DIMH-1)
procedure ADDH(var h:string; v:variant);            // ajoute le champ v à la fin
procedure INSH(var h:string; v:variant; n:integer); // insère v pos n  h=a;b;c;d  insh(h,9,1)-> a;9;b;c;d
procedure DELH(var h:string; n:integer);            // supprime champ n h=a;b;c;d   delh(h,1)-> a;c;d
procedure PUTH(var h:string; v:variant; n:integer); // ecrit champ v à pos n h=a;b;c;d   ecrh(h,9,1)-> a;9;c;d
function  GETH(h:string; n:integer):variant;        //h=a;b;c;d   geth(h,1)-> b
function  XofH(h:string; v:variant; e:integer=1):integer;
   /// renvoie position colonne de V dans H
   /// h=a;b;c;d   XofH(h,'b')-> 1  XofH(h,'z')-> -1
   /// si e=1 ou omis : Majus ou Minus, sinon Test carac
procedure IncH(var h:string; n:integer; v:integer=1);
procedure DecH(var h:string; n:integer; v:integer=1);



//==============================================================================
      IMPLEMENTATION
//==============================================================================


//------------------------------------------------------------------------------{*DER}
function DER(var O:TlistBox):integer;  begin result:=O.count-1       end;
function DER(var O:TComboBox):integer; begin result:=O.Items.Count-1 end;
function DER(var O:TMemo):integer;     begin result:=O.lines.count-1 end;

//------------------------------------------------------------------------------{*IDX}
function IDX(var O:TListBox):integer;  begin result:=O.ItemIndex end;
function IDX(var O:TComboBox):integer; begin result:=O.ItemIndex end;
function IDX(var O:Tmemo):integer;
  var s,n,c,l:integer;
  begin
  n:=0; c := -1;  l:=O.lines.count;
  s := O.SelStart;
  while (n<s) and (c<l) do begin n := posEx(#13,O.Text,n+1); inc(c) end;
  result:= c
  end;

//------------------------------------------------------------------------------{*LIG}
function  LIG(var O:TlistBox; n:integer):string;
  begin result := ''; 
  if (n>-1) and (n<O.count) then result := O.Items[n];
  end;
function  LIG(var O:TComboBox; n:integer):string;
  begin result := '';
  if (n>-1) and (n<O.items.count) then result := O.Items[n];
  end;
function  LIG(var O:TMemo; n:integer):string;
  begin result := ''; 
  if (n>-1) and (n<O.lines.count) then result := O.lines[n];
  end;

//------------------------------------------------------------------------------{*QTE}
function QTE(var O:TlistBox):integer;  begin result:=O.count       end;
function QTE(var O:TComboBox):integer; begin result:=O.items.count end;
function QTE(var O:TMemo):integer;     begin result:=O.lines.count end;

//------------------------------------------------------------------------------{*TXT}
function  TXT(var O:TListBox):string;
    begin
    result := '';
    if IDX(O)>-1 then result := LIG(O,IDX(O));
    end;
function  TXT(var O:TComboBox):string;
    begin
    result := '';
    if IDX(O)>-1 then result := LIG(O,IDX(O));
    end;
function  TXT(var O:TMemo):string;
    begin
    result := '';
    if IDX(O)>-1 then result := LIG(O,IDX(O));
    end;

//------------------------------------------------------------------------------{*XOF}
function  XOF(var O:TListBox; z:string; e:integer=1):integer;
   var i:integer;
   begin
   if e=1 then result := O.Items.IndexOf(z)
          else begin
               result := -1;
               z := uppercase(z);
               for i:=0 to DER(O) do
                   if pos(z,uppercase(LIG(O,i)))>0 then
                      begin
                      result := i;
                      exit
                      end;
               end;
   end;
function  XOF(var O:TComboBox; z:string; e:integer=1):integer;
   var i:integer;
   begin
   if e=1 then result := O.Items.IndexOf(z)
          else begin
               result := -1;
               z := uppercase(z);
               for i:=0 to DER(O) do
                   if pos(z,uppercase(LIG(O,i)))>0 then
                      begin
                      result := i;
                      exit
                      end;
               end;
   end;
function  XOF(var O:Tmemo; z:string; e:integer=1):integer;
   var i:integer;
   begin
   if e=1 then result := O.lines.indexof(z)
          else begin
               result := -1;
               z := uppercase(z);
               for i:=0 to DER(O) do
                   if pos(z,uppercase(LIG(O,i)))>0 then
                      begin
                      result := i;
                      exit
                      end;
               end;
   end;

//------------------------------------------------------------------------------{ADD}
procedure ADD(var O:TlistBox; z:string);  begin O.Items.Add(z) end;
procedure ADD(var O:Tmemo; z:string);     begin O.lines.add(z) end;
procedure ADD(var O:TcomboBox; z:string); begin O.items.add(z) end;
procedure ADD(var O:TEdit; z:string);     begin O.text := O.Text + z end;

//------------------------------------------------------------------------------{CHG}
Procedure CHG(var O:Tlistbox; fic:string);  begin O.items.LoadFromFile(fic); end;
Procedure CHG(var O:Tmemo; fic:string);     begin O.lines.LoadFromFile(fic); end;
Procedure CHG(var O:TcomboBox; fic:string); begin O.items.LoadFromFile(fic); end;

//------------------------------------------------------------------------------{ECR}
procedure ECR(var O:TListBox; n:integer; z:string);
  begin if (n>-1) and (n< QTE(O)) then O.Items[n] := z; end;
procedure ECR(var O:TComboBox; n:integer; z:string);
  begin  if (n>-1) and (n< QTE(O)) then
             begin
             O.Items[n] := z;
             O.ItemIndex := n;
             end;
  end;
procedure ECR(var O:TMemo; n:integer; z:string);
  begin  if (n>-1) and (n< QTE(O)) then O.lines[n] := z; end;
procedure ECR(var O:TEdit; z:string);
  begin O.Text := z; end;

//------------------------------------------------------------------------------{EFF}
Procedure EFF(var O:Tlistbox);  begin O.visible:=false end;
Procedure EFF(var O:Tmemo);     begin O.visible:=false end;
Procedure EFF(var O:TcomboBox); begin O.visible:=false end;
Procedure EFF(var O:Tpanel);    begin O.visible:=false end;
Procedure EFF(var O:Tedit);     begin O.visible:=false end;
Procedure EFF(var O:Tbutton);   begin O.visible:=false end;
Procedure EFF(var O:Timage);    begin O.visible:=false end;

//------------------------------------------------------------------------------{NDX}
procedure NDX(var O:TlistBox; n:integer);
begin
if n<O.Items.count then
   begin
   O.ItemIndex :=n;
   O.TopIndex := n;
   end;
end;
procedure NDX(var O:TComboBox; n:integer);
begin
if n<O.Items.count then O.ItemIndex :=n;
end;

//------------------------------------------------------------------------------{RAZ}
Procedure RAZ(var O:Tlistbox);  begin O.clear       end;
Procedure RAZ(var O:Tmemo);     begin O.clear       end;
Procedure RAZ(var O:TcomboBox); begin O.clear       end;
Procedure RAZ(var O:Tedit);     begin O.text:=''    end;
Procedure RAZ(var O:Tbutton);   begin O.caption:='' end;
Procedure RAZ(var O:Tpanel);    begin O.caption:='' end;

//------------------------------------------------------------------------------{SVG}
Procedure SVG(var O:Tlistbox; fic:string);  begin O.items.SaveToFile(fic); end;
Procedure SVG(var O:Tmemo; fic:string);     begin O.lines.SaveToFile(fic); end;
Procedure SVG(var O:TcomboBox; fic:string); begin O.items.SaveToFile(fic); end;

//------------------------------------------------------------------------------{VIS}
Procedure VIS(var O:Tlistbox);  begin O.visible:=true; O.BringToFront end;
Procedure VIS(var O:Tmemo);     begin O.visible:=true; O.BringToFront end;
Procedure VIS(var O:TcomboBox); begin O.visible:=true; O.BringToFront end;
Procedure VIS(var O:Tpanel);    begin O.visible:=true; O.BringToFront end;
Procedure VIS(var O:Tedit);     begin O.visible:=true; O.BringToFront end;
Procedure VIS(var O:Tbutton);   begin O.visible:=true; O.BringToFront end;
Procedure VIS(var O:TImage);    begin O.visible:=true; O.BringToFront end;

//------------------------------------------------------------------------------{ChgH}
procedure ChgH(var O:Tlistbox; H:string);
  var i:integer;
  begin
  if H='' then exit;   // vide par défaut
  RAZ(O);
  for i:=0 to DerH(H) do ADD(O,AnsiReplaceStr(getH(H,i),'¸',#59)); 
  end;
procedure ChgH(var O:Tmemo; H:string);
  var i:integer;
  begin if H='' then exit;   // vide par défaut
  RAZ(O);
  for i:=0 to DerH(H) do ADD(O,AnsiReplaceStr(getH(H,i),'¸',#59));
    // decoma(getH(H,i)));
  end;
  procedure ChgH(var O:TcomboBox; H:string);
  var i:integer;
  begin
  if H='' then exit;   // vide par défaut
  RAZ(O);
  for i:=0 to DerH(H) do ADD(O,AnsiReplaceStr(getH(H,i),'¸',#59)); 
  end;

//------------------------------------------------------------------------------{Style}
procedure Style(var O:Tlistbox;  S:TFontStyles); begin O.Font.Style := s; end;
procedure Style(var O:TCombobox; S:TFontStyles); begin O.Font.Style := s; end;
procedure Style(var O:TMemo;     S:TFontStyles); begin O.Font.Style := s; end;
procedure Style(var O:TPanel;    S:TFontStyles); begin O.Font.Style := s; end;
procedure Style(var O:TButton;   S:TFontStyles); begin O.Font.Style := s; end;
procedure Style(var O:Tedit;     S:TFontStyles); begin O.Font.Style := s; end;
procedure Style(var O:Tlabel;    S:TFontStyles); begin O.Font.Style := s; end;
//------------------------------------------------------------------------------{Style}
procedure Taille(var O:Tlistbox;  n:integer); begin O.Font.Size := n; end;
procedure Taille(var O:TCombobox; n:integer); begin O.Font.Size := n; end;
procedure Taille(var O:TMemo;     n:integer); begin O.Font.Size := n; end;
procedure Taille(var O:TPanel;    n:integer); begin O.Font.Size := n; end;
procedure Taille(var O:TButton;   n:integer); begin O.Font.Size := n; end;
procedure Taille(var O:Tedit;     n:integer); begin O.Font.Size := n; end;
procedure Taille(var O:Tlabel;    n:integer); begin O.Font.Size := n; end;

//------------------------------------------------------------------------------{*SvgH}
function SvgH(var O:Tlistbox):string;
  var i:integer; H:string;
  begin
  result := '';
  if QTE(O)=0 then exit;  // liste vide
  H := AnsiReplaceStr(LIG(O,0),#59,'¸'); // remplace les points virgule ligne 0
  result := H;  if QTE(O)=1 then exit;   // une seule ligne
  for i:=1 to DER(O) do addH(H,AnsiReplaceStr(LIG(O,i),#59,'¸'));
  result := H;
  end;
function SvgH(var O:TCombobox):string;
  var i:integer; H:string;
  begin
  result := '';
  if QTE(O)=0 then exit;  // liste vide
  H := AnsiReplaceStr(LIG(O,0),#59,'¸'); // remplace les points virgule ligne 0
  result := H;  if QTE(O)=1 then exit;   // une seule ligne
  for i:=1 to DER(O) do addH(H,AnsiReplaceStr(LIG(O,i),#59,'¸'));
  result := H;
  end;
function SvgH(var O:Tmemo):string;
  var i:integer; H:string;
  begin
  result := '';
  if QTE(O)=0 then exit;  // liste vide
  H := AnsiReplaceStr(LIG(O,0),#59,'¸'); // remplace les points virgule ligne 0
  result := H;  if QTE(O)=1 then exit;   // une seule ligne
  for i:=1 to DER(O) do addH(H,AnsiReplaceStr(LIG(O,i),#59,'¸'));
  result := H;
  end;

//______________________________________________________________________________
// Mise à jour 3 : Ajouts
//______________________________________________________________________________

//------------------------------------------------------------------------------{INS}
procedure INS(var O:Tlistbox;  l:integer; z:string); begin O.Items.Insert(l,z); end;
procedure INS(var O:TCombobox; l:integer; z:string); begin O.Items.Insert(l,z); end;
procedure INS(var O:Tmemo;     l:integer; z:string); begin O.Lines.Insert(l,z); end;

//------------------------------------------------------------------------------{DEL}
procedure DEL(var O:Tlistbox; l:integer);  begin O.Items.Delete(l); end;
procedure DEL(var O:TCombobox; l:integer); begin O.Items.Delete(l); end;
procedure DEL(var O:Tmemo; l:integer);     begin O.Lines.Delete(l); end;
  

//------------------------------------------------------------------------------{AFF}
procedure AFF(var O:TPanel;  z:string); begin O.Caption := z; end;
procedure AFF(var O:TButton; z:string); begin O.Caption := z; end;
procedure AFF(var O:TLabel;  z:string); begin O.Caption := z; end;
procedure AFF(var O:TEdit;   z:string); begin O.text    := z; end;

// le ; a été pris comme séparateur dans GestH afin d'être compatible avec les
// fichiers CSV d'excel  (il a juste fallu modifier les points virgule avant
// le stockage et les remettre au déstockage

procedure Filtre(var O:TopenDialog; Z:string; e:string);
    begin O.Filter := Z + '(*.' + e + ')|*' + e; end;
procedure Filtre(var O:TsaveDialog; Z:string; e:string);
    begin O.Filter := Z + '(*.' + e + ')|*' + e; end;


{functions et procedures diverses}

{--------------------------------------}
procedure Msg(t:string);
begin
messageDLG(t,mtinformation,[mbOk],0)
end;
procedure Msg2(t1,t2:string);
begin
messageDLG(t1+chr(10)+chr(13)+t2,mtinformation,[mbOk],0)
end;
procedure Msg3(t1,t2,t3:string);
begin
messageDLG(t1+chr(10)+chr(13)+t2+chr(10)+chr(13)+t3,mtinformation,[mbOk],0)
end;

//------------------------------------------------------------------------------
function  OuiNon(Q:string):boolean;  //use Dialogs pour messageDLG
begin
result := (messageDLG(Q,mtinformation,[mbOk,mbNo],0)= 1)
end;
//------------------------------------------------------------------------------
function  NonOui(Q:string):boolean;  //use Dialogs pour messageDLG
begin
result := (messageDLG(Q,mtinformation,[mbOk,mbNo],0)<> 1)
end;
//------------------------------------------------------------------------------
Function  JustG(T:string; N:byte):string;  //use StrUtils pour Dupestring
begin result := copy(trim(T)+DupeString(' ',N),1,N); End;
             //-----------//
Function  JustD(T:string; N:byte):string; //use StrUtils pour Dupestring
Var  L:byte; S:string;
Begin S := trim(T); L := length(S); result := DupeString(' ',N-L)+S; End;
             //-----------//
Function  JustC(T:string; N:byte):string; //use StrUtils pour Dupestring
var l:byte;
Begin
l := length(trim(T));
if l>N
   then result := copy(trim(T),1,N)
   else result := copy(dupestring(' ',(N-l) div 2) + T + dupestring(' ',N),1,N);
End;
//------------------------------------------------------------------------------
Function Len(z:string):integer;  begin result := length(z)       end;
Function Dup;                    begin result := dupestring(c,n) end;
function Str(n:integer):string;  begin result := inttostr(n)     end;
function Minus(z:string):string; begin result := lowercase(z)    end;
function Majus(z:string):string; begin result := uppercase(z)    end;
   
function  Min(N1,N2:integer):integer;
   begin if N1>N2 then result := N2 else result := N1 end;

function  Max(N1,N2:integer):integer;
   begin if N1<N2 then result := N2 else result := N1 end;

Function  Int(z:string):integer;
  var a,e:integer;
  begin val(z,a,e);
  if e>0 then a:= 0;
  result := a;
  end;
  
procedure Lim(var N:integer; Nmin,Nmax:integer); 
  begin N := min(Nmax,max(Nmin,N)) end;
  
{--------------------------------------}
function Extension(fic:string; ext:string):string;
begin
result := ChangeFileExt(fic,'.'+ext)
end;

///===================================== GestH ==================================================
function ZV(Z:variant):variant;
var i,e:integer;  d,d9:tdatetime;  w:string;
begin
val(z,i,e);
if e=0 then begin result := i; exit end;                          // integer
if (lowercase(z)='true')  then begin result := true; exit end;     // boolean
if (lowercase(z)='false') then begin result := false; exit end;    // boolean
d9 := encodedate(1945,12,31); w := z;
d := StrToDateDef(w,d9);
if d<>d9 then begin result := d ;exit end;
result := z;
end;

function VZ(v:variant):string;
begin
result := v;
end;

procedure RAZH(var h:string);            // h = ''
begin h := '';
end;

//-------------------------------------------------------------
function  QTEH(h:string):integer;    // nbre de champs
var c,n:integer;
begin
result := 0;
if trim(h)='' then exit;
result := 1;
n := pos(';',h);
if n=0 then exit;
c := 2;
repeat
    n := posEx(';',h,n+1);   // n+1
    if n>0 then inc(C);
until n=0;
result := c;
end;

//-------------------------------------------------------------
function  DERH(h:string):integer;    // n° du dernier champ (DIMH-1)
begin
result := QTEH(h)-1;
end;

//-------------------------------------------------------------
procedure ADDH(var h:string; v:variant); // ajoute le champ v à la fin
begin
h := h + ';' + vz(v);
end;

//-------------------------------------------------------------
procedure INSH(var h:string; v:variant; n:integer); // ajoute le champ v à la pos n
  ///  h=a;b;c;d   insh(h,9,1)-> a;9;b;c;d
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('INSH('+h+','+v+','+inttostr(n)+') : n>derh(h)'); exit end;
if c=0 then       // un seul champ
   begin
   h := vz(v) + ';' + h;            // x;a
   exit
   end;
x  := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then         // 1er champ
   begin
   h := vz(v) + ';' + h;   // a;b;c;d;e; -> x;a;b;c;d;e;
   exit
   end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
h := copy(h,1,n1) + vz(v) + ';' + copy(h,n1+1,length(h));
end;

//-------------------------------------------------------------
procedure DELH(var h:string; n:integer); // supprime le champ n
  ///  h=a;b;c;d   delh(h,1)-> a;c;d
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('Erreur : n > derh(h)'); exit end;
if c=0 then       // un seul champ
   begin
   h := '';
   exit
   end;
x := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then         // 1er champ
   begin
   h := copy(h,n2-1,length(h));   // a;b;c;d;e; -> b;c;d;e;
   exit
   end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
if n=c
   then h := copy(h,1,n1-1)
   else h := copy(h,1,n1) + copy(h,n2+1,length(h));
end;

//-------------------------------------------------------------
procedure PUTH(var h:string; v:variant; n:integer); // ecrit le champ v à la pos n
  ///  h=a;b;c;d   ecrh(h,9,1)-> a;9;c;d
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('Erreur : n > derh(h)'); exit end;
if c=0 then       // un seul champ
   begin
   h := vz(v);
   exit
   end;
x  := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then         // 1er champ
   begin
   h := vz(v) + copy(h,n2,length(h));   // v;x;x;x;x;
   exit
   end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
if n=c
   then h := copy(h,1,n1) + vz(v)
   else h := copy(h,1,n1) + vz(v) + copy(h,n2,length(h));
end;

//-------------------------------------------------------------
function  GETH(h:string; n:integer):variant;
  ///  h=a;b;c;d   geth(h,1)-> b
var c,n1,n2,x:integer;
begin
c := derh(h);
if n>c then begin showmessage('GETH(var h:string n:integer) : n > derh(h)'); exit end;
if c=0 then begin result := h; exit end;  // un seul champ
x := 0;
n1 := 0;
n2 := pos(';',h);
if n=0 then begin result := copy(h,1,n2-1); exit end;
while n>x do begin
    inc(x);
    n1 := n2;
    n2 := posEx(';',h,n1+1);
    end;
if n=c
   then result := copy(h,n1+1,length(h))
   else result := copy(h,n1+1,n2-n1-1);
end;

//-------------------------------------------------------------
function  XofH(h:string; v:variant; e:integer=1):integer;
  /// renvoie position colonne de V dans H
  /// h=a;b;c;d   XofH(h,'b')-> 1  XofH(h,'z')-> -1
  /// si e=1 ou omis : Majus ou Minus, sinon Test carac
  var z:string; n,d:integer;
begin
 z := vz(v);
 if e=1 then 
    begin
    H := uppercase(H);
    Z := uppercase(Z);
    end;
result := -1; // par défaut : pas trouvé
// x := -1;
n := -1; d := derh(H);
 while n<d do
   begin
   inc(n);
   if z=geth(H,n) then 
      begin
      result := n;
      n := d;
      end;
   end;
end;

//-------------------------------------------------------------
procedure IncH(var h:string; n:integer; v:integer=1);
var x:integer;
begin
x := geth(H,n) + v;
puth(H,x,n);
end;
//-------------------------------------------------------------
procedure DecH(var h:string; n:integer; v:integer=1);
var x:integer;
begin
x := geth(H,n) - v;
puth(H,x,n);
end;



//==============================================================================
             END.
//==============================================================================


