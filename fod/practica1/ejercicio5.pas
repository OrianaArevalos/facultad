program E5P1;
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
          writeln('hola');
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
  writeln('hola');
  readln;
  reset(arcAlum);
  writeln('hola');
  readln;
  while (EOF(arcAlum) <> true) do
    begin
      writeln('hola');
      readln;
      read(arcAlum, alumno);
      write(alumno.apellido,' ',alumno.nombre,' ',alumno.edad,' ',alumno.legajo);
    end;
end;
procedure anadirAlumno(var arcAlum:alumA);
var
  alumno:alum;
begin
  reset(arcAlum);
  writeln('Se ingresan alumnos hasta que ingrese un apellido nulo');
  Seek(arcAlum,fileSize(arcAlum));
  leerRegistro(alumno);
  while (alumno.apellido <> '') do
    begin
      write(arcAlum,alumno);
      leerRegistro(alumno);
    end;
  close(arcAlum);
end;
procedure modificarLegajo (var arcAlum:alumA);
var
  ape, legajoMod:String;
  alumno:alum;
  opc : integer;
begin
  reset(arcAlum);
  writeln('Ingrese el apellido de los alumnos que quiere modificar el legajo');
  readln(ape);
  while (EOF(arcAlum) <> true) do
    begin
      read(arcAlum,alumno);
      if (alumno.apellido = ape) then
        begin
          writeln ('Usted va a cambiar el legajo del alumno',alumno.nombre,' con legajo ',alumno.legajo, ' para confirmar presione 1');
          readln(opc);
          if(opc = 1) then
            begin
              writeln('ingrese el numero de legajo nuevo');
              readln(legajoMod);
              alumno.legajo := legajoMod;
              Seek(arcAlum,FilePos(arcAlum)-1);
              write(arcAlum,alumno);
            end;
        end;
      end;
end;
procedure exportarArchivo(var arcAlum:alumA);
var
  alumnos:text;
  alumno:alum;
begin
  assign(alumnos,'alumnos.txt');
  reset(arcAlum);
  rewrite(alumnos);
  repeat
    read (arcAlum, alumno);
    with alumno do
      begin
       write(nombre,legajo,apellido,edad);
       write(alumnos,apellido,nombre,legajo,edad);
    end;
  until(EOF(arcAlum));
  close(arcAlum);
  close(alumnos);
end;
procedure exportarLegajoCero (var arcAlum:alumA);
var
    erroneo:text;
    alumno:alum;
begin
    assign(erroneo,'erroneo.txt');
    reset(arcAlum);
    rewrite(erroneo);
    while(EOF(arcAlum) <> true) do
      begin
        read(arcAlum,alumno);
        if ( alumno.legajo = '0') then
          begin
            with alumno do
              begin
                write(erroneo,apellido,nombre,legajo,edad);
            end;
        end;
    end;
    close(arcAlum);
    close(erroneo);
end;
var
  opc:byte;
  nombArch: string;
  arcAlum : alumA;
begin
  writeln('ALUMNOS');
  writeln('Ingrese la opcion 1 para crear un archivo de alumnos');
  writeln('Ingrese la opcion 2 para listar en pantalla los datos de alumnos que tengan un apellido determinado');
  writeln('Ingrese la opcion 3 para listar en pantalla los amlumnos de a uno por linea');
  writeln('Ingrese la opcion 4 para añadir uno o mas alumnos al final');
  writeln('Ingrese la opcion 5 para modificar el legajo de uno o mas alumnos');
  writeln('Ingrese la opcion 6 para exportar el contenido de un archivo de texto');
  writeln('Ingrese la opcion 7 para exportar a un archivo de texto los alumnos con legajo 0');
  readln(opc);
  If((opc=3) or (opc=2) or (opc=1) or (opc=4) or (opc=5) or (opc=6) or (opc=7)) then
    begin
      writeln('if');
      readln;
      assign (arcAlum, 'nombArch');
    end;
  case opc of
    1: begin
         completarArchivo(arcAlum);
       end;
    2: begin
         listarAlumnoDeterminado(arcAlum);
       end;
    3: begin
         writeln('hol');
         listarAlumnos(arcAlum);
       end;
    4: begin
         anadirAlumno(arcAlum);
       end;
    5: begin
         modificarLegajo (arcAlum);
       end;
    6: begin
         exportarArchivo (arcAlum);
       end;
    7: begin
         exportarLegajoCero (arcAlum);
       end;
  end;
end.