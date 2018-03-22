program ejercicio3;
type
  numR_archivos=file of real;
procedure incisoA( var numR:numR_archivos);
var
  tot,i:integer;
  num:real;
begin
  rewrite(numR);
  writeln('Ingrese la cantidad de numero');
  readln(tot);
  for i:=1 to tot do 
    begin
      writeln('Ingrese el numero');
      readln(num);
      write(numR,num);
  end;
  close(numR);
end;
procedure incisoB(var numR:numR_archivos);
var
  n:integer;
  numero:real;
begin
  reset(numR);
  while(EOF(numR)<> true)do 
    begin
      n:=0;
      while((EOF(numR)<> true) and (n<10)) do
        begin
          read(numR,numero);
          write(numero:3:2,' ');
          n:=n+1;
        end;
      writeln(' ');
    end;
  close(numR);
end;
procedure incisoC(var numR:numR_archivos);
var
  tot, totPos, totNeg:integer;
  sumNeg, sumPos, numero:real;
begin
  reset(numR);
  tot:=0;
  totPos:= 0; 
  totNeg:=0;
  sumNeg:=0; 
  sumPos:=0;
  while (EOF(numR)<> true) do
    begin
      read (numR,numero);
      if(numero < 0) then
        begin
          sumNeg := sumNeg + numero;
          totNeg:= totNeg+1;
        end
      else
        begin
          sumPos := sumPos + numero;
          totPos := totPos + 1;
        end;
      tot:= tot + 1;
    end;
  writeln(totNeg,totPos);
  writeln(((sumPos+sumNeg)/tot):3:2);
  writeln((sumNeg/tot):3:2, (sumPos/tot):3:2);
end;
var
  numR:numR_archivos;
  numIngresado:integer;
begin
  writeln('Ingrese la opcion 0 para terminar el programa');
  writeln('Ingrese 1 para inciso A');
  writeln ('2 para inciso B'); 
  writeln('3 para inciso C');
  repeat 
    writeln('Ingrese la opcion');
    readln(numIngresado);
    case numIngresado of
      1: begin
          incisoA(numR);
        end;
      2: begin
         incisoB(numR);
       end;
      3: begin
         incisoC(numR);
       end;
  until: (numIngresado = 0);
end.