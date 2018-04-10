program ejercicio11;
const
  valorAlto = 'zzzzzzzzz';
type
  regMae = record
    continente : String;
    pais : String;
    ciudad : String;
    cantHom : integer;
    cantMuj : integer;
  end;
  maestro = file of regMae;
procedure cargarInformacion(var mae:maestro);
var
  carga:text;
  regM:regMae;
begin
  assign(carga,'cargaEjercicio11.txt');
  reset(carga);
  rewrite(mae);
  while(not EOF(carga)) do
  begin
    with regM do
    begin
      readln(carga,continente);
      readln(carga,pais);
      readln(carga,ciudad); 
      readln(carga,cantHom,cantMuj);
    end;
    write(mae,regM);
  end;
  close(mae);
  close(carga);
end;
procedure leer(var mae:maestro;var regM: regMae);
begin
  if(not EOF(mae)) then
    read(mae,regM)
  else
    regM.continente := valorAlto;
end;
procedure listarEnUnArchivoTxt(var mae:maestro);
var
  regM : regMae;
  carga :Text;
  totCont,totPais,totHab:integer;
  contAct,paisAct : String;
begin
  assign(carga,'infoContinente.txt');
  reset(mae);
  rewrite(carga);
  leer(mae,regM);
  while (regM.continente <> valorAlto) do
  begin
    writeln(carga,'Continente: ',regM.continente);
    contAct := regM.continente;
    totCont := 0;
    while(contAct = regM.continente) do
    begin
      writeln(carga,'Pais: ',regM.pais);
      totPais := 0;
      paisAct := regM.pais;
      writeln(carga,'Ciudad  cantHomb  cantMuj  totHab');
      while((paisAct = regM.pais) and (contAct = regM.continente)) do
      begin
        totHab := regM.cantHom + regM.cantMuj;
        writeln(carga,regM.ciudad,'  ',regM.cantMuj,'  ',regM.cantHom,'  ',totHab);
        totPais := totPais + totHab;
        leer(mae,regM)
      end;
      writeln(carga,'Total de habitante pais: ',totPais);
      totCont := totCont + totPais;
    end;
    writeln(carga,'Total de habitante continente: ',totCont);
  end;
  close(mae);
  close(carga);
end;
var
  mae:maestro;
begin
  assign(mae,'maestro11.dat');
  cargarInformacion(mae);
  listarEnUnArchivoTxt(mae);
end. 