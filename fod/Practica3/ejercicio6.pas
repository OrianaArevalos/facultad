program ejercicio6;
type
  alum = record
    apellido : string[30];
    nombre : string[20];
    edad : integer;
    legajo : integer;
  end;
  alumA = file of alum;
procedure leerRegistro (var alumno: alum);
begin
 with alumno do
 begin
  writeln('Ingrese el apellido del alumno');
  readln(apellido);
  if(apellido <> '')then
    begin
      writeln('Ingrese el nombre del alumno');
      readln(nombre);
      writeln('Ingrese la edad del alumno');
      readln(edad);
      writeln('Inrese el legajo del alumno');
      readln(legajo);
    end;
 end;
end;
procedure completarArchivo(var arcAlum:alumA);
var
  alumno : alum;
begin
  rewrite(arcAlum);
  leerRegistro(alumno);
  while (alumno.apellido <> '')do
    begin
      write(arcAlum,alumno);
      leerRegistro(alumno);
    end;
  close(arcAlum);
end;
procedure listarAlumnoDeterminado(var arcAlum:alumA);
var
  ape: string;
  alumno:alum;
  ok:boolean;
begin
  reset(arcAlum);
  ok:=false;
  writeln('Ingrese el apellido del alumno del cual quiere que se muestren todos los datos');
  readln(ape);
  while(EOF(arcAlum) <> true) do
    begin
      read(arcAlum,alumno);
      if (alumno.apellido = ape) then
        begin
          ok:=true;
          with alumno do
           begin
            writeln(apellido,' ',nombre,' ',edad,' ',legajo);
           end;
        end;
    end;
  if(ok = false) then
    writeln('No existe ningun alumno con ese apellido');
    readln;
end;
procedure listarAlumnos (var arcAlum: alumA);
var
  alumno:alum;
begin
  reset(arcAlum);
  while (EOF(arcAlum) <> true) do
    begin
      read(arcAlum, alumno);
      writeln(alumno.apellido,' ',alumno.nombre,' ',alumno.edad,' ',alumno.legajo);
    end;
end;
procedure menu (var opc:byte);
begin
    writeln('ALUMNOS');
    writeln('Ingrese la opcion 0 para terminar el programa');
    writeln('Ingrese la opcion 1 para crear un archivo de alumnos');
    writeln('Ingrese la opcion 2 para listar en pantalla los datos de alumnos que tengan un apellido determinado');
    writeln('Ingrese la opcion 3 para listar en pantalla los amlumnos de a uno por linea');
    writeln('Ingrese la opcion 4 para eliminar de forma logica a un alumno');
    writeln('Ingrese la opcion 5 para listar en un archivo de texto a los alumnos, excepto aquellos que esten eliminados');
    writeln('Ingrese la opcion 6 para compactar el archivo');
    readln(opc);
end;
procedure eliminarAlumno (var arcAlum : alumA);
var
    rAlum : alum;
    legajo : integer;
    car : Char;
begin
    car := '*';
    reset(arcAlum);
    writeln('Ingrese el legajo del alumno que quiere eliminar');
    readln(legajo);
    read(arcAlum,rAlum);
    while ((not EOF(arcAlum)) and (rAlum.legajo <> legajo))do
    begin
        read(arcAlum,rAlum);
    end;
    if (rAlum.legajo = legajo) then
    begin
        rAlum.apellido := car + rAlum.apellido;
        seek(arcAlum,filepos(arcAlum)-1);
        write(arcAlum,rAlum);
    end
    else
    begin
        writeln('El alumno que quiere eliminar no se encuentra en el archivo')
    end;
    close(arcAlum);
end;
procedure listarAlumnosSinEliminados (var arcAlum:alumA);
var
    rAlum : alum;
    carga:Text;
begin
    assign(carga,'alumnos.txt');
    rewrite(carga);
    reset(arcAlum);
    while (not EOF(arcAlum)) do
    begin
        read(arcAlum,rAlum);
        if (rAlum.apellido[1] <> '*') then
            writeln(carga,rAlum.apellido,' ',rAlum.nombre,' ',rAlum.edad,' ',rAlum.legajo);
    end;
    close(carga);
    close(arcAlum);
end;
procedure compactarArchivo(var arcAlum : alumA);
var
    aAlum : alumA;
    rAlum : alum;
begin
    assign(aAlum, 'archivoEj6.dat');
    rewrite(aAlum);
    reset(arcAlum);
    while (not EOF(arcAlum)) do
    begin
        read(arcAlum,rAlum);
        if (rAlum.apellido[1] <> '*') then
        begin
            write(aAlum,rAlum);
        end;
    end;
    close(aAlum);
end;
var
  opc:byte;
  arcAlum : alumA;
begin
  assign (arcAlum, 'archivoEj6.dat');
  menu(opc);
  while (opc <> 0) do
  begin
     case opc of
        1: completarArchivo(arcAlum);
        2: listarAlumnoDeterminado(arcAlum);
        3: listarAlumnos(arcAlum);
        4: eliminarAlumno(arcAlum);
        5: listarAlumnosSinEliminados(arcAlum);
        6: compactarArchivo(arcAlum);
     end;
     menu(opc);
  end;
end.