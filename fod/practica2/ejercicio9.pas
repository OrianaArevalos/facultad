program ejercicio9;
const
  valorAlto = 9999;
type
  dimF = 1..15;
  regArreglo = record
    categoria : dimF;
    precioHs : real;
  end;
  regMae = record
    departamento : integer;
    division : integer;
    numEmp : integer;
    categoria : integer;
    cantHsExt : integer;
  end;
  maestro = file of regMae;
  arreglo = array [dimF] of real;
procedure cargarInformacion(var mae:maestro);
var
  carga:text;
  regM:regMae;
begin
  assign(carga,'cargaEjercicio9.txt');
  reset(carga);
  rewrite(mae);
  while(not EOF(carga)) do
  begin
    with regM do
    begin
      readln(carga,departamento,division,numEmp,categoria,cantHsExt); 
    end;
    write(mae,regM);
  end;
  close(mae);
  close(carga);
end;
procedure cargarVector(var arreHs : arreglo);
var
  carga:text;
  regArre: regArreglo;
begin
  assign(carga,'cargaVector.txt');
  reset(carga);
  while(not EOF(carga)) do
  begin
    with regArre do
    begin
      readln(carga,categoria,precioHs);
      arreHs[categoria] := precioHs;
    end;
  end;
  close(carga); 
end;
procedure leer (var mae:maestro; var regM:regMae);
begin
  if (not EOF (mae)) then
    read(mae,regM)
  else
    regM.departamento := valorAlto;
end;
procedure informar(var mae:maestro; arreHs:arreglo);
var
  regM : regMae;
  depAct,divAct,actEmp,catAct:integer;
  totHsDiv,totHsEmp,importeACobrar,totHsDep,montoTotDiv,montoTotDep:real;
begin
  reset(mae);
  leer(mae,regM);
  while (regM.departamento <> valorAlto) do 
  begin
    totHsDep := 0;
    depAct := regM.departamento;
    montoTotDep := 0;
    writeln('Departamento ', regM.departamento);
    while (depAct = regM.departamento)do
    begin
      writeln('Division ',regM.division);
      divAct := regM.division;
      totHsDiv := 0;
      montoTotDiv := 0;
      while ((divAct = regM.division) and (depAct = regM.departamento)) do
      begin
        actEmp := regM.numEmp;
        totHsEmp := 0;
        catAct := regM.categoria;
        while((actEmp = regM.numEmp)and (divAct = regM.division) and (depAct = regM.departamento)) do
        begin
          totHsEmp := totHsEmp + regM.cantHsExt;
          leer(mae,regM);
        end;
        totHsDiv := totHsDiv + totHsEmp;
        importeACobrar := totHsEmp * arreHs[catAct];
        montoTotDiv := montoTotDiv + importeACobrar;
        writeln('Numero de empleado: ',actEmp,' Total de Hs ',totHsEmp:4:2,' Importe a cobrar: ',importeACobrar:4:2);
      end;
      writeln('Total de horas por division: ',totHsDiv:4:2);
      writeln('Monto total por division : ',montoTotDiv:4:2);
      montoTotDep := montoTotDep + montoTotDiv;
      totHsDep := totHsDep + totHsDiv;
    end;
    writeln('Total horas departamente: ', totHsDep:4:2);
    writeln('Monto total departamento: ', montoTotDep:4:2);
  end;
  close(mae);
end;
var
  mae : maestro;
  arreHs : arreglo;
begin
  assign (mae,'maestro9.dat');
  cargarInformacion(mae);
  cargarVector(arreHs);
  informar(mae,arreHs);
end.