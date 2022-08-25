{
3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. 
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1. 
b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría. 
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con menor puntaje.
}

program ej3P1;
const
	MaxGen = 8;
type
	rangoGenero = 1..MaxGen;
	pelicula = record
		code: integer;
		codeGenero: rangoGenero;
		puntaje: real;
	end;
	lista = ^nodo;
	nodo = record
		data: pelicula;
		sig: lista;
	end;
	arrGeneros = array [rangoGenero] of pelicula;
procedure leerPelicula (var p: pelicula);
begin
	writeln('Ingrese codigo de la pelicula: ');
	readln(p.code);
	if(p.code <> -1) then begin
		writeln('Ingrese codigo del genero: ');
		readln(p.codeGenero);
		writeln('Ingrese puntaje de la pelicula: ');
		readln(p.puntaje);
	end;
end;
procedure agregarNodo (var L: lista; p: pelicula);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.data:= p;
	nuevo^.sig:= nil;
	if(L = nil) then 
		L:= nuevo
	else begin
		nuevo^.sig:= L;
		L:= nuevo;
	end;
end;
procedure armarLista (var L: lista);
var
	p: pelicula;
begin
	leerPelicula(p);
	while (p.code <> -1) do begin
		agregarNodo(L, p);
		leerPelicula(p);
	end;
end;
procedure imprimirLista (L: lista);
var
	aux: lista;
begin
	aux:= L;
	while (aux <> nil) do begin
		writeln('Codigo de la Pelicula: ', aux^.data.code);
		writeln('Codigo del Genero: ', aux^.data.codeGenero);
		writeln('Puntaje de la Pelicula: ', aux^.data.puntaje:0:0);
		aux:= aux^.sig;
	end;
end;
procedure inicializar (var v: arrGeneros);
var 
	i: rangoGenero;
	p: pelicula;
begin
	p.code:= 0;
	p.puntaje:= 0;
	for i:= 1 to MaxGen do begin
		p.codeGenero:= i;
		v[i]:= p;
	end;
end;
procedure max(puntaje: real; code: integer; var maxP: real; var maxCode: integer);
begin
	if(puntaje >= maxP) then begin
		maxP:= puntaje;
		maxCode:= code;
	end;
end;
procedure imprimirVector (v: arrGeneros);
var
	i: rangoGenero;
begin
	for i:= 1 to MaxGen do begin
		writeln('Genero: ', v[i].codeGenero, ' ||  Codigo de pelicula: ', v[i].code, ' ||  Puntaje de Pelicula: ', v[i].puntaje:0:0);
	end;
end;
procedure recorrerLista (L: lista; var v: arrGeneros);
var
	aux: lista;
	maxPuntaje: real;
	generoActual: rangoGenero;
	maxCode: integer;
begin
	inicializar(v);
	aux:= L;
	while (aux <> nil) do begin
		generoActual:= aux^.data.codeGenero;
		maxPuntaje:= -10;
		maxCode:= -100;
		while (aux <> nil) and (aux^.data.codeGenero = generoActual) do begin
			max(aux^.data.puntaje, aux^.data.code, maxPuntaje, maxCode);
			v[generoActual]:= aux^.data;
			aux:= aux^.sig;
		end;
	end;
end;
procedure ordenarInsercion (var v: arrGeneros);
var
	i: rangoGenero;
	actual: pelicula;
	j: integer;
begin
	for i:= 2 to MaxGen do begin
		actual:= v[i];
		j:= i - 1;
		while (j > 0) and (v[j].puntaje < actual.puntaje) do begin
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= actual;
	end;
end;
var
	L: lista;
	v: arrGeneros;
begin
	L:= nil;
	armarLista(L);
	imprimirLista(L);
	recorrerLista(L, v);
	imprimirVector(v);
	writeln('---');
	ordenarInsercion(v);
	imprimirVector(v);
end.
