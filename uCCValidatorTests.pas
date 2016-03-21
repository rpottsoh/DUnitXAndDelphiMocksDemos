unit uCCValidatorTests;

interface
uses
  SysUtils, DUnitX.TestFramework, Delphi.Mocks;

type

  [TestFixture]
  TCCValidatorTests = class(TObject)
  public
    [Test]
    procedure TestCardChargeReturnsProperAmountWhenCardIsGood;
    [Test]
    procedure TestCardChargeReturnsZeroWhenCCIsBad;
  end;

implementation
uses uCreditCardManager, uCreditCardValidator;

procedure TCCValidatorTests.TestCardChargeReturnsProperAmountWhenCardIsGood;
var
  CCManager: TCreditCardManager;
  CCValidator: TMock<ICreditCardValidator>;
  GoodCard: String;
  Input: Double;
  Expected, Actual: Double;
begin
  //Arrange
  GoodCard := '123456';
  Input := 49.95;
  Expected := Input;
  CCValidator := TMock<ICreditCardValidator>.Create;
  CCValidator.Setup.WillReturn(True).When.IsCreditCardValid(GoodCard);

  CCManager := TCreditCardManager.Create(CCValidator);
  try
    //Act
    Actual := CCManager.ProcessCreditCard(GoodCard, Input);
  finally
    CCManager.Free;
  end;
  //Assert
  Assert.AreEqual(Expected, Actual);
end;

procedure TCCValidatorTests.TestCardChargeReturnsZeroWhenCCIsBad;
var
  CCManager: TCreditCardManager;
  CCValidator: TMock<ICreditCardValidator>;
  GoodCard: string;
  Input: Double;
  Expected, Actual: Double;
begin
  //Arrange
  GoodCard := '777777'; //Any CC with 7s are bad
  Input := 49.95;
  Expected := 0;        //No Charge for bad cards
  CCValidator := TMock<ICreditCardValidator>.Create;
  // Tell the stub to make it a bad card
  CCValidator.Setup.WillReturn(False).When.IsCreditCardValid(GoodCard);

  CCManager := TCreditCardManager.Create(CCValidator);
  try
    //Act
    Actual := CCManager.ProcessCreditCard(GoodCard, Input);
  finally
    CCManager.Free;
  end;
  // Assert
  Assert.AreEqual(Expected, Actual);
end;

initialization
  TDUnitX.RegisterTestFixture(TCCValidatorTests);
end.
