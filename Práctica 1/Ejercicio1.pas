{
Implementar un programa que procese la información de las ventas de productos de un comercio (como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades).  El ingreso de las ventas finaliza con el código 0 (no se procesa).
a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
h. Mostrar la lista resultante.
}


program ej1P1;
const
	DIMF = 20;
	MAXU = 99;
type
	rangoVentas = 0..DIMF;
	rangoCod= 1..15;
	rangoCant = 0..MAXU;
	venta = record
		code: rangoCod;
		cantV: rangoCant;
	end;
	arrVentas = array[rangoVentas] of venta;
	lista = ^nodo;
	nodo = record
		data: venta;
		sig: lista;
	end;
procedure leerVenta (var v : venta);
begin
	randomize;
	v.code:= random(15) + 1;
	writeln('Ingresar cantidades vendidas: ');
	readln(v.cantV);
end;
procedure cargarVector (var v: arrVentas; var dimL: rangoVentas; ve: venta);
begin
	if((dimL+1) <= DIMF) then begin
		dimL:= dimL + 1;
		v[dimL]:= ve;
	end;
end;
procedure imprimirVector (v: arrVentas; dimL: rangoVentas);
var
	i: rangoVentas;
begin
	for i:= 1 to dimL do begin
		writeln('Venta ', i);
		writeln('Codigo de Producto: ',v[i].code);
		writeln('Cantidades Vendidas: ', v[i].cantV);
	end;
end;
procedure Ordenar (var v: arrVentas; dimL: rangoVentas);
var
	i, j, p: rangoVentas;
	ve: venta;
begin
	for i:= 1 to dimL - 1 do begin
		p:= i;
		for j := i + 1 to dimL do
			if v[j].code < v[p].code then p:= j;
		ve:= v[p];
		v[p]:= v[i];
		v[i]:= ve;
	end;
end;
procedure Eliminar (var v: arrVentas; codA: rangoCod; codB: rangoCod; var dimL: rangoVentas);
var
	i: rangoVentas;
begin
	for i:= 1 to dimL do begin
		if (v[i].code >= codA) and (v[i].code <= codB) then begin
			v[i] := v[i+1];
			dimL:= dimL - 1;
		end;
	end;
end;
function esPar(code: rangoCod): boolean;
begin
	esPar:= (code MOD 2) = 0;
end;
procedure agregarNodo (var L: lista; v: venta);
var
	nuevo, aux: lista;
begin
	new(nuevo);
	nuevo^.data:= v;
	nuevo^.sig:= nil;
	if(L = nil) then
		L:= nuevo
	else begin
		aux:= L;
		while(aux^.sig <> nil) do
			aux:= aux^.sig;
		aux^.sig:= nuevo;
	end;
end;
procedure recorrerVector (ve: arrVentas; dimL: rangoVentas; var L: lista);
var
	i: rangoVentas;
begin
	for i:= 1 to dimL do begin
		if (esPar(ve[i].code)) then
			agregarNodo(L, ve[i])
	end;
end;
procedure imprimirLista (L : lista);
var
	aux: lista;
begin
	aux:= L;
	while(aux <> nil) do begin
		writeln('Codigo de Producto: ',aux^.data.code);
		writeln('Cantidades Vendidas: ', aux^.data.cantV);
		aux:= aux^.sig;
	end;
end;
var
	v: arrVentas;
	code: integer;
	ve: venta;
	dimL: rangoVentas;
	L: lista;
begin
	dimL:= 0;
	readln(code);
	while(code <> 0) do begin
		leerVenta(ve);
		cargarVector(v, dimL, ve);
		readln(code);
	end;
	imprimirVector(v, dimL); {Inciso b}
	writeln('---');
	Ordenar(v, dimL); {Inciso c}
	imprimirVector(v, dimL); {Inciso d}
	writeln('---');
	Eliminar(v, 11, 14, dimL);{Inciso e}
	imprimirVector(v, dimL);{Inciso f}
	writeln('---');
	recorrerVector(v, dimL, L);{Inciso g}
	imprimirLista(L);{Inciso h}
	writeln('---');
end.
