program CompararString;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  LoadList in 'LoadList.pas',
  Metaphone in 'Metaphone.pas',
  Soundex in 'Soundex.pas',
  BuscaBR in 'BuscaBR.pas',
  Tuples in 'Tuples.pas',
  SimilarityTest in 'SimilarityTest.pas',
  FormsGenerics in 'FormsGenerics.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
