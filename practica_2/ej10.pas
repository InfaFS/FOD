program ej10;
const n=2; //va 15
const valorAlto=999;
type 
    empleado=record
        departamento:integer;
        division:integer;
        numeroEmpleado:integer;
        categoria:integer;
        horasExtras:integer;
    end;

    empleados = file of empleado;
    ar15 = array[1..n] of double;

    procedure cargarVector(var valores:ar15);
    var arch:Text;
    entry1:integer;
    valor:double;
    i:integer;
    begin
    assign(arch,'ej10.txt');
    reset(arch);
    while (not eof(arch)) do
    begin
        readln(arch,entry1,valor);
        valores[entry1]:=valor; 
    end;

    close(arch);

        writeln('Imprimiendo vector');
        for  i:=1 to n do
        begin
            writeln('valores ',i,' = ', valores[i]:0:2);
        end;
    end;

    procedure crearArchivo(var arch:empleados);
    var reg:empleado;

    begin
        rewrite(arch);
        writeln('departamento');
        readln(reg.departamento);
        while (reg.departamento <> 0) do
        begin
            writeln('division');
            readln(reg.division);
            writeln('numeroEmpleado');
            readln(reg.numeroEmpleado);
            writeln('categoria');
            readln(reg.categoria);
            writeln('horas extras');
            readln(reg.horasExtras);
            write(arch,reg);
            writeln('departamento');
            readln(reg.departamento);
        end;

        close(arch);
    end;

    procedure leer (var arch:empleados;var reg:empleado);
    begin
        if (not eof(arch)) then
            read(arch,reg)
        else
            reg.departamento:=valorAlto;
    end;

    procedure informar (var arch:empleados; var valores:ar15);
    var 
        importe:double;
        reg:empleado;
        depAux:integer;
        horasDepartamento:integer;
        montoDepartamento:double;
        divisionAux:integer;
        horasDivision:integer;
        montoDivision:double;
    begin
        reset(arch);
        leer(arch,reg);       
        while(reg.departamento <> valorAlto) do 
        begin
            writeln('Departamento: ',reg.departamento);
            depAux:=reg.departamento;
            horasDepartamento:=0;
            montoDepartamento:=0.0;
            while (depAux = reg.departamento) do begin
            writeln('Division : ',reg.division);
            divisionAux:=reg.division;
            horasDivision:=0;
            montoDivision:=0.0;
            writeln('Numero de empleado Total Hs. Importe a Cobrar');
            while(depAux = reg.departamento) and (divisionAux = reg.division) do begin //interpreto que un empleado aparece 1 vez
                importe:=valores[reg.categoria]*reg.horasExtras;
                writeln(reg.numeroEmpleado,' ',reg.horasExtras,' ',importe:0:2);
                horasDivision:=horasDivision+reg.horasExtras;
                montoDivision:=montoDivision+importe;
                leer(arch,reg);
            end;
            writeln('Total horas division: ',horasDivision);
            writeln('Monto total por division: ',montoDivision:0:2);
            horasDepartamento:=horasDepartamento+horasDivision;
            montoDepartamento:=montoDepartamento+montoDivision;
            end;
            writeln('Total horas departamento: ',horasDepartamento);
            writeln('Total monto departamento: ',montoDepartamento:0:2);
        end;
        close(arch);
    end;      
    
    procedure imprimirMaster(var arch:empleados);
    var reg:empleado;
    begin
        reset(arch);
        while (not eof(arch)) do
        begin
            read(arch,reg);
            writeln(reg.departamento,' ',reg.division,' ',reg.numeroEmpleado,' ',reg.categoria,' ',reg.horasExtras);
        end;

        close(arch);
    end;

var valores : ar15;
archivo:empleados;
begin
    cargarVector(valores);
    assign(archivo,'archivoEj10');
   // crearArchivo(archivo);
    imprimirMaster(archivo);
    informar(archivo,valores);
end.