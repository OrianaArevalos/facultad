program Ejercicio4;
const
  valorAlto = 9999;
type
  regDet = record
    cod_ususario:integer;
    fecha:String;
    tiempo_sesion:real;
  end;
  regMae=record
    cod_usuario:integer;
    fecha:String;
    tiempo_total:real;
  end;
  maestro : file of regMae;
  detalle : file of regDet;
procedure leer(det:detalle;regD:regDet);
begin
  if(not EOF(det)) then
    read(det,regD);
  else
    regD.cod_usuario := valorAlto;
end;
procedure minimoCod(var regD1,regD2,regD3,regD4,regD5,minReg:regDet;var det1,det2,det3,det4,det5:detalle)
begin
  if((regD1.cod_usuario < regD2.cod_usuario) and (regD1.cod_usuario < regD3.cod_usuario) and (regD1.cod_usuario < regD4.cod_usuario) and (regD1.cod_usuario < regD5.cod_usuario)) then
  begin
    minReg := regD1;
    leer(det1,regD1);
  end
  else
    begin
      if((regD2.cod_usuario < regD1.cod_usuario) and (regD2.cod_usuario < regD3.cod_usuario) and (regD2.cod_usuario < regD4.cod_usuario) and (regD2.cod_usuario < regD5.cod_usuario)) then
      begin
        minReg := regD2;
        leer(det2,regD2);
      end
      else
      begin
        if((regD3.cod_usuario < regD1.cod_usuario) and (regD3.cod_usuario < regD2.cod_usuario) and (regD3.cod_usuario < regD4.cod_usuario) and (regD3.cod_usuario < regD5.cod_usuario)) then
        begin
         minReg := regD3;
         leer(det3,regD3);
       end
       else
       begin
         if((regD4.cod_usuario < regD1.cod_usuario) and (regD4.cod_usuario < regD3.cod_usuario) and (regD4.cod_usuario < regD2.cod_usuario) and (regD4.cod_usuario < regD5.cod_usuario)) then
         begin
           minReg := regD4;
           leer(det4,regD4);
         end
         else
         begin
           minReg := regD5;
           leer(det5,regD5);
         end;
       end;
      end;
    end;
end;
procedure actualizarRegMaestro(var regM:regMae;hora:real;codAct:integer;fechaAct:String);
begin
  with regM do
    begin
      cod_usuario:=codAct;
      fecha:fechaAct;
      tiempo_total:hora;
    end;
end;
procedure crearArchivoMaestro(var mae:maestro; var det1,det2,det3,det4,det5:detalle);
var
  regD : regDet;
  regM : regMae;
  hora:real;
begin
  reset(det1);
  reset(det2);
  reset(det3);
  reset(det4);
  reset(det5);
  rewrite(mae);
  leer(det1,regD1);
  leer(det2,regD2);
  leer(det3,regD3);
  leer(det4,regD4);
  leer(det5,regD5);
  minimoCod(regD1,regD2,regD3,regD4,regD5,minReg,det1,det2,det3,det4,det5);
  while (minReg.cod_usuario <> valorAlto) do
  begin
     codAct := minReg.cod_usuario;
     while(codAct = minReg.cod_usuario)do
     begin 
       hora := 0;
       fechaAct := minReg.fecha;
       while (minReg.cod_usuario = codAct) and (fechaAct = minReg.fecha) do
       begin
         hora := hora + minReg.tiempo_sesion;
         minimoCod(regD1,regD2,regD3,regD4,regD5,minReg,det1,det2,det3,det4,det5);
       end;
       actualizarRegMaestro(regM,hora,codAct,dechaAct)
       write(mae,regM);
     end;
  end;
  close(det1);
  close(det2);
  close(det3);
  close(det4);
  close(det5);
  close(mae);
end;
var
  mae : maestro;
  det1,det2,det3,det4,det5 : detalle;
begin
  assign(maestro, '~/projects/facultad/fod/practica2/log/var');
  assign(detalle, 'detalle1.dat');
  assign(detalle, 'detalle2.dat');
  assign(detalle, 'detalle3.dat');
  assign(detalle, 'detalle4.dat');
  assign(detalle, 'detalle5.dat');
  crearArchivoMaestro(mae,det1,det2,det3,det4,det5);
end;