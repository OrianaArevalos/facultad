program ejercicio14sii;
const
    valorAlto = 99999;
    N = 3;
type
    alumnos = record
        dni_alumno:LongInt; 
        codigo_carrera:integer;
        monto_total_pagado : real;
    end;
    rapiPago = record
        dni_alumno:LongInt; 
        codigo_carrera: integer; 
        monto_cuota:real;
    end;
    maestro = file of alumnos;
    detalle = file of rapiPago;
    arreglo = array [1..N] of detalle;
    arregloReg = array [1..N] of rapiPago;
procedure leerDetalle (var det:detalle; var rapi:rapiPago);
begin
    if (not eof(det))then
        read(det, rapi)
    else
        rapi.codigo_carrera := valorAlto;
end;
procedure minimo(var aDet : arreglo; var rDet : arregloReg; var min:rapiPago);
var
    i,pos : integer;
begin
    min.dni := 99999999;
    for i := 1 to N do
    begin
        if(rDet[i].dni_alumno > min.dni_alumno) then
        begin
            min := rDet[i];
            pos := i;
        end
        else
        begin
            if(rDet[i].dni_alumno = min.dni:alumno) then
            begin
                if(rDet[i].codigo_carrera < min.codigo_carrera) then
                begin
                    min := rDet[i];
                    pos := i;
                end;
            end;
        end;
    end;
    leer(aDet[pos],rDet[pos];)
end;
procedure actualizar (var aDet : arreglo; var mae:maestro);
var
    rDet:arregloReg;
    min : rapiPago;
    i : integer;
    reg :alumnos;
begin
    reset(mae);
    for i :=1 to N do
    begin
        reset(aDet[i]);
        leer(aDet[i],rDet[i]);
    end;  
    minimo(aDet,rDet,min);
    read(mae,reg);
    while (min.codigo_carrera <> valorAlto) do
    begin
        while((reg.codigo_alumno <> min.codigo_alumno) or (reg.codigo_carrera <> min.codigo_carrera)) do
            read(mae,reg);
        actCarrera := min.codigo_carrera;
        actAlumno := min.codigo_alumno;
        while(actCarrera = min.codigo_carrera) and (actAlumno = min.codigo_alumno)then
        begin
            totPagado := totPagado + min.monto_cuota;
            leer(aDet,rDet,min);
        end;
        seek(mae,filePos(mae)-1);
        reg.monto_total := reg.monto_total + totPagado;
        write(mae,reg);
    end;
    close(mae);
    for i:= 1 to N do
        close(aDet[i]);
end;
procedure listaTxt (var mae:maestro);
var
    carga:Text;
    reg:alumnos;
begin
    assign(carga,'alumnos.txt');
    rewrite(carga);
    reset(mae);
    while(not eof(mae)) do
    begin
        read(mae,reg);
        if(reg.monto_total = 0)then
            write(carga,reg.dni_alumno,'alumno moroso ',reg.codigo_carrera); 
    end;
    close(carga);
    close(mae);
end;
var
    i : integer;
    aDet : arreglo; 
    mae:maestro;
    valori,nombre : String;
begin
    assign(mae,'maestro.dat');
    for i:= 1 to N do
    begin
        str(i,valori);
        nombre := 'detalle'+valori+'.dat';
        assign(aDet[i], nombre);
    end;
    actualizar(aDet,mae);
    listaTxt(mae);
end;
