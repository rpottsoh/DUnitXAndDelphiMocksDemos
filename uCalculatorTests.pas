unit uCalculatorTests;

interface
uses
  DUnitX.TestFramework, uCalculator;

type

  [TestFixture]
  TCalculatorTests = class(TObject)
  private
    Expected, Actual: integer;
    Calculator: TCalculator;
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
  public
    [Test]
    procedure TestSimpleAddition;
    [Test]
    procedure TestAddingOneAndOneShouldReturnTwo;
    [Test]
    procedure TestAddingZero;
    [Test]
    procedure TestAddingTwoNegativeNumbers;
  end;

implementation

procedure TCalculatorTests.Setup;
begin
  Calculator := TCalculator.Create;
end;

procedure TCalculatorTests.TearDown;
begin
  Calculator.Free;
end;

procedure TCalculatorTests.TestSimpleAddition;
begin
  Expected := 4;
  Actual := Calculator.Add(2, 2);
  Assert.AreEqual(Expected, Actual, 'The calculator thinks that 2 + 2 is not 4!');
end;

procedure TCalculatorTests.TestAddingOneAndOneShouldReturnTwo;
begin
  Expected := 2;
  Actual := Calculator.Add(1, 1);
  Assert.AreEqual(Expected, Actual, 'The calculator thinks that 1 + 1 is not 2!');
end;

procedure TCalculatorTests.TestAddingZero;
begin
  Expected := 4;
  Actual := Calculator.Add(4, 0);
  Assert.AreEqual(Expected, Actual, 'The calculator thinks that 4 + 0 is not 4!');
end;

procedure TCalculatorTests.TestAddingTwoNegativeNumbers;
begin
  Expected := -4;
  Actual := Calculator.Add(-2, -2);
  Assert.AreEqual(Expected, Actual, 'The Add function failed to realise that -2 + -2 is -4');
end;

initialization
  TDUnitX.RegisterTestFixture(TCalculatorTests);
end.

