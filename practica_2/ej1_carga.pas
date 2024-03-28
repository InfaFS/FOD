program ej1Carga;
type
  empleado = record
        cod: integer;
        nombre: string[15];
        monto_comision: Double;
    end;

    empleados = file of empleado;
    
    procedure cargaEmpleado(var emp:empleado);
    var cod:integer;
        nombre:string[15];
        monto_comision:double;
    begin
        write('cod');
        readln(cod);
        emp.cod:=cod;
        write('nombre');
        readln(nombre);
        emp.nombre:=nombre;
        write('monto comision');
        readln(monto_comision);
        emp.monto_comision:=monto_comision;
    end;
var 
    corte:integer;
    emp:empleado;
    archEmpleados: empleados;


begin
    assign(  archEmpleados,'empleados');
    rewrite(  archEmpleados);
    writeln('Ingrese corte');
    readln(corte);
    while (corte <> 0 ) do 
    
    begin
        cargaEmpleado(emp);
        write(archEmpleados,emp);
        writeln('Ingrese corte');
        readln(corte);
    end;
    close(  archEmpleados);

    reset(archEmpleados);
    while not eof(archEmpleados) do
    begin
    read(archEmpleados,emp);
    writeln(emp.cod,' ', emp.nombre,' ',emp.monto_comision:0:2);
    end;
    close(archEmpleados);
end.