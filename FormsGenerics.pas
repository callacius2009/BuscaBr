unit FormsGenerics;

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
  IFormGeneric = interface

  end;

  TFormSimilaridade = class(TInterfacedObject, IFormGeneric)
  private
    FFrm:TForm;
    FLbl:TLabel;
    FBtnOk:TButton;
    FBtnCancel:TButton;
    FPnlTop:TPanel;
    FPnlBottom:TPanel;
    FListBox:TListBox;
    FItemList:TListItem;
    FEdt:TEdit;
    FModalResult:Integer;
  public
    constructor Create;
    procedure Show(Alist:TStringList;AText:string);
    property Form:TForm           read FFrm         write FFrm;
    property ButtonOk:TButton     read FBtnOk       write FBtnOk;
    property ButtonCancel:TButton read FBtnCancel   write FBtnCancel;
    property PanelTop:TPanel      read FPnlTop      write FPnlTop;
    property PanelBottom:TPanel   read FPnlBottom   write FPnlBottom;
    property ListBox:TListBox     read FListBox     write FListBox;
    property edt:TEdit            read FEdt         write FEdt;
    property ModalResult:Integer  read FModalResult write FModalResult;
  end;

implementation

{ TFormSimilaridade }

constructor TFormSimilaridade.Create;
begin
  FFrm           := TForm.Create(nil);
  FLbl           := TLabel.Create(FFrm);
  FBtnOk         := TButton.Create(FFrm);
  FBtnCancel     := TButton.Create(FFrm);
  FPnlTop        := TPanel.Create(FFrm);
  FPnlBottom     := TPanel.Create(FFrm);
  FListBox       := TListBox.Create(FFrm);
  FEdt           := TEdit.Create(FFrm);

  with FFrm do
  begin
    BorderStyle  := bsDialog;
    Caption      := 'Cadastros Similares';
    Width        := 420;
    Height       := 200;
    Position     := poScreenCenter;
    ClientHeight := Height;
    ClientWidth  := Width;
  end;
  with FPnlTop do
  begin
    Parent     := FFrm;
    Align      := alTop;
    Height     := 55;
    Caption    := EmptyStr;
  end;
  with FPnlBottom do
  begin
    Parent     := FFrm;
    Align      := alBottom;
    Height     := 40;
    Caption    := EmptyStr;
  end;
  with FLbl do
  begin
    Parent     := FPnlTop;
    Top        := 8;
    Left       := 8;
    Caption    := 'Cadastro a ser salvo';
  end;
  with FEdt do
  begin
    Parent     := FPnlTop;
    Top        := 25;
    Left       := 8;
    Width      := 400;
    Enabled    := False;
    Text       := EmptyStr;
    Font.Size  := 10;
  end;
  with FBtnOk do
  begin
    Parent     := FPnlBottom;
    Default    := True;
    ModalResult:= mrOk;
    Top        := 8;
    Left       := 8;
    Width      := 80;
    Caption    := 'Ok';
  end;
  with FBtnCancel do
  begin
    Parent     := FPnlBottom;
    ModalResult:= mrCancel;
    Top        := 8;
    Left       := 96;
    Width      := 80;
    Caption    := 'Cancel';
  end;
  with FListBox do
  begin
    Parent       := FFrm;
    Align        := alClient;
    Style        := lbOwnerDrawVariable;
    Font.Size    := 10;
  end;
  FModalResult := FFrm.ModalResult;
end;

procedure TFormSimilaridade.Show(Alist: TStringList; AText: string);
var
  i:Integer;
  ItemList:TListItem;
begin
  FListBox.Items := Alist;
  FEdt.Text := UpperCase(AText);
  FFrm.ShowModal;
  FModalResult := FFrm.ModalResult;
end;

end.
