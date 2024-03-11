program ej3_b;
type
    empleado = record
        nro:integer;
        apellido: string[12];
        nombre: string[12];
        edad:integer;
        DNI:string[20];
    end;

type archivo = file of empleado;
var apellido_prueba:string[12];
nombre_prueba:string[12];
arch:archivo;
nombre_arch:string[12];

procedure pasar_a_txt_DNI_nocargado(var arch:archivo);
var nom_txt:String[20];
archivo_txt: Text;
E:empleado;
begin
writeln('Ingrese nombre txt: ');
readln(nom_txt);
assign(archivo_txt,nom_txt);
rewrite(archivo_txt);

reset(arch);

while not eof(arch) do 
begin
    
    read(arch,E);
    if (E.DNI = '00') then begin
    write(archivo_txt, 'Número: ', E.nro);
    write(archivo_txt, '|| Apellido: ', E.apellido);
    write(archivo_txt, '|| Nombre: ', E.nombre);
    write(archivo_txt, '|| Edad: ', E.edad);
    write(archivo_txt, '|| DNI: ', E.DNI);
    writeln(archivo_txt,' ');
    end;
end;

close(archivo_txt);
close(arch);



end;


procedure pasar_a_txt (var arch:archivo);
var nom_txt:String[20];
archivo_txt: Text;
E:empleado;
begin
writeln('Ingrese nombre txt: ');
readln(nom_txt);
assign(archivo_txt,nom_txt);
rewrite(archivo_txt);

reset(arch);

while not eof(arch) do 
begin
    read(arch,E);
    write(archivo_txt, 'Número: ', E.nro);
    write(archivo_txt, '|| Apellido: ', E.apellido);
    write(archivo_txt, '|| Nombre: ', E.nombre);
    write(archivo_txt, '|| Edad: ', E.edad);
    write(archivo_txt, '|| DNI: ', E.DNI);
    writeln(archivo_txt,' ');
end;

close(archivo_txt);
close(arch);


end;

procedure modificar_edad(var arch:archivo);
var edad_cambio:integer;
E:empleado;
cod_empleado:integer;
var pos:integer;
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
        pos:=FilePos(arch)-1;
        seek(arch,pos);
        write(arch,E);
    end;
    end;
    close(arch);

end;


function numeroValido(var arch: archivo; num:integer):boolean;
var E:empleado;
valido:boolean;
begin
    valido:=true;
    reset(arch);
    while not eof(arch) do
    begin
    read(arch,E);
    if E.nro=num then 
        valido:=false;
    
    end;


    close(arch);
    numeroValido:=valido;
end;


procedure aniadir_empleado(var arch:archivo);
var E:empleado;
nro_entry:integer;
ape_entry:string[12];
nombre_entry: string[12];
edad_entry:integer;
DNI_entry:string[20];
nombre_arch:string[12];
var pos:integer;
begin
    writeln('Ingrese apellido del empleado: ');
    readln(ape_entry);
    E.apellido:=ape_entry;
    while ape_entry <> 'fin' do begin
    writeln('Ingrese dni del empleado: ');
    readln(DNI_entry);
    E.DNI:=DNI_entry;
    writeln('Ingrese nombre del empleado: ');
    readln(nombre_entry);
    E.nombre:=nombre_entry;
    writeln('Ingrese edad del empleado: ');
    readln(edad_entry);
    E.edad:=edad_entry;
    writeln('Ingrese numero del empleado: ');
    readln(nro_entry);
    E.nro:=nro_entry;
  
    if numeroValido(arch,nro_entry) then 
        begin
        reset(arch);   
        Seek(arch,FileSize(arch));
        write(arch,E);
        close(arch);
    end
    Else
        writeln('El numero ingresado ya existe para otro empleado.');
    writeln('Ingrese apellido del empleado: ');
    readln(ape_entry);
    E.apellido:=ape_entry;
    end;

end;


procedure listar_empleados_especificos(var arch:archivo; nombre:string; apellido:string);
var E:empleado;
begin
    reset(arch);
    while not eof(arch) do
    begin
    read(arch,E);
    if((E.nombre = nombre) or (E.apellido = apellido) ) then
        writeln('Numero de empleado: ',E.nro,' Apellido del empleado: ',E.apellido,' Nombre del empleado: ',E.nombre,' Edad del emepleado: ',E.edad,' DNI del empleado: ',E.DNI);

    end;
    close(arch);
    writeln('/////////////\\\\\\\\\\\\\\\/////////');
end;

procedure listar_empleados(var arch:archivo);
var E:empleado;
begin
    reset(arch);
    while not eof(arch) do
    begin
    read(arch,E);
    writeln('Numero de empleado: ',E.nro,' Apellido del empleado: ',E.apellido,' Nombre del empleado: ',E.nombre,' Edad del emepleado: ',E.edad,' DNI del empleado: ',E.DNI);
    end;
    close(arch);
    writeln('/////////////\\\\\\\\\\\\\\\/////////');
end;

procedure listar_empleados_jubilados(var arch:archivo);
var E:empleado;
begin
    reset(arch);
    while not eof(arch) do
    begin
    read(arch,E);
    if (E.edad>70) then 
    writeln('Numero de empleado: ',E.nro,' Apellido del empleado: ',E.apellido,' Nombre del empleado: ',E.nombre,' Edad del emepleado: ',E.edad,' DNI del empleado: ',E.DNI);
    end;
    close(arch);
    writeln('/////////////\\\\\\\\\\\\\\\/////////');

end;

procedure menu(var arch:archivo );
var i:integer;
apellido_prueba:string[12];
nombre_prueba:string[12];

begin

 writeln('Ingrese una opcion (1-6 0 para finalizar): ');
 readln(i);
while (i <> 0) do begin
case i of
    1: listar_empleados(arch);
    2: begin 
    writeln('Ingrese nombre a buscar');
    readln(nombre_prueba);
    writeln('Ingrese apellido a buscar');
    readln(apellido_prueba);
    listar_empleados_especificos(arch,nombre_prueba,apellido_prueba);
       end;
    3: listar_empleados_jubilados(arch);
    4: aniadir_empleado(arch);
    5: modificar_edad(arch);
    6: pasar_a_txt(arch);
    7: pasar_a_txt_DNI_nocargado(arch);
  else
    writeln('Seleccione opcion valida... ');
  end;
  
 writeln('Ingrese una opción (1-3, 0 para finalizar): ');
 readln(i);
end;
writeln('Saliendo del menu...');
end;



begin
    writeln('Ingrese nombre archivo: ');
    readln(nombre_arch);
    assign(arch,nombre_arch);
    menu(arch);



end.