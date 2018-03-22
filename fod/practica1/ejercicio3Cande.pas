program Ej3;
type
  arreales= file of real;
procedure crearArchivo (var archivo:arreales);
var
  cant: integer;
  num: real;
  i: integer;
begin
  Rewrite(archivo);
  write('Ingrese la cantidad de numeros que va a ingresar: ');
  readln(cant);
  for i:= 1 to cant do
  begin
    write('Ingrese un numero: ');
    readln(num);
    write(archivo,num);
  end;
  Close(archivo);
end;
procedure listadoEnPantalla(var archivo:arreales);
var
  i: integer;
  num: real;
begin
  Reset(archivo);
  while (not EOF(archivo)) do
  begin
    i:=0;
    while(not eof(archivo)) and (i<>10) do
    begin
      read(archivo,num);
      write(num:3:2, ' ');
      i:= i+1;
    end;
    writeln();
  end;
  Close(archivo);
end;
procedure promedio (var archivo:arreales);
var
  num: real;
  neg: integer;
  pos: integer;
  suma: real;
begin
  reset(archivo);
  neg:= 0;
  pos:= 0;
  suma:= 0;
  while (EOF(archivo) <> true) do
  begin
    read(archivo,num);
    suma:= suma +num;
    if (num<0)then
       neg:= neg+1
    else
       pos:= pos+1;
  end;
  suma:= suma/fileSize(archivo);
  writeln('La cantidad de numeros positivos es: ', pos);
  writeln('La cantidad de numeros negativos es: ', neg);
  writeln('El promedio general de los numeros ingresados es: ', suma);
  writeln('No se que corcho es el promedio de numeros negativos/positivos respecto del total de numeros');
  Close(archivo);
end;
var
  archivo: arreales;
  opcion: integer;
begin
  Assign(archivo,'Reales');
  writeln('INGRESE:');
  writeln('   1 - Crear un archivo de numeros reales.');
  writeln('   2 - Listar en pantalla la informacion del archivo.');
  writeln('   3 - Cantidad y promedio de numeros negativos y positivos.');
  readln(opcion);
  case opcion of
    1: crearArchivo(archivo);
    2: listadoEnPantalla(archivo);
    3: promedio(archivo);
  else
    writeln('El numero ingresado no es valido.')
  end;
  readln();
end.