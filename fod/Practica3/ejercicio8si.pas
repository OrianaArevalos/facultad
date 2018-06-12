program ejercicio8si;
type
    rEmpleado = record
        codEmpleado : integer;
        DNI : String;
        apellido : String;
        nombre : String;
        peso : real;
        estatura : real;
        fNac: LongInt;
    end;
procedure leerRegistro(var emp : rEmpleado);
begin
    with emp do
    begin
        writeln('codEmp');
        readln(codEmpleado);
        if (codEmpleado <> 0)then
        begin
            writeln('dni');
            readln(dni);
            writeln('apellido');
            readln(apellido);
            writeln('nombre');
            readln(nombre);
            writeln('peso');
            readln(peso);
            writeln('estatura');
    else
        emp.codEmpleado := valorAlto;
end;
procedure eliminar(var aEmp : aEmpleado);
var
    emp : empleado;
begin
    reset(aEmp);
    leer(aEmp,emp);
    while (emp.codEmpleado <> valorAlto) do
    begin
      
            readln(estatura);
            writeln('fecha nacimiento');
            readln(fNac);
        end;
    end;
end;
procedure cargarRegistros(var aEmp:file;var emp:rEmpleado);
var
    tamReg : byte;
begin
    //primero guardo lo que mide todo el registro, le agrego 3 por los 3 strings. 
    tamReg := Length(emp.DNI)+Length(emp.apellido)+Length(emp.nombre)+3+SizeOf(emp.codEmpleado)+SizeOf(emp.peso)+SizeOf(emp.estatura)+SizeOf(emp.fNac);
    BlockWrite(aEmp,tamReg,SizeOf(tamReg));
    BlockWrite(aEmp,emp.codEmpleado,SizeOf(emp.codEmpleado));
    BlockWrite(aEmp,emp.DNI,Length(emp.DNI)+1);
    BlockWrite(aEmp,emp.apellido,Length(emp.apellido)+1);
    BlockWrite(aEmp,emp.nombre,Length(emp.nombre)+1);
    BlockWrite(aEmp,emp.peso,SizeOf(emp.peso));
    BlockWrite(aEmp,emp.estatura,SizeOf(emp.estatura));
    BlockWrite(aEmp,emp.fNac,SizeOf(emp.fNac));
end;
procedure cargarArchivo (var aEmp : file);
var 
    emp : rEmpleado;
begin
    rewrite(aEmp, 1);
    leerRegistro(emp);
    while (emp.codEmpleado <> 0)do
    begin
        cargarRegistros(aEmp,emp);
        leerRegistro(emp);
    end;
    close(aEmp);
end;
procedure leerRegistr(var aEmp : file;var emp : rEmpleado);
var
    tamReg, tamCampo, i : byte;
    datos : array  [1..256] of byte;
begin
    BlockRead(aEmp, tamReg, SizeOf(tamReg));
    BlockRead(aEmp, datos, tamReg);
    i := 1;

    move(datos[i],emp.codEmpleado,SizeOf(emp.codEmpleado));
    i := i + SizeOf(emp.codEmpleado);

    tamCampo := datos[i];
    SetLength(emp.DNI,tamCampo);
    move(datos[i],emp.DNI, tamCampo+1);
    i := i+1+tamCampo;

    tamCampo := datos[i];
    SetLength(emp.apellido,tamCampo);
    move(datos[i],emp.apellido, tamCampo+1);
    i := i + 1 + tamCampo;

    tamCampo := datos[i];
    SetLength(emp.nombre,tamCampo);
    move(datos[i], emp.nombre, tamCampo);
    i := i + 1 +tamCampo;

    move(datos[i],emp.peso,SizeOf(emp.peso));
    i := i + SizeOf(emp.peso);

    move(datos[i],emp.estatura,SizeOf(emp.estatura));
    i := i + SizeOf(emp.estatura);

    move(datos[i],emp.fNac,SizeOf(emp.fNac)); 
end;
procedure imprimirEnPantalla(var aEmp:file);
var
    emp : rEmpleado;
begin
    reset(aEmp,1);
    while(not eof(aEmp)) do
    begin
        leerRegistr(aEmp,emp);
        write(emp.nombre,' ',emp.apellido);
    end;
    close(aEmp);
end;
procedure menu (var opc : byte);
begin
    write('Opcion 0, Termina el programa');
    write('Opcion 1, crear archivo');
    write('Opcion 2, listar archiv');
    readln(opc);
end;
var 
    aEmp : file; opc: byte;
begin
    assign(aEmp,'ejercicio8si.dat');
    menu(opc);
    while (opc <> 0) do
    begin
        case opc of
            1: cargarArchivo(aEmp);
            2: imprimirEnPantalla(aEmp);
        end;
        menu(opc);
    end;
end.