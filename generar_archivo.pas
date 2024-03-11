program generar_archivo;

type archivo = file of integer;

var arc_logico: archivo;
    nro: integer;
    arc_fisico: string[12];

procedure modificar(var arc_logico:archivo);
var nro_3:integer;
begin
reset(arc_logico);
while not eof(arc_logico) do {deberia usar el seek con file pos -1 porque en teoria con el not eof me desplaza pero no estaria pasando }
begin
    read(nro_3);
    {Seek(arc_logico, filepos(arc_logico) -1 );}
    write(arc_logico,nro_3);
    
end;
close(arc_logico);
writeln('/////////////');
end;

procedure recorrido(var arc_logico: archivo);
var nro_2: integer;
begin
    reset(arc_logico);
    while not eof(arc_logico) do 
    begin
    read(arc_logico,nro_2);
    writeln(nro_2);
    end;
    close(arc_logico);
    writeln('/////////////');
end;

begin

write( 'Ingrese el nombre del archivo: ');
read (arc_fisico);
assign(arc_logico, arc_fisico);
rewrite(arc_logico);
{write('Ahora ingrese un numero a coloar:');}
read(nro);
while nro <> 0 do 
begin
    write (arc_logico,nro);
    read(nro);
end;
close (arc_logico);
recorrido(arc_logico);
modificar(arc_logico);
recorrido(arc_logico);

end.