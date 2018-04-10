program Ejercicio7;
const 
  valorAlto = 9999;
type
  regMae = record
    codProv : integer;
    codLoc : integer;
    numMesa : integer;
    cantVotosMesa : integer;
  end;
  maestro = file of regMae;
procedure leer (var mae:maestro;var regM:regMae);
begin
  if (not EOF (mae)) then
    read(mae,regM)
  else
    regM.codProv := valorAlto;
end;
procedure cargarInformacion(var mae:maestro);
var
  carga:text;
  regM:regMae;
begin
  assign(carga,'cargaEjercicio7.txt');
  reset(carga);
  rewrite(mae);
  while(not EOF(carga)) do
  begin
    with regM do
    begin
      readln(carga,codProv,codLoc,numMesa,cantVotosMesa); 
    end;
    write(mae,regM);
  end;
  close(mae);
  close(carga);
end;
procedure mostrarInformacion (var mae : maestro);
var
  regM:regMae;
  actLoc,actProv,totLoc,totProv,totPais: integer;
begin
  reset(mae);
  leer(mae,regM);
  totPais := 0;
  while(regM.codProv <> valorAlto) do
  begin
     writeln('Codigo de provincia: ',regM.codProv);
     totProv := 0;
     actProv := regM.codProv;
     while(actProv = regM.codProv) do
     begin
       totLoc := 0;
       actLoc := regM.codLoc;
       while(actLoc = regM.codLoc) and (actProv = regM.codProv) do
       begin
         totLoc := totLoc + regM.cantVotosMesa;
         leer(mae,regM);
       end;
       totProv := totProv + totLoc;
       writeln('Codigo de localidad: ',actLoc,' Total voto: ',totLoc);
     end;
     totPais := totPais + totProv;
     writeln('Total de votos provincia: ',totProv); 
  end;
  writeln('Total general de votos ',totPais); 
  close(mae);
end;
var
  mae : maestro;
begin
  assign (mae,'maestro7.dat');
  cargarInformacion(mae);
  mostrarInformacion(mae);
end. 