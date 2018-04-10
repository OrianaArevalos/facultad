program ejercicio3;
const 
  valorAlto = 9999;
type
  redDea=record
     codProd = integer;
     cantPed = integer;
  end;
  regMae = record
     codProd = integer;
     precio = real;
     descripcion = string;
     stockAct = integer;
     stockMin = integer;
  end;
  detalle = file of regDea;
  maestro = file of regMae;
procedure leer (var det:detalle;var regD = regDet);
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
procedure minimo (det1,det2,det3,det4:detalle;regD1,regD2,regD3,regD4,detMin:regDea);
begin
   if ((regD1.codProd < reg2.codProd) and (regD1.codProd < reg3.codProd) and (regD1.codProd < reg4.codProd))then
   begin
      detMin=regD1;
      leer(det1,regD1);
    end
   else
   begin
     if ((regD2.codProd < reg1.codProd) and (regD2.codProd < reg3.codProd) and (regD2.codProd < reg4.codProd))then
     begin
        detMin=regD2;
        leer(det2,regD2);
     end 
     else
     begin
         if ((regD3.codProd < reg2.codProd) and (regD3.codProd < reg1.codProd) and (regD3.codProd < reg4.codProd))then
         begin
             detMin=regD3;
             leer(det3,regD3);
         end
         else
         begin
             if ((regD4.codProd < reg2.codProd) and (regD4.codProd < reg3.codProd) and (regD4.codProd < reg1.codProd))then
             begin
                 detMin=regD4;
                 leer(det4,regD4);
             end
          end;
     end;
  end;
end;
proedure actualizarStock(var detM:maestro;var detMin:detalle;var ok:boolean);
begin
   if (detM.stockAct >= detMin.cantPed) then
   begin
     detM.stockAct := detM.stockAct - detMin.cantPed;
     ok := true;
   end
   else
   begin
     detMin.cantPed := detMin.cantPed - regM.stockAct;
     regM.stockAct := 0;
     ok := false;
     end;
end;
procedure actualizacionMaestro(var mae:maestro; var det1,det2,det3,det4:detalle);
var 
  regD1,regD2,regD3,regD4,detMin:regDea;
  regM:regMae;
begin
  reset(regD1);
  reset(regD2);
  reset(regD3);
  reset(regD4);
  reset(regM);
  leer(det1,regD1);
  leer(det1,regD2);
  leer(det1,regD3);
  leer(det1,regD4);
  minimo(det1,det2,det3,det4,regD1,regD2,regD3,regD4,detMin);
  while((regD1.codProd <> valorAlto) and (regD2.codProd <> valorAlto) and (regD3.codProd <> valorAlto) or (regD4.codProd <> valorAlto)) do
  begin
       read(mae,regM);
       while (detMin.codProd <> regM.codProd) do
       begin
         read(mae,regM);
       end;
       while (detMin.codProd = regM.codProd) do
       begin
         actualizarStock(regM,detMin);
         if(ok = false) then
         begin
             writeln('El pedido falló, la sucursal que no pudo recibir productos fue ..... , el producto',detMin.codProd,'y la cantidad de productos que faltaron fue ',detMin.cantPed);
         end;
         minimo(det1,det2,det3,det4,regD1,regD2,regD3,regD4,detMin);
       end;
       if(regM.stockMin > regM.stockAct) then
         writeln('El producto que quedo por debajo del stock es ',regM.codProd);
       seek(mae,filePos(mae)-1);
       write(mae,regM);
   end;
end;      
  close(regD1);
  close(regD2);
  close(regD3);
  close(regD4);
  close(regM);
var
  det1,det2,det3,det4 = detalle;
  mae = maestro;
begin
  assign(det1,'detalle1.dat');
  assign(det2,'detalle2.dat');
  assign(det3,'detalle3.dat');
  assign(det4,'detalle4.dat');
  assign(mae,'maestro.dat');
end.