unit uCreditCardValidator;

interface
uses sysutils, vcl.Dialogs;

type
  ICreditCardValidator = interface(IInvokable)
  ['{273794E9-E780-4675-863D-D283EE04FE44}']
  function IsCreditCardValid(aCreditCardNumber: string): Boolean;
  procedure DoNotCallThisEver;
  end;

  TCreditCardValidator = class(TInterfacedObject, ICreditCardValidator)
    function IsCreditCardValid(aCreditCardNumber: string): Boolean;
    procedure DoNotCallThisEver;
  end;

  ECreditCardValidatorException = class(Exception);

implementation

function TCreditCardValidator.isCreditCardValid(aCreditCardNumber: string): Boolean;
begin
  Result := Pos('7', aCreditCardNumber) <= 0;
  Writeln('Ka-Ching! You were just charged $0.25');
  if not Result then
  begin
    raise ECreditCardValidatorException.Create('Bad Credit Card!  Do not accept!');
  end;
end;

procedure TCreditCardValidator.DoNotCallThisEver;
begin

end;

end.
