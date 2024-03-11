program ej3;

type
    empleado = record
        nro:integer;
        apellido: string[12];
        nombre: string[12];
        edad:integer;
        DNI:string[20];
    end;

type archivo = file of empleado;




var arch:archivo;
nro_entry:integer;
ape_entry:string[12];
nombre_entry: string[12];
edad_entry:integer;
DNI_entry:string[20];
nombre_arch:string[12];
E: empleado;


begin




    writeln('Ingrese nombre archivo: ');
    readln(nombre_arch);
    assign(arch,nombre_arch);
    rewrite(arch);


    writeln('Ingrese apellido del empleado: ');
    readln(ape_entry);
    E.apellido:=ape_entry;
    while ape_entry<>'fin' do 
    begin
    writeln('Ingrese numero del empleado: ');
    readln(nro_entry);
    E.nro:=nro_entry;
    writeln('Ingrese nombre del empleado: ');
    readln(nombre_entry);
    E.nombre:=nombre_entry;
    writeln('Ingrese edad del empleado: ');
    readln(edad_entry);
    E.edad:=edad_entry;
    writeln('Ingrese dni del empleado: ');
    readln(DNI_entry);
    E.DNI:=DNI_entry;

    write(arch,E);

    writeln('Ingrese apellido del empleado: ');
    readln(ape_entry);
    E.apellido:=ape_entry;

    end;

    close(arch);
    

end.