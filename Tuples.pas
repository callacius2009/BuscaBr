{****************************************************}
{                                                    }
{  Generics.Tuples                                   }
{                                                    }
{  Copyright (C) 2014 Malcolm Groves                 }
{                                                    }
{  https://github.com/malcolmgroves/generics.tuples  }
{                                                    }
{****************************************************}
{                                                    }
{  This Source Code Form is subject to the terms of  }
{  the Mozilla Public License, v. 2.0. If a copy of  }
{  the MPL was not distributed with this file, You   }
{  can obtain one at                                 }
{                                                    }
{  http://mozilla.org/MPL/2.0/                       }
{                                                    }
{****************************************************}
unit Tuples;

interface

type
  ITuple<T1, T2> = interface
    procedure SetValue1(Value : T1);
    function GetValue1 : T1;
    procedure SetValue2(Value : T2);
    function GetValue2 : T2;
    property Value1 : T1 read GetValue1 write SetValue1;
    property Value2 : T2 read GetValue2 write SetValue2;
  end;

  ITuple<T1, T2, T3> = interface(ITuple<T1, T2>)
    procedure SetValue3(Value : T3);
    function GetValue3 : T3;
    property Value3 : T3 read GetValue3 write SetValue3;
  end;

  ITuple<T1, T2, T3, T4> = interface(ITuple<T1, T2, T3>)
    procedure SetValue4(Value : T4);
    function GetValue4 : T4;
    property Value4 : T4 read GetValue4 write SetValue4;
  end;

  ITuple<T1, T2, T3, T4, T5> = interface(ITuple<T1, T2, T3, T4>)
    procedure SetValue5(Value : T5);
    function GetValue5 : T5;
    property Value5 : T5 read GetValue5 write SetValue5;
  end;

  ITuple<T1, T2, T3, T4, T5, T6> = interface(ITuple<T1, T2, T3, T4, T5>)
    procedure SetValue6(Value : T6);
    function GetValue6 : T6;
    property Value6 : T6 read GetValue6 write SetValue6;
  end;

  ITuple<T1, T2, T3, T4, T5, T6, T7> = interface(ITuple<T1, T2, T3, T4, T5, T6>)
    procedure SetValue7(Value : T7);
    function GetValue7 : T7;
    property Value7 : T7 read GetValue7 write SetValue7;
  end;

  ITuple<T1, T2, T3, T4, T5, T6, T7, TRest> = interface(ITuple<T1, T2, T3, T4, T5, T6, T7>)
    procedure SetValueRest(Value : TRest);
    function GetValueRest : TRest;
    property ValueRest : TRest read GetValueRest write SetValueRest;
  end;

  TTuple<T1, T2> = class(TInterfacedObject, ITuple<T1, T2>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    procedure SetValue1(Value : T1);
    function GetValue1 : T1;
    procedure SetValue2(Value : T2);
    function GetValue2 : T2;
  public
    constructor Create(Value1:T1; Value2:T2); virtual;
    destructor Destroy; override;
    property Value1 : T1 read FValue1 write FValue1;
    property Value2 : T2 read FValue2 write FValue2;
  end;

  TTuple<T1, T2, T3> = class(TTuple<T1, T2>, ITuple<T1, T2, T3>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    FValue3 : T3;
    procedure SetValue3(Value : T3);
    function GetValue3 : T3;
  public
    constructor Create(Value1:T1; Value2:T2; Value3:T3); reintroduce;
    destructor Destroy; override;
    property Value3 : T3 read GetValue3 write SetValue3;
  end;

  TTuple<T1, T2, T3, T4> = class(TTuple<T1, T2, T3>, ITuple<T1, T2, T3, T4>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    FValue3 : T3;
    FValue4 : T4;
    procedure SetValue4(Value : T4);
    function GetValue4 : T4;
  public
    constructor Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4); reintroduce;
    destructor Destroy; override;
    property Value4 : T4 read GetValue4 write SetValue4;
  end;

  TTuple<T1, T2, T3, T4, T5> = class(TTuple<T1, T2, T3, T4>, ITuple<T1, T2, T3, T4, T5>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    FValue3 : T3;
    FValue4 : T4;
    FValue5 : T5;
    procedure SetValue5(Value : T5);
    function GetValue5 : T5;
  public
    constructor Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4; Value5:T5); reintroduce;
    destructor Destroy; override;
    property Value5 : T5 read GetValue5 write SetValue5;
  end;

  TTuple<T1, T2, T3, T4, T5, T6> = class(TTuple<T1, T2, T3, T4, T5>, ITuple<T1, T2, T3, T4, T5, T6>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    FValue3 : T3;
    FValue4 : T4;
    FValue5 : T5;
    FValue6 : T6;
    procedure SetValue6(Value : T6);
    function GetValue6 : T6;
  public
    constructor Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4; Value5:T5; Value6:T6); reintroduce;
    destructor Destroy; override;
    property Value6 : T6 read GetValue6 write SetValue6;
  end;

  TTuple<T1, T2, T3, T4, T5, T6, T7> = class(TTuple<T1, T2, T3, T4, T5, T6>, ITuple<T1, T2, T3, T4, T5, T6, T7>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    FValue3 : T3;
    FValue4 : T4;
    FValue5 : T5;
    FValue6 : T6;
    FValue7 : T7;
    procedure SetValue7(Value : T7);
    function GetValue7 : T7;
  public
    constructor Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4; Value5:T5; Value6:T6; Value:T7); reintroduce;
    destructor Destroy; override;
    property Value7 : T7 read GetValue7 write SetValue7;
  end;

  TTuple<T1, T2, T3, T4, T5, T6, T7, TRest> = class(TTuple<T1, T2, T3, T4, T5, T6, T7>, ITuple<T1, T2, T3, T4, T5, T6, T7, TRest>)
  protected
    FValue1 : T1;
    FValue2 : T2;
    FValue3 : T3;
    FValue4 : T4;
    FValue5 : T5;
    FValue6 : T6;
    FValue7 : T7;
    FValueRest : TRest;
    procedure SetValueRest(Value : TRest);
    function GetValueRest : TRest;
  public
    constructor Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4; Value5:T5; Value6:T6; Value:T7; ValueRest:TRest); reintroduce;
    destructor Destroy; override;
    property ValueRest : TRest read GetValueRest write SetValueRest;
  end;

implementation
uses
  System.RTTI;

{ TPair<T1, T2> }

constructor TTuple<T1, T2>.Create(Value1: T1; Value2: T2);
begin
  self.Value1 := Value1;
  self.Value2 := Value2;
end;

destructor TTuple<T1, T2>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValue1Holder, LValue2Holder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValue1Holder := TValue.From<T1>(FValue1);
  if LValue1Holder.IsObject then
    LValue1Holder.AsObject.Free;

  LValue2Holder := TValue.From<T2>(FValue2);
  if LValue2Holder.IsObject then
    LValue2Holder.AsObject.Free;
  inherited;
{$ENDIF}
end;

function TTuple<T1, T2>.GetValue1: T1;
begin
  Result := FValue1;
end;

function TTuple<T1, T2>.GetValue2: T2;
begin
  Result := FValue2;
end;

procedure TTuple<T1, T2>.SetValue1(Value: T1);
begin
  FValue1 := Value;
end;

procedure TTuple<T1, T2>.SetValue2(Value: T2);
begin
  FValue2 := Value;
end;

{ TTuple3<T1, T2, T3> }

constructor TTuple<T1, T2, T3>.Create(Value1: T1; Value2: T2; Value3: T3);
begin
  inherited Create(Value1, Value2);
  self.Value3 := Value3;
end;

destructor TTuple<T1, T2, T3>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValue3Holder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValue3Holder := TValue.From<T3>(FValue3);
  if LValue3Holder.IsObject then
    LValue3Holder.AsObject.Free;
{$ENDIF}
  inherited;
end;

function TTuple<T1, T2, T3>.GetValue3: T3;
begin
  Result := FValue3;
end;

procedure TTuple<T1, T2, T3>.SetValue3(Value: T3);
begin
  FValue3 := Value;
end;

{ TTuple4<T1, T2, T3, T4> }

constructor TTuple<T1, T2, T3, T4>.Create(Value1: T1; Value2: T2; Value3: T3; Value4: T4);
begin
  inherited Create(Value1, Value2, Value3);
  self.Value4 := Value4;
end;

destructor TTuple<T1, T2, T3, T4>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValue4Holder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValue4Holder := TValue.From<T4>(FValue4);
  if LValue4Holder.IsObject then
    LValue4Holder.AsObject.Free;
{$ENDIF}
  inherited;
end;

function TTuple<T1, T2, T3, T4>.GetValue4: T4;
begin
  Result := FValue4;
end;

procedure TTuple<T1, T2, T3, T4>.SetValue4(Value: T4);
begin
  FValue4 := Value;
end;

{ TTuple5<T1, T2, T3, T4, T5> }

constructor TTuple<T1, T2, T3, T4, T5>.Create(Value1: T1; Value2: T2; Value3: T3; Value4: T4; Value5: T5);
begin
  inherited Create(Value1, Value2, Value3, Value4);
  self.Value5 := Value5;
end;

destructor TTuple<T1, T2, T3, T4, T5>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValue5Holder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValue5Holder := TValue.From<T5>(FValue5);
  if LValue5Holder.IsObject then
    LValue5Holder.AsObject.Free;
{$ENDIF}
  inherited;
end;

function TTuple<T1, T2, T3, T4, T5>.GetValue5: T5;
begin
  Result := FValue5;
end;

procedure TTuple<T1, T2, T3, T4, T5>.SetValue5(Value: T5);
begin
  FValue5 := Value;
end;

{ TTuple6<T1, T2, T3, T4, T5, T6> }

constructor TTuple<T1, T2, T3, T4, T5, T6>.Create(Value1: T1; Value2: T2; Value3: T3; Value4: T4; Value5: T5; Value6: T6);
begin
  inherited Create(Value1, Value2, Value3, Value4, Value5);
  self.Value6 := Value6;
end;

destructor TTuple<T1, T2, T3, T4, T5, T6>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValue6Holder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValue6Holder := TValue.From<T6>(FValue6);
  if LValue6Holder.IsObject then
    LValue6Holder.AsObject.Free;
{$ENDIF}
  inherited;
end;

function TTuple<T1, T2, T3, T4, T5, T6>.GetValue6: T6;
begin
  Result := FValue6;
end;

procedure TTuple<T1, T2, T3, T4, T5, T6>.SetValue6(Value: T6);
begin
  FValue6 := Value;
end;

{ TTuple6<T1, T2, T3, T4, T5, T6, T7> }

constructor TTuple<T1, T2, T3, T4, T5, T6, T7>.Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4; Value5:T5; Value6:T6; Value:T7);
begin
  inherited Create(Value1, Value2, Value3, Value4, Value5, Value6);
  self.Value7 := Value7;
end;

destructor TTuple<T1, T2, T3, T4, T5, T6, T7>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValue7Holder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValue7Holder := TValue.From<T7>(FValue7);
  if LValue7Holder.IsObject then
    LValue7Holder.AsObject.Free;
{$ENDIF}
  inherited;
end;

function TTuple<T1, T2, T3, T4, T5, T6, T7>.GetValue7: T7;
begin
  Result := FValue7;
end;

procedure TTuple<T1, T2, T3, T4, T5, T6, T7>.SetValue7(Value: T7);
begin
  FValue7 := Value;
end;

{ TTuple6<T1, T2, T3, T4, T5, T6, T7, TRest> }

constructor TTuple<T1, T2, T3, T4, T5, T6, T7, TRest>.Create(Value1:T1; Value2:T2; Value3:T3; Value4:T4; Value5:T5; Value6:T6; Value:T7; ValueRest:TRest);
begin
  inherited Create(Value1, Value2, Value3, Value4, Value5, Value6, Value7);
  self.ValueRest := ValueRest;
end;

destructor TTuple<T1, T2, T3, T4, T5, T6, T7, TRest>.Destroy;
{$IFNDEF AUTOREFCOUNT}
var
  LValueRestHolder : TValue;
{$ENDIF}
begin
{$IFNDEF AUTOREFCOUNT}
  LValueRestHolder := TValue.From<TRest>(FValueRest);
  if LValueRestHolder.IsObject then
    LValueRestHolder.AsObject.Free;
{$ENDIF}
  inherited;
end;

function TTuple<T1, T2, T3, T4, T5, T6, T7, TRest>.GetValueRest: TRest;
begin
  Result := FValueRest;
end;

procedure TTuple<T1, T2, T3, T4, T5, T6, T7, TRest>.SetValueRest(Value: TRest);
begin
  FValueRest := Value;
end;


end.
