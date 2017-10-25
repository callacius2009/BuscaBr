unit Metaphone;

interface

uses
  System.SysUtils,
  System.RegularExpressions;

type
  IMetaphone = interface
  end;

  TMetaphoneBr = class(TInterfacedObject, IMetaphone)
  public
    class function PhoneticCode(AText:string):string;
  end;


implementation

{ TMetaphoneBr }

function RemoveAccents(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := UpperCase(Trim(AText));
  for n := 0 to Length(NewStr) do
  begin
    case NewStr[n] of
      'Á', 'Â', 'Ã', 'À', 'Ä', 'Å': NewStr[n] := 'A';
      'É', 'Ê', 'È', 'Ë': NewStr[n] := 'E';
      'Í', 'Î', 'Ì', 'Ï': NewStr[n] := 'I';
      'Ó', 'Ô', 'Õ', 'Ò', 'Ö': NewStr[n] := 'O';
      'Ú', 'Û', 'Ù', 'Ü': NewStr[n] := 'U';
      'Ç': NewStr[n] := 'C';
      'Ñ': NewStr[n] := 'N';
      'Ý', 'Ÿ', 'Y': NewStr[n] := 'I';
    else
      if Ord(NewStr[n]) > 127 then
        NewStr[n] := #32
    end;
  end;
  Result := NewStr;
end;

function RemoveOfStr(AText:string;APattern:Array of string): string;
var
  n,p,i:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := UpperCase(Trim(AText));
  for n := low(APattern) to High(APattern) do
  begin
    i:= 0;
    p:= Pos(APattern[n],NewStr);
    while p > 0 do
    begin
      Delete(NewStr,p,Length(APattern[n]));
      p:= Pos(APattern[n],NewStr);
    end;
  end;
  Result := NewStr;
end;

function RemoveDuplicate(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := UpperCase(Trim(AText));
  for n := 1 to Pred(Length(AText)) do
  begin
    if NewStr[n] = NewStr[n+1] then
      Delete(NewStr,n,1);
  end;
  Result := NewStr;
end;

function AdaptStr(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  for n := 1 to Length(AText) do
  begin
    case AText[n] of
      'B','D','F','J','K','L','M','N','R','T','V','X': NewStr := Format('%s%s',[NewStr,AText[n]]);{Ignorar A,E,I,O,U,Y,H e Espaços}
      'C': { CH = X}
      begin
        if AText[n+1] = 'H' then NewStr := Format('%sX',[NewStr]){CH = X}
        else if AText[n+1] in ['A','O','U'] then NewStr := Format('%sK',[NewStr]) {Carol = Karol}
        else if AText[n+1] in ['E','I'] then NewStr := Format('%sS',[NewStr]); {Celina = Selina, Cintia = Sintia}
      end;
      'G': if AText[n+n] = 'E' then NewStr := Format('%sJ',[NewStr]) else NewStr := Format('%sG',[NewStr]); {Jeferson = Geferson}
      'P': if AText[n+1] = 'H' then NewStr := Format('%sF',[NewStr]) else NewStr := Format('%sP',[NewStr]); {Phelipe = Felipe}
      'Q': if AText[n+1] = 'U' then NewStr := Format('%sK',[NewStr]) else NewStr := Format('%sQ',[NewStr]); {Keila = Queila}
      'S': if AText[n+1] = 'H' then NewStr := Format('%sX',[NewStr]); {SH = X}
      'A','E','I','O','U': if AText[n-1] in ['A','E','I','O','U'] then NewStr := Format('%sZ',[NewStr]) else NewStr := Format('%sS',[NewStr]); {S entre duas vogais = Z}
      'W': NewStr := Format('%sV',[NewStr]); {Walter = Valter}
      'Z': if ((n = Length(AText)) or (AText[n+1] = EmptyStr)) then NewStr := Format('%sS',[NewStr]) else NewStr := Format('%sZ',[NewStr]); {No final do nome Tem som de S -> Luiz = Luis}
    end;
  end;
  Result := NewStr;
end;

class function TMetaphoneBr.PhoneticCode(AText: string): string;
var
  n:Integer;
begin
  Result := AdaptStr(RemoveDuplicate(RemoveOfStr(RemoveAccents(AText),['E','DA','DAS','DE','DI','DO','DOS'])));
end;

end.
