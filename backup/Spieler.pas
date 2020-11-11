unit Spieler;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
    TSpieler = class
       public
         SpielerNr: integer;
         infos: String;
         procedure calculate; virtual;
         procedure setInfos(infoNeu:string); virtual;
         constructor create(Nummer:integer); overload;
    end;

implementation
uses spielfeld;

constructor TSpieler.create(Nummer:integer);
begin
  create;
  SpielerNr:=Nummer;
  infos:='Spieler '+inttostr(SpielerNr);
end;

procedure TSpieler.calculate;      //ruft die prozedur Zug(i,j) in spielfeld auf

begin
  form1.label1.Caption:='diesen Text solltest du niemals sehen';
end;
procedure TSpieler.setInfos(infoNeu:string);
begin
  infos:=infoNeu;
end;

end.

