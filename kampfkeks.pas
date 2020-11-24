unit kampfkeks;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, spieler;
type TBot=class(TSpieler)
  private
     botNr:integer;

  public
     procedure calculate; override;
     constructor create(Nummer:integer);  overload;
end;

implementation
uses spielfeld;
var
  i,j,e:integer;
constructor TBot.create(Nummer:integer);
begin
    inherited create;
    botNr:=Nummer;
     e:=0;
    infos:='Bot '+inttostr(botNr);
end;
procedure TBot.calculate; //Überprüfe ob Bot dran ist
var
  a,b,r,h,p:integer;
begin
    Form1.label1.caption:='Du bist dran Bot '+inttostr(botNr)+'!';
    for h:=1 to 3 do
    begin
         for p:=1 to 3 do
         begin
           e:=e+(Form1.getBelegung(h,p));
         end
    end;
//---------------------------------------------------------------------------------------------------------------------------------------------------------
    //Setze auf die Diagonale beim ersten Zug, wenn alle Felder frei sind
    if e=0 then
       begin
            r:=random(4)+1;
            if (r=1) AND (Form1.getBelegung(1,1)=0) then
               begin
                    Form1.zug(1,1);
                    infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                    exit;
               end
            else if (r=2) AND (Form1.getBelegung(3,1)=0) then
                 begin
                      Form1.zug(3,1);
                      infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                      exit;
                 end
            else if (r=3) AND (Form1.getBelegung(1,3)=0) then
                 begin
                      Form1.zug(1,3);
                      infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                      exit;
                 end
            else if (r=4) AND (Form1.getBelegung(3,3)=0) then
                 begin
                      Form1.zug(3,3);
                      infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                      exit;
                 end
       end;
    Form1.delay(1000);
    for i:=1 to 3 do  //Alle Felder werden durchgegangen
        begin
             for j:=1 to 3 do
                 begin
    //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
                                                      infos:=infos+#13#10+inttostr(a)+', '+inttostr(b);
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
                                                      infos:=infos+#13#10+inttostr(b)+', '+inttostr(a);
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
                                     infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                                     exit;
                                end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       infos:=infos+#13#10+inttostr(2)+', '+inttostr(2);
                                       exit;
                                  end
                             else if (Form1.getBelegung(3,3)=0) then
                                  begin
                                       Form1.zug(3,3);
                                       infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                                       exit;
                                  end
                        end;
                     if ((Form1.getBelegung(1,3)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) XOR ((Form1.getBelegung(1,3)=Form1.getBelegung(3,1)) AND (Form1.getBelegung(3,1)=botNr)) XOR ((Form1.getBelegung(3,1)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) then
                        begin
                             if (Form1.getBelegung(1,3)=0) then
                                begin
                                     Form1.zug(1,3);                                 //zweite Diagonale durchsuchen und Zug machen
                                     infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                                     exit;
                                end
                             else if (Form1.getBelegung(3,1)=0) then
                                  begin
                                       Form1.zug(3,1);
                                       infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                                       exit;
                                  end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       infos:=infos+#13#10+inttostr(2)+', '+inttostr(2);
                                       exit;
                                  end
                        end;

                //--------------------------------------------------------------------------------------------------------------------------------------------------------

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
                                                        infos:=infos+#13#10+inttostr(a)+', '+inttostr(b);
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
                                                        infos:=infos+#13#10+inttostr(b)+', '+inttostr(a);
                                                        exit;
                                                   end
                                           end                                                            
                                  end;
                          end;
                     if ((Form1.getBelegung(1,1)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) XOR ((Form1.getBelegung(1,1)=Form1.getBelegung(3,3)) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) XOR ((Form1.getBelegung(2,2)=Form1.getBelegung(3,3)) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) then
                        begin
                             if (Form1.getBelegung(1,1)=0) then                       //erste Diagonale durchsuchen und zug machen
                                begin
                                     Form1.zug(1,1);
                                     infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                                     exit;
                                end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       infos:=infos+#13#10+inttostr(2)+', '+inttostr(2);
                                       exit;
                                  end
                             else if (Form1.getBelegung(3,3)=0) then
                                  begin
                                       Form1.zug(3,3);
                                       infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                                       exit;
                                  end
                        end;
                     if ((Form1.getBelegung(1,3)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) XOR ((Form1.getBelegung(1,3)=Form1.getBelegung(3,1)) AND NOT (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(3,1)>0)) XOR ((Form1.getBelegung(3,1)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) then
                        begin
                             if (Form1.getBelegung(1,3)=0) then
                                begin
                                     Form1.zug(1,3);                                 //zweite Diagonale durchsuchen und Zug machen
                                     infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                                     exit;
                                end
                             else if (Form1.getBelegung(3,1)=0) then
                                  begin
                                       Form1.zug(3,1);
                                       infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                                       exit;
                                  end
                             else if (Form1.getBelegung(2,2)=0) then
                                  begin
                                       Form1.zug(2,2);
                                       infos:=infos+#13#10+inttostr(2)+', '+inttostr(2);
                                       exit;
                                  end
                        end;

                //--------------------------------------------------------------------------------------------------------------------------------------------------
                //Überprüfe nach Zwickmühlen (in Arbeit).
                     if (NOT (Form1.getBelegung(1,1)=botNr) AND (Form1.getBelegung(1,1)>0) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) XOR (NOT (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(3,1)>0) AND NOT (Form1.getBelegung(1,3)=botNr) AND (Form1.getBelegung(1,3)>0)) then
                          begin
                               r:=random(4)+1;
                               if r=1 then
                                    begin
                                         Form1.zug(1,2);
                                         infos:=infos+#13#10+inttostr(1)+', '+inttostr(2);
                                         exit;
                                    end
                               else if r=2 then
                                   begin
                                        Form1.zug(3,2);
                                        infos:=infos+#13#10+inttostr(3)+', '+inttostr(2);
                                        exit;
                                   end
                               else if r=3 then
                                   begin
                                        Form1.zug(2,1);
                                        infos:=infos+#13#10+inttostr(2)+', '+inttostr(1);
                                        exit;
                                   end
                               else if r=4 then
                                   begin
                                        Form1.zug(2,3);
                                        infos:=infos+#13#10+inttostr(2)+', '+inttostr(3);
                                        exit;
                                   end;
                          end;
                     if (Form1.getBelegung(2,2)=botNr) then
                         begin
                              if (NOT (Form1.getBelegung(2,1)=botNr) AND (Form1.getBelegung(2,1)>0)) then
                                  begin
                                       r:=random(4)+1;
                                       if (r>2) AND (Form1.getBelegung(1,1)=0) then
                                           begin
                                                Form1.zug(1,1);
                                                infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                                                exit;
                                           end
                                       else if (r<=2) AND (Form1.getBelegung(3,1)=0) then
                                           begin
                                                Form1.zug(3,1);
                                                infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                                                exit;
                                           end
                                  end
                              else if (NOT (Form1.getBelegung(2,3)=botNr) AND (Form1.getBelegung(2,3)>0)) then
                                  begin
                                       r:=random(4)+1;
                                       if (r>2) AND (Form1.getBelegung(1,3)=0) then
                                           begin
                                                Form1.zug(1,3);
                                                infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                                                exit;
                                           end
                                       else if (r<=2) AND (Form1.getBelegung(3,3)=0) then
                                           begin
                                                Form1.zug(3,3);
                                                infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                                                exit;
                                           end
                                  end;
                         end;


                //--------------------------------------------------------------------------------------------------------------------------------------------------
                //Stelle selbst Zwickühlen.
                     if (Form1.getBelegung(1,1)=botNr) AND (Form1.getBelegung(3,3)=botNr) then
                         begin
                              if (Form1.getBelegung(1,3)=0) then
                                  begin
                                       Form1.zug(1,3);
                                       infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                                       exit;
                                  end
                              else if (Form1.getBelegung(3,1)=0) then
                                  begin
                                       Form1.zug(3,1);
                                       infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                                       exit;
                                  end;
                         end
                     else if (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(1,3)=botNr) then
                         begin
                              if (Form1.getBelegung(1,1)=0) then
                                  begin
                                       Form1.zug(1,1);
                                       infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                                       exit;
                                  end
                              else if (Form1.getBelegung(3,3)=0) then
                                  begin
                                       Form1.zug(3,3);
                                       infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                                       exit;
                                  end;
                         end;

                //--------------------------------------------------------------------------------------------------------------------------------------------------

                //Überprüfe ob Mitte frei ist

                     if (Form1.getBelegung(2,2)=0) then
                          begin
                             Form1.zug(2,2); //Setze, wenn Mitte frei ist
                             infos:=infos+#13#10+inttostr(2)+', '+inttostr(2);
                             exit;
                          end
                     else 
                          begin
                              //Setze auf das gegenüberliegende diagonale Feld, wenn es frei ist.
                              if (Form1.getBelegung(1,1)=botNr) AND (Form1.getBelegung(3,3)=0) then
                                 begin
                                      Form1.zug(3,3);
                                      infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                                      exit;
                                 end
                              else if (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(1,3)=0) then
                                   begin
                                        Form1.zug(1,3);
                                        infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                                        exit;
                                   end
                              else if (Form1.getBelegung(1,3)=botNr) AND (Form1.getBelegung(3,1)=0) then
                                   begin
                                        Form1.zug(3,1);
                                        infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                                        exit;
                                   end
                              else if (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(1,1)=0) then
                                   begin
                                        Form1.zug(1,1);
                                        infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                                        exit;
                                   end;
                              //Sonst setze in eine der Ecken
                              if (Form1.getBelegung(1,1)=0) then
                                  begin
                                      Form1.zug(1,1);
                                      infos:=infos+#13#10+inttostr(1)+', '+inttostr(1);
                                      exit;
                                  end
                              else if (Form1.getBelegung(3,1)=0) then
                                  begin
                                      Form1.zug(3,1);
                                      infos:=infos+#13#10+inttostr(3)+', '+inttostr(1);
                                      exit;
                                  end
                              else if (Form1.getBelegung(1,3)=0) then
                                  begin
                                      Form1.zug(1,3);
                                      infos:=infos+#13#10+inttostr(1)+', '+inttostr(3);
                                      exit;
                                  end
                              else if (Form1.getBelegung(3,3)=0) then
                                  begin
                                      Form1.zug(3,3);
                                      infos:=infos+#13#10+inttostr(3)+', '+inttostr(3);
                                      exit;
                                  end;
                          end;
                     //Setze auf die Seiten
                     //Überprüfe ob eine Zeile vom Bot oder Gegner und ob eine andere Zeile in derselben Spalte vom Bot oder Gegner belegt wurde
                     if (Form1.getBelegung(2,1)=0) then
                         begin
                               Form1.zug(2,1);
                               infos:=infos+#13#10+inttostr(2)+', '+inttostr(1);
                               exit;
                         end
                     else if (Form1.getBelegung(1,2)=0) then
                         begin
                               Form1.zug(1,2);
                               infos:=infos+#13#10+inttostr(1)+', '+inttostr(2);
                               exit;
                         end
                     else if (Form1.getBelegung(3,2)=0) then
                         begin
                               Form1.zug(3,2);
                               infos:=infos+#13#10+inttostr(3)+', '+inttostr(2);
                               exit;
                         end
                     else if (Form1.getBelegung(2,3)=0) then
                         begin
                               Form1.zug(2,3);
                               infos:=infos+#13#10+inttostr(2)+', '+inttostr(3);
                               exit;
                         end;
                 end;
        end;
end;

end.

