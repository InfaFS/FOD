program ej2;
const valorAlto=9999;
type
    string15 = string[15];

    alumno = record
      cod:integer;
      apellido:string15;
      nombre:string15;
      cursadas:integer;
      aprobadas:integer;
    end;

    materia = record
      cod:integer;
      estadoMateria:boolean; //true aprobo con final, false solo cursada
    end;

    alumnos =file of alumno;
    materias = file of materia;

    procedure leer( var archivo:materias; var dato:materia);
    
    begin
      if (not(EOF(archivo))) then
        read(archivo,dato)
      else
        dato.cod:=valorAlto;
    end;

    procedure cargarAlumno(var alu:alumno);
    begin


      writeln('apellido alumno: ');
      readln(alu.apellido);

      writeln('nombre alumno: ');
      readln(alu.nombre);

      writeln('cursadas alumno: ');
      readln(alu.cursadas);

      writeln('aprobadas alumno: ');
      readln(alu.aprobadas);
    end;

    procedure cargarMaestro(var archivo:alumnos);
    var
      alu:alumno;
    begin            
      rewrite(archivo);                         
      writeln('cod alumno: ');
      readln(alu.cod);
      while(alu.cod<> 0) do
      begin
      cargarAlumno(alu);
      write(archivo,alu);
      writeln('cod alumno: ');
      readln(alu.cod);
      end;
      close(archivo);
    end;

    procedure cargarDetalle (var archivo:materias);
    var mat:materia;
    aux:string;
    begin
      rewrite(archivo);
      writeln('cod alumno en maestro: ');
      readln(mat.cod);
      while (mat.cod <> 0) do
      begin
      writeln('TRUE O FALSE');
      readln(aux);
      if (aux = 'TRUE') then
        mat.estadoMateria:=true
      else
        mat.estadoMateria:=false;
      write(archivo,mat);
      writeln('cod alumno: ');
      readln(mat.cod);
      end;
     

      close(archivo);
    end;
  procedure imprimirMaster(var archivo:alumnos);
  var alu:alumno;
  begin
    reset(archivo);
    //read(archivo,alu);
    while (not eof(archivo)) do begin
      read(archivo,alu);
      writeln(alu.cod,' ',alu.apellido,' ', alu.nombre,' ',alu.cursadas,' ',alu.aprobadas);
    end;

    close(archivo);
  end;

  procedure imprimirDetalle(var archivo:materias);
  var mat:materia;
  begin
    reset(archivo);
    while(not eof(archivo)) do begin;
      read(archivo,mat);
      writeln(mat.cod,' ',mat.estadoMateria);
    end;  
    close(archivo);
  end;

  procedure exportarATxt(var archivo:alumnos);
  var
    alu:alumno;
    txt:Text;
  begin 
    assign(txt,'Exportado.txt');
    rewrite(txt);
    reset(archivo);
    while(not eof(archivo)) do 
    begin
    read(archivo,alu);
    if (alu.aprobadas > alu.cursadas) then
      writeln(txt,alu.cod,' ',alu.apellido,' ', alu.nombre,' ',alu.cursadas,' ',alu.aprobadas);
    end;
    close(archivo);
    close(txt);
  end;

  var
    master:alumnos;
    detalle:materias;
    regM: alumno;
    regD: materia;
    codAux: integer;
    cursadasAux: integer;
    aprobadasAux: integer;

begin
  assign(master, 'maestroAlumnos');
  assign(detalle, 'detalleAlumnos');
  cargarMaestro(master);
  cargarDetalle(detalle);
  imprimirMaster(master);
  writeln('///////////');
  imprimirDetalle(detalle);
  writeln('///////////');
  reset(master);
  reset(detalle);

  read(master,regM);
  leer(detalle,regD);
  
  while (regD.cod <> valorAlto) do
  begin
    codAux:= regD.cod;
    aprobadasAux:=0;
    cursadasAux:=0;
    
    while( codaux = regD.cod) do
    begin
      if(regD.estadoMateria = true) then //veo si esta aprobada
        aprobadasAux:=aprobadasAux+1
      else if (regD.estadoMateria = false) then //si solo esta la cursada
        cursadasAux:=cursadasAux+1;
      leer(detalle,regD);
    end;

    while(regM.cod <> codAux) do
    begin
      read(master,regM);
    end;

    regM.aprobadas:=regM.aprobadas+aprobadasAux;
    regM.cursadas:=regM.cursadas-aprobadasAux;

    regM.cursadas:=regM.cursadas+cursadasAux;
    
    seek(master,filepos(master)-1);
    write(master,regM);
    if (not eof(master)) then
      read(master,regM);

  end;

  close(master);
  close(detalle);
  imprimirMaster(master);
  imprimirDetalle(detalle);
  exportarATxt(master);
    
end.

