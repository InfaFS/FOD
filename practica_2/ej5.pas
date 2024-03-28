program ej5;
const n = 3;
const valorAlto = 999;
type
    producto = record
        cod:integer;
        nombre: string[15];
        descripcion : string[15];
        stockDisponible: integer;
        stockMinimo: integer;
        precio: double;
        

    end;

    infoExtra = record
        cod: integer;
        cantidadVendida:integer;
    end;

    masterProductos = file of producto;
    detalleProductos = file of infoExtra;
    ar_30 = array [1..30] of detalleProductos;

   
    procedure crearDetalle(var det:detalleProductos;i:integer);
    var dt:infoExtra;
    begin
        rewrite(det);
        writeln('cod (en detalle ', i, ')');
        readln(dt.cod);
        while (dt.cod <> 0) do 
        begin
            writeln('cantidad vendida');
            readln(dt.cantidadVendida);
            write(det,dt);
            writeln('cod (en detalle ', i, ')');
            readln(dt.cod);
        end;
        close(det);
    end;


    procedure readProducto(var pr:producto);
    begin
        writeln('nombre');
        readln(pr.nombre);
        writeln('descripcion');
        readln(pr.descripcion);
        writeln('stockDisponible');
        readln(pr.stockDisponible);
        writeln('stockMinimo');
        readln(pr.stockMinimo);
        writeln('precio (real)');
        readln(pr.precio);
    end;

    procedure crearMaestro (var master:masterProductos);
    var pr:producto;

    begin
        rewrite(master);
        writeln('codigo');
        readln(pr.cod);
        while(pr.cod <> 0) do 
        begin
        readProducto(pr);
        write(master,pr);
        writeln('codigo');
        readln(pr.cod);
        end;
        close(master);    
    end;

    procedure imprimirMaster(var master:masterProductos);
    var pr:producto;
    begin
        reset(master);
        while (not eof(master)) do
        begin
        read(master,pr);
        writeln(pr.cod,' ',pr.nombre,' ',pr.descripcion,' ',pr.stockDisponible,' ',pr.stockMinimo,' ',pr.precio:0:2);            
        end;

        close(master);
    end;

     procedure imprimirDetalle(var det:detalleProductos;i:integer);
    var dt:infoExtra;
    begin
        reset(det);
        writeln('DETALLE ',i);
        while (not eof(det)) do
        begin
        read(det,dt);
        writeln(dt.cod,' ',dt.cantidadVendida);            
        end;

        close(det);
    end;

      procedure leer (var arch:detalleProductos; var dt:infoExtra);
    begin
        if (not(EOF(arch))) then
            read(arch,dt)
        else
            dt.cod:=valorAlto;
    end;

    procedure exportarATxt(var arch:masterProductos);
    var txt:Text;
    pr:producto;
    begin  
        assign(txt,'ProductosEj5.txt');
        rewrite(txt);
        reset(arch);
        
        while (not eof(arch)) do
        begin
            read(arch,pr);
            if(pr.stockDisponible < pr.stockMinimo ) then
                writeln(txt,pr.nombre,' ',pr.descripcion,' ',pr.stockDisponible,' ',pr.precio);
        end;
        
        close(arch);
        close(txt);
    end;

///////////
    var master:masterProductos;
    detalle:detalleProductos;
    arDetalles: ar_30;
    AString: string;
    i:integer;
    regD:infoExtra;
    regM:producto;
    aux:integer;
    suma:integer;
//////////
    
begin
    assign(master,'masterProductos');
    crearMaestro(master);
    imprimirMaster(master);
    for i:= 0 to (n-1)do begin
    Str(i,AString);
    assign(arDetalles[i],'detalle' + AString);
    crearDetalle(arDetalles[i],i);
    imprimirDetalle(arDetalles[i],i);
    end;

    //hacer iteracion con corte de control
    reset(master);
    //iterar por el vector de archivos
    for i:=0 to (n-1) do begin
        read(master,regM);
        reset(arDetalles[i]);
        leer(arDetalles[i],regD);//probamos con un archivo
        while(regD.cod <> valorAlto) do begin
            aux :=regD.cod;
            suma:=0;
            writeln('sigue');
            while (regD.cod = aux) do begin
                suma:=suma+regD.cantidadVendida;
                leer(arDetalles[i],regD);
            end;
            while (regM.cod <> aux ) do 
                read(master,regM);
            //modifico regm
            regM.stockDisponible:=regM.stockDisponible-suma;
            seek(master,filepos(master)-1);

            write(master,regM);
            if (not(EOF(master))) then
                read(master,regM);

            end;
        close(arDetalles[i]);
        seek(master,0);
    end;

   close(master);
   writeln('///////////////');
   //imprimirDetalle(arDetalles[0],0);
    
   imprimirMaster(master);
   exportarATxt(master);
end.