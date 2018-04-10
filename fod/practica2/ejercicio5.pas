program ejercicio5;
const
  valorAlto = 9999;
type
  regMae = record
    codProd:integer;
    stockAct:integer;
    stockMin: integer;
    precio : real;
    nombre : String;
  end;
  regDet = record
    codProd : integer;
    cantVen : integer;
  end;
  maestro = file of regMae;
  detalle = file of regDet;
procedure leer (var det:detalle;var regD:regDet);
begin
  if (not EOF(det)) then
    read(det,regD)
  else 
    regD.codProd := valorAlto;
end;
procedure crearArchivoMaestro(var mae:maestro);
var 
  cargaMae:text;
  regM:regMae;
begin
  assign(cargaMae,'productos.txt');
  reset(cargaMae);
  rewrite(mae);
  writeln('hola,proceso1');
  while(not EOF(cargaMae)) do
  begin
     with regM do
     begin
       readln(cargaMae,codProd,stockAct,stockMin,precio);
       readln(cargaMae,nombre);
     end;
     write(mae,regM); 
  end;
  writeln('saliendo del proceso 1');
  close(mae);
  close(cargaMae);
end;
procedure listarElArchivoMaestroTxt(var mae:maestro);
var
  regM:regMae;
  cargaMae:text;
begin
  writeln('prcesos2');
  assign(cargaMae,'reporte.txt');
  rewrite(cargaMae);
  reset(mae); 
  writeln('a punto de entrar al while');
  while (not EOF (mae))do
  begin
    read(mae,regM);
    with regM do
    begin
      writeln(cargaMae,codProd);
      writeln(cargaMae,nombre);
      writeln(cargaMae,precio);
      writeln(cargaMae,stockAct);
      writeln(cargaMae,stockMin);
    end;
  end;
  close(cargaMae);
  close(mae);
end;
procedure detalleCrearArchivoDetalle (var det : detalle);
var
  cargaDet:text;
  regD:regDet;
begin
  assign(cargaDet,'ventas.txt');
  rewrite(det);
  reset(cargaDet);
  while (not EOF(cargaDet)) do
  begin
    with regD do
    begin
      readln(cargaDet,codProd,cantVen); 
    end;
    write(det,regD);
  end;
  close(det);
  close(cargaDet);
end;
procedure detalleListarElArchivoDetalleEnPantalla (var det:detalle);
var 
  regD : regDet;
begin
  reset(det);
  while(not EOF(det)) do
  begin
    read(det,regD);
    writeln('El codigo de producto es ',regD.codProd,' y la cantidad de ventas es ',regD.cantVen);
  end;
  close(det);
end;
procedure actualizarArchivoMaestro(var det:detalle;var mae:maestro);
var
  regD:regDet;
  regM:regMae;
begin
  reset(mae);
  reset(det);
  leer(det,regD);
  while(regD.codProd <> valorAlto)do
  begin
    read(mae,regM);
    while(regM.codProd <> regD.codProd) do
    begin
      read(mae,regM);
    end;
    while (regM.codProd = regD.codProd) do
    begin
      regM.stockAct := regM.stockAct - regD.cantVen;
      leer(det,regD);
    end;
    seek(mae,filePos(mae)-1);
    write(mae,regM);
  end;
  close(mae);
  close(det);
end;
procedure crearArchivoStockMinimo(var mae:maestro);
var 
  regM:regMae;
  cargaMin:text;
begin
  assign(cargaMin,'stock_minimo.txt');
  rewrite(cargaMin);
  reset(mae);
  while(not EOF (mae)) do
  begin
    read(mae,regM);
    if(regM.stockAct < regM.stockMin)then
    begin
      with regM do
        writeln(cargaMin,codProd,nombre,precio,stockAct,stockMin);
    end;
  end;
  close(mae);
  close(cargaMin);
end;
var
  mae:maestro;
  det:detalle;
begin
  writeln('empieza');
  assign(mae,'maestro5.dat');
  assign(det,'detalle5.dat');
  writeln('hola');
  crearArchivoMaestro(mae);
  listarElArchivoMaestroTxt(mae);
  detalleCrearArchivoDetalle(det);
  detalleListarElArchivoDetalleEnPantalla(det);
  actualizarArchivoMaestro(det,mae);
  crearArchivoStockMinimo(mae);
end.