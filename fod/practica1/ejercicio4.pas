program ejercicio4;
type
  alum = record
    apellido : string[30];
    nombre : string[20];
    edad : integer;
    legajo : string[10];
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
var
  opc:integer;
  nombArch: string;
  arcAlum : alumA;
begin
  writeln('ALUMNOS');
  writeln('Ingrese la opcion 1 para crear un archivo de alumnos');
  writeln('Ingrese la opcion 2 para listar en pantalla los datos de alumnos que tengan un apellido determinado');
  writeln('Ingrese la opcion 3 para listar en pantalla los amlumnos de a uno por linea');
  readln(opc);
  If((opc = 1) or (opc = 2) or (opc = 3)) then
    begin
      assign (arcAlum, 'nombArch');
    end;
  case opc of
    1: begin
         completarArchivo(arcAlum);
       end;
    2: begin
         listarAlumnoDeterminado(arcAlum);
         readln();
       end;
    3: begin
         listarAlumnos(arcAlum);
         readln();
       end;
end;
end.