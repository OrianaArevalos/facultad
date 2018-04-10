program ejercicio1;
type
  ingresosR = record
    codEmpl : integer;
    nombre : Sring;
    montoCom : real;
  end;
  archivo_ingresos : file of ingresos;
procedure leer (var archivoIngresos:archivo_ingresos,ingresos:ingresosR);
begin
  if (not eof(archivo_Ingresos))then
    readln(archivoIngresos,ingresos)
  else
    ingresos.codEmpl := 99999;
end;
procedure compactarArchivo(archivoIngresos, archivoCompactado:archivo_ingresos);
var
  actualCodEmpl : integer; //para hacer el corte de control.
  ingresos:ingresosR //para extraer el registro del archivo existente.
  montoTotal:real //para sumar el monto de cada empleado ya que se puede repetir el mismo empleado 
begin
  reset(archivoIngresos);
  rewrite(archivoCompactado);
  leer(archivoIngresos,ingresos);
  while(ingresos.codEmpl <> 99999) do
    begin
      actualCodEmpl := ingresos.codEmpl;
      montoTotal := 0;
      while (actualCodEmpl = ingresos.codEmpl) do
        begin
          montoTotal := montoTotal + ingreso.codEmpl
          leer(archivoIngresos,ingresos);
      end;
      ingresos.montoCom := montoTotal;
      writeln(archivoCompactado,ingresos);
  end;
  close(archivoIngresos);
  close(archivoCompactado);
end;
var
  archivoIngresos,archivoCompactado := archivo_ingresos;
begin
  assign(archivoIngresos, 'archivoIngresosEj1.dat');
  assign(archivoCompactado, 'archivoCompactadoEj1.dat');
  compactarArchivo(archivoIngresos,archivoCompactado);
end. 