program ejercicio9sii;
type
    producto = record
        nombre : String;
        descripción: String; 
        precio: real; 
        stockMinimo: integer;
        stockActual : integer;
    end;
procedure leerRegistro(var prod:producto);
begin
  with(prod) do
  begin
    read(nombre);
    if (nombre <> '')then
    begin
        read(descripcion);
        read(precio);
        read(stockMinimo);
        read(stockActual);
    end;
  end;
end;
procedure crearArchivo(var a : file);
var
    prod:producto;
begin
    rewrite(a,1);
    leerRegistro(prod);
    while(prod.nombre <> '')do
    begin
        BlockWrite(a,prod.nombre[1], length(prod.nombre));
        BlockWrite(a,sc,1);
        BlockWrite(a,prod.descripcion[1], Length(prod.descripcion));
        BlockWrite(a,sc,1);
        BlockWrite(a,prod.precio,sizeof(prod.precio));
        BlockWrite(a,sc,1);
        BlockWrite(a,prod.stockMinimo,sizeof(prod.stockMinimo));
        BlockWrite(a,sc,1);
        BlockWrite(a,prod.stockActual,sizeof(stockActual));
        BlockWrite(a,sr,1);
        leerRegistro(prod);
    end;
    close(a);
end;
procedure leerCampo(var a:file; var campo:String; var buffer:char);
begin
    campo := '';
    while (buffer <> sc) and (buffer <> sr) do
    begin
        campo := campo + buffer;
        BlockRead(a,buffer,1);
    end;
end;
procedure leerArchivo(var a :file);
var
    prod:producto;
begin
    reset(a,1);
    while (not eof(a))do
    begin
        blockread(a,buffer,1);
        campo := 0;
        while (buffer <> sr)do
        begin
            campo := '';
            while (buffer <> sc) and (buffer <> sr) do
            begin
                campo := campo + buffer;
                BlockRead(a,buffer,1);
            end;
            campo := campo +1;
            case campo of:
            1:prod.nombre := campo;
            2:prod.descripcion := campo;
            4:val(campo,prod.stockMinimo);
            5:val(campo,prod.stockActual);
            end;
            if(buffer = sc) and (not eof(a))then
                blockread()
        end;
    end;
    close(a);
end;    
