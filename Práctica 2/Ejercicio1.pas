{
1.- Implementar un programa que invoque a los siguientes módulos.
a. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y los almacene en un vector con dimensión física igual a 10.
b. Implementar un módulo que imprima el contenido del vector.
c. Implementar un módulo recursivo que imprima el contenido del vector.
d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres leídos. 
El programa debe informar el valor retornado.
e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres leídos.
f. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en el mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en orden inverso al que están almacenados.

}

program ej1P2;
const 
	DIMF = 10;
type
	arrCaracter = array[1..DIMF] of char;
function ingresoPunto (c: char): boolean;
begin
	ingresoPunto:= c = '.';
end;
procedure cargarVector (var v: arrCaracter; var dimL: integer);
var
	c: char;
begin
	writeln('Ingrese caracter: ');
	readln(c);
	if (dimL <= DIMF) and (not ingresoPunto(c))then begin
		dimL:= dimL + 1;
		v[dimL]:= c;
		cargarVector(v, dimL)
	end;
end;
procedure imprimirVector (v: arrCaracter; dimL: integer);
var
	i: integer;
begin
	for i := 1 to dimL do begin
		writeln(v[i]);
	end;
end;
procedure imprimirVectorRecursivo (v: arrCaracter; dimL, i: integer);
begin
	if(dimL > 0) then begin
		writeln(v[i]);
		i:= i + 1;
		imprimirVectorRecursivo(v, (dimL - 1), i);
	end;
end;
procedure contarCaracteres (var cont: integer);
var
	c: char;
begin
	writeln('Ingrese caracter: ');
	readln(c);
	if (not ingresoPunto(c)) then begin
		cont:= cont + 1;
		contarCaracteres(cont);
	end;
end;
var
	v: arrCaracter;
	dimL, i, cont: integer;
begin
	dimL:= 0;
	i:= 1;
	cont:= 0;
	cargarVector(v, dimL); {Inciso A}
	if(dimL = 0) then begin
		writeln('Vector Vacio');
	end
	else begin
		imprimirVector(v, dimL); {Inciso B}
		imprimirVectorRecursivo(v, dimL, i); {Inciso C}
	end;
	contarCaracteres(cont); {Inciso D}
	writeln(cont);
end.
