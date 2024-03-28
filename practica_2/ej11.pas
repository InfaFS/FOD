program ej11;
const valorAlto=999;

type

    string15 = string[15];
    acceso = record
        anio:integer;
        mes:integer;
        dia:integer;
        idUsuario:string15;
        tiempoAcceso:integer;

    end;

    servidor = file of acceso;

    procedure crearRegistro(var reg:acceso);
    begin
        writeln('mes');
        readln(reg.mes);
        writeln('dia');
        readln(reg.dia);
        writeln('idUsuario');
        readln(reg.idUsuario);
        writeln('tiempo de accesso');
        readln(reg.tiempoAcceso);
    end;

    procedure crearArchivo(var arch:servidor);
    var reg:acceso;
    begin
        rewrite(arch);
        writeln('anio');
        readln(reg.anio);
        while (reg.anio <> 0) do
        begin
            crearRegistro(reg);
            write(arch,reg);
            writeln('anio');
            readln(reg.anio);
        end;
        close(arch);
    end;

    procedure imprimirArchivo(var arch:servidor);
    var reg:acceso;
    begin
        reset(arch);
        
        while(not eof(arch)) do
        begin
            read(arch,reg);
            writeln(reg.anio,' ',reg.mes,' ',reg.dia,' ',reg.idUsuario,' ',reg.tiempoAcceso);
        end;

        close(arch);
    end;

    procedure leer(var arch:servidor;var reg:acceso);
    begin
        if (not eof(arch)) then
            read(arch,reg)
        else
            reg.mes:=valorAlto;
    end;

 //   procedure seleccionarAnio (var arch:servidor;var archAux:servidor;var encontrado:boolean);
  //  var i:integer;
  //  reg:acceso;
   // aString:string;
    //begin
        //reset(arch);
        //encontrado:=false;
        //writeln('Ingrese anio a buscar: ');
        //readln(i);
        //while (not eof(arch)) and not encontrado do
        //begin
        //    read(arch,reg);

       //     if (reg.anio = i) then
       //     begin
       //         encontrado:=true;
       //         Str(i,aString);
       //         assign(archAux,'archivoAnio'+aString);
       //         rewrite(archAux);
                //seek(arch,filepos(arch)-1);
       //         while (not eof(arch)) and (reg.anio = i) do
       //         begin
       //             write(archAux,reg);
      //              read(arch,reg);
     //           end;
     //           close(archAux);
    //        end;


    //   end;
    //    if (not encontrado) then 
    //        writeln('No hay archivos con el anio ',i);
    //  close(arch);
    //end;

procedure mostrar (var arc_maestro:servidor; anio:integer);
var
m:acceso;
total,totalMes,totalDia,totalId:double;
mesActual:integer;
diaActual:integer;
idActual:string;
ok:boolean;
begin
	ok:= false;
	reset (arc_maestro);
	leer (arc_maestro,m);
	while (m.anio <> valorAlto) and (m.anio <> anio) do begin
		leer (arc_maestro,m);
	end;
	total:= 0;
	while (m.anio = anio) and (m.mes <> valorAlto) do begin
		ok:= true;
		mesActual:= m.mes;
		writeln ('Mes:-- ',m.mes);
		totalMes:= 0;
		while (m.anio = anio) and (m.mes = mesActual) do begin
			diaActual:= m.dia;
			writeln ('Dia:-- ',m.dia);
			totalDia:= 0;
			while (m.anio = anio) and (m.mes = mesActual) and (m.dia = diaActual) do begin
				idActual:= m.idUsuario;
				totalId:= 0;
				while (m.anio = anio) and (m.mes = mesActual) and (m.dia = diaActual) and (m.idUsuario = idActual) do begin
					totalId+= m.tiempoAcceso;
					leer (arc_maestro,m);
				end;
				writeln ('idUsuario ',idActual,' Tiempo Total de acceso en el dia ',diaActual,' mes ',mesActual);
				writeln ('	',totalId:2:2);
				writeln ('');
				totalDia+= totalId;
			end;
			writeln ('Tiempo total acceso dia ',diaActual ,' mes ',mesActual);
			writeln ('	',totalDia:2:2);	
			writeln ('');
			totalMes+= totalDia;
		end; 
		writeln ('Total tiempo de acceso mes ',mesActual);
		writeln ('	',totalMes:2:2);
		writeln ('');
		total+= totalMes;
	end;
	if (ok)	then begin
		writeln ('Total tiempo de accesos anio', anio);
		writeln ('	',total:2:2);
	end
	else
		writeln ('Anio no encontrado.');
    
    close(arc_maestro);
end;

var server:servidor;
    serverAux:servidor;
    encontrado:boolean;
    i:integer;
    
begin
    assign(server,'servidorEj11');
   // crearArchivo(server);
    imprimirArchivo(server);
   // informarAnio(server);
   //seleccionarAnio(server,serverAux,encontrado);
   //if(encontrado) then
   // imprimirArchivo(serverAux);
   writeln('Ingrese anio');
   readln(i);
   mostrar(server,i);
end.