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
  while (EOF(arcArtic)) do
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
  while(EOF(arcArtic) <> false) do
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
    readln(opc);
    if((opc=1) or (opc=2) or (opc=3) or (opc=4)) then
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
    end;
end.