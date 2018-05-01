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
procedure cargarArchivo (var aEmp : file;tamReg : integer;codEmp,dni:integer;tamApe:integer;apellido:String;tamNom:integer;nombre:String;peso:real;estatura:real;fecha:LongInt);
begin
    BlockWrite(aEmp,tamReg,sizeof(tamReg));
    blockwrite(aEmp,codEmp,SizeOf(codEmp));
    BlockWrite(aEmp,dni,SizeOf(dni));
    BlockWrite(aEmp,apellido,Length(apellido)+1); //podria ser bw (aEmp,apellido,length(apellido)+1)
    blockWrite(aEmp,nombre,Length(nombre)+1); //lo mismo que para apellido , acá
    BlockWrite(aEmp,peso,SizeOf(peso));
    BlockWrite(aEmp,estatura,SizeOf(estatura));
    blockWrite(aEmp,fecha,sizeOf(fecha));
end;
procedure crearArchivo (var aEmp : file);
var
    nombre,apellido : String;
    fecha : LongInt;
    peso,estatura : real;
    codEmp,dni : integer;
    auxPreFijoReg:integer;
begin
    rewrite(aEmp,1);
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
        auxPreFijoReg := SizeOf(codEmp)+SizeOf(dni)+Length(apellido)+1+Length(nombre)+1+SizeOf(peso)+SizeOf(estatura)+SizeOf(fecha);  
        cargarArchivo(aEmp, auxPreFijoReg,codEmp,dni,Length(apellido)+1,apellido, Length(nombre)+1,nombre,peso,estatura,fecha);
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
        BlockRead(aEmp,control,1);  //leo la longitud del registro
        BlockRead(aEmp, buffer,control); //almaceno todo el registro en el vector
        move(buffer[1],codEmp,SizeOf(codEmp));      //copio el codigo de empleado en la variable desde el vector
        indice := SizeOf(codEmp)+1 ;       //sumo 1 para tener en cuenta que donde me decia la long del campo ocupa un byte
        move(buffer[indice],dni,SizeOf(dni));
        indice := indice + SizeOf(dni);
        move(buffer[indice],long,SizeOf(long));
        indice := indice + 1;
        SetLength(apellido,long);
        move(buffer[indice],apellido, long+1);
        indice := indice + long + 1;
        long := buffer[indice];
        SetLength(nombre,long  + 1);
        move(buffer[indice+1],nombre, long);
        indice := indice +long + 1;
        move(buffer[indice],peso, SizeOf(peso));
        indice := indice + SizeOf(peso)+1;
        move(buffer[indice],estatura, SizeOf(estatura));
        indice := indice  + SizeOf(estatura) + 1;
        move(buffer[indice],fecha, SizeOf(fecha));
        writeln('holi');
        writeln(codEmp,' ',dni,' ',apellido,' ',nombre,' ',peso,' ',estatura,' ',fecha);
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
