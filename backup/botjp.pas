unit kampfkeks;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, spieler;
type TBot=class(TSpieler)
  private
     i,j,belegung,botNr:integer;
  public
     procedure calculate; override;
     procedure botzug();
     constructor create(Nummer:integer);
end;

implementation
uses spielfeld;
constructor TBot.create(Nummer:integer);
begin
    inherited create;
    botNr:=Nummer;
end;

procedure TBot.calculate;
begin
    Form1.label1.caption:='Du bist dran Bot '+inttostr(botNr)+'!';
end;
procedure TBot.botzug();
begin
     belegung:=array[1..3, 1..3];
     if getDran()=1 then belegung[i][j]:=getDran();
     if getBelegung()=0 then
     begin
     Zug(i;j);
     end;
end;

end.

