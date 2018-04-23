program ejercicio1;
type    
    regPeli = record
        codigo : integer;
        genero : String;
        nombre : String;
        duracion : real;
        director : String;
        cantCopias : integer;
        precio : real;
    end;
    arcPeli = file of regPeli;
procedure menu (var opc:byte);
begin
    writeln('Ingrese la opcion 0 para terminar el programa');
    writeln('Ingrese la opcion 1 para crear un archivo a partir de datos ingresados por teclado');
    writeln('Ingrese la opcion 2 para dar de alta un pelicula leyendo informacion desde teclado');
    writeln('Ingrese la opcion 3 para modificar los datos de una pelicula ');
    writeln('Ingrese la opcion 4 para eliminar una pelicula cuyo codigo es ingresado por teclado');
    writeln('Ingrese la opcion 5 para listar en un archivo de texto todas las peliculas , incluso las eliminadas');
    readln(opc);
end;
procedure leerRegistro(var rPeli:regPeli);
begin
    with rPeli do
    begin
        writeln('Ingrese el codigo de pelicula, la condicion de corte es -1, la cual no se incluye');
        readln(codigo);
        if (codigo <> -1)then
        begin
            writeln('Ingrese el genero de la pelicula');
            readln(genero);
            writeln('Ingrese el nombre de la pelicula');
            readln(nombre);
            writeln('Ingrese la duracion de la pelicula');
            readln(duracion);
            writeln('Ingrese el director de la pelicula');
            readln(director);
            writeln('Ingrese la cantidad de copias de la pelicula');
            readln(cantCopias);
            writeln('Ingrese el precio de la pelicula');
            readln(precio);
        end;
    end;
end;
procedure crearRegListaInvertida(var rPeli : regPeli);
begin
    rPeli.codigo := 0;
    rPeli.genero := '';
    rPeli.nombre := '';
    rPeli.duracion := 0.0;
    rPeli.director := '';
    rPeli.cantCopias := 0;
    rPeli.precio := 0.0;
end;
procedure crearArchivo(var aPeli:arcPeli);
var
    rPeli:regPeli;
begin
    rewrite(aPeli);
    crearRegListaInvertida(rPeli);
    write(aPeli,rPeli);
    leerRegistro(rPeli);
    while (rPeli.codigo <> -1) do
    begin
        write(aPeli,rPeli);
        leerRegistro(rPeli);
    end;
    close(aPeli);
end;
procedure darDeAltaPelicula(var aPeli : arcPeli);
var
    rPeli,rPeliAux : regPeli;
    auxLista, posLista : integer;
begin
    reset(aPeli);
    writeln('Ingrese los datos para cargar un nueva pelicular');
    leerRegistro(rPeli);
    if (rPeli.codigo <> -1) then
    begin
        read(aPeli,rPeliAux);
        if (rPeli.codigo <> 0) then
        begin
            posLista := rPeliAux.codigo * -1;
            seek(aPeli,posLista);
            read(aPeli,rPeliAux);
            auxLista := rPeliAux.codigo;
            seek(aPeli,filePos(aPeli)-1);
            write(aPeli,rPeli);
            reset(aPeli);
            write(aPeli,rPeliAux);
        end
        else
        begin
            seek(aPeli,fileSize(aPeli));
            write(aPeli,rPeli);
        end;
    end;
    close(aPeli);
end;
procedure modificarRegistro (var rPeli,rPeliAux : regPeli);
begin
    rPeliAux.genero := rPeli.genero;
    rPeliAux.nombre := rPeli.nombre;
    rPeliAux.duracion := rPeli.duracion;
    rPeliAux.director := rPeli.director;
    rPeliAux.cantCopias := rPeli.cantCopias;
    rPeliAux.precio := rPeli.precio;
end;
procedure modificarPelicula (var aPeli : arcPeli);
var
    rPeli, rPeliAux : regPeli;
begin
    reset(aPeli);
    writeln('Ingrese los datos de la pelicula que quiere que se modifiquen los datos, tenga en cuenta que el codigo no va a ser modificado');
    leerRegistro(rPeli);
    read(aPeli,rPeliAux);
    while ((not EOF(aPeli)) and (rPeli.nombre <> rPeliAux.nombre)) do
    begin
        read(aPeli,rPeliAux);
    end;
    if ((rPeli.nombre = rPeliAux.nombre) and (rPeliAux.codigo > 0)) then
    begin
        modificarRegistro(rPeli,rPeliAux);
        seek(aPeli,filePos(aPeli)-1);
        write(aPeli,rPeliAux);
    end
    else
    begin
        if (rPeliAux.codigo > 0) then
            writeln ('La pelicula que usted quiere modificar ha sido eliminada ó nunca estuvo en el archivo');
    end;
    close(aPeli);
end;
procedure listarPeliculas (var aPeli : arcPeli);
var
    carga : text;
    rPeli : regPeli;
begin
    assign (carga,'Peliculas.txt');
    rewrite (carga);
    reset(aPeli);
    seek(aPeli,filePos(aPeli)+1);
    while (not EOF(aPeli)) do
    begin
        read(aPeli,rPeli);
        with (rPeli) do
        begin
            writeln(carga,codigo,' ',genero,' ',nombre,' ',duracion,' ',director,' ',cantCopias,' ',precio);
        end;
    end;
    close(carga);
    close(aPeli);
end;
procedure eliminarPelicula(var aPeli : arcPeli);
var
    rPeli, rPeliAux : regPeli;
    codigo, codigoLista : integer;
begin
    reset(aPeli);
    writeln('Ingrese el codigo de la pelicula que quiere eliminar');
    readln(codigo);
    read(aPeli,rPeliAux); //guardo el registro de la cabecera para luego copiarlo en el que elimine
    read(aPeli,rPeli);
    while ((not EOF(aPeli)) and (rPeli.codigo <> codigo)) do
    begin
        read(aPeli,rPeli);
    end;
    if (rPeli.codigo = codigo) then
    begin
        seek(aPeli,filePos(aPeli)-1);
        codigoLista := FilePos(aPeli) * -1;
        rPeli.codigo := rPeliAux.codigo;
        write(aPeli,rPeli);
        seek(aPeli,0);
        rPeliAux.codigo := codigoLista;
        write(aPeli,rPeliAux);
    end;
    close(aPeli);
end;
var
    aPeli : arcPeli;
    opc:byte;
begin
    menu(opc);
    assign(aPeli,'archivoEj1.dat');
    while (opc <> 0) do
    begin
        case opc of
            1 : crearArchivo(aPeli);
            2 : darDeAltaPelicula(aPeli);
            3 : modificarPelicula(aPeli);
            4 : eliminarPelicula(aPeli);
            5 : listarPeliculas(aPeli);
        end;
        menu(opc);
    end;
end. 