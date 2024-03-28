program ej9;

const valorAlto=999;

type
    mesaElectoral=record
    codProvincia:integer;
    codLocalidad:integer;
    numMesa:integer;
    votos:integer;
    end;

    mesasElectorales = file of mesaElectoral;

    procedure leer(var archivo:mesasElectorales;var dato:mesaElectoral);
    begin
        if (not(EOF(archivo))) then
            read(archivo,dato)
        else
            dato.codProvincia:=valorAlto;
    end;

    procedure cargarRegistro(var reg:mesaElectoral);
    begin
        writeln('cod localidad');
        readln(reg.codLocalidad);
        writeln('num mesa');
        readln(reg.numMesa);
        writeln('votos');
        readln(reg.votos);
    end;

    procedure cargarFile(var arch:mesasElectorales);
    var reg:mesaElectoral;
    begin
        rewrite(arch);
        writeln('Cod provincia');
        readln(reg.codProvincia);
        while (reg.codProvincia<>0) do
        begin
            cargarRegistro(reg);
            write(arch,reg);
            writeln('Cod provincia');
            readln(reg.codProvincia);
        end;


        close(arch);
    end;

    procedure imprimirMaster(var arch:mesasElectorales);
    var reg:mesaElectoral;
     begin
        reset(arch);
        while(not eof(arch)) do begin
        read(arch,reg);
        writeln(reg.codProvincia,' ',reg.codLocalidad,' ',reg.numMesa,' ',reg.votos);
        end;

        close(arch);
    end;
    var arch:mesasElectorales;
    provinciaAux:integer;
    numAux:integer;
    localidadAux:integer;
    sumaVotosTotal:integer;
    sumaVotosProvincia:integer;
    sumaVotosLocalidad:integer;
    reg:mesaElectoral;
    begin
        assign(arch,'archivo_votos');
        //cargarFile(arch);
        imprimirMaster(arch);
        reset(arch);
        leer(arch,reg);       
        while(reg.codProvincia <> valorAlto) do 
        begin
            writeln('Cod Provincia: ',reg.codProvincia);
            provinciaAux:=reg.codProvincia;
            sumaVotosProvincia:=0;
            while (provinciaAux = reg.codProvincia) do begin
            writeln('Codigo Localidad: ',reg.codLocalidad);
            localidadAux:=reg.codLocalidad;
            sumaVotosLocalidad:=0;
            while(provinciaAux = reg.codProvincia) and (localidadAux = reg.codLocalidad) do begin
                writeln('mesa: ',reg.numMesa,'   ',reg.votos);
                sumaVotosLocalidad:=sumaVotosLocalidad+reg.votos;
                leer(arch,reg);
            end;
            writeln('Total localidad: ',sumaVotosLocalidad);
            sumaVotosProvincia:=sumaVotosProvincia+sumaVotosLocalidad;
            end;
            writeln('Total provincia: ',sumaVotosProvincia);
            sumaVotosTotal:=sumaVotosTotal+sumaVotosProvincia;
        end;
        writeln('Total votos',sumaVotosTotal);
        close(arch);
       
    end.