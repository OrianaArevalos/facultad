program ejercicio7;
const 
    carSeparador : Char = '@';
procedure menu (var opc : byte);
begin
    writeln('Ingrese la opcion 0 para terminar el programa');
    writeln('Ingrese la opcion 1 para crear el archivo de nombres de personas');
    writeln('Ingrese la opcion 2 para listar en pantalla los nombres de las personas');
    readln(opc);
end;
procedure crearArchivo(var aPer:file);
var
    nombre : String;
begin
    rewrite(aPer);
    writeln('Ingrese el nombre de la persona, el corte es un nombre nulo');
    readln(nombre);
    while (nombre <> '') do
    begin
        nombre := nombre + carSeparador;
        blockwrite(aPer,nombre[1],length(nombre));
        writeln('Ingrese el nombre de la persona, el corte es un nombre nulo');
        readln(nombre);
    end;
    close(aPer);
end;
procedure listarArchivo(var aPer:file);
var
    nombre : String;
    car : Char;
    carga : Text;
begin
    assign(carga,'pruebaEj7.txt');
    rewrite(carga);
    reset(aPer,1);
    while (not EOF(aPer)) do
    begin
        nombre := '';
        BlockRead(aPer,car,1);
        while ((not EOF(aPer)) and (car <> carSeparador))do
        begin
            nombre := nombre + car;
            BlockRead(aPer,car,1);
        end;
        writeln(carga,nombre);
        writeln(nombre);
    end;
    close(carga);
    close(aPer);
end;
var
    aPer : file;
    opc : byte;
begin
    assign (aPer,'archivoEj7.dat');
    menu(opc);
    while (opc <> 0) do
    begin
        case opc of 
            1:crearArchivo(aPer);
            2: listarArchivo(aPer);
        end;
        menu(opc);
    end;
end.