program ej7;
const n=2;
const valorAlto=999;
type 
    municipio=record
      codLocalidad:integer;
      codCepa:integer;
      casosActivos:integer;
      casosNuevos:integer;
      casosRecuperados:integer;
      casosFallecidos:integer;
    end;

    ministerio=record
      codLocalidad:integer;
      nombreLocalidad:string;
      codCepa:integer;
      nombreCepa:string;
      casosActivos:integer;
      casosNuevos:integer;
      casosRecuperados:integer;
      casosFallecidos:integer;
    
    end;

    master = file of ministerio;
    detalle = file of municipio;

    arDetalles = array [1..n] of detalle;

    procedure cargarMinisterio(var regM:ministerio);
    begin
      writeln('Seteando valores...');
      writeln('Ingrese localidad');
      readln(regM.nombreLocalidad);
      writeln('Ingrese codigo de cepa');
      readln(regM.codCepa);
      writeln('Ingrese nombre de cepa');
      readln(regM.nombreCepa);
      regM.casosActivos:=0;
      regM.casosNuevos:=0;
      regM.casosRecuperados:=0;
      regM.casosFallecidos:=0;

    end;

    procedure crearMaster(var arch:master);
    var regM:ministerio;
    begin
      rewrite(arch);
      writeln('codLocalidad');
      readln(regM.codLocalidad);
      while(regM.codLocalidad <> 0) do
      begin
        cargarMinisterio(regM);
        write(arch,regM);
        writeln('codLocalidad');
        readln(regM.codLocalidad);
      end;

      close(arch);

    end;

    procedure cargarMunicipio (var regD:municipio);
    begin
      writeln('codCepa');
      readln(regD.codCepa);
      writeln('casosActivos');
      readln(regD.casosActivos);
      writeln('casosNuevos');
      readln(regD.casosNuevos);
      writeln('casosRecuperados');
      readln(regD.casosRecuperados);
      writeln('casosFallecidos');
      readln(regD.casosFallecidos);
    end;


    procedure leer(var arch:detalle;var regD:municipio);
    begin
        if (not(EOF(arch))) then
            read(arch,regD)
        else
          regD.codLocalidad:=valorAlto;
    end;

    procedure recorrerYCargar(var archM:master; var arrayDetalles:arDetalles);

    var regM:ministerio;
    regD:municipio;
    aux:integer;
    aux2:integer;
    fallecidos:integer;
    recuperados:integer;
    activos:integer;
    nuevos:integer;

    i:integer;
    begin
    //hacer iteracion con corte de control
    reset(archM);
    //iterar por el vector de archivos
    for i:=1 to (n) do begin
        read(archM,regM);
        reset(arrayDetalles[i]);
        leer(arrayDetalles[i],regD);//probamos con un archivo
      //  writeln('entra1');
        while(regD.codLocalidad <> valorAlto) do begin
            aux :=regD.codLocalidad;
            aux2:=regD.codCepa;
            fallecidos:=0;
            recuperados:=0;
            while (regD.codLocalidad = aux) and (regD.codCepa = aux2) do begin
                fallecidos:=fallecidos+regD.casosFallecidos;
                recuperados:=recuperados+regD.casosRecuperados;
                activos:=regD.casosActivos;
                nuevos:=regD.casosNuevos;
                leer(arrayDetalles[i],regD);
            end;
          // writeln('entra2');
       
            while (regM.codLocalidad <> aux ) and (regM.codCepa <> aux2) and not(eof(archM)) do //preguntar por que
                read(archM,regM);
                
            //modifico regm
            writeln('Los casos activos de la cepa ',regD.codCepa,'son ',regD.casosActivos);
            regM.casosActivos:=nuevos;
            regM.casosNuevos:=nuevos;
            regM.casosRecuperados:=regM.casosRecuperados+recuperados;
            regM.casosFallecidos:=regM.casosFallecidos+fallecidos;
            seek(archM,filepos(archM)-1);
            write(archM,regM);
         //   writeln('Escribio con exito regM');
            if (not eof(archM)) then
                read(archM,regM);

            end;
        close(arrayDetalles[i]);
        seek(archM,0);
    end;
    close(archM);
  end;

  procedure imprimirMaster(var arch:master);
  var regM:ministerio;
  begin
    reset(arch);
    while (not eof(arch)) do
    begin
      read(arch,regM);
      writeln(regM.codLocalidad,' ',regM.nombreLocalidad,' ',regM.codCepa,' ',regM.nombreCepa,' ',regM.casosActivos,' ',regM.casosNuevos,' ',regM.casosRecuperados,' ',regM.casosFallecidos);      
    end;

    close(arch);
  end;

  procedure imprimirDetalle(var arch:detalle;i:integer);
  var regD:municipio;
  begin
    reset(arch); 
    writeln('Archivo detalle ',i);
    while (not eof(arch)) do begin
      read(arch,regD);
      writeln(regD.codLocalidad,' ',regD.codCepa,' ',regD.casosActivos,' ',regD.casosNuevos,' ',regD.casosRecuperados,' ',regD.casosFallecidos);
    end;

    close(arch);
  end;


    procedure crearDetalle(var arch:detalle;i:integer);
    var regD:municipio;
    begin
      rewrite(arch);
      writeln('Archivo detalle ',i);
      writeln('regD.codLocalidad');
      readln(regD.codLocalidad);
      while (regD.codLocalidad <> 0 ) do begin
        cargarMunicipio(regD);
        write(arch,regD);
        writeln('regD.codLocalidad');
        readln(regD.codLocalidad);
      end;

      close(arch);
    end;


var archM:master;
  arrayDetalles:arDetalles;
  i:integer;
  aString:string;

begin
    assign(archM,'masterEj7');
    crearMaster(archM);
    imprimirMaster(archM);
    for i:=1 to n do
    begin
      Str(i,aString);
      assign(arrayDetalles[i],'municipio'+aString);
   //   crearDetalle(arrayDetalles[i],i);
    end;

    for i:=1 to n do
    begin
      imprimirDetalle(arrayDetalles[i],i);
      writeln('//////////////');
    end;
   recorrerYCargar(archM,arrayDetalles);
   imprimirMaster(archM);
    
end.