unit uTestWidgetProcessor;

interface
uses
  DUnitX.TestFramework, Delphi.Mocks;

type

  [TestFixture]
  TTestWidgetProcessor = class(TObject)
  public
    [Test]
    procedure TestBadWidgetRaisedException;
    [Test]
    procedure TestGoodWidget;
  end;

implementation
uses uDependencyRaisesObjection;

procedure TTestWidgetProcessor.TestBadWidgetRaisedException;
var
  CUT: IWidgetProcessor;
  MockWidget: TMock<IWidget>;
begin
  //Arrange
  MockWidget := TMock<IWidget>.Create;
  MockWidget.Setup.WillRaise(EInvalidWidgetException).When.IsValid;
  CUT := TWidgetProcessor.Create;
  //Act
  CUT.ProcessWidget(MockWidget);
  //Assert
  MockWidget.Verify();
end;

procedure TTestWidgetProcessor.TestGoodWidget;
var
  CUT : IWidgetProcessor;
  MockWidget : TMock<IWidget>;
begin
  //Arrange
  MockWidget := TMock<IWidget>.Create;
  MockWidget.Setup.WillReturn(True).When.IsValid;
  CUT := TWidgetProcessor.Create;
  //Act
  CUT.ProcessWidget(MockWidget);
  //Assert
  MockWidget.Verify();
end;
initialization
  TDUnitX.RegisterTestFixture(TTestWidgetProcessor);
end.
