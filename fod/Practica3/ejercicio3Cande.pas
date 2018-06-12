program Ej3;
type
  cososo = String[9];
  empleado = record
    codigo: integer;
    nomap: String[30];
    cantHijos: integer;
    dni: cososo;
    fnac: String[10];
  end;
  ar = file of empleado;
procedure justificarDerecha (var dni: cososo);
begin
while (length(dni)<9) do
  dni:= '0'+dni;
end;
procedure leerEmpleado(var emp:empleado);
begin
  write('Ingrese el codigo de empleado: ');
  readln(emp.codigo);
  if (emp.codigo<>-1) then
  begin
    write('Ingrese el nombre y apellido del empleado: ');
    readln(emp.nomap);
    write('Ingrese la cantidad de hijos del empleado: ');
    readln(emp.cantHijos);
    write('Ingrese el dni del empleado: ');
    readln(emp.dni);
    justificarDerecha(emp.dni);
    write('Ingrese la fecha de nacimiento del empleado (formato aaaa/mm/dd): ');
    readln(emp.fnac);
  end;
end;
procedure crearArchivo(var archivo:ar);
var
  emp: empleado;
begin
  Rewrite(archivo);
  leerEmpleado(emp);
  while(emp.codigo<>-1) do
  begin
    write(archivo,emp);
    leerEmpleado(emp);
  end;
  Close(archivo);
end;
procedure eliminarPersonal(var archivo:ar);
var
  emp:empleado;
begin
  Reset(archivo);
  while(not eof(archivo)) do
  begin
    read(archivo,emp);
    if(emp.fnac<'1960/01/01') then
    begin
      emp.nomap:='@' + emp.nomap;
      seek(archivo, filePos(archivo)-1);
      write(archivo, emp);
    end;
  end;
  Close(archivo);
end;
procedure imprimirArchivo(var archivo: ar);
var
  emp: empleado;
begin
  Reset(archivo);
  while(not eof(archivo)) do
  begin
    read(archivo, emp);
    writeln(emp.codigo, ' ', emp.nomap,' ',emp.cantHijos,' ', emp.dni, ' ', emp.fnac);
  end;
  Close(archivo);
end;

var
  archivo: ar;
begin
  Assign(archivo, 'ejercicio3sii.dat');
  //crearArchivo(archivo);
  imprimirArchivo(archivo);
  eliminarPersonal(archivo);
  imprimirArchivo(archivo);
end.