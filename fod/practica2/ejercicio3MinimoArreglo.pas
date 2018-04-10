program ejercicio3;
const 
  valorAlto = 9999;
type
  regDea=record
     codProd : integer;
     cantPed : integer;
  end;
  regMae = record
     codProd : integer;
     precio : real;
     descripcion : string;
     stockAct : integer;
     stockMin : integer;
  end;
  detalle = file of regDea;
  maestro = file of regMae;
  aDet=array[1..4] of detalle;
  aReg=array[1..4] of regDea;
procedure leer (var det:detalle;var regD: regDea);
begin
  if (not EOF(det)) then
  begin
     read(det,regD);
  end
  else
  begin 
     regD.codProd := valorAlto;
  end;    
end;
procedure minimo (var arreD:aDet;var arreR:aReg;var min:regDea;var pos:integer);
var
  i:integer;
begin
  min.codProd := valorAlto;
  for i := 1 to 4 do
  begin
    if(arreR[i].codProd < min.codProd) then
    begin
      pos := i;
      min := arreR[i];
    end;
  end;
  leer(arreD[pos],arreR[pos])
end;

procedure actualizarStock(var regM:regMae;var min : regDea;var pos:integer);
begin
   if (regM.stockAct >= min.cantPed) then
   begin
     regM.stockAct := regM.stockAct - min.cantPed;
   end
   else
   begin
     min.cantPed := min.cantPed - regM.stockAct;
     regM.stockAct := 0;
     writeln('La sucursal que no cumplio',pos);
     end;
end;
procedure actualizacionMaestro(var mae:maestro; var arreD:aDet);
var 
  min:regDea;
  arreR: aReg;
  regM:regMae;
  pos:integer;
  i:integer;
begin
  for i:=1 to 4 do
  begin
    reset(arreD[i]);
  end;
  reset(mae);
  for i:=1 to 4 do
  begin
    leer(arreD[i],arreR[i]);
  end;
  minimo(arreD,arreR,min,pos);
  while(min.codProd <> valorAlto) do
  begin
       read(mae,regM);
       while (min.codProd <> regM.codProd) do
       begin
         read(mae,regM);
       end;
       while (min.codProd = regM.codProd) do
       begin
         actualizarStock(regM,min,pos);
         minimo(arreD,arreR,min,pos);
       end;
       if(regM.stockMin > regM.stockAct) then
         writeln('El producto que quedo por debajo del stock es ',regM.codProd);
       seek(mae,filePos(mae)-1);
       write(mae,regM);
   end;
  close(arreD[1]);
  close(arreD[2]);
  close(arreD[3]);
  close(arreD[4]);
  close(mae);
end;      
var
  arreD : aDet;
  mae : maestro;
begin
  assign(arreD[1],'detalle1.dat');
  assign(arreD[2],'detalle2.dat');
  assign(arreD[3],'Detalle3.dat');
  assign(arreD[4],'detalle4.dat');
  write('Despues de asignar');
  assign(mae,'maestro.dat');
  actualizacionMaestro(mae,arreD);
end.