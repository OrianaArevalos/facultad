Program personasVersion1;
Uses CRT;
Type
 rPersona=record
  apellido:string;
  nombre:string;
  fNac:longInt;
 end;
var
    aPersona: file; {archivo sin tipo}
    opc: Byte;


procedure escribirRegistro(var a: file; var r:rPersona);
var
  tamRegistro: byte;
begin
 tamRegistro := length(r.nombre) + length(r.apellido) + 2 + sizeof(r.fNac); //los 2 bytes, 1 por cada string
 blockwrite(a, tamRegistro, sizeof(tamRegistro));// escribe el tama�o del registro
 blockwrite(a, r.apellido, length(r.apellido)+1); //escribe apellido
 blockwrite(a, r.nombre, length(r.nombre)+1);  //escribe nombre
 blockwrite(a, r.fNac, sizeof(r.fNac));//escribe fecha nacimiento
end;

procedure crearYCargarArchivo (var aPer: file);
var
rPer:rPersona;

begin
 ReWrite(aPer, 1);
 writeln('Ingrese el apellido de la persona o enter para finalizar la carga');
 readln(rPer.apellido);
 while (rPer.apellido <> '') do begin
         writeln('Ingrese el nombre de la persona');
         readln(rPer.nombre);
         writeln('Ingrese la fecha de nacimiento en formato dMA (Ej: 10022018)');
         readln(rPer.fNac);
         escribirRegistro(aPer,rPer);
         writeln('Ingrese el apellido de la persona');
         readln(rPer.apellido);
    end;
    Write('Archivo cargado....');
    Close(aPer);
end;


 //// Lectura ////////////


procedure leerRegistro(var arch:file; var r:rPersona);
var
 tamCampo,tamReg, i: byte;
 dato: array[1..256] of byte;
begin
 blockread(arch, tamReg, sizeof(tamReg)); //lee primer byte con el tama�o del registro
 blockread(arch, dato, tamReg); //lee el registro completo
 i:=1;//posicion dentro del bloque de byte en memoria
 tamCampo := dato[i]; // longitud del apellido
 SetLength(r.apellido, tamCampo);//pone manualmente el tam al string que esta �creando�
 move(dato[i],r.apellido, tamCampo+1); //mueve los length+1 bytes, incluyendo el prefijo de longitud del string
 i:=i+tamCampo+1; //aumenta la posicion en el bloque para leer correctamente
 tamCampo:=dato[i]; //analogamente para el nombre repite los mismos pasos que apellido
 SetLength(r.nombre, tamCampo);
 move(dato[i], r.nombre, tamCampo+1);
 i:=i+tamCampo+1;
 move(dato[i], r.fNac, sizeof(r.fNac));//mueve la fecha de nacimiento
end;

procedure mostrarPantalla (var aPer: file);
var
rP:rPersona;
begin
 Reset(aPer,1);
 while (not eof(aPer))  do begin
         leerRegistro (aPer,rP);
         Write('-El apellido es: ',rP.apellido,', el nombre es:', rP.nombre, ' y nacio:', rP.fNac);
         readln;

    end;
 Close(aPer);
end;


Begin

WriteLn('Sistema de Gestion de Personas');


Repeat
Write('Ingrese el nro. de opcion: ');

WriteLn;
WriteLn('0. Terminar el Programa');
WriteLn('1. Crear archivo de personas');
WriteLn('2. Abrir archivo existente');
ReadLn(opc);
Assign(aPersona,'personasVariableV1.dat');
If (opc=1) then begin

   WriteLn;

   end;
Case opc of
     1: begin
        crearYCargarArchivo(aPersona);
         end;
     2: begin
          mostrarPantalla(aPersona);
          end;
end;
ClrScr
until opc=0;
end.

end.
 