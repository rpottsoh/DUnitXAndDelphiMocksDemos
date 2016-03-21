unit uDollarToGalleonsConverterTests;

interface
uses
  SysUtils, DUnitX.TestFramework, uDollarToGalleonsConverter, Delphi.Mocks;

type

  [TestFixture]
  TDollarsToGalleonsConverterTest = class(TObject)
  public
    [Test]
    procedure TestPointFiveCutsDollarsInHalf;
    [Test]
    procedure TestThatLoggerIsProperlyCalled;
  end;

implementation

procedure TDollarsToGalleonsConverterTest.TestPointFiveCutsDollarsInHalf;
var
  Expected: Double;
  Actual: Double;
  TempConverter: TDollarToGalleonsConverter;
  TempLogger: TStub<ILogger>;
begin
  //Arrange
  TempLogger := TStub<ILogger>.Create;
  TempConverter := TDollarToGalleonsConverter.Create(TempLogger);
  try
    Expected := 1.0;
    //Act
    Actual := TempConverter.ConvertDollarsToGalleons(2, 0.5);
    //Assert
    Assert.AreEqual(Expected, Actual, 'Converter failed to convert 2 dollars to 1 galleon');
  finally
    TempConverter.Free;
  end;
end;

procedure TDollarsToGalleonsConverterTest.TestThatLoggerIsProperlyCalled;
var
  Expected: Double;
  Actual: Double;
  TempConverter: TDollarToGalleonsConverter;
  TempLogger: TMock<ILogger>;
  Input: Double;
  TempMessage: string;
begin
  //Arrange
  TempLogger := TMock<ILogger>.Create;
  Input := 2.0;
  Expected := 1.0;
  TempMessage := format('Converted %f dollars to %f Galleons',[Input, Expected]);
  TempLogger.Setup.Expect.Once.When.Log(TempMessage);
  TempConverter := TDollarToGalleonsConverter.Create(TempLogger);
  try
    //Act
    Actual := TempConverter.ConvertDollarsToGalleons(Input, 0.5);
    //Assert
    TempLogger.Verify();
  finally
    TempConverter.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TDollarsToGalleonsConverterTest);
end.
