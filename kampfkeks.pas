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
		procedure ecken();
		procedure setInfos(m:integer; n:integer);
		procedure ersteDiag();
		procedure zweiteDiag();
		procedure zeilen();
		procedure spalten();
		procedure ziehe(s:integer; t:integer);
                constructor create(Nummer:integer); overload;
	end;
implementation
uses spielfeld;
var
	i,j,e,r,b,a,test:integer;
constructor TBot.create(Nummer:integer);
begin
        //Erstelle den Bot.
	inherited create;
	botNr:=Nummer;
	e:=0;
	infos:='Bot '+inttostr(botNr);
end;
procedure TBot.setInfos(m:integer; n:integer);
begin
	infos:=infos+#13#10+inttostr(m)+', '+inttostr(n); //Ändere die Infos
end;
procedure TBot.ziehe(s:integer; t:integer);
begin
	if test=botNr then
	begin
		if (Form1.getBelegung(s,t)=0) then
		begin				//Mache einen Zug
			Form1.zug(s,t);
			setInfos(s,t);
			if (Form1.getBelegung(s,t)=botNr) then test:=test+1;
		end;
        end;
end;
procedure TBot.ecken();
begin
	//Setze in eine der Ecken.
	if test=botNr then
	begin
             r:=random(4)+1;
		if (r=1) AND (Form1.getBelegung(1,1)=0) then ziehe(1,1)
		else if (r=2) AND (Form1.getBelegung(3,1)=0) then ziehe(3,1)
		else if (r=3) AND (Form1.getBelegung(1,3)=0) then ziehe(1,3)
		else if (r=4) AND (Form1.getBelegung(3,3)=0) then ziehe(3,3);
end
end;
procedure TBot.ersteDiag();
begin
	//Gehe die erste Diagonale durch und setze
	if test=botNr then
	begin
		if (Form1.getBelegung(1,1)=0) then ziehe(1,1)
		else if (Form1.getBelegung(2,2)=0) then ziehe(2,2)
		else if (Form1.getBelegung(3,3)=0) then ziehe(3,3);
	end
end;
procedure TBot.zweiteDiag();
begin
	//Gehe die zweite Diagonale durch und setze
	if test=botNr then
	begin
		if (Form1.getBelegung(1,3)=0) then ziehe(1,3)
		else if (Form1.getBelegung(3,1)=0) then ziehe(3,1)
		else if (Form1.getBelegung(2,2)=0) then ziehe(2,2);
	end;
end;
procedure TBot.zeilen();
begin
	//Gehe die Zeilen durch und setze
	if test=botNr then
	begin
		if (Form1.getBelegung(a,b)=0) then ziehe(a,b);
	end;
end;
procedure TBot.spalten();
begin
	//Gehe die Spalten durch und setze
	if test=botNr then
	begin
		if (Form1.getBelegung(b,a)=0) then ziehe(b,a);
	end;
end;
procedure TBot.calculate;
var
	h,p:integer;
begin
	Form1.label1.caption:='Du bist dran Bot '+inttostr(botNr)+'!';
	test:=botNr;  //Bot ist dran
	for h:=1 to 3 do
	begin
		for p:=1 to 3 do
		begin
			e:=e+(Form1.getBelegung(h,p));	//Überprüfe ob alle Felder frei sind
		end
	end;
//--------------------------------------------------------------------------------------------------------------------------
	//Setze auf die Diagonale beim ersten Zug, wenn alle Felder frei sind
	if e=0 then ecken();
	Form1.delay(1000); //Kleiner Delay zu Kontrollzwecken, damit man sieht wie der Bot spielt
	for i:=1 to 3 do //Alle Felder werden durchgegangen
	begin
		for j:=1 to 3 do
		begin
//---------------------------------------------------------------------------------------------------------------------------
	//Überprüfe ob Bot gewinnen kann.
                    for a:=1 to 3 do
			begin
			//Gehe Zeilen durch und setze
				if ((Form1.getBelegung(a,1)=Form1.getBelegung(a,2)) AND (Form1.getBelegung(a,1)=botNr)) XOR ((Form1.getBelegung(a,1)=Form1.getBelegung(a,3)) AND (Form1.getBelegung(a,1)=botNr)) XOR ((Form1.getBelegung(a,2)=Form1.getBelegung(a,3)) AND (Form1.getBelegung(a,2)=botNr)) then
				begin
					for b:=1 to 3 do
                                        begin
                                             zeilen();
					end
				end;
			//Gehe spalten durch und setze
				if ((Form1.getBelegung(1,a)=Form1.getBelegung(2,a)) AND (Form1.getBelegung(1,a)=botNr)) XOR ((Form1.getBelegung(1,a)=Form1.getBelegung(3,a)) AND (Form1.getBelegung(1,a)=botNr)) XOR ((Form1.getBelegung(2,a)=Form1.getBelegung(3,a)) AND (Form1.getBelegung(2,a)=botNr)) then
				begin
					for b:=1 to 3 do
					begin
						spalten();
					end
				end;
			end;
	//Überprüfe die erste Diagonale und setze
			if ((Form1.getBelegung(1,1)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) XOR ((Form1.getBelegung(1,1)=Form1.getBelegung(3,3)) AND (Form1.getBelegung(3,3)=botNr)) XOR ((Form1.getBelegung(2,2)=Form1.getBelegung(3,3)) AND (Form1.getBelegung(3,3)=botNr)) then ersteDiag();
	//Überprüfe die zweite Diagonale und setze
			if ((Form1.getBelegung(1,3)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) XOR ((Form1.getBelegung(1,3)=Form1.getBelegung(3,1)) AND (Form1.getBelegung(3,1)=botNr)) XOR ((Form1.getBelegung(3,1)=Form1.getBelegung(2,2)) AND (Form1.getBelegung(2,2)=botNr)) then zweiteDiag();
//-------------------------------------------------------------------------------------------------------------------------------
//Überprüfe ob Gegner gewinnen kann
			for a:=1 to 3 do
			begin
				if ((Form1.getBelegung(a,1)=Form1.getBelegung(a,2)) AND NOT (Form1.getBelegung(a,1)=botNr) AND (Form1.getBelegung(a,1)>0)) XOR ((Form1.getBelegung(a,1)=Form1.getBelegung(a,3)) AND NOT (Form1.getBelegung(a,1)=botNr) AND (Form1.getBelegung(a,1)>0)) XOR ((Form1.getBelegung(a,2)=Form1.getBelegung(a,3)) AND NOT (Form1.getBelegung(a,2)=botNr) AND (Form1.getBelegung(a,2)>0)) then
				begin
					for b:=1 to 3 do
					begin
						zeilen();	//Gehe Zeilen durch und setze
                                        end
				end;
				if ((Form1.getBelegung(1,a)=Form1.getBelegung(2,a)) AND NOT (Form1.getBelegung(1,a)=botNr) AND (Form1.getBelegung(1,a)>0)) XOR ((Form1.getBelegung(1,a)=Form1.getBelegung(3,a)) AND NOT (Form1.getBelegung(1,a)=botNr) AND (Form1.getBelegung(1,a)>0)) XOR ((Form1.getBelegung(2,a)=Form1.getBelegung(3,a)) AND NOT (Form1.getBelegung(2,a)=botNr) AND (Form1.getBelegung(2,a)>0)) then
				begin
					for b:=1 to 3 do
					begin
						spalten();	//Gehe Spalten durch und setze
                                        end;
				end;
			end;
			//Gehe die erste Diagonale durch und setze
			if ((Form1.getBelegung(1,1)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) XOR ((Form1.getBelegung(1,1)=Form1.getBelegung(3,3)) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) XOR ((Form1.getBelegung(2,2)=Form1.getBelegung(3,3)) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) then ersteDiag();
			//Gehe die zweite Diagonale durch und setze
			if ((Form1.getBelegung(1,3)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) XOR ((Form1.getBelegung(1,3)=Form1.getBelegung(3,1)) AND NOT (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(3,1)>0)) XOR ((Form1.getBelegung(3,1)=Form1.getBelegung(2,2)) AND NOT (Form1.getBelegung(2,2)=botNr) AND (Form1.getBelegung(2,2)>0)) then zweiteDiag();
//------------------------------------------------------------------------------------------------------------------------------
			//Überprüfe nach Zwickmühlen.
			if (NOT (Form1.getBelegung(1,1)=botNr) AND (Form1.getBelegung(1,1)>0) AND NOT (Form1.getBelegung(3,3)=botNr) AND (Form1.getBelegung(3,3)>0)) XOR (NOT (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(3,1)>0) AND NOT (Form1.getBelegung(1,3)=botNr) AND (Form1.getBelegung(1,3)>0)) then
			begin
				r:=random(4)+1;
				if (r=1) AND (Form1.getBelegung(1,2)=0) then ziehe(1,2)
				else if (r=2) AND (Form1.getBelegung(3,2)=0) then ziehe(3,2)
				else if (r=3) AND (Form1.getBelegung(2,1)=0) then ziehe(2,1)
				else if (r=4) AND (Form1.getBelegung(2,3)=0) then ziehe(2,3);
			end;
			if (Form1.getBelegung(2,2)=botNr) then
			begin
				if (NOT (Form1.getBelegung(2,1)=botNr) AND (Form1.getBelegung(2,1)>0)) then
				begin
					r:=random(4)+1;
					if (r>2) AND (Form1.getBelegung(1,1)=0) then ziehe(1,1)
					else if (r<=2) AND (Form1.getBelegung(3,1)=0) then ziehe(3,1);
				end
				else if (NOT (Form1.getBelegung(2,3)=botNr) AND (Form1.getBelegung(2,3)>0)) then
				begin
					r:=random(4)+1;
					if (r>2) then ziehe(1,3)
					else if (r<=2) then ziehe(3,3);
				end;
			end;
//-----------------------------------------------------------------------------------------------------------------------
			//Stelle selbst Zwickmühlen.
			if (Form1.getBelegung(1,1)=botNr) AND (Form1.getBelegung(3,3)=botNr) then
			begin
				r:=random(4)+1;
				if r>2 then ziehe(1,3)
				else if r<=2 then ziehe (3,1);
			end
			else if (Form1.getBelegung(3,1)=botNr) AND (Form1.getBelegung(1,3)=botNr) then
			begin
				r:=random(4)+1;
				if r>2 then ziehe(1,1)
				else if r<=2 then ziehe(3,3);
			end;
//------------------------------------------------------------------------------------------------------------------------------------
			//Überprüfe ob Mitte frei ist.
			if (Form1.getBelegung(2,2)=0) then ziehe(2,2)
			else
			begin
				//Setze auf das gegenüberliegende diagonale Feld
				if (Form1.getBelegung(1,1)=botNr) then ziehe(3,3)
				else if (Form1.getBelegung(3,1)=botNr) then ziehe(1,3)
				else if (Form1.getBelegung(1,3)=botNr) then ziehe(3,1)
				else if (Form1.getBelegung(3,3)=botNr) then ziehe(1,1);
				//Sonst setze in eine zufällige Ecke
				ecken();
			end;
			//Setze auf die Seiten.
			r:=random(4)+1;
			if r=1 then ziehe(2,1)
			else if r=2 then ziehe(1,2)
			else if r=3 then ziehe(3,2)
			else if r=4 then ziehe(2,3);
		end;
	end;
end;

end.
