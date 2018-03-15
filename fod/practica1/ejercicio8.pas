program E8P1;
type
  lib = record
    ISBN:String;
    nombre:String;
    precio:real;
    codEditorial:integer;
  end;
  archivos_libros = file of lib;
procedure crearArchivo (var arcLib:archivos_libros);
var 
  libroText : text;
  libro:lib;
begin
  assign(libroText,'libro.txt');
  rewrite(arcLib);
  reset(libroText);
  repeat
      with(libro)do 
        begin
          read(libroText,ISBN,nombre,precio,codEditorial);
        end; 
        write(arcLib,libro);
  until (EOF(arcLib));
  close(arcLib);
  close(libroText);
end;
procedure leerRegistro(var libro:lib);
begin
    with libro do
      begin
          writeln('Ingrese el nombre nuevo');
          readln(nombre);
          writeln('Ingrese el precio nuevo');
          readln(precio);
          writeln('Ingrese el codEditorial nuevo');
          readln(codEditorial);
          writeln('Ingrese el ISBN nuevo');
          readln(ISBN);
    end;
end;
procedure modificarArchivo(var arcLib:archivos_libros);
var 
  libro:lib;
  ok:boolean;
  ISBNmod:String;
begin
  ok := true;
  reset(arcLib);
  writeln('Ingrese el ISBN del libro que quiere modificar');
  readln(ISBNmod);
  while ((EOF(arcLib) <> true) and (ok)) do
    begin
      read(arcLib,libro);
      if(ISBNmod = libro.ISBN) then
        begin
          leerRegistro(libro);
          seek(arcLib,FilePos(arcLib)-1);
          write(arcLib,libro);
          ok := false;
        end;
    end;
  if(EOF(arcLib) <> true) then
    seek(arcLib,fileSize(arcLib));
  leerRegistro(libro);
  write(arcLib,libro);
  close(arcLib);
end;
var
  arcLib:archivos_libros;
begin
    assign(arcLib,'ejercicio7');
    crearArchivo(arcLib);
    modificarArchivo(arcLib);
end.