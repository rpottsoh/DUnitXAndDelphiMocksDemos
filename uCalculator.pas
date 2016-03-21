unit uCalculator;

interface

type
  TCalculator = class
    function Add(x, y: integer): integer;
  end;
implementation

{ TCalculator }

function TCalculator.Add(x, y: Integer): integer;
begin
  result := x + y;
end;

end.
