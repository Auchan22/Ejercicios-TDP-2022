{
6.- Realizar un programa que lea números y que utilice un procedimiento recursivo que escriba el equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa el número 0 (cero).
}

program ej6P2;
procedure convertirBinario (num: integer);
begin
	if(num DIV 2 = 0) then
		write(num MOD 2)
	else begin
		convertirBinario(num DIV 2);
		write(num MOD 2);
	end;
end;
var 
	num: integer;
begin
	writeln('Ingresar un numero a convertir: ');
	readln(num);
	while(num <> 0) do begin
		convertirBinario(num);
		writeln('');
		writeln('Ingresar un numero a convertir: ');
		readln(num);
	end;
end.
