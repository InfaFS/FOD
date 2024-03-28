program CheckSubstring;

function ContieneSubcadena(cadena, subcadena: string): boolean;
begin
  ContieneSubcadena := Pos(subcadena, cadena) > 0;
end;

var
  cadenaPrincipal, subcadena: string;
begin
  writeln('Ingrese una cadena principal: ');
  readln(cadenaPrincipal);
  writeln('Ingrese la subcadena que desea buscar: ');
  readln(subcadena);

  if ContieneSubcadena(cadenaPrincipal, subcadena) then
    writeln('La cadena principal contiene la subcadena.')
  else
    writeln('La cadena principal no contiene la subcadena.');
end.


