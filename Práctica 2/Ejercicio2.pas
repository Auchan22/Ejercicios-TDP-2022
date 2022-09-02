{
Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número leído,
sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo recursivo que reciba el número
e imprima lo pedido. Ejemplo si se lee el valor 256, se debe imprimir 2  5  6
}

program ej2P2;
procedure leerNum (var n: integer);
	
	procedure descomponerNum(num: integer);
	var
		dig: integer;
	begin
		if(num <> 0) then begin
			dig:= num MOD 10;
			num:= num DIV 10;
			descomponerNum(num);
			writeln(dig); {Se va a ejecutar cuando se devuelva el control al bloque, por lo tanto, si recibimos el 256, en la 1er etapa, dig contendra 6, en la 2da, 5, y en la 3ra, 2, pero solo se mostrara a medida que retorne el control, por lo que la etapa base se lo devuelve a la 3, imprimiendo 2, la etapaa 3 se lo devuelve a la 2, imprimiendo 5, y la etapa 2 se lo devuelve a la 1, imprimiendo 6}
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

