//Read more: http://www.linhadecodigo.com.br/artigo/2237/implementando-algoritmo-buscabr.aspx#ixzz4kmJj5J00
unit BuscaBR;

interface

uses
  System.SysUtils,
  System.classes,
  System.RegularExpressions;

type
  TBuscaBR = class
  public
    class function PhoneticCode(AText:string):string;
  end;

implementation

{ TBuscaBR }

function ReturnSplitString(AText:string):TStrings;
var
  Values: TStrings;
  LWord, LInput: string;
begin
//  Values := TStringList.Create;
//  LInput := AText;
//  Values.add('Spliting the text: ');
//  for LWord in SplitString(LInput) do
//    Values.Add(LWord);
//  Result:= Values;
end;

function StrReplace(const AText: string;AOldChar:array of string;ANewChar:string):string;
var
  n:Integer;
  New:TStringBuilder;
begin
  New := TStringBuilder.Create;
  New.Append(Trim(UpperCase(AText)));
  for n := Low(AOldChar) to High(AOldChar) do
  begin
    New.Replace(AOldChar[n],ANewChar);
  end;
  Result := New.ToString;
end;

function RemoveAccents(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  NewStr := Trim(UpperCase(AText));
  NewStr := StrReplace(NewStr,['Á', 'Â', 'Ã', 'À', 'Ä', 'Å'],'A');
  NewStr := StrReplace(NewStr,['É', 'Ê', 'È', 'Ë'],'E');
  NewStr := StrReplace(NewStr,['Í', 'Î', 'Ì', 'Ï'],'I');
  NewStr := StrReplace(NewStr,['Ó', 'Ô', 'Õ', 'Ò', 'Ö'],'O');
  NewStr := StrReplace(NewStr,['Ú', 'Û', 'Ù', 'Ü'],'U');
  NewStr := StrReplace(NewStr,['Ý', 'Ÿ', 'Y'],'Y');
  NewStr := StrReplace(NewStr,['Ç'],'C');
  NewStr := StrReplace(NewStr,['Ñ'],'N');
  Result := NewStr;
end;

class function TBuscaBR.PhoneticCode(AText: string): string;
var
  NewStr:string;
begin
  NewStr := RemoveAccents(AText);
  NewStr := StrReplace(NewStr,['Y'],'I'); // Substituimos Y por I
  NewStr := StrReplace(NewStr,['BR','BL'],'B'); // Substituimos BR por B;
  NewStr := StrReplace(NewStr,['PH'],'F'); // Substituimos PH por F;
  NewStr := StrReplace(NewStr,['MG','NG','RG'],'G'); // Substituimos GR, MG, NG, RG por G;
  NewStr := StrReplace(NewStr,['GE','GI','RJ','MJ','NJ'],'J'); // Substituimos GE, GI, RJ, MJ, NJ por J;
  NewStr := StrReplace(NewStr,['GR','GL'],'G');
  NewStr := StrReplace(NewStr,['CE','CI','CH','CS'],'S'); // Substituimos CE, CI e CH por S
  NewStr := StrReplace(NewStr,['CT'],'T'); // Substituimos CT por T
  NewStr := StrReplace(NewStr,['Q','CA','CO','CU','CK','C'],'K'); // Substituimos Q, CA, CO, CU, C por K;
  NewStr := StrReplace(NewStr,['LH'],'L'); // Substituimos LH por L;
  NewStr := StrReplace(NewStr,['RM'],'SM');
  NewStr := StrReplace(NewStr,['N','GM','MD'],'M'); // Substituimos N, RM, GM, MD, SM e Terminação AO por M;
  NewStr := StrReplace(NewStr,['NH'],'N'); // Substituimos NH por N;
  NewStr := StrReplace(NewStr,['PR'],'P'); // Substituimos PR por P;
  NewStr := StrReplace(NewStr,['X','TS','C','Z','RS','Ç'],'S'); // Substituimos Ç, X, TS, C, Z, RS por S;
  NewStr := StrReplace(NewStr,['TR','TL','LT','RT','ST'],'T'); // Substituimos LT, TR, CT, RT, ST por T;
  NewStr := StrReplace(NewStr,['W'],'V'); // Substituimos W por V;
  NewStr := StrReplace(NewStr,['L'],'R'); //Substituimos L por R;
  NewStr := StrReplace(NewStr,['H','A','E','I','O','U'],EmptyStr);
  // Eliminamos as terminações S, Z, R, R, M, N, AO e L;







//  int tam = sb.Length - 1;
//  if (tam > -1)
//  {
//      if (sb[tam] == "S" || sb[tam] == "Z" || sb[tam] == "R" || sb[tam] == "M" || sb[tam] == "N" || sb[tam] == "L")
//      {
//          sb.Remove(tam, 1);
//      }
//  }
//  tam = sb.Length - 2;
//  if (tam > -1)
//  {
//      if (sb[tam] == "A" && sb[tam + 1] == "O")
//      {
//          sb.Remove(tam, 2);
//      }
//  }
//  // ---------
//
//
//
//  //Eliminamos todas as letras em duplicidade;
//  StringBuilder frasesaida = new StringBuilder();
//  frasesaida.Append(sb[0]);
//  for (int i = 1; i <= sb.Length - 1; i += 1)
//  {
//      if (frasesaida[frasesaida.Length - 1] != sb[i] || char.IsDigit(sb[i]))
//          frasesaida.Append(sb[i]);
//  }



end;

end.
