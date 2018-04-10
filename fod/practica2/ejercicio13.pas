program ejercicio13;
const
    valorAlto = 'zzzzzz'
type
    regMae = record
        destino : String;
        fecha : String;
        hsSalida : real;
        cantAsientosDisponibles : integer;
    end;
    regDet = record
        destino : String;
        fecha : String;
        hsSalida : real;
        cantAsientosComprados : integer;
    end;
    regListita = record
        destino = String;
        fecha = String;
        hsSalida = real;
    end;
    regLista = record
        regVuelo : regListita;
        sig : ^regLista;
    end;

    maestro = file of regMae;
    detalle = file of regDet;
procedure leer (var det:detalle; var regD:regDet);
begin
    if (not EOF(det))
        read(det,regD)
    else
        regD.destino=valorAlto;
end;
procedure minimo (var regD1,regD2,min:regDet; var det1,det2:detalle;);
begin
    if ((regD1.destino < regD2.destino) and (regD1.fecha < regD2.fecha) and (regD1.hsSalida < regD2.fecha))
    begin
        min = regD1;
        leer(det1,regD1);
    end
    else
    begin
        min = regD2;
        leer(det2,regD2);
    end;
end;
procedure actualizarMaestro (var det1,det2:detalle; var mae:maestro);
var
    actDestino,actFecha:String;
    actHsSalida : real;
    sumaAsientos : integer;
begin
    reset(mae);
    reset(det1);
    reset(det2);
    regD1,regD2,min : regDet;
    leer(det1,regD1);
    leer(det2,regD2);
    minimo(regD1,regD2,min,det1,det2);
    while (min.destino <> valorAlto)
    begin
        read(mae,regM);
        while (regM.destino <> min.destino)
            read(mae,regM);
        actDestino = min.destino;
        while (actDestino = min.destino)
        begin
            while (regM.fecha <> min.fecha)
                read(mae,regM);
            actFecha = min.fecha;
            while ((actFecha = min.fecha) and (actDestino = min.destino))
            begin
                while (regM.hsSalida <> min.hsSalida)
                    read(mae,regM);
                actHsSalida = min.hsSalida;  
                sumAsiento = 0; 
                while ((actHsSalida = min.hsSalida) and (actFecha = min.fecha) and (actDestino = min.destino))    
                begin
                    sumAsiento = sumAsiento + min.cantAsientosComprados;
                    minimo(regD1,regD2,min,det1,det2);
                end;     
                regM.cantAsientosDisponibles = regM.cantAsientosDisponibles - sumaAsiento;
                seek(mae,filePos(mae)-1)
                write(mae,regM);
            end;
        end;
    end;
    close(det1);
    close(det2);
    close(mae);
end;
procedure agregarAdelante (var l:regLista; elem : regMae);
var
    nodo : regLista;
begin
    nodo.sig = l;
    nodo.regVuelo.destino = elem.destino;
    nodo.regVuelo.hsSalida = elem.hsSalida;
    nodo.regVuelo.fecha = elem.fecha;
    l = nodo;
end;
procedure armarLista (var l:lista;var mae:maestro;cantMinima:integer;);
var
    regM : regMae;
begin
    reset(mae);
    while (not EOF(mae))
    begin
        read(mae,regM);
        if (regM.cantAsientosDisponibles < cantMinima)
        begin
            agregarAdelante(l,regM);
        end;
    end;
end;
var
    det1,det2:detalle;
    mae:maestro;
    l :lista;
    cantMinima : integer;
begin
    l = nill;
    assign (det1,'detalle1Ej13.dat');
    assign (det2,'detalle2Ej13.dat');
    assign (det3,'maestroEj13.dat');
    actualizarMaestro(det1,det2,mae);
    writeln('Ingrese el numero del cual quiere que se genere la lista con los vuelos');
    readln(cantMinima);
    armarLista(l,mae,cantMinima);
end. 