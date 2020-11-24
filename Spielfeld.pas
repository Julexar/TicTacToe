unit Spielfeld;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, ActnList, Spieler, kampfkeks;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Info2: TLabel;                                     //hier können Nachrichten an die spieler stehen
    Info3: TLabel;                                     //oder Informationen, was im Programm nicht funktioniert hat
    Spieler2: TRadioGroup;
    StartKnopf: TButton;
    Label1: TLabel;
    Panel1: TPanel;                                     //ist nur ein Muster, von dem zur Laufzeit erzeugte Panels abschreiben können
    Spieler1: TRadioGroup;                              //Hier wird der 1. Spieler festgelegt
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Feldklik(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure StartKnopfClick(Sender: TObject);
    procedure Wechsel();
    Procedure Bild();
    function Sieg: boolean;
    Procedure Start();
  private
    { private declarations }
    Belegung: array[1..3, 1..3] of Integer;                //das Spielfeld mit 0 für frei, 1 für Spieler 1, 2 für Spieler 2
    Feld: array[1..3, 1..3] of  TPanel;                   //Die visualisierung des Spielfeldes mit Panels
    spieler: array[1..2] of TSpieler;                     //Zwei Spieler spielen mit.
    dran: integer;                                        //Diese Variable kontrolliert, welcher Spieler gerade dran ist.
    Sieger: integer;
    gewaehlt1: boolean;                                         //ob Spieler 1 bereits existiert.
    gewaehlt2: boolean;                                         //ob Spieler 2 bereits existiert.
    bot:array[1..2] of TBot;
  public
    { public declarations }
    function getBelegung(i: Integer; j:Integer): integer;       //0 heißt frei, 1/2 heißt Spieler 1/2 hat schon drauf gesetzt
    procedure Zug(i, j:Integer);                                //es wird auf das Feld i,j gesetzt.
    procedure Delay(dt: QWORD);
  end;

var
  Form1: TForm1;

implementation

uses Mensch;
{$R *.lfm}

{ TForm1 }

//____________________________________________________________________________________________________________________________
procedure TForm1.StartKnopfClick(Sender: TObject);
begin
  start;
  gewaehlt1:=true;
  gewaehlt2:=true;
  if Spieler1.ItemIndex=-1 then Spieler1.ItemIndex:=0;             //Falls nichts ausgewählt wurde, sind beide Spieler Menschen
  if Spieler2.ItemIndex=-1 then Spieler2.ItemIndex:=0;
  case Spieler1.Items[Spieler1.ItemIndex] of                      //welcher Fall tritt ein?
        'Mensch':     Spieler[1]:=TMensch.create(1);              //ist mensch ausgewählt wird ein Mensch-avatar erschaffen
        'Computer':   Spieler[1]:=TBot.create(1);             //ist computer ausgewählt, wird ein virtueller Gegner erzeugt.
      end;                                                        //statt einem Spieler, muss hier ein davon abgeleitetes Programm eingesetzt werden.

  case Spieler2.Items[Spieler2.ItemIndex] of
        'Mensch':     Spieler[2]:=TMensch.create(2);
        'Computer':   Spieler[2]:=TBot.create(2);
      end;
  Spieler[1].calculate;
end;


procedure TForm1.start;//   Das Spielfeld wird aufgebaut
var i,j: integer;
begin
  dran:=1;                                                //Spieler1 fängt an
  sieger:=0;                                              //noch hat keiner gewonnen
  label1.Caption:='Es beginnt Spieler: '+inttostr(dran);  //es wird angezeigt, wer anfängt. So kann ein Mensch erfahren, wer dran ist.
  Info2.Caption:='';                                      //es gibt noch keine anzuzeigenden Infos
  Info3.Caption:='';
  for i:=1 to 3 do
  begin
     for j:=1 to 3 do
     begin
         Belegung[i][j]:=0;                             //kein Feld ist belegt
         Feld[i][j]:=TPanel.Create(Self);               //die Panels sind die auf dem Monitor sichtbaren Felder
         Feld[i][j].Parent := Self;
         Feld[i][j].Caption :='';
         Feld[i][j].Left := 100*j;
         Feld[i][j].Top := 100*i;
         Feld[i][j].Color := clDefault;
         Feld[i][j].width := 100;
         Feld[i][j].Height := 100;
         Feld[i][j].OnClick := Panel1.onClick;          //die onklickmethode wird von Panel1 übernommen
         Feld[i][j].font.size:=50;
     end;
  end;
end;

//_______________________________________________________________________________________________________________________________


procedure TForm1.Wechsel();                                  //Die spieler sind abwechselnd dran.
begin
  if dran=1 then dran:=2
  else if dran=2 then dran:=1;
  label1.caption:='Dran ist Spieler: '+inttostr(dran);
  Spieler[dran].calculate;                                  //der Spieler der dran ist, berechnet seinen nächsten Zug.
end;

procedure TForm1.Feldklik(sender: TObject);           //Was passiert wenn ein Spieler auf ein Panel click
var i,j: integer;
  begin
    for i:=1 to 3 do
       for j:=1 to 3 do
       if sender=Feld[i][j] then                      //es wird geprüft, auf welches Feld geklickt wurde
       begin
         if dran=0 then                               //wenn niemand dran ist, passiert auch nichts.
         else                                        //sonst passiert was
          begin
            Spieler[dran].infos:=spieler[dran].infos+#13#10+inttostr(i)+', '+inttostr(j);  //der Zug wird protokolliert
            Zug(i,j);                                //der Zug wird ausgeführt
          end;
       end;
  end;

procedure TForm1.Zug(i: integer; j: integer);               //auf das Panel i, j gesetzt wird.
var passt:boolean;
begin
  passt:=false;                                            //es wurde noch nicht geprüft, ob i,j ein erlaubtes Feld ist
  if (0<i)and(i<4)and(0<j)and(j<4) then                    //i und j sollen nur Werte von 1 bis 3 annehmen
  begin
    if Belegung[i][j]=0 then                               //wenn das Feld noch frei ist
      begin
         passt:=true;                                      //dieses Feld passt
         Belegung[i][j]:=dran;                             //wer dran hat gerade das Feld i,j belegt
         Bild;                                             //das ganze Feld wird aktuell angezeigt
         if NOT(Sieg) then  Wechsel;
      end;
  end;
  if NOT(passt) then                                  //wenn das Feld nicht passt
  begin
      label1.Caption:='Spieler '+inttostr(spieler[dran].SpielerNR)+' versuch es nochmal';    //menschen können lesen, was schief gelaufen ist.
      Spieler[dran].infos:=Spieler[dran].infos+#13#10+'Fehlzug, i='+inttostr(i)+', j='+inttostr(j);  //bei spieler wird im Info-String eine Fehlermeldung geschrieben.
  end;
end;

//_____________________________________________________________________________________________________________________________________________


function TForm1.Sieg:boolean;                             //prüft ob und wenn ja welcher Spieler gewonnen hat.
var a,i,j: integer;
begin
  sieger:=0;
  for a:=1 to 3 do
  begin
      if (Belegung[a][1]=Belegung[a][2]) AND (Belegung[a][1]=Belegung[a][3]) AND (Belegung[a][1]>0) then
         sieger:=Belegung[a][1]                                         //Zeilen durchsuchen
      else if (Belegung[1][a]=Belegung[2][a]) AND (Belegung[1][a]=Belegung[3][a]) AND (Belegung[1][a]>0) then
         sieger:=Belegung[1][a];                                         //Spalten durchsuchen
  end;
  if (Belegung[1][1]=Belegung[2][2]) AND (Belegung[1][1]=Belegung[3][3]) AND (Belegung[2][2]>0) then
      sieger:=Belegung[1][1]                                            //erste Diagonale durchsuchen
  else if (Belegung[1][3]=Belegung[2][2]) AND (Belegung[1][3]=Belegung[3][1]) AND (Belegung[2][2]>0) then
      sieger:=Belegung[2][2];                                            //zweite Diagonale durchsuchen
  if sieger=0 then
  begin
    result:=false;
    a:=0;
    for i:=1 to 3 do
      for j:=1 to 3 do
        if Belegung[i][j]>0 then a:=a+1;                                 //a zählt die Anzahl der belegten Felder
    if a=9 then
    begin
      label1.caption:='unendschieden';                        //wenn alle Felder voll sind, ist das Spiel vorbei
      result:=true;                                           //es hat niemand gesiegt, aber das Spiel ist dennoch vorbei.
    end;
  end
  else
  begin
    label1.caption:='Spieler '+ inttostr(sieger) + ' hat gewonnen';
    dran:=0;
    result:=true;
  end;
end;

//__________________________________________________________________________________________________________________

Procedure TForm1.Bild();                          //Das graphische Spielfeld wird aktualisiert.
var i,j: integer;
begin
  for i:=1 to 3 do
  begin
     for j:=1 to 3 do
     begin
       if Belegung[i][j]=1 then                        //Wenn Spieler 1 auf (i,j) gesetzt hat
       begin
         Feld[i][j].Caption:='X';
         Feld[i][j].Color:=clLime;
       end;
       if Belegung[i][j]=2 then
       begin
         Feld[i][j].Caption:='O';
         Feld[i][j].Color:=clRed;
       end;
     end;
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  if gewaehlt1 then Info3.caption:=Spieler[1].infos
  else Info3.caption:='Bitte wähle Spieler1 aus!';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if gewaehlt2 then Info2.caption:=Spieler[2].infos
  else Info2.caption:='Bitte wähle Spieler2 aus!';
end;


procedure TForm1.Panel1Click(Sender: TObject);
begin
  Feldklik(Sender);
end;

function TForm1.getBelegung(i: Integer; j:Integer): integer;
  begin
    if (0<i)and(i<4)and(0<j)and(j<4) then
       result:=Belegung[i,j]
    else
    begin
        showmessage('Belegung falsch abgefragt');
        Spieler[dran].infos:=Spieler[dran].infos+#13#10+'Belegung falsch abgefragt, i='+inttostr(i)+', j='+inttostr(j);
        result:=-1;                                                                 //so kann überprüft werden, ob die Belegung erfolgreich abgefragt wurde
    end;
  end;
//-----------------------------------------------------------------------------------------------
procedure TForm1.Delay(dt: QWORD);            //Bleibe auf dem Screen, damit man das Ergebnis sieht
var
  tc:QWORD;
begin
  tc:=GetTickCount64;
  while (GetTickCount64<tc+dt) and (not Application.Terminated) do
    Application.ProcessMessages;
end;

end.

