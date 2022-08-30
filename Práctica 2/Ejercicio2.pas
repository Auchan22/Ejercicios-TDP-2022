{
Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número leído,
sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo recursivo que reciba el número
e imprima lo pedido. Ejemplo si se lee el valor 256, se debe imprimir 2  5  6
}

program ej2P2;
procedure leerNum (var n: integer);
	
	procedure descomponerNum(num: integer);
	var
		n, c, exp: integer;
	begin
		c:= 0;
		if(num <> 0) then begin
			n:= num;
			while(n >= 10) do begin
				n:= n DIV 10;
				c:= c + 1;
			end;
			writeln(n);
			exp:= 1;
			repeat begin
				exp:= exp * 10;
				c:= c - 1;
			end;
			until (c = 0);
			writeln(exp);
			num := num MOD exp;
			descomponerNum(num);
		end;
	end;

begin
	writeln('Ingrese un numero: ');
	readln(n);
	if(n <> 0) then begin
		descomponerNum(n);
		leerNum(n);
	end;
end;
var
	num: integer;
begin
	leerNum(num);
end.

