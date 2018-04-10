program ejercicio2;
type
  informacion = 1..2;
  regMaestro=record
    codAlum : integer;
    apellido : String;
    nombre:String;
    cantMatFinAp : integer; //La cantidad de materias con final aprobado.
    cantMatFinDes : integer; //La cantidad de materias con final desaprobado.  
  end;
  regDet = record
    codAlum : integer;
    infoMateria : informacion; //subrango que es 1 si aprobo la cursada, 2 si aprobo el final.
  end;
  maestro = file of regMaestro;
  detalle = file of regDet;
procedure leer (var archivoDet:detalle; var regD:regDet);
begin
  if(not EOF(archivoDet)) then
    read(archivoDet,regD)
  else
    regD.codAlum := 9999;
end;
procedure leerArchivoMaestroTxt(var mae:maestro);
var 
  carga:Text;
  regM:regMaestro;
begin
  assign (carga,'alumnos.txt');
  rewrite(mae);
  reset(carga);
  while(not EOF(carga)) do
  begin
    with regM do
    begin 
      readln(carga,codAlum,cantMatFinAp,cantMatFinDes,nombre);
      readln(carga,apellido);
    end;
    write(mae,regM);
  end;
  close(carga);
  close(mae);
end;
procedure leerArchivoDetalleTxt(var det:detalle);
var
  carga:Text;
  regD:regDet;
begin
  assign(carga,'detalle.txt');
  rewrite(det);
  reset(carga);
  while(not EOF(carga)) do
  begin
    with regD do
    begin
      readln(carga,codAlum,infoMateria);
    end;
    write(det,regD);
  end;
  close(det);
  close(carga);
end;
procedure listarArchivoMaestroTxt(var mae:maestro);
var
  carga:Text;
  regM:regMaestro;
begin
  assign(carga,'reporteAlumnos.txt');
  reset(mae);
  rewrite(carga);
  while(not EOF(mae)) do
  begin
    read(mae,regM);
    with regM do
    begin
      writeln(carga,codAlum,nombre,apellido,cantMatFinAp,cantMatFinDes);
    end;
  end;
  close(carga);
  close(mae);
end;
procedure listarArchivoDetalleTxt(var det:detalle);
var 
  carga:Text;
  regD:regDet;
begin
  assign(carga,'reporteDetalle.txt');
  rewrite(carga);
  reset(det);
  while (not EOF(det)) do
  begin
    read(det,regD);
    with regD do
    begin
      writeln(carga,codAlum,infoMateria);
    end;
  end;
  close(carga);
  close(det);
end;
procedure actualizarArchivoMaestro(var mae:maestro;var det:detalle);
var
  regD:regDet;
  regM:regMaestro;
  totalDes,totalAp :integer;
begin
  reset(det);
  reset(mae);
  leer(det,regD);
  while (regD.codAlum <> 9999) do
  begin
    read(mae,regM);
    totalDes := 0;
    totalAp := 0;
    while (regD.codAlum = regM.codAlum) do
    begin
      if (regD.infoMateria = 1) then
        totalDes := totalDes + 1
      else
        totalAp := totalAp + 1;
      leer(det,regD);
    end;
    seek(mae,filePos(mae)-1);
    regM.cantMatFinAp := regM.cantMatFinAp + totalAp;
    regM.cantMatFinDes := regM.cantMatFinDes + totalDes;
    write(mae,regM);
  end;
  close(det);
  close(mae);
end;
procedure listarEnUnArchivoTxtMasDe4MateriasAprobadas(var mae:maestro);
var
  carga : Text;
  regM : regMaestro;
begin
  assign (carga,'masDe4CursadasAprobadas');
  reset(mae);
  rewrite(carga);
  while (not EOF(mae)) do
  begin
    read(mae,regM);
    if (regM.cantMatFinDes > 4) then
    begin
      with regM do
      begin
        writeln(carga,codAlum,nombre,apellido,cantMatFinAp,cantMatFinDes);
      end;
    end;
  end;
  close(mae);
  close(carga);
end;
var
  mae : maestro;
  det : detalle;
  opc:byte;
begin
  writeln('Ingrese la opcion 1 para exportar de un archivo txt a uno binario (maestro)');
  writeln('Ingrese la opcion 2 para exportar de un archivo txt a uno binario (detalle)');
  writeln('Ingrese la opcion 3 para listar el contenido del archivo maestro en un archivo txt');
  writeln('Ingrese la opcion 4 para listar el contenido del archivo detalle en un archivo txt');
  writeln('Ingrese la opcion 5 para actualizar el archivo maestro');
  writeln('Ingrese la opcion 6 para listar en un archivo txt los alumnos que tengan mas de 4 materias aprobadas sin final');
  readln(opc);
  assign (mae,'maestro.dat');
  assign (det,'detalle.dat');
  case opc of
    1: leerArchivoMaestroTxt(mae);
    2: leerArchivoDetalleTxt(det);
    3: listarArchivoMaestroTxt(mae);
    4: listarArchivoDetalleTxt(det);
    5: actualizarArchivoMaestro(mae,det);
    6: listarEnUnArchivoTxtMasDe4MateriasAprobadas(mae);
  end;
end.