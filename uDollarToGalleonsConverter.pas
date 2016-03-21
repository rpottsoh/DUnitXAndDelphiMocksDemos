unit uDollarToGalleonsConverter;

interface
uses SysUtils;

type
  ILogger = interface(IInvokable)
  ['{1AA2CC2E-31A3-492F-9106-80BB9AB1F3A2}']
    procedure Log(aString: string);
  end;

  TDollarToGalleonsConverter = class
  private
    FLogger : ILogger;
  public
    constructor Create(aLogger: ILogger);
    function ConvertDollarsToGalleons(aDollars: Double; aExchangeRate: Double): Double;
  end;

implementation

function TDollarToGalleonsConverter.ConvertDollarsToGalleons(aDollars, aExchangeRate: Double): Double;
begin
  result := aDollars * aExchangeRate;
  FLogger.Log(format('Converted %f dollars to %f Galleons',[aDollars, Result]));
end;

constructor TDollarToGalleonsConverter.Create(aLogger: ILogger);
begin
  inherited Create;
  FLogger := aLogger;
end;

end.
