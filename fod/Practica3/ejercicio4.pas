program ejercicio4;
type 
    tTitulo = String [50];
    archivoString = file of aTitulo;
procedure agregar(var aTit:archivoString; var titulo:String);
var
    auxTit:String[50];
    aux,num,auxNRR:integer;
begin
    reset(aTit);
    read(aTit,auxTit);
    val(auxTit,num,aux); //num es el numero que genero. Aux= 0 si lo transformo.
    if (aux = 0) then
    begin
        if (num = 0)then
        begin
            seek(aTit,fileSize(tTit));
            write(aTit,titulo);
        end
        else
        begin
            num := num * -1;
            seek(aTit,num);
            read(aTit,auxTit);
            val(auxTit,num,aux);
            auxNRR :=num;
            write(atit,titulo);
            seek(aTit,0);
            str(auxNRR,titulo);
            write(aTit,titulo);
        end;
    end;
end;
procedure cargarArchivo(var aTit : archivoString);
var
    titulo : String[50];
begin
    reset(aTit);
    write('Ingrese el titulo');
    readln(titulo);
    while (titulo <> '')do
    begin
        agregar(aTit,titulo);
        write('Ingrese el titulo');
        readln(titulo);
    end;
    close(aTit);
end;
var
    aTit : archivoString;
begin
    assign(aTit,'archivoEj4.dat');
    prcedure cargarArchivo(aTit);
end. 