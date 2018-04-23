program ejercicio3;
type
    fechaReg = record
        dia : integer;
        mes : integer;
        anio : integer;
    end;
    regFacu = record
        codEmpleado : integer;
        nombres : String;
        cantHijos : integer;
        dni : integer;
        fechaNac : fechaReg;
    end;
    arcFacu = file of regFacu;
procedure eliminarMenos1960 (aFacu : arcFacu);
var
    car : Char;
    rFacu : regFacu;
begin
    car := '@';
    reset(aFacu);
    while (not EOF(aFacu)) do
    begin
        read(aFacu,rFacu);
        if (rFacu.fechaNac.anio < 1960) then
        begin
            rFacu.nombres := car + rFacu.nombres;
            seek(aFacu,filePos(aFacu)-1);
            write(aFacu,rFacu);
        end;
    end;
    close(aFacu);
end;
var
    aFacu : arcFacu;
begin
    assign(aFacu,'archivoEj3');
    eliminarMenos1960(aFacu);
end.