procedure modificar_edad(var arch:archivo);
var edad_cambio:integer;
E:empleado;
cod_empleado:integer;
begin   
    writeln('Ingrese codigo de empleado a buscar: ');
    readln(cod_empleado);
    reset(arch);
    while not eof(arch) do 
    begin
    read(arch,E);
    if (E.nro=cod_empleado) then
    begin
        writeln('Ingrese la edad nueva: ');
        readln(edad_cambio);
        E.edad:=edad_cambio;
        seek(arch,FilePos(arch)-1);
        write(arch,E);
    end;
    end;
    close(arch);

end;
