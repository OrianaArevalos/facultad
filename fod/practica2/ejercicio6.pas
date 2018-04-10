program ejercicio6;
const
  valorAlto = 9999;
type
  regCliente = record
    codCliente : integer;
    nombre : String;
    apellido : String;
  end;
  regMae = record
    cliente : regCliente;
    ano : integer;
    mes : integer;
    dia : integer;
    montoVen : real;
  end;
  maestro = file of regMae;
procedure leer (var mae:maestro; var regM:regMae);
begin
  if(not EOF (mae)) then
    read(mae,regM)
  else
    regM.cliente.codCliente := valorAlto;
end;
procedure crearArchivo(var mae:maestro);
var 
  regM:regMae;
  carga:text;
begin
  writeln('proceso 1 comienzo');
  assign(carga,'cargaEjercicio6.txt');
  reset(carga);
  rewrite(mae);
  writeln('proceso 1');
  while(not EOF (carga)) do
  begin
    with regM do
    begin
      readln(carga,ano,mes,dia,montoVen,cliente.codCliente,cliente.nombre);
      readln(carga,cliente.apellido);
    end;
    write(mae,regM);
  end;
  close(mae);
  close(carga);
end;
procedure informarSobreElCliente(var mae:maestro);
var
  regM:regMae;
  totMes,totAno,totEmpresa : real;
  clienteAct,actAno,actMes:integer;
begin
  reset(mae);
  leer(mae,regM);
  totEmpresa := 0;
  while(regM.cliente.codCliente <> valorAlto) do
  begin
    clienteAct := regM.cliente.codCliente;
    writeln('El cliente es ', regM.cliente.nombre, regM.cliente.apellido,regM.cliente.codCliente);
    while (clienteAct = regM.cliente.codCliente) do
    begin
      actAno := regM.ano;
      totAno := 0;
      while((actAno = regM.ano) and (clienteAct = regM.cliente.codCliente)) do
      begin
        actMes := regM.mes;
        totMes := 0;
        while((actMes = regM.mes) and (actAno = regM.ano) and (clienteAct = regM.cliente.codCliente)) do
        begin
          totMes := totMes + regM.montoVen;
          leer(mae,regM);
        end;
        writeln('El monto del mes ',actMes,' es ' ,totMes:3:2);
        totAno := totAno + totMes;
      end;
      writeln('El monto del año es ',actAno,' es ',totAno:3:2);
      totEmpresa := totEmpresa + totAno;
    end;
  end;
  writeln('El total del monto vendido por la empresa es ',totEmpresa:3:2);
  close(mae);
end;
var
  mae : maestro;
begin
  assign(mae,'maestro6.dat');
  crearArchivo(mae);
  informarSobreElCliente(mae);
end. 