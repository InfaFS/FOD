//tuve que inicializar el master,preguntar si esta bien

program ej6;
const n=2;
const valorAlto=999;
type
    logUsuario = record
    cod_usuario:integer;
    fecha:String;
    tiempo_sesion:integer; //minutos

    end;
    
    logTotal = record
    cod_usuario:integer;
    fecha:String;
    tiempo_sesion_total:integer; //minutos
    end;

    logsMaquina = file of logUsuario;
    logsMaster = file of logTotal;

    maquinasArray = array [1..5] of logsMaquina;

    procedure leer (var arch:logsMaquina; var dt:logUsuario);
    begin
        if (not(EOF(arch))) then
            read(arch,dt)
        else
            dt.cod_usuario:=valorAlto;
    end;

    procedure crearDetalle(var detalle:logsMaquina;i:integer);
    var regD:logUsuario;
    begin
        rewrite(detalle);
        writeln('registro ', i);
        writeln('cod usuario(detalle)');
        readln(regD.cod_usuario);
        while (regD.cod_usuario<>0) do
        begin
            writeln('fecha(detalle)');
            readln(regD.fecha);
            writeln('tiempo sesion(detalle)');
            readln(regD.tiempo_sesion);
            write(detalle,regD);
            writeln('cod usuario(detalle)');
            readln(regD.cod_usuario);
        end;
        close(detalle);
    end;

    procedure imprimirDetalle(var detalle:logsMaquina);
    var regD:logUsuario;
    begin
        reset(detalle);
        while not(eof(detalle)) do
        begin
            read(detalle,regD);
            writeln(regD.cod_usuario,' ',regD.fecha,' ',regD.tiempo_sesion);
        end;
        close(detalle);
    end;

    procedure imprimirMaster(var master:logsMaster);
    var rm:logTotal;
    begin
        reset(master);

        while(not eof(master)) do
        begin
            read(master,rm);
            writeln(rm.cod_usuario,' ',rm.fecha,' ',rm.tiempo_sesion_total);
        end;
        
        close(master);
    end;

    procedure llevarAMaster(var master:logsMaster; var maquinas:maquinasArray);
    var regM:logTotal;
    regD:logUsuario;
    aux:integer;
    suma:integer;
    i:integer;
    begin
    writeln('entro');
    //hacer iteracion con corte de control
    reset(master);
    //iterar por el vector de archivos
    for i:=1 to (n) do begin
        if (not eof(master)) then
        read(master,regM);

        reset(maquinas[i]);
        leer(maquinas[i],regD);//probamos con un archivo
        while(regD.cod_usuario <> valorAlto) do begin
            aux :=regD.cod_usuario;
            suma:=0;

            while (regD.cod_usuario = aux) do begin
                suma:=suma+regD.tiempo_sesion;
                leer(maquinas[i],regD);
            end;
       
            while (regM.cod_usuario <> aux ) do 
                read(master,regM);
                
            //modifico regm
           
            regM.fecha:='27/3/24';
            regM.tiempo_sesion_total:=regM.tiempo_sesion_total+suma;
            seek(master,filepos(master)-1);

            write(master,regM);
            if (not(EOF(master))) then
                read(master,regM);

            end;
        close(maquinas[i]);
        seek(master,0);
    end;

    close(master);
    end;

    procedure inicializarMaster(var master:logsMaster);
    var regM:logTotal;
    begin
        rewrite(master);
        writeln('codigo de usuario');
        readln(regM.cod_usuario);
        while(regM.cod_usuario<>0) do begin
        regM.fecha:='Sin carga';
        regM.tiempo_sesion_total:=0;
        write(master,regM);
        writeln('codigo de usuario');
        readln(regM.cod_usuario);
        end;
        
        close(master);
    end;
var
    arMaquinas:maquinasArray;
    master:logsMaster;
    AString: string;
    i:integer;
begin
    assign(master,'/Users/infa/Desktop/masterComputadoras'); //poner la carpeta que pide si fuese el caso
    for i:=1 to (n) do begin
       Str(i,AString);
        assign(arMaquinas[i],'detalleMaquina' + AString);
     //   crearDetalle(arMaquinas[i],i);
    end;

     for i:=1 to (n) do begin
        imprimirDetalle(arMaquinas[i]);
        writeln('///////////');
    end;
    inicializarMaster(master);
    llevarAMaster(master,arMaquinas);
    imprimirMaster(master);
end.