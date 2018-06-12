program ejercicio4sii;
type
    tTitulo = String[50];
    tArchLibros = file of tTitulo ;
procedure agregar (var a: tArchLibros ; titulo: string);
var
    cabecera,pos:integer;
    tit:string;
begin
    reset(a);
    read(a,tit);
    if (tit[1] = '-')then
    begin
        val(tit,cabecera);
        seek(a,cabecera);
        read(a,tit);
        seek(a,filepos(a)-1);
        write(a,titulo);
        seek(a,0);
        write(tit);
    end
    else
    begin
        seek(a,FileSize(a));
        write(a,titulo);
    end;
    close(a);
end;
procedure listarArchivo (var a : tArchLibros);
var
    tit:string;
begin
    reset(a);
    while (not eof(a)) do
    begin
        read(a,tit);
        if(tit[1] <> '0') and (tit[1] <> '-') then
        begin
            write(tit,' ');
        end;
    end;
    close(a);
end;
procedure eliminar (var a: tArchLibros ; titulo: string);
var 
    tit:string;
    cabecera:string;
    pos:integer;
begin
    reset(a);
    read(a,tit);
    cabecera := tit; 
    while (not eof(a)) and (tit <> titulo) do
    begin
        read(a,tit);
    end;
    if(tit = titulo) then
    begin
        seek(a,filepos(a)-1);
        pos := filepos(a)*(-1);
        write(a,cabecera);
        seek(a,0);
        str(pos,tit);
        write(a,tit);
    end;
    close(a);
end;