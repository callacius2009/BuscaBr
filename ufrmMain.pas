unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, System.Math,
  SimilarityTest, Data.DBXFirebird, Data.DB, Data.SqlExpr, LoadList,
  Vcl.ExtCtrls, Vcl.ComCtrls, FormsGenerics, Vcl.Grids;

type
  TfrmMain = class(TForm)
    btnOk: TButton;
    edtValor1: TEdit;
    edtValor2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnGerarPerc: TButton;
    Label3: TLabel;
    edtValorCodFon: TEdit;
    btnGerarCodFon: TButton;
    Con: TSQLConnection;
    BtnTestFon: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnGerarPercClick(Sender: TObject);
    procedure btnGerarCodFonClick(Sender: TObject);
    procedure BtnTestFonClick(Sender: TObject);
  private
    function NivelSemelhanca(StringA, StringB: String): Integer;
    function Soundex(strNome: string): string;
    function CompareStringsInPercent(AText1, AText2: string): Byte;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Metaphone;

procedure TfrmMain.btnOkClick(Sender: TObject);
begin
  ShowMessage(IntToStr(NivelSemelhanca(edtValor1.Text,edtValor2.Text)));
end;

procedure TfrmMain.BtnTestFonClick(Sender: TObject);
var
  ASimTest : TSimilarityTest;
  ALoadList: TLoadList;
  AForm: TFormSimilaridade;
//  i: Integer;
begin
  ALoadList:= TLoadList.Create(Con,'LAN_DESCRICAO','CLASSIF_LANCAMENTOS');
  ASimTest := TSimilarityTest.Create(ALoadList.List,'Teste',70);
  AForm := TFormSimilaridade.Create;
  AForm.Show(ASimTest.List,'Teste');
  ShowMessage(IntToStr(AForm.ModalResult));

//  ALoadList:= TLoadList.Create(Con,'LAN_DESCRICAO','CLASSIF_LANCAMENTOS');
//  ASimTest := TSimilarityTest.Create(ALoadList.List,'Teste',70);
//  for i := 0 to Pred(ASimTest.List.Count) do
//  begin
//    ShowMessage(ASimTest.List[i]);
//  end;

end;

function TfrmMain.NivelSemelhanca(StringA, StringB: String): Integer; //similarity
var
  Pontos, i, j, LetStringA, LetStringB: Integer;
  Pontuou: Boolean;
begin
  Pontuou := False;
  Pontos := 0;
  LetStringA := Length(StringA);
  LetStringB := Length(StringB);
  //Fase1 - Verifica as letras iniciais e finais
  if LetStringB > 3 then
  begin
    if StringA[1] = StringB[1] then
    begin
      Pontos := 15;
    end
    else
    begin
      if StringA[LetStringA] = StringB[LetStringB] then
      begin
        Pontos := 15;
      end;
    end;
    if StringA[1] = StringB[1] then
    begin
      Pontos :=25;
    end;
    //Fase2 - Verifica letra por letra nas mesmas posições
    for i := 1 to LetStringA do
    begin
      if StringA[i] = StringB[i] then
      begin
        Pontos := Pontos+1;
        if Pontuou then
          begin
            Pontos := Pontos+15;
          end;
        Pontuou := True
      end
      else
      begin
        Pontuou := False;
      end;
    end;
    //Fase3 - Verifica letra por letra variando posições no comandoA
    j := 1;
    Pontuou := False;
    for i := 1 to LetStringA do
    begin
      if StringA[j] = StringB[i] then
      begin
        Pontos := Pontos+1;
        if Pontuou then
        begin
          Pontos := Pontos+15;
        end;					j := j+1;
        Pontuou := True
      end
      else
      begin
        Pontuou := False;
      end;
    end;
    //Fase4 - Verifica letra por letra variando posições no comandoB
    j := 1;
    Pontuou := False;
    for i := 1 to LetStringA do
    begin
      if StringA[i] = StringB[j] then
      begin
        Pontos := Pontos+1;
        if Pontuou then
        begin
          Pontos := Pontos+15;
        end;
        j := j+1;
        Pontuou := True
      end
      else
      begin
        Pontuou := False;
      end;
    end;
  end;
  //retorna a quantidade de pontos, qto mais pontos somados maior o grau de semelhança entre as palavras
  Result := Pontos;
end;


function TfrmMain.Soundex (strNome : string) : string;
var
  V, V1 : set of Char;
  C, CN : set of 'a'..'z';
  intTam, n : integer;

begin
  V := ['a','e','i','o','u','y','á','é','ê','ó','ô','í','ú','â','à','ä','è','ë','ì','ï','î','ò','ö','ü','ù','û'];
  V1 := ['e','i','y','é','ê','í','è','ë','ì','ï','î','ù','û'];
  C := ['b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','z'];
  CN := ['m','n'];

  {Result := Excecoes.Values[Trim(strNome)];
  if Result <> ´´ then exit;}
  Result := '';
  strNome := '' + AnsiLowerCase(Trim(strNome)) + '';
  intTam := length(strNome);
  n := 1;
  while n < intTam do
  begin
    inc(n);
    if (strNome[n] = strNome[n + 1]) then
       inc(n);

    case strNome[n] of
      '#':
         exit;
      'a','á','â','à','ä':
         Result := Result + 'a';
      'e','è','ë':
         begin
           if (strNome[n + 1]= '') or (Copy(strNome, n+1, 2) = 's') then
              Result := Result + 'e'
              //Result := Result + ´i´
           else
              Result := Result + 'e';
         end;
      'é','ê':
         Result := Result + 'e';
      'i','y','í','ì','ï','î':
           if not ((strNome[n - 1] in ['e','é']) and (strNome[n + 1] in ['a','o'])) then
              Result := Result + 'i';
      'o','ò','ö':
         begin
           if (strNome[n+1] = '') or (Copy(strNome, n+1, 2) = 's') then
              Result := Result + 'u'
           else
              Result := Result + 'o';
         end;
      'ó','ô':
         begin
           if (strNome[n+1] = '') then
              Result := Result + 'o'
           else
              Result := Result + 'o';
         end;
      'u','ú','ü','ù','û':
         Result := Result + 'u';
      'b','f','j','k','v':
         Result := Result + strNome[n];
      'c':
         begin
           if (strNome[n+1] in V1) then
              Result := Result + 's'
           else if (strNome[n+1] in ['a','o','u','r','l']) then
              Result := Result + 'k'
           else if (Copy(strNome, n + 1, 2) = 'hr') then  //christina, chrizóstemo
             begin
                Result := Result + 'kR';
                n := n + 2;
             end
           else if (strNome[n+1] = 'h') then
             begin
                Result := Result + 'x';
                inc(n);
             end
           else if (strNome[n+1] = 'k') then
             begin
                Result := Result + 'k';
                inc(n);
             end
           else
              Result := Result + 'k';
         end;
      'd':
         begin
           if (strNome[n+1] in C) and (not (strNome[n+1] in ['r', 'l'])) or (strNome[n+1] = '') then
              Result := Result + 'di'
           else
              Result := Result + 'd';
         end;
      'g':
         begin
           if (Copy(strNome, n + 1, 2) = 'ue') or (Copy(strNome, n + 1, 2) = 'ui') or(strNome[n+1] = 'ü') then
             begin
               Result := Result + 'g';
               inc(n);
             end
           else if (strNome[n+1] in ['i','e']) then
              Result := Result + 'j'
           else if (Copy(strNome, n - 2, 2) = 'i') and (strNome[n + 1] = 'n') then
             begin
               Result := Result + 'n';
               inc(n);
             end
           else
             Result := Result + 'g';
         end;
      'h':
         n := n;
      'l':
         begin
           if (strNome[n+1] = 'h') then
             begin
               Result := Result + 'L';
               inc(n);
             end
           else if (strNome[n+1] = '') then
              Result := Result + 'u'
           else if (strNome[n+1] in C) then
              Result := Result + 'u'
           else
              Result := Result + 'l'
         end;
      'm':
         begin
           if (strNome[n-1] in V) and  (strNome[n+1] in C) or (strNome[n+1] = '') then
              Result := Result + 'n'
           else
              Result := Result + 'm';
         end;
      'n':
         begin
           if (strNome[n+1] = 'h') then
             begin
               Result := Result + 'N';
               inc(n);
             end
           else
              Result := Result + 'n'
         end;
      'p':
         begin
           if (strNome[n+1] = 'h') then
             begin
               Result := Result + 'f';
               inc(n);
             end
           else
              Result := Result + 'p';
         end;
      'q':
         begin
           if (Copy(strNome, n + 1, 2) = 'ue') or (Copy(strNome, n + 1, 2) = 'ui') then
             begin
               Result := Result + 'k';
               inc(n);
             end
           else
               Result := Result + 'k';
         end;
//      'r':
//         begin
//           if (strNome[n-1] in  ['','n','m','r']) then
//              Result := Result + 'r'
//           else
//              Result := Result + 'R'
//         end;
      's':
         begin
           if (strNome[n+1] = 'h') then
             begin
                Result := Result + 'x';
                inc(n);
             end
           else if (strNome[n-1] = '') and (strNome[n+1] in V) then
               Result := Result + 's'
           else if (strNome[n-1] = '') and (strNome[n+1] in C) then
               Result := Result + 'es'
           else if (Copy(strNome, n + 1, 2) = 'ce') or (Copy(strNome, n + 1, 2) = 'ci') or (strNome[n+1] = 'ç') then
             begin
                Result := Result + 's';
                inc(n);
             end
           else if (strNome[n-1] in V) and (strNome[n+1] in V) then
                Result := Result + 'z'
           else if (strNome[n-1] in V) and (strNome[n+1] in C) then
                Result := Result + 's'
           else if (Copy(strNome, 1, 3) = 'ex') and (strNome[n-1] in V) then
               Result := Result + 'z'
           else if (strNome[n-1] in C) and  (strNome[n+1] in V) then
                Result := Result + 's'
           else
              Result := Result + 's';
         end;
      't':
         begin
           if (Copy(strNome, n + 1, 2) = 'h#') then
              Result := Result + 'te'
           else if (strNome[n+1] <> '') then
              Result := Result + 't';
         end;
      'w':
         begin
           if (Copy(strNome, n + 1, 2) = 'al') or (Copy(strNome, n + 1, 2) = 'an') then
              Result := Result + 'v'
           else
              Result := Result + 'u';
         end;
      'x':
         begin
           if (strNome[n-1] = '') or (strNome[n-1] = 'n') then
               Result := Result + 'x'
           else if (Copy(strNome, n+1, 2) = 'ce') or (Copy(strNome, n+1, 2) = 'ci') then
             begin
               Result := Result + 's';
               inc(n);
             end
           else if (strNome[n-1] in V) and (strNome[n+1] = 't') then
               Result := Result + 's'
           else if (Copy(strNome, n+1, 2) = 'ai') or (Copy(strNome, n+1, 2) = 'ei') or (Copy(strNome, n+1, 2) = 'ou') then
               Result := Result + 'x'
           else if (Copy(strNome, n- 2, 2) = 'e') and  (strNome[n+1] in V) then
               Result := Result + 'z'
           else
               Result := Result + 'x'
         end;
      'z':
         begin
           if (strNome[n-1] = '') then
               Result := Result + 'z'
           else if (strNome[n+1] = '') or (strNome[n+1] in C) then
               Result := Result + 's'
           else
                Result := Result + 'z'
         end;
      'ç':
         Result := Result + 's';
      'ã':
              Result := Result + 'ã';
      'õ':
         Result := Result + 'õ';
      '''' : inc(n);
      else
        Result := Result + '@';
    end;
  end;
end;

procedure TfrmMain.btnGerarCodFonClick(Sender: TObject);
begin
  ShowMessage(TMetaphoneBr.PhoneticCode(edtValorCodFon.Text));
end;

procedure TfrmMain.btnGerarPercClick(Sender: TObject);
var
  Percent: byte;
begin
  Percent := CompareStringsInPercent(edtValor1.Text, edtValor2.Text);
  ShowMessage(IntToStr(Percent));
end;

function TfrmMain.CompareStringsInPercent(AText1, AText2: string): Byte;
type
  TLink = array[0..1] of Byte;
var
  tmpPattern: TLink;
  PatternA, PatternB: array of TLink;
  IndexA, IndexB, LengthStr: Integer;
begin
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


end.
