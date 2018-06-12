program ejercicioParcial;
type
    sistemaR = record 
        nombreSistema : String;
        cantInstalaciones : integer;
        esCodigoAbierto : Boolean;
        tipoLicencia : String;
        puntero : integer;
    end;
    archivo = file of sistemaR;
procedure darAlta (var arch : archivo; var sis : sistemaR);
var
    punteroInicial : integer;
    sisAux : sistemaR;
begin
    reset(arch);
    read(arch,sisAux);
    if (sisAux.puntero = 0) then
    begin
        seek(arch, filesize(arch));
        write(arch,sis);
    end
    else
    begin
        punteroInicial := sisAux.puntero * (-1);
        seek(arch,punteroInicial);
        read(arch,sisAux);
        seek(arch,punteroInicial);
        write(arch,sis);
        seek(arch,0);
        write(arch,sisAux);
    end;
    close(arch);
end;
procedure darBaja (var arch:archivo; var sis:sistemaR);
var
    pos,punteroInicial:integer;
    sisAux:sistemaR;
    encontre : boolean;
begin
    reset(arch);
    read(arch,sisAux);
    punteroInicial := sisAux.puntero;
    read(arch,sisAux);
    encontre := False;
    while (not eof(arch) and (not encontre))do
    begin
        if ((sisAux.nombreSistema = sis.nombreSistema) and (sisAux.tipoLicencia = sis.tipoLicencia)) then
            encontre := true
        else
            read(arch,sisAux);
    end;
    if (encontre)then
    begin
        seek(arch,FilePos(arch)-1);
        pos := filepos(arch) * (-1);
        sisAux.puntero := punteroInicial;
        write(arch,sisAux);
        seek(arch,0);
        sisAux.puntero := pos;
        write(arch,sisAux);
    end
    else
        writeln('El sistema operativo no existe');
    close(arch);
end;

procedure listarMaestro(var maestro:mae;var detalle: det);
var
    carga:Text;
    cantMensaje;
begin
    reset(mae);
    reset(det);
    rewrite(carga);  
    leer(det, reg);
    while (not EOF(mae)) or (reg.codigo <> valorAlto) do 
    begin
        read(mae,reg);
        write(numero de usuario);
        while (registro.nroUs <> reg.nroUs) or (not eof(mae))do
            write(cantMensaje 0);
            read(mae,registro);
            write(numero de usuario);
        if(eof (mae))
            write (cantMensaje 0);
        mensaje := 0;
        while (registro.nroUs = reg.nroUs) do
            mensaje := mensaje +1;
            leer(det,reg);
        write(cantidad mensaje);
    end;
    close(carga);
    close(mae);
    close(det);
end;

procedure
begin
    leer(mae,registro);
    leer(det,reg);
    mensaje := 0;
    while (registro.cod <> valorAlto) do
        while (registr.nro <> reg.nro) and (registro.nro <> valorAlto) do
            write(nombre, mensaje);
            mensaje := 0;
            leer(mae,registro);  
        while (registro.nro = reg.nro) and (reg.nro <> valorAlto)
            mensaje := mensaje +1;
            leer(det,reg);
end;