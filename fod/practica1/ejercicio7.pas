program E6P1;
type
  art = record
    nombre: String[30];
    descripcion: String;
    stock:integer;
  end;
  archivos_articulos = file of art;
procedure crearArchivo(var arcArtic:archivos_articulos);
var
  carga:text;
  articulo:art;
begin
  assign(carga,'carga.txt');
  rewrite(arcArtic);
  reset(carga);
  repeat
    with articulo do
     begin
      read(carga,nombre);
      readln(carga,descripcion,stock);
    end;
    write(arcArtic,articulo);
  until (EOF(carga));
  writeln('Archivo cargado');
  readln;
  close(arcArtic);
  close(carga);
end;
procedure listarInferiorCien(var arcArtic:archivos_articulos);
var
  articulo:art;
begin
  reset(arcArtic);
  while (EOF(arcArtic)<> true) do
    begin 
      read(arcArtic,articulo);
      if(articulo.stock < 100) then
        begin
          with articulo do  
            writeln('Nombre: ',nombre,'. Descripcion: ',descripcion,'. Stock: ',stock);
        end;
    end;
  close(arcArtic);
end;
procedure listarMismaDescripcion(var arcArtic:archivos_articulos);
var
  descrip:String;
  articulo:art;
begin
  reset(arcArtic);
  writeln('Inrgese la descripcion de la cual quiere que se listen los datos de los articulos');
  readln(descrip);
  while(EOF(arcArtic) <> true) do
    begin 
      read(arcArtic,articulo);
      if(articulo.descripcion = descrip) then
        begin
          with articulo do
            writeln('Nombre: ',nombre,'. Stock',stock);
        end;
    end;
   close(arcArtic);
end;
procedure exportarArchivo(var arcArtic:archivos_articulos);
var
  perfumeria : text;
  articulo:art;
begin
  assign(perfumeria,'perfumeria.txt');
  reset(arcArtic);
  rewrite(perfumeria);
  while (EOF(arcArtic) <> true) do
    begin
      read(arcArtic,articulo);
      with articulo do
        write(perfumeria,nombre,descripcion,stock);
    end;
  close(arcArtic);
  close(perfumeria);
end;
procedure leerRegistro(var articulo:art);
begin
  with articulo do
    begin
      writeln ('Ingrese el nombre del articulo');
      readln(nombre);
      if (nombre <> '') then
        begin
          writeln('Ingrese la descripcion del articulo');
          readln(descripcion);
          writeln('Ingrese el stock del articulo');
          readln(stock);
        end;
    end;
end;
procedure anadirArticulo (var arcArtic:archivos_articulos);
var
  articulo:art;
begin
  reset(arcArtic);
  seek(arcArtic,fileSize(arcArtic));
  leerRegistro(articulo);
  while (articulo.nombre <> '')do
    begin
      write(arcArtic,articulo);
      leerRegistro(articulo);
    end;
  close(arcArtic);
end;
procedure modificarStock(var arcArtic:archivos_articulos);
var
  articulo:art;
  nomb:String[30];
  OK:boolean;
begin
  OK:=true;
  reset(arcArtic);
  writeln('Ingrese el nombre del archivo que quiere modificar');
  readln(nomb);
  while (EOF(arcArtic) <> true) and (OK) do
    begin
      read(arcArtic,articulo);
      if(articulo.nombre = nomb) then
        begin
          writeln('Ingrese el numero de stock nuevo');
          readln(articulo.stock);
          seek(arcArtic,filePos(arcArtic)-1);
          write(arcArtic,articulo);
          OK := false;
        end;
    end;
  close(arcArtic);
end;
procedure exportarArchivoStockCero(var arcArtic:archivos_articulos);
var
  articulo:art;
  sinStock:text;
begin
  assign(sinStock,'sinStock.txt');
  reset(arcArtic);
  rewrite(sinStock);
  while(EOF(arcArtic)<>true) do
    begin
      read(arcArtic,articulo);
      if (articulo.stock = 0) then
        begin
          with articulo do
            begin
              write(sinStock,nombre,descripcion,stock);
            end;
        end;
    end;
  close(arcArtic);
  close(sinStock);
end;
var 
  opc:byte;
  nombArchivo:String;
  arcArtic:archivos_articulos; 
begin
    writeln ('PERFUMERIA');
    writeln ('Ingrese la opcion 1 para cargar el archivo desde un archivo .txt');
    writeln('Ingrese la opcion 2 para listar en pantalla aquellos articulos que tengan menos de 100 unidades');
    writeln('Ingrese la opcion 3 para listar en pantallas los articulos que cuya descripcion sea la misma que la ingresada por teclado');
    writeln('Ingrese la opcion 4 para exportar el archivo a un archivo .txt');
    writeln('Ingrese la opcion 5 para añadir articulo al final del archivo');
    writeln('Ingrese la opcion 6 para modificar el stock de un articulo');
    writeln('Ingrese la opcion 7 para exportar a un archivo .txt los articulos con stock 0');
    readln(opc);
    if((opc=1) or (opc=2) or (opc=3) or (opc=4) or (opc=5) or (opc=6) or (opc=7)) then
      begin
        writeln('Ingrese el nombre del archivo');
        readln(nombArchivo);
        assign(arcArtic,nombArchivo);
    end;
    case opc of
        1: begin
            crearArchivo(arcArtic);
        end;
        2: begin
            listarInferiorCien(arcArtic);
        end;
        3: begin
             listarMismaDescripcion(arcArtic);
        end;
        4: begin
             exportarArchivo(arcArtic);
        end;
        5: begin
             anadirArticulo(arcArtic);
        end;
        6: begin
             modificarStock(arcArtic);
        end;
        7: begin
             exportarArchivoStockCero(arcArtic);
        end;
    end;
end.