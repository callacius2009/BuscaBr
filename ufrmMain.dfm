object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'dd'
  ClientHeight = 205
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 7
    Width = 33
    Height = 13
    Caption = 'Valor 1'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 33
    Height = 13
    Caption = 'Valor 2'
  end
  object Label3: TLabel
    Left = 17
    Top = 103
    Width = 204
    Height = 13
    Caption = 'Valor para converter para C'#243'digo Fonetico'
  end
  object btnOk: TButton
    Left = 12
    Top = 158
    Width = 100
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = btnOkClick
  end
  object edtValor1: TEdit
    Left = 16
    Top = 24
    Width = 417
    Height = 21
    TabOrder = 1
  end
  object edtValor2: TEdit
    Left = 16
    Top = 72
    Width = 417
    Height = 21
    TabOrder = 2
  end
  object btnGerarPerc: TButton
    Left = 120
    Top = 158
    Width = 100
    Height = 25
    Caption = 'Gerar % Comp'
    TabOrder = 4
    OnClick = btnGerarPercClick
  end
  object edtValorCodFon: TEdit
    Left = 17
    Top = 119
    Width = 417
    Height = 21
    TabOrder = 3
  end
  object btnGerarCodFon: TButton
    Left = 228
    Top = 158
    Width = 100
    Height = 25
    Caption = 'Gerar Cod F'#243'netico'
    TabOrder = 5
    OnClick = btnGerarCodFonClick
  end
  object BtnTestFon: TButton
    Left = 337
    Top = 158
    Width = 100
    Height = 25
    Caption = 'TesteFonetico'
    TabOrder = 6
    OnClick = BtnTestFonClick
  end
  object Con: TSQLConnection
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver160.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=16.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver160.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=16.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database=D:\Banco_DSI\Industrial\BANCO_DSI.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Connected = True
    Left = 416
  end
end
