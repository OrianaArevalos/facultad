program ejercicio12;
const
  valorAlto = 9999;
type
  regMae = record
    nro_usuario:integer;
    nombreUsuario : String[30];
    nombre:String[30];
    apellido :String[30];
    cantMailEnv:integer;
  end;
  regDet = record 
    nro_usuario:integer;
    cuentaDestino : String;
    cuerpoMsj :String;
  end;
  dettalle = file of regDet;
  maestro=file of regMae;
procedure leer(var det:detalle ;var regD:regDet);
begin
  if (not EOF (det)) then
    read(det,regD)
  else
    regD.nro_usario= valorAlto;
end;
procedure actualizarMaestro(var det:detalle;var mae:maestro);
var 
  regD:regDet;
  regM:regMae;
  actNum,totMsj:integer;
begin
   reset(det);
   reset(mae);
   leer(det,regD);
   while(regD.nro_usuario <> valorAlto) do
   begin
     totMsj := 0;
     actNum := regD.nro_usuario;
     read(mae,regM);
     while(regM.nro_usuario <> regD.nro_usuario)do
     begin
       read(mae,regM);
     end;
     while (actNum = regD.nro_usuario) do
     begin
       totMsj := totMsj + 1;
       leer(det,regD);
     end;
     seek(mae,filePos(mae)-1);
     regM.cantMailEnv := regM.cantMailEnv + totMsj;
     write(mae,regM);
   end;
   close(mae);
   close(det);
end;
procedure crearTxt (var det:detalle);
var
  regD : regDet;
  actNum,totalMsj:integer;
  carga:Text;
begin
  assign(carga,'Datos12.txt');
  rewrite(carga); 
  reset(det);
  leer(det,regD);
  while(regD.nro_usuario <> valorAlto) do
  begin
    totalMsj := 0;
    actNum := regD.nro_usuario;
    write(carga,'El numero de usuario es: ',regD.nro_usuario);
    while (actNum = regD.nro_usuario) do
    begin
      totalMsj := totalMsj + 1;
      leer(det,regD);
    end;
  writeln(carga,'Cantidad de mensajes: ',totalMsj);..
  end;
  close(carga);
  close(det);
end;
var
  det:detalle;
  mae:maestro;
begin
  assign(det,'detalle12.dat');
  assign(mae,'~/projects/facultad/fod/practica2/var/log/logmail.dat');
  actualizarMaestro(det,mae);
  crearTxt(det);
end.
