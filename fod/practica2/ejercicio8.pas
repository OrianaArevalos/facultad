program Ejercicio8;
const
  valorAlto = 9999;
type
  regMae = record
    numLinea : integer;
    numCoche : integer;
    recCoche: real;
  end;
  maestro = file of regMae;
procedure cargarInformacion(var mae:maestro);
var
  carga:text;
  regM:regMae;
begin
  assign(carga,'cargaEjercicio8.txt');
  reset(carga);
  rewrite(mae);
  while(not EOF(carga)) do
  begin
    with regM do
    begin
      readln(carga,numLinea,numCoche,recCoche); 
    end;
    write(mae,regM);
  end;
  close(mae);
  close(carga);
end;
procedure leer(var mae:maestro;var regM:regMae);
begin
  if(not EOF(mae)) then
    read(mae,regM)
  else
    regM.numLinea := valorAlto;
end;
function finInformacion(regM:regMae):boolean;
begin
  if((regM.numLinea = -1) and (regM.numCoche = -1) and (regM.recCoche = -1)) then 
    finInformacion := true
  else
    finInformacion := false;
end;
procedure maximoCocheRecaudacion(var actCoc,maxCoc: integer; var maxRecCoc,totRecCoc:real);
begin
  if(totRecCoc > maxRecCoc) then
  begin
    maxCoc := actCoc;
    maxRecCoc := totRecCoc;
  end;
end;
procedure maximoLineaRecaudacion(var actLi,maxLi:integer;var totRecLi,maxRecLi:real);
begin
  if(totRecLi > maxRecLi) then
  begin
    maxLi := actLi;
    maxRecLi := totRecLi;
  end;
end;
procedure informar(var mae:maestro);
var
  maxCoc,totCocLi,maxLi,totLi,actLi,actCoc:integer;
  maxRecCoc,totRecLi,totRecEmp,totRecCoc,maxRecLi:real;
  regM:regMae;
begin
  reset(mae);
  leer(mae,regM);
  totRecEmp := 0;
  totLi := 0;
  maxRecLi := -1;
  while ((regM.numLinea <> valorAlto) and (not finInformacion(regM))) do
  begin
    totLi := totLi + 1;
    actLi := regM.numLinea;
    maxRecCoc := -1;
    totRecLi:=0;
    totCocLi := 0;
    maxRecCoc := 0;
    while(actLi = regM.numLinea)do
    begin
      actCoc := regM.numCoche;
      totRecCoc := 0;
      while ((actCoc = regM.numCoche) and (actLi = regM.numLinea))do
      begin
        totRecCoc := totRecCoc + regM.recCoche;
        totCocLi := totCocLi + 1;
        leer(mae,regM); 
      end;
      maximoCocheRecaudacion(actCoc,maxCoc,maxRecCoc,totRecCoc);
      totRecLi := totRecLi + totRecCoc;
    end;
    writeln('Informacion de la linea ',actLi);
    writeln('El auto que mas recaudo fue ',maxCoc,' y lo que recaudo fue ',maxRecCoc);
    writeln('La recaudacion promedio de la linea es ',(totRecLi/totCocLi):3:2);
    writeln('El total recaudado de la linea es : ',totRecLi:3:2);
    maximoLineaRecaudacion(actLi,maxLi,totRecLi,maxRecLi);
    totRecEmp := totRecEmp + totRecLi;
  end;
  writeln('La linea de mayor recaudacion es ',maxLi);
  writeln('Lo total recaudado por la empresa fue ',totRecEmp); 
  writeln('El promedio de recaudacion de las lineas es ', (totRecEmp/totLi):2:3);
  close(mae);
end;
var
  mae: maestro;
begin
  assign (mae,'maestro8.dat');
  writeln('hola');
  cargarInformacion(mae);
  writeln('hola2');
  informar(mae);
end.