unit Soundex;

interface

uses
  System.SysUtils,
  System.RegularExpressions;

type
  ISoundex = interface
  end;

  TSoundexBr = class(TInterfacedObject, ISoundex)
  public
    //class function PhoneticCode(AText:string):string;
  end;

implementation

end.
