unit uDependencyRaisesObjection;

interface
uses SysUtils;

type
  IWidget = interface(IInvokable)
    function IsValid: Boolean;
  end;

  TWidget = class(TInterfacedObject, IWidget)
  public
    function IsValid: Boolean;
  end;

  IWidgetProcessor = interface(IInvokable)
    procedure ProcessWidget(aWidget: IWidget);
  end;

  TWidgetProcessor = class(TInterfacedObject, IWidgetProcessor)
  public
    procedure ProcessWidget(aWidget: IWidget);
  end;

  EInvalidWidgetException = class(Exception);

implementation

procedure TWidgetProcessor.ProcessWidget(aWidget: IWidget);
begin
  try
    if aWidget.IsValid then
    begin
      Writeln('Widget has been properly processed');
    end;
  except
    On E: EInvalidWidgetException do
    begin
      Writeln('IsValid failed to validate the widget');
    end;
  end;
end;

function TWidget.IsValid: Boolean;
begin
  result := Random(100) >= 99;
  if not Result then
  begin
    raise EInvalidWidgetException.Create('Bad Widget!  Bad, bad widget!');
  end;
end;

end.
