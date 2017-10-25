unit LoadList;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  WinApi.Windows,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Data.DbxFirebird,
  Data.DB,
  Data.SqlExpr,
  Data.FmtBcd;

type
  TLoadList = class
  private
    FList:TStringList;
    Query:TSQLQuery;
    procedure Carregar;
  public
    constructor Create(const AConnection: TSQLConnection; AField,ATable: String);
    property List:TStringList read FList;
  end;
  function ReturnFormSimilaridade(Alist:TStringList;AtextComp:string):Boolean;
implementation

{ TLoadList }

constructor TLoadList.Create(const AConnection: TSQLConnection; AField,ATable: String);
begin
  Query := TSQLQuery.Create(nil);
  Query.SQLConnection := AConnection;
  Query.SQL.Text := Format('select %s from %s',[AField,ATable]);
  Query.Open;
  Carregar;
end;

procedure TLoadList.Carregar;
begin
  FList := TStringList.Create;
  FList.Clear;
  Query.First;
  while not Query.Eof do
  begin
    List.Add(Query.Fields[0].AsString);
    Query.Next;
  end;
end;

function ReturnFormSimilaridade(Alist:TStringList;AtextComp:string):Boolean;
var
  frm: TForm;
  lbl: TLabel;
  btnOk, btnCancel: TButton;
  pnlFooter,pnlTop: TPanel;
  lsw: TListView;
  edt: TEdit;
begin
  Result := False;
  frm := TForm.Create(nil);
  try
    pnlTop           := TPanel.Create(frm);
    pnlFooter        := TPanel.Create(frm);
    lbl              := TLabel.Create(frm);
    btnOk            := TButton.Create(frm);
    btnCancel        := TButton.Create(frm);
    edt              := TEdit.Create(frm);
    lsw              := TListView.Create(frm);

    frm.BorderStyle  := bsDialog;
    frm.Caption      := 'Cadastros Similares';
    frm.Width        := 500;
    frm.Height       := 400;
    frm.Position     := poScreenCenter;

    pnlTop.Parent    := frm;
    pnlTop.Align     := alTop;
    pnlTop.Height    := 55;
    pnlTop.Caption   := EmptyStr;

    pnlFooter.Parent := frm;
    pnlFooter.Align  := alBottom;
    pnlFooter.Height := 40;
    pnlFooter.Caption:= EmptyStr;

    lbl.Parent       := pnlTop;
    lbl.Top          := 8;
    lbl.Left         := 8;
    lbl.Caption      := 'Cadastro a ser salvo';

    edt.Parent       := pnlTop;
    edt.Top          := 25;
    edt.Left         := 8;
    edt.Width        := 400;
    edt.Enabled      := False;
    edt.Text         := EmptyStr;

    btnOk.Parent     := pnlFooter;
    btnOk.Default    := True;
    btnOk.ModalResult:= mrOk;
    btnOk.Top        := 8;
    btnOk.Left       := 8;
    btnOk.Width      := 80;
    btnOk.Caption    := 'Ok';

    btnCancel.Parent := pnlFooter;
    btnCancel.ModalResult:= mrCancel;
    btnCancel.Top    := 8;
    btnCancel.Left   := 96;
    btnCancel.Width  := 80;
    btnCancel.Caption:= 'Cancel';

    lsw.Parent       := frm;
    lsw.Align        := alClient;
    lsw.ReadOnly     := True;

    frm.ClientHeight := frm.Height;
    frm.ClientWidth  := frm.Width;

    if frm.ShowModal = mrOk then
      Result := True
    else
      Result := False;
  finally
    frm.Free;
  end;
end;

end.
