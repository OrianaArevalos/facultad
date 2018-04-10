Program E3P2;
const valoralto=9999;
type
producto = record
 codigo:integer;
 descripcion:string;
 stocka:integer;
 stockm:integer;
end;

pedido = record
 cod:integer;
 cantidad:integer;
 end;

detalle = file of pedido;
maestro = file of producto;
 {-----------------------}

procedure leerprod (var p:producto);
begin
writeln ('Ingrese el codigo del producto: ');
readln(p.codigo);
if (p.codigo <>0) then begin
writeln ('Ingrese la descripcion del producto: ');
readln(p.descripcion);
writeln ('Ingrese el stock actual: ');
readln(p.stocka);
writeln ('Ingrese el stock minimo: ');
readln(p.stockm);
end;
end;

procedure crear_archivo (var archivo: maestro);
var
p: producto;

begin
  rewrite (archivo);
  writeln;
  leerprod (p);
  while (p.codigo <> 0) do
     begin
       write (archivo, p);
       leerprod (p);
     end;
  close (archivo);
  writeln ('El archivo se creo correctamente.');
end;

procedure leerdet (var d:pedido);
begin
writeln ('Ingrese el codigo del producto: ');
readln(d.cod);
if (d.cod <>0) then begin
writeln ('Ingrese la cantidad pedida: ');
readln(d.cantidad);
end;
end;

procedure crear_detalle (var archivo_detalle: detalle);
var
p: pedido;

begin
  rewrite (archivo_detalle);
  writeln;
       leerdet (p);
       while (p.cod <>0 ) do begin
       write (archivo_detalle, p);
       leerdet (p);
       end;
  close (archivo_detalle);
  writeln ('El detalle se creo correctamente.');
end;

procedure leer (var archivo: detalle; var dato:pedido);
 begin
   if (not eof(archivo))
     then read (archivo,dato)
     else dato.cod := valoralto;
 end;

procedure minimo (var r1,r2,r3: pedido; var min:pedido ; var det1, det2, det3: detalle);
 begin
   if (r1.cod<=r2.cod) and (r1.cod<=r3.cod) then begin
       min := r1;
       leer(det1,r1)
     end
     else if (r2.cod<=r3.cod) then begin
            min := r2;
            leer(det2,r2)
          end
          else begin
            min := r3;
            leer(det3,r3)
          end;
 end;

procedure actualizar (var mae1: maestro ; var det1: detalle ; var det2: detalle ; var det3: detalle);
var
regm:producto;
regd1, regd2, regd3, min: pedido;
falto:integer;
begin
reset (mae1);  reset (det1); reset (det2); reset (det3);
  leer(det1, regd1); leer(det2, regd2); leer(det3, regd3);
  minimo(regd1, regd2, regd3, min, det1, det2, det3);
  while (min.cod <> valoralto) do  begin
      read(mae1,regm);
      while (regm.codigo <> min.cod) do
         read(mae1,regm);
      while (regm.codigo = min.cod ) do begin
       if (regm.stocka<regm.stockm) then
        writeln ('El siguiente producto esta por debajo del stock minimo: ', regm.codigo, ' descripcion: ',regm.descripcion);
       if (min.cantidad>regm.stocka) then begin
        writeln ('El siguiente producto no puede reponerse por falta de stock: ',regm.codigo, ' descripcion: ',regm.descripcion);
        falto:=min.cantidad-regm.stocka;
        writeln ('Falto: ',falto);
        end
        else begin
        regm.stocka:=regm.stocka-min.cantidad;
        writeln ('Actualizado correctamente, queda: ',regm.stocka);
        end;
        minimo(regd1, regd2, regd3, min, det1, det2, det3);
      end;
      seek (mae1, filepos(mae1)-1);
      write(mae1,regm);
      end;
      end;

Procedure Recorrido(var archivo: maestro );
  var
  p:producto;
  begin
    reset( archivo ); {archivo ya creado, para operar debe abrirse como de lect/escr}
   		 while not eof( archivo ) do begin
        read( archivo, p ); {se obtiene elemento desde archivo }
        writeln ('Codigo del producto es: ',p.codigo);
        writeln ('Descripcion: ',p.descripcion);
        writeln ('El stock actual es: ',p.stocka);
        writeln ('El stock minimo es: ',p.stockm);
     end;
     close( archivo );
  end;
var
det1, det2, det3: detalle;
mae1: maestro;
nombre_archivo:string;
nombre_detalle:string;
nombre_detalle2:string;
nombre_detalle3:string;
i:integer;
opcion:char;

begin
write ('Introduzca el nombre del archivo a trabajar: ');
readln (nombre_archivo);
assign (mae1, nombre_archivo);
write ('Introduzca el nombre del detalle a trabajar: ');
readln (nombre_detalle);
assign (det1, nombre_detalle);
write ('Introduzca el nombre del segundo detalle a trabajar: ');
readln (nombre_detalle2);
assign (det2, nombre_detalle2);
write ('Introduzca el nombre del tercer detalle a trabajar: ');
readln (nombre_detalle3);
assign (det3, nombre_detalle3);
for i:=1 to 10 do begin
writeln ('MENU DE OPCIONES: ');
   writeln;
   writeln ('a. Crear Archivo.');
   writeln ('b. Crear archivo detalle 1.');
   writeln ('c. Crear archivo detalle 2.');
   writeln ('d. Crear archivo detalle 2.');
   writeln ('e. Imprimir maestro.');
   writeln ('f. Actualizar maestro.');
   writeln ('g. Imprimir maestro actualizado.');
   writeln;
   write ('Introduzca la opcion a seguir: ');
   readln (opcion);
     case opcion of
      'a': crear_archivo (mae1);
      'b': crear_detalle (det1);
      'c': crear_detalle (det2);
      'd': crear_detalle (det3);
      'e': recorrido(mae1);
      'f': actualizar (mae1, det1, det2, det3);
      'g': recorrido(mae1);
      end;
      end;
      end.

end.



