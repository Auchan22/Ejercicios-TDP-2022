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
	rangoVector = 1..DIMF;
	arrCaracteres = array[rangoVector] of char;
	lista = ^nodo;
	nodo = record
		c: char;
		sig: lista;
	end;
procedure generarVector (var v: arrCaracteres; var dimL: integer);
var
	c: char;
begin
	writeln('Ingresa un caracter: ');
	readln(c);
	if(c <> '.') and (dimL < 10) then begin
			dimL:= dimL + 1;
			v[dimL]:= c;
			generarVector(v, dimL);
	end;
end;
procedure imprimirVector(v: arrCaracteres; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do
		writeln(v[i]);
end;
procedure imprimirVectorRecursivo (v: arrCaracteres; dimL: integer);
begin
	if(dimL = 1) then
		writeln('Inicial: ',v[dimL])
	else begin
		writeln('Antes: ', v[dimL], ' DimL: ', dimL); //Escribe al reves de la forma que se ingresaron los valores
		imprimirVectorRecursivo(v, dimL - 1);
		writeln('Despues: ', v[dimL], ' DimL: ', dimL);
	end;
end;
procedure cantidadCaracteres (var cont: integer);
var
	c: char;
begin
	writeln('Ingrese un caracter: ');
	readln(c);
	if (c <> '.') then begin
		cont:= cont + 1;
		cantidadCaracteres(cont);
	end;
end;
procedure generarLista (var L: lista);
	procedure agregarAdelante (var L: lista; c: char);
	var
		nuevo: lista;
	begin
		new(nuevo);
		nuevo^.c:= c;
		nuevo^.sig:= L;
		if (L = nil) then
			L:= nuevo
		else begin
			nuevo^.sig:= L;
			L:= nuevo;
		end;
	end;
	
var
	c: char;
begin
	writeln('Ingrese un caracter: ');
	readln(c);
	if (c <> '.') then begin
		agregarAdelante(L, c);
		generarLista(L);
	end;
end;
procedure imprimirLista (L: lista);
begin
	if(L <> nil) then begin
		writeln('Caracter: ', L^.c);
		L:= L^.sig;
		imprimirLista(L);
	end;
end;
procedure imprimirListaInverso (L: lista);
begin
	if (L^.sig = nil) then
		writeln('Caracter: ', L^.c)
	else begin
		L:= L^.sig;
		imprimirListaInverso(L);
		writeln('Caracter: ', L^.c);
	end;
end;
var
	v: arrCaracteres;
	dimL, cant: integer;
	L: lista;
begin
	dimL:= 0;
	L:= nil;
	generarVector(v, dimL);
	if (dimL = 0) then
		writeln('Vector Vacio')
	else begin
		imprimirVector(v, dimL);
		writeln('---');
		imprimirVectorRecursivo(v, dimL);
	end;
	cantidadCaracteres(cant);
	writeln('Cantidad Caracteres: ', cant);
	writeln('---');
	generarLista(L);
	if (L = nil) then
		writeln('Lista vacia')
	else begin
		imprimirLista(L);
		writeln('---');
		imprimirListaInverso(L);
	end;
end.
