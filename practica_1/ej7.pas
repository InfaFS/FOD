program ej7;

type
    novela = record
        codigo:integer;
        precio:double;
        genero:string[12];
        nombre:string[30];
    end;

type archivo = file of novela;

procedure imprimir(var arch:archivo);
var n:novela;
begin
    reset(arch);
    while not eof(arch)do
    begin
        read(arch,n);
        writeln(n.codigo,' ',n.precio:0:2,' ',n.genero,' ',n.nombre);
    end;

    close(arch);

end;

procedure cargar_novela(var n:novela);

var
    codigo_entry:integer;
    precio_entry:double;
    genero_entry:string[12];
    nombre_entry:string[30];

begin
    writeln('Ingrese codigo: ');
    readln(codigo_entry);
    n.codigo:=codigo_entry;

    writeln('Ingrese precio: ');
    readln(precio_entry);
    n.precio:=precio_entry;

    writeln('Ingrese genero: ');
    readln(genero_entry);
    n.genero:=genero_entry;

    writeln('Ingrese nombre: ');
    readln(nombre_entry);
    n.nombre:=nombre_entry;

end;

procedure exportar_a_txt(var arch:archivo);
var arch_txt:Text;
n:novela;

begin
    assign(arch_txt,'novelas.txt');
    rewrite(arch_txt);
    reset(arch);

    while not eof(arch) do
    begin
        read(arch,n);
        writeln(arch_txt,n.codigo,' ',n.precio:0:2,' ',n.genero);
        writeln(arch_txt,n.nombre);

    end;

    close(arch_txt);
    close(arch);
end;

procedure modificar_archivo(var arch:archivo);
var n:novela;
entry:integer;
codigo_entry:integer; 
precio_entry:double;
genero_entry:string[12];
nombre_entry:string[30];
encontrado:boolean;

begin
    reset(arch);
    encontrado:=false;
    writeln('Ingrese 1 para agregar una novela, cualquier otro para modificar: ');
    readln(entry);
    if (entry = 1) then begin

    cargar_novela(n);
    seek(arch,FileSize(arch));
    write(arch,n);

    end
    else 
        begin
        writeln('Ingrese el codigo de la novela a buscar: ');
        readln(codigo_entry);
        while not eof(arch) and not encontrado do
        begin
            read(arch,n);
            if (n.codigo=codigo_entry) then 
                encontrado:=true;
        end;
        if encontrado then begin
            seek(arch,FilePos(arch)-1);
            writeln('Ingrese 1 para modificar codigo');
            writeln('Ingrese 2 para modificar precio');
            writeln('Ingrese 3 para modificar genero');
            writeln('Ingrese 4 para modificar nombre');
            writeln('Ingrese un numero: ');
            readln(entry);
            case entry of
            1: begin
            writeln('Ingrese codigo a modificar');
            readln(codigo_entry);
            n.codigo:=codigo_entry;
            write(arch,n);
            end;
            2: begin
            writeln('Ingrese precio a modificar');
            readln(precio_entry);
            n.precio:=precio_entry;
            write(arch,n);
            end;
            3: begin
            writeln('Ingrese genero a modificar');
            readln(genero_entry);
            n.genero:=genero_entry;
            write(arch,n);
            end;
            4: begin
            writeln('Ingrese nombre a modificar');
            readln(nombre_entry);
            n.nombre:=nombre_entry;
            write(arch,n);
            end;
            else
            writeln('No es un codigo valido');
            end;
        end
        else
            writeln('No se encontro novela con ese codigo');



        end;

    close(arch);

end;

var arch:archivo;
n:novela;
begin
    assign(arch,'ej7_test');
    rewrite(arch);
    cargar_novela(n);
    write(arch,n);
    cargar_novela(n);
    write(arch,n);
    close(arch);
    
    imprimir(arch);
    modificar_archivo(arch);
    imprimir(arch);
    exportar_a_txt(arch);

end.