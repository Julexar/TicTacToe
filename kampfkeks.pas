unit kampfkeks; //Dies ist der Bot

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, spieler;
type TBot=class(TSpieler)
  private
     botNr:integer;
     belegung:array[1..3, 1..3] of Integer;
  public
     procedure calculate; override;
     constructor create(Nummer:integer);  overload;
end;

implementation
uses spielfeld;
var
  i,j:integer;
constructor TBot.create(Nummer:integer);
begin
    inherited create;
    botNr:=Nummer;
    infos:='Bot '+inttostr(botNr);
end;

procedure TBot.calculate; //Überprüfe ob Bot dran ist
var
  a,b,r:integer;
begin
    Form1.label1.caption:='Du bist dran Bot '+inttostr(botNr)+'!';
    for i:=1 to 3 do  //Alle Felder werden durchgegangen
        begin
             for j:=1 to 3 do
                 begin
                 //Überprüfe ob Bot gewinnen kann.
                     for a:=1 to 3 do
                         begin
                              if ((Form1.getBelegung(a,1)=Form1.getBelegung(a,2)) AND (Form1.getBelegung(a,1)=botNr)) XOR ((Form1.getBelegung(a,1)=Form1.getBelegung(a,3)) AND (Form1.getBelegung(a,1)=botNr)) XOR ((Form1.getBelegung(a,2)=Form1.getBelegung(a,3)) AND (Form1.getBelegung(a,2)=botNr)) then
                                 begin
                                      for b:=1 to 3 do
                                          begin                                                                //Zeilen durchsuchen und Zug machen
                                              if (Form1.getBelegung(a,b)=0) then
                                                 begin
                                                      Form1.zug(a,b);
                                                      exit;
                                                 end
                                          end
                                 end;
                              if ((Form1.getBelegung(1,a)=Form1.getBelegung(2,a)) AND (Form1.getBelegung(1,a)=botNr)) XOR ((Form1.getBelegung(1,a)=Form1.getBelegung(3,a)) AND (Form1.getBelegung(1,a)=botNr)) XOR ((Form1.getBelegung(2,a)=Form1.getBelegung(3,a)) AND (Form1.getBelegung(2,a)=botNr)) then
                                 begin
                                      for b:=1 to 3 do
                                          begin                                                            //Spalten durchsuchen und Zug machen
                                              if (Form1.getBelegung(b,a)=0) then
                                                 begin
                                                      Form1.zug(b,a);
                                                      exit;
                                                 end
                                          end
                                 end;
                         end;
                     if ((Form1.getBelegung(1,1)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) XOR ((Form1.getBelegung(1,1)=Form1.getBelegung(3,3)) AND (Form1.getBelegung(3,3)=botNr)) XOR ((Form1.getBelegung(2,2)=Form1.getBelegung(3,3)) AND (Form1.getBelegung(3,3)=botNr)) then
                        begin
                             if (Form1.getBelegung(1,1)=0) then                       //erste Diagonale durchsuchen und Zug machen
                                begin
                                     Form1.zug(1,1);
                                     exit;
                                end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       exit;
                                  end
                             else if (Form1.getBelegung(3,3)=0) then
                                  begin
                                       Form1.zug(3,3);
                                       exit;
                                  end
                        end;
                     if ((Form1.getBelegung(1,3)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) XOR ((Form1.getBelegung(1,3)=Form1.getBelegung(3,1)) AND (Form1.getBelegung(3,1)=botNr)) XOR ((Form1.getBelegung(3,1)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) then
                        begin
                             if (Form1.getBelegung(1,3)=0) then
                                begin
                                     Form1.zug(1,3);                                 //zweite Diagonale durchsuchen und Zug machen
                                     exit;
                                end
                             else if (Form1.getBelegung(3,1)=0) then
                                  begin
                                       Form1.zug(3,1);
                                       exit;
                                  end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       exit;
                                  end
                        end;
                      //Überprüfe ob Gegner gewinnen kann
                     for a:=1 to 3 do
                         begin
                              if ((Form1.getBelegung(a,1)=Form1.getBelegung(a,2)) AND NOT (Form1.getBelegung(a,1)=botNr) AND (Form1.getBelegung(a,1)>0)) XOR ((Form1.getBelegung(a,1)=Form1.getBelegung(a,3)) AND NOT (Form1.getBelegung(a,1)=botNr) AND (Form1.getBelegung(a,1)>0)) XOR ((Form1.getBelegung(a,2)=Form1.getBelegung(a,3)) AND NOT (Form1.getBelegung(a,2)=botNr) AND (Form1.getBelegung(a,2)>0)) then         
                                 begin
                                      for b:=1 to 3 do
                                          begin
                                               if (Form1.getBelegung(a,b)=0) then                      //Zeilen durchsuchen und Zug machen
                                                   begin
                                                        Form1.zug(a,b);
                                                        exit;
                                                   end
                                           end
                                  end;
                               if ((Form1.getBelegung(1,a)=Form1.getBelegung(2,a)) AND NOT (Form1.getBelegung(1,a)=botNr) AND (Form1.getBelegung(1,a)>0)) XOR ((Form1.getBelegung(1,a)=Form1.getBelegung(3,a)) AND NOT (Form1.getBelegung(1,a)=botNr) AND (Form1.getBelegung(1,a)>0)) XOR ((Form1.getBelegung(2,a)=Form1.getBelegung(3,a)) AND NOT (Form1.getBelegung(2,a)=botNr) AND (Form1.getBelegung(2,a)>0)) then
                                  begin
                                       for b:=1 to 3 do                                                       //Spalten durchsuchen und Zug machen
                                           begin
                                                if (Form1.getBelegung(b,a)=0) then
                                                   begin
                                                        Form1.zug(b,a);
                                                        exit;
                                                   end
                                           end                                                            
                                  end;
                          end;
                     if ((Form1.getBelegung(1,1)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) XOR ((Form1.getBelegung(1,1)=Form1.getBelegung(3,3)) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) XOR ((Form1.getBelegung(2,2)=Form1.getBelegung(3,3)) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) then
                        begin
                             if (Form1.getBelegung(1,1)=0) then                       //erste Diagonale durchsuchen
                                begin
                                     Form1.zug(1,1);
                                     exit;
                                end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       exit;
                                  end
                             else if (Form1.getBelegung(3,3)=0) then
                                  begin
                                       Form1.zug(3,3);
                                       exit;
                                  end
                        end;
                     if ((Form1.getBelegung(1,3)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) XOR ((Form1.getBelegung(1,3)=Form1.getBelegung(3,1)) AND NOT (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(3,1)>0)) XOR ((Form1.getBelegung(3,1)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) then
                        begin
                             if (Form1.getBelegung(1,3)=0) then
                                begin
                                     Form1.zug(1,3);                                 //zweite Diagonale durchsuchen
                                     exit;
                                end
                             else if (Form1.getBelegung(3,1)=0) then
                                  begin
                                       Form1.zug(3,1);
                                       exit;
                                  end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       exit;
                                  end
                        end;
                     //Überprüfe ob Mitte frei ist
                     if (Form1.getBelegung(2,2)=0) then
                          begin
                             Form1.zug(2,2); //Setze, wenn Mitte frei ist
                             exit;
                          end
                     else 
                          begin
                              //Sonst setze in eine der Ecken
                              r:=random(4)+1;
                              if (r=1) AND (Form1.getBelegung(1,1)=0) then
                                  begin
                                      Form1.zug(1,1);
                                      exit;
                                  end
                              else if (r=2) AND (Form1.getBelegung(3,1)=0) then
                                  begin
                                      Form1.zug(3,1);
                                      exit;
                                  end
                              else if (r=3) AND (Form1.getBelegung(1,3)=0) then
                                  begin
                                      Form1.zug(1,3);
                                      exit;
                                  end
                              else if (r=4) AND (Form1.getBelegung(3,3)=0) then
                                  begin
                                      Form1.zug(3,3);
                                      exit;
                                  end
                          end;
                 end;
        end;
end;

end.

