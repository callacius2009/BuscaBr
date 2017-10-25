unit SimilarityTest;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Math,
  WinApi.Windows,
  Vcl.Forms,
  Vcl.Controls,
  Data.DbxFirebird,
  Data.DB,
  Data.SqlExpr,
  Data.FmtBcd,
  Metaphone;

type
  TRegistry = class
  public
    FText:string;
    FTextFonec:string;
    FDegreSim:Integer;
    constructor Create(const Atext,AtextFonec:string;ADegraSim:Integer);
  end;

  TSimilarityTest = class
  private
    FList:TStringList;
    FListComp: array of TRegistry;
    FPercSimilarity:Integer;
    procedure Carregar;
  public
    constructor Create(const AList: TStringList; ATextCompare: String;APercSimilarity:Integer);
    property PercSimilarity:Integer       read FPercSimilarity  write FPercSimilarity ;
    property List:TStringList             read FList;
  end;
  function CompareStringsInPercent(AText1, AText2: string): Byte;

implementation

{ TSimilarityTest }

constructor TSimilarityTest.Create(const AList: TStringList; ATextCompare: String;APercSimilarity:Integer);
var
  i:Integer;
  AReg: TRegistry;
begin
  SetLength(FListComp,AList.Count);
  i := 0;
  FPercSimilarity := APercSimilarity;
  for i := 0 to Pred(AList.Count) do
  begin
//    AReg :=  TRegistry.Create(AList[i],TMetaphoneBr.PhoneticCode(AList[i]),CompareStringsInPercent(AList[i],ATextCompare));
//    FListComp[i] := AReg ;
    FListComp[i] := TRegistry.Create(AList[i],TMetaphoneBr.PhoneticCode(AList[i]),CompareStringsInPercent(AList[i],ATextCompare));
  end;
  Carregar;
end;

procedure TSimilarityTest.Carregar;
var
  i:Integer;
begin
  i := 0;
  FList := TStringList.Create;
  FList.Clear;
  for i := Low(FListComp) to High(FListComp) do
  begin
    if FListComp[i].FDegreSim >= FPercSimilarity then
      FList.Add(FListComp[i].FText);
  end;
end;

function CompareStringsInPercent(AText1, AText2: string): Byte;
type
  TLink = array[0..1] of Byte;
var
  tmpPattern: TLink;
  PatternA, PatternB: array of TLink;
  IndexA, IndexB, LengthStr: Integer;
begin
  AText1 := UpperCase(AText1);
  AText2 := UpperCase(AText2);
  Result := 100;
  // Construindo tabelas padrão
  LengthStr := Max(Length(AText1), Length(AText2));
  for IndexA := 1 to LengthStr do
  begin
    if Length(AText1) >= IndexA then
    begin
      SetLength(PatternA, (Length(PatternA) + 1));
      PatternA[Length(PatternA) - 1][0] := Byte(AText1[IndexA]);
      PatternA[Length(PatternA) - 1][1] := IndexA;
    end;
    if Length(AText2) >= IndexA then
    begin
      SetLength(PatternB, (Length(PatternB) + 1));
      PatternB[Length(PatternB) - 1][0] := Byte(AText2[IndexA]);
      PatternB[Length(PatternB) - 1][1] := IndexA;
    end;
  end;
  // Tipos de tabelas padrão
  IndexA := 0;
  IndexB := 0;
  while ((IndexA < (Length(PatternA) - 1)) and (IndexB < (Length(PatternB) - 1))) do
  begin
    if Length(PatternA) > IndexA then
    begin
      if PatternA[IndexA][0] < PatternA[IndexA + 1][0] then
      begin
        tmpPattern[0]           := PatternA[IndexA][0];
        tmpPattern[1]           := PatternA[IndexA][1];
        PatternA[IndexA][0]     := PatternA[IndexA + 1][0];
        PatternA[IndexA][1]     := PatternA[IndexA + 1][1];
        PatternA[IndexA + 1][0] := tmpPattern[0];
        PatternA[IndexA + 1][1] := tmpPattern[1];
        if IndexA > 0 then Dec(IndexA);
      end
      else
        Inc(IndexA);
    end;
    if Length(PatternB) > IndexB then
    begin
      if PatternB[IndexB][0] < PatternB[IndexB + 1][0] then
      begin
        tmpPattern[0]           := PatternB[IndexB][0];
        tmpPattern[1]           := PatternB[IndexB][1];
        PatternB[IndexB][0]     := PatternB[IndexB + 1][0];
        PatternB[IndexB][1]     := PatternB[IndexB + 1][1];
        PatternB[IndexB + 1][0] := tmpPattern[0];
        PatternB[IndexB + 1][1] := tmpPattern[1];
        if IndexB > 0 then Dec(IndexB);
      end
      else
        Inc(IndexB);
    end;
  end;
  // Cálculo da porcentagem de similaridade
  LengthStr := Min(Length(PatternA), Length(PatternB));
  for IndexA := 0 to (LengthStr - 1) do
  begin
    if PatternA[IndexA][0] = PatternB[IndexA][0] then
    begin
      if Max(PatternA[IndexA][1], PatternB[IndexA][1]) - Min(PatternA[IndexA][1],
        PatternB[IndexA][1]) > 0 then Dec(Result,
        ((100 div LengthStr) div (Max(PatternA[IndexA][1], PatternB[IndexA][1]) -
          Min(PatternA[IndexA][1], PatternB[IndexA][1]))))
      else if Result < 100 then Inc(Result);
    end
    else
      Dec(Result, (100 div LengthStr))
  end;
  SetLength(PatternA, 0);
  SetLength(PatternB, 0);
end;

{ TRegistry }

constructor TRegistry.Create(const Atext, AtextFonec: string;
  ADegraSim: Integer);
begin
  FText      := Atext;
  FTextFonec := AtextFonec;
  FDegreSim  := ADegraSim;
end;

end.
