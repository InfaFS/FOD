program ej1;
const corte= 30000;

type archivo = file of integer;

var num:integer;
nombre: string[12];
arc_logico: archivo;

Begin
    write('Ingrese nombre archivo: ');
    read(nombre);
    assign(arc_logico,nombre);
    rewrite(arc_logico);
    write('Ingrese num: ');
    read(num);
    while num <> corte do
    begin
        write(arc_logico,num);
        read(num);
    end;
    {solo para corroborar buen funcionamiento...
    seek(arc_logico,0);
    while not eof(arc_logico) do
    begin
        read(arc_logico,num);
        writeln(num);
    end;
    close(arc_logico);
    }
    writeln('Carga finalizada...');
end.