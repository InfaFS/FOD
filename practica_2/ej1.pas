program ej1;
const valor_alto = 9999;
type
    empleado = record
        cod: integer;
        nombre: string[15];
        monto_comision: Double;
    end;

    empleado_t = record
        cod: integer;
        monto_total: Double;
    end;
    empleados = file of empleado;
    compactado = file of empleado_t;

    procedure leer (var arch: empleados; var e:empleado);
    begin
        if (not(EOF(arch))) then
        begin
            read(arch,e);
        end
        else
        begin
            e.cod:=valor_alto;
        end;
    end;

var archEmpleados:empleados;
    archEmpleadosTotal:compactado;
    regEmp: empleado;
    regEmpTotal: empleado_t;
    totalEmpActual:double;
    total:Double;
    codEmpleadoActual:integer;
    

begin
    assign(archEmpleados,'empleados');
    reset(archEmpleados);
    assign(archEmpleadosTotal,'empleadosTotal.dat');
    rewrite(archEmpleadosTotal);
    leer(archEmpleados,regEmp);
    total:=0.0;

    while(regEmp.cod <> valor_alto) do begin
        totalEmpActual:=0.0;
        codEmpleadoActual:=regEmp.cod;
        while (regEmp.cod = codEmpleadoActual) do
        begin
            totalEmpActual := totalEmpActual + regEmp.monto_comision;
            leer(archEmpleados,regEmp);
        end;
        regEmpTotal.cod:=codEmpleadoActual;
        regEmpTotal.monto_total:=totalEmpActual;
        write(archEmpleadosTotal,regEmpTotal);
    end;

    close(archEmpleados);
    close(archEmpleadosTotal);
    //other output
    reset(archEmpleados);
    while not eof(archEmpleados) do
    begin
    read(archEmpleados,regEmp);
    writeln(regEmp.cod,' ', regEmp.nombre,' ',regEmp.monto_comision:0:2);
    end;
    close(archEmpleados);
    //master output
    reset (archEmpleadosTotal);
    while not eof(archEmpleadosTotal) do
    begin
    read(archEmpleadosTotal,regEmpTotal);
    writeln(regEmpTotal.cod,' ',regEmpTotal.monto_total:0:2);
    end;

end.