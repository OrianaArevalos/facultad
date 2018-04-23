program ejercicio8;
type
    arreglo = array[0..550] of byte;
procedure menu (var opc : byte);
begin
    writeln('Ingrese la opcion 0 para terminar el programa');
    writeln('Ingrese la opcion 1 para crear el archivo');
    writeln('Ingrese la opcion 2 para listar el archivo');
    readln(opc);
end;
procedure cargarArchivo (var aEmp : file;tamReg : integer;tamEmp,codEmp,tamDni,dni:integer;tamApe:integer;apellido:String;tamNom:integer;nombre:String; tamPeso:integer;peso:real;tamEst:integer;estatura:real;tamFecha:integer;fecha:LongInt);
begin
    BlockWrite(aEmp,tamReg,1);
    blockwrite(aEmp,tamEmp,1);
    blockwrite(aEmp,codEmp,tamEmp);
    blockwrite(aEmp,tamDni,1);
    BlockWrite(aEmp,dni,tamDni);
    blockwrite(aEmp,tamApe,1);
    BlockWrite(aEmp,apellido,tamApe);
    blockwrite(aEmp,tamNom,1);
    blockWrite(aEmp,nombre,tamNom);
    blockwrite(aEmp,tamPeso,1);
    BlockWrite(aEmp,peso,tamPeso);
    blockwrite(aEmp,tamEst,1);
    BlockWrite(aEmp,estatura,tamEst);
    blockwrite(aEmp,tamFecha,1);
    blockWrite(aEmp,fecha,tamFecha);
end;
procedure crearArchivo (var aEmp : file);
var
    nombre,apellido : String;
    fecha : LongInt;
    peso,estatura : real;
    codEmp,dni : integer;
    auxPreFijoReg:integer;
begin
    rewrite(aEmp);
    writeln('Ingrese el codigo del empleado , fin de carga: codigo 0');
    readln(codEmp);
    while (codEmp <> 0)do
    begin
        writeln('Ingrese el dni del empleado');
        readln(dni);
        writeln('Ingrese el apellido del empleado');
        readln(apellido);
        writeln('Ingrese el nombre del empleado');
        readln(nombre);
        writeln('Ingrese el peso del empleado');
        readln(peso);
        writeln('Ingrese la estatura del empleado');
        readln(estatura);
        writeln('Ingrese la fecha de nacimiento del empleado');
        readln(fecha);
        auxPreFijoReg := SizeOf(codEmp)+SizeOf(dni)+Length(apellido)+Length(nombre)+SizeOf(peso)+SizeOf(estatura)+SizeOf(fecha)+7;
        cargarArchivo(aEmp, auxPreFijoReg, sizeOf(codEmp),codEmp, sizeOf(dni),dni,Length(apellido),apellido, Length(nombre),nombre, sizeOf(peso),peso,SizeOf(estatura),estatura,sizeOf(fecha),fecha);
        writeln('Ingrese el codigo del empleado , fin de carga: codigo 0');
        readln(codEmp);
    end;
    close(aEmp);
end;
procedure leerRegistro(var aEmp : file;var codEmp:integer; var dni:integer; var apellido,nombre:String;var peso,estatura:real;var fecha:LongInt);
var
    tam : integer;
    buffer : arreglo; //el arreglo para tener todo el registro
    control,long: byte; //control es para tener la longitud del registro y long para la longitud de cada campo
    indice: integer; //indice se usa para ir moviendose en el arreglo
begin
    reset(aEmp,1);
    while (not EOF(aEmp)) do
    begin
        writeln('hasta llego');
        BlockRead(aEmp,control,1);
        BlockRead(aEmp, buffer[0],control);
        long := buffer[0];
        move(buffer[1],codEmp,long);
        indice := long + 1;
        long := buffer[indice];
        move(buffer[indice+1],dni, long);
        indice := long + 1;
        long := buffer[indice];
        SetLength(apellido,long+1);
        move(buffer[indice+1],apellido, long);
        indice := long + 2;
        long := buffer[indice];
        SetLength(nombre,long+1);
        move(buffer[indice+1],nombre, long);
        indice := long + 2;
        long := buffer[indice];
        move(buffer[indice+1],peso, long);
        indice := long + 1;
        long := buffer[indice];
        move(buffer[indice+1],estatura, long);
        indice := long + 1;
        long := buffer[indice];
        move(buffer[indice+1],fecha, long);
        writeln(fecha,peso);
    end;
    close(aEmp);
end;
var
    aEmp : file;
    opc:byte;
    codEmp:integer; 
    dni:integer;
    apellido,nombre:String;
    peso,estatura:real;
    fecha:LongInt;
begin
    assign (aEmp, 'archivoEj8.dat');
    menu(opc);
    while (opc <> 0) do
    begin
        case opc of 
            1:crearArchivo(aEmp);
            2:leerRegistro(aEmp,codEmp,dni,apellido,nombre,peso,estatura,fecha);
        end;
        menu(opc);
    end;
end.