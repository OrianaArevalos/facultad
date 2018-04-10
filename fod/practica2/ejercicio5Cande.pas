program ejercicio2;
type
  alumnos =record
    codigo: integer;
    apellido: String[20];
    nombre: String[20];
    cursap: integer;
    finap: integer;
  end;
  informacion =1..2; {1 si aprobo la cursada, 2 si aprobo el final}
  materia = record
    codigo: integer;
    info: informacion;
  end;
  archmaestro = file of alumnos;
  archdetalle = file of materia;
procedure crearMaestro (var archivo:archmaestro; var carga:Text);
var
  a: alumnos;
begin
  Rewrite(archivo);
  Reset(carga);
  while (not eof(carga)) do
  begin
    readln(carga, a.codigo, a.cursap, a.finap, a.apellido, a.nombre);
    write(archivo, a);
  end;
  Close(archivo);
  Close(carga);
end;
procedure crearDetalle (var archivo:archdetalle; var carga:Text);
var
  m: materia;
begin
  Rewrite(archivo);
  Reset(carga);
  while (not eof(carga)) do
  begin
    readln(carga, m.codigo, m.info);
    write(archivo, m);
  end;
  Close(archivo);
  Close(carga);
end;
procedure listarMaestro(var archivo:archmaestro; var carga: Text);
var
  a: alumnos;
begin
  Reset(archivo);
  Rewrite(carga);
  while(not eof(archivo)) do
  begin
    read(archivo, a);
    writeln(carga, a.codigo,' ', a.cursap,' ',a.finap, a.apellido, a.nombre);
  end;
  Close(archivo);
  Close(carga);
end;
procedure listarDetalle(var archivo:archdetalle; var carga: Text);
var
  m: materia;
begin
  Reset(archivo);
  Rewrite(carga);
  while(not eof(archivo)) do
  begin
    read(archivo, m);
    writeln(carga, m.codigo,' ', m.info);
  end;
  Close(archivo);
  Close(carga);
end;
procedure actualizarMaestro(var maestro:archmaestro; var detalle:archdetalle);
begin

end;

procedure listarAprobados(var archivo:archmaestro; var carga: Text);
begin

end;

var
  opcion: integer;
  maestro: archmaestro;
  detalle: archdetalle;
  maestrotext: Text;
  detalletext: Text;
  listmaestro: Text;
  listdetalle: Text;
  listf: Text;
begin
  writeln('INGRESE:');
  writeln('   1 - Crear el archivo maestro a partir de un archivo de texto.');
  writeln('   2 - Crear el archivo detalle a partir de un archivo de texto.');
  writeln('   3 - Listar el contenido del archivo maestro en un archivo de texto.');
  writeln('   4 - Listar el contenido del archivo detalle en un archivo de texto.');
  writeln('   5 - Actualizar el archivo maestro');
  writeln('   6 - Listar en un archivo de texto alumnos con mas de cuatro materias con cursada aprobada pero sin final.');
  writeln('   0 - Finalizar el programa.');
  write('Ingrese su opcion: ');
  readln(opcion);
  Assign(maestro, 'Maestro');
  Assign(detalle, 'Detalle');
  Assign(maestrotext, 'alumnosCande.txt');
  Assign(detalletext, 'detalleCande.txt');
  Assign(listmaestro, 'reporteAlumnosCande.txt');
  Assign(listdetalle, 'reporteDetalleCande.txt');
  Assign(listf, 'reporteAprobado.txt');
  while (opcion<>0) do
  begin
    case opcion of
      1:crearMaestro(maestro,maestrotext);
      2:crearDetalle(detalle,detalletext);
      3:listarMaestro(maestro,listmaestro);
      4:listarDetalle(detalle, listdetalle);
      5:actualizarMaestro(maestro, detalle);
      6:listarAprobados(maestro, listf);
    else
      writeln('El numero ingresado no es valido:');
    end;
    write('Ingrese su opcion: ');
    readln(opcion);
  end;
  writeln('El programa finalizo');
  readln();
end.