program ejercicio10;
const 
  valorAlto = 'zzzzzzzzzzzzzzzzzzzz';
type
  regMae = record
    nomProv : String;
    cantAlf : integer;
    totEnc : integer;
  end;
  regDet = record
    nomProv : String;
    codLoc : integer;
    cantAlf : integer;
    totEnc : integer;
  end;
  detalle = file of regDet;
  maestro = file of regMae;
procedure leerArchivoMaestroTxt(var mae:maestro);
var 
  carga:Text;
  regM:regMae;
begin
  assign (carga,'cargaEjercicio10.txt');
  rewrite(mae);
  reset(carga);
  while(not EOF(carga)) do
  begin
    with regM do
    begin 
      readln(carga,nomProv);
      readln(carga,cantAlf,totEnc);
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
  assign(carga,'cargaDetEjer10.txt');
  rewrite(det);
  reset(carga);
  while(not EOF(carga)) do
  begin
    with regD do
    begin
      readln(carga,nomProv);
      readln(carga,codLoc,cantAlf,totEnc);
    end;
    write(det,regD);
  end;
  close(det);
  close(carga);
end;
procedure leerArchivoDetalleTxt1(var det:detalle);
var
  carga:Text;
  regD:regDet;
begin
  writeln('entre');
  assign(carga,'cargaDet2Ejer10.txt');
  writeln('asigne');
  rewrite(det);
  writeln('no quiero seguir mas con esto');
  reset(carga);
  writeln('antes de leer');
  while(not EOF(carga)) do
  begin
    with regD do
    begin
      readln(carga,nomProv);
      readln(carga,codLoc,cantAlf,totEnc);
    end;
    write(det,regD);
  end;
  close(det);
  close(carga);
end;
procedure listarArchivoMaestroTxt(var mae:maestro);
var
  carga:Text;
  regM:regMae;
begin
  assign(carga,'pruebaEj6.txt');
  reset(mae);
  rewrite(carga);
  while(not EOF(mae)) do
  begin
    read(mae,regM);
    with regM do
    begin
      writeln(carga,nomProv,cantAlf,totEnc);
    end;
  end;
  close(carga);
  close(mae);
end;
procedure leer (var det:detalle;var regD:regDet);
begin
  if(not eof(det))then
    read(det,regD)
  else
    regD.nomProv := valorAlto;
end;
procedure actualizarMaestro(var mae:maestro;var det1,det2:detalle);
var 
  regD1,regD2:regDet;
  regM:regMae;
begin
  reset(mae);
  reset(det1);
  reset(det2);
  leer(det1,regD1);
  leer(det2,regD2);
  while((regD1.nomProv <> valorAlto) or (regD2.nomProv <> valorAlto)) do
  begin
    read(mae,regM);
    while((regM.nomProv <> regD1.nomProv) and (regM.nomProv <> regD2.nomProv)) do
    begin
      read(mae,regM);
    end;
    while ((regM.nomProv = regD1.nomProv) or (regM.nomProv = regD2.nomProv))do
    begin
      if(regM.nomProv = regD1.nomProv) then
      begin
        writeln('entro');
        regM.cantAlf := regM.cantAlf + regD1.cantAlf;
        regM.totEnc := regM.totEnc + regD1.totEnc;
        leer(det1,regD1);
      end
      else
      begin
        writeln('entro2');
        regM.cantAlf := regM.cantAlf + regD2.cantAlf;
        regM.totEnc := regM.totEnc + regD2.totEnc;
        leer(det2,regD2);
      end;
    end;
    seek(mae,filePos(mae)-1);
    write(mae,regM);
  end;
  close(det1);
  close(det2);
  close(mae);
end;
var
  det1,det2:detalle;
  mae:maestro;
begin
  assign(mae,'maestro10.dat');
  assign(det1,'detalle110.dat');
  assign(det2,'detaale210.dat');
  leerArchivoMaestroTxt(mae);
  writeln('cargueMAestro');
  leerArchivoDetalleTxt(det1);
  writeln('cargue detalle1');
  leerArchivoDetalleTxt1(det2);
  writeln('cargué registros');
  actualizarMaestro(mae,det1,det2);
  listarArchivoMaestroTxt(mae);
end. 