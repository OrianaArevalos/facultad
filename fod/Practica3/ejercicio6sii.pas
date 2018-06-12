program ejerciciosii;
const
    valorAlto = 99999;
type    
    cliente = record
        codCliente : integer;
        nombre : String;
        apellido : String;
    end;
    empresa = record
        clien : cliente;
        año:integer;
        mes:integer; 
        día:integer; 
        monto: real; 
    end;
    archivo = file of empresa;
procedure leerMaestro(var a:archivo;var emp:empresa);
begin
    if(not eof(a))then
        read(a,emp)
    else
        emp.clien.codCliente := valorAlto;
end;
procedure mostrarInformacion(var a:archivo);
var 
    emp:empresa;
    totEmpresa,totMes,totAnio :integer;
begin
    reset(a);
    leer(a,emp);
    totEmpresa := 0;
    while(emp.clien.codCliente <> valorAlto)do
    begin
        actCliente := emp.clien.codCliente;
        write(emp.clien.nombre);
        while(actCliente = emp.clien.codCliente) do
        begin
            actAnio := emp.anio;
            totAnio := 0;
            while ((actCliente = emp.clien.codCliente) and (actAnio = emp.anio)) do
            begin
                actMes := emp.mes;
                totMes := 0;
                while((actMes = emp.mes) and (actCliente = emp.clien.codCliente) and (actAnio = emp.anio))do
                begin
                    totMes := totMes + emp.monto;
                    leer(a,emp);
                end;
                write(totMes);
                totAnio := totAnio+totMes;
            end;
            write(totAnio);
            totEmpresa := totEmpresa + totAnio;
        end;
    end;
    write(totEmpresa);
    close(a);
end;