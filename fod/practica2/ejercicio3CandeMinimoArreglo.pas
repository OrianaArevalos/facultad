program ejercicio3CandeMinimoArreglo;
const
  valorAlto= 9999;
type
  producto = record
    codigo: integer;
    descripcion: String [40];
    precio: real;
    stocka: integer;
    stockm: integer;
  end;
  pedido = record
    codigo: integer;
    cantpedida: integer;
  end;
  archproducto = file of producto;
  archpedido = file of pedido;
  vector = array [1..4] of archpedido;
  vector2 = array [1..4] of pedido;
procedure leer (var archivo:archpedido; var dato:pedido);
begin
  if (not eof(archivo))then
    read (archivo,dato)
  else
    dato.codigo := valoralto;
end;
procedure minimo (var vecDetalle: vector2; var min: pedido; var v: vector; var pos: integer);
var
  i: integer;
begin
  min.codigo:= valorAlto;
  for i:= 1 to 4 do
  begin
    if (vecDetalle[i].codigo<min.codigo) then
    begin
      min:= vecDetalle[i];
      pos:= i;
    end;
    leer(v[pos],vecDetalle[pos]);
  end;
  for i:=1 to 4 do 
  begin
    close(v[i]);
  end;
end;
procedure actualizarStock(var regM: producto; var min: pedido; pos: integer);
begin
    regM.stocka:= regM.stocka-min.cantpedida;
    if (regM.stocka<0) then
    begin
      writeln('La sucursal ', pos,' no pudo satisfacer su pedido');
      writeln('Faltan ', Abs(regM.stocka), ' unidades de ', regM.descripcion);
      regM.stocka:= 0;
  end;
end;
procedure actualizarMaestro (var maestro:archproducto; var v: vector);
var
  regM: producto;
  regD: vector2;
  i: integer;
  pos: integer;
  min: pedido;
begin
  for i:= 1 to 4 do
      leer(v[i], regD[i]);
  minimo(regD,min,v, pos);
  while(min.codigo<>valorAlto) do
  begin
    read(maestro,regM);
    while (regM.codigo <> min.codigo) do
      read(maestro,regM);
    while (regM.codigo = min.codigo) do
    begin
      actualizarStock(regM,min, pos);
      minimo(regD,min,v, pos);
    end;
    if (regM.stocka<regM.stockm) then
       writeln('El stock de ',regM.descripcion,' esta por debajo del stock minimo');
    seek(maestro,filePos(maestro)-1);
    write(maestro,regM);
  end;
end;
procedure cargarMaestro (var maestro:archproducto);
var
    carga:Text;
    regM:producto;
begin
    rewrite(maestro);
    assign(carga,'Empresa.txt');
    reset(carga);
    while (not EOF(carga)) do
    begin
        readln(carga,producto.codigo,producto.descripcion);
        readln(carga,producto.precio,producto.stocka,producto.stockm);
        write(maestro,regM);
    end;
    close(maestro);
    close(carga);
end;
procedure cargarDetalle1 (var detalle:archpedido);
var
    carga:Text;
    regD:pedido;
begin
    rewrite(detalle);
    assign(carga,'Sucursal1.txt');
    reset(carga);
    while (not EOF(carga)) do
    begin
        readln(carga,pedido.codigo,pedido.cantpedida);
        write(detalle,regD);
    end;
    close(detalle);
    close(carga);
end;
procedure cargarDetalle2 (var detalle:archpedido);
var
    carga:Text;
    regD:pedido;
begin
    rewrite(detalle);
    assign(carga,'Sucursal2.txt');
    reset(carga);
    while (not EOF(carga)) do
    begin
        readln(carga,pedido.codigo,pedido.cantpedida);
        write(detalle,regD);
    end;
    close(detalle);
    close(carga);
end;
procedure cargarDetalle3 (var detalle:archpedido);
var
    carga:Text;
    regD:pedido;
begin
    rewrite(detalle);
    assign(carga,'Sucursal3.txt');
    reset(carga);
    while (not EOF(carga)) do
    begin
        readln(carga,pedido.codigo,pedido.cantpedida);
        write(detalle,regD);
    end;
    close(detalle);
    close(carga);
end;
procedure cargarDetalle4 (var detalle:archpedido);
var
    carga:Text;
    regD:pedido;
begin
    rewrite(detalle);
    assign(carga,'Sucursal4.txt');
    reset(carga);
    while (not EOF(carga)) do
    begin
        readln(carga,pedido.codigo,pedido.cantpedida);
        write(detalle,regD);
    end;
    close(detalle);
    close(carga);
end;
var
  maestro: archproducto;
  v : vector;
  i: integer;
begin
  writeln('Aqui, comenzando');
  Assign(maestro, 'Empresa');
  writeln('Asigne maestro');
  Assign(v[1], 'Sucursal1.dat');
  Assign(v[2], 'Sucursal2.dat');
  Assign(v[3], 'Sucursal3.dat');
  Assign(v[4], 'Sucursal4.dat');
  writeln('Asigne');
  cargarMaestro(maestro);
  cargarDetalle1(v[1]);
  cargarDetalle2(v[2]);
  cargarDetalle3(v[3]);
  cargarDetale4(v[4]);
  for i:= 1 to 4 do
  begin
    Reset(v[i]);
  end;
  actualizarMaestro(maestro,v);
  readln();
end.