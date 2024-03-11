program ej2;
CONST max=1500;
type archivo = file of integer;

var nombre_arch:string[12];
arch: archivo;
suma:integer;
promedio:double;
contador_menores:integer;
num:integer;
contador_nums:integer;

Begin
    read(nombre_arch);
    assign(arch,nombre_arch);
    reset(arch);
    suma:=0;
    contador_menores:=0;
    promedio:=0.0;
    contador_nums:=0;

    while not eof(arch) do
    Begin
    read(arch,num);
    if (num < max) then
        contador_menores:=contador_menores+1;
    suma:=suma+num;
    contador_nums:=contador_nums+1;
    write(num,' ');

    end;
    writeln('');
    writeln('La cantidad de numeros menores a 1500 es: ',contador_menores);
    promedio:=suma/contador_nums;
    writeln('El promedio de los nums es: ',promedio:0:2);
    close(arch);

    

End.
