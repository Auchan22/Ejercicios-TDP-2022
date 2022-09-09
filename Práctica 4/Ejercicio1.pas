{
1.	 Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante cada el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a.	Un módulo que lea préstamos y retorne en una estructura adecuada la información de los préstamos organizada por mes. Para cada mes, los préstamos deben quedar ordenados por ISBN. La lectura de los préstamos finaliza con ISBN -1.
b.	Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes, ISBN y numero de socio.
c.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por ISBN.
d.	Un módulo recursivo que reciba la estructura generada en c. y muestre todos los ISBN y número de socio correspondiente.
e.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó durante el año 2021.
f.	Un módulo recursivo que reciba la estructura generada en e. y muestre su contenido.

}

program ej1P4;
const
	dimF = 12;
type
	rangoMes= 1..dimF;
	fechaReg = record
		dia: integer;
		mes: rangoMes;
	end;
	prestamo = record
		ID: integer;
		numSocio: integer;
		fecha: fechaReg;
		cantDias: integer;
	end;
	lista = ^nodo;
	nodo = record
		dato: prestamo;
		sig: lista;
	end;
	arrPrestamos = array[rangoMes] of lista;
procedure inicializarVector (var a: arrPrestamos);
var
	i: rangoMes;
begin
	for i:= 1 to dimF do 
		a[i]:= nil;
end;
procedure leerPrestamo (var p: prestamo);
	procedure leerFecha (var f: fechaReg);
	begin
		writeln('Ingrese dia del prestamo: ');
		readln(f.dia);
		writeln('Ingrese el mes del prestamo: ');
		readln(f.mes);
	end;
begin
	writeln('Ingrese ISBN del libro: ');
	readln(p.ID);
	if (p.ID <> -1) then begin
		writeln('Ingrese numero de socio: ');
		readln(p.numSocio);
		writeln('Ingrese fecha: ');
		leerFecha(p.fecha);
		writeln('Ingrese cantidad de dias en prestamo: ');
		readln(p.cantDias);
	end;
end;
procedure insertarOrdenado(var L: lista; p: prestamo);
var
	nuevo: lista;
	act, ant: lista;
begin
	new(nuevo);
	nuevo^.dato:= p;
	nuevo^.sig:= nil;
	if (L = nil) then L:= nuevo
	else begin
		act:= L;
		while (act <> nil) and (act^.dato.ID < nuevo^.dato.ID) do begin
			ant:= act;
			act:= act^.sig;
		end;
		if(act = L) then begin
			nuevo^.sig:= L;
			L:= nuevo;
		end
		else begin
			ant^.sig:= nuevo;
			nuevo^.sig:= act;
		end;
	end;
end;
procedure cargarVector(var a: arrPrestamos);
var
	p: prestamo;
begin
	leerPrestamo(p);
	while (p.ID <> -1) do begin
		insertarOrdenado(a[p.fecha.mes], p);
		leerPrestamo(p);
	end;
end;
procedure imprimirLista (L: lista);
		procedure imprimirPrestamo(p: prestamo);
		begin
			writeln('---');
			writeln('ISBN: ', p.ID);
			writeln('Numero de socio: ', p.numSocio);
			writeln('---');
		end;
	begin
		if(L <> nil) then begin
			imprimirPrestamo(L^.dato);
			imprimirLista(L^.sig);
		end;
	end;
procedure imprimirArreglo (a: arrPrestamos; i: rangoMes);
var
	L: lista;
begin
	{for i:= 1 to dimF do begin
		L:= a[i];
		writeln('Mostrando el mes ', i);
		if(L = nil) then
			writeln('Lista Vacia')
		else begin
			while(L <> nil) do begin
				imprimirPrestamo(L^.dato);
				L:= L^.sig;
			end;
		end;
	end;}
	L:= a[i];
	if (i <> 12) then begin
		writeln('Mostrando el mes ', i);
		imprimirLista(L);
		imprimirArreglo(a, i + 1);
	end;
	{else begin
		writeln('Mostrando el mes ', i);
		imprimirLista(a[12]);
	end;}
end;
procedure merge(var L: lista; a: arrPrestamos);
	procedure agregarAtras(var L: lista; p: prestamo);
	var
		nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= p;
		nuevo^.sig:= nil;
		if(L = nil) then
			L:= nuevo
		else begin
			while(L^.sig <> nil) do 
				L:= L^.sig;
			L^.sig:= nuevo;
		end;
	end;
	procedure ISBNMenor(var a: arrPrestamos;var p: prestamo);
	var
		i, indiceMin: rangoMes;
	begin
		p.ID:= 32767; //Seteamos un valor grande para evaluar
		for i:= 1 to dimF do begin //Recorremos el array
			if(a[i] <> nil) then begin //Si el nodo actual es distinto de nil, evaluaremos si su elemento ID (ISBN), es menor que el inicializado anteriormente
				if(a[i]^.dato.ID <= p.ID) then begin
					indiceMin:= i; //Vamos a guardar de que lista, debemos pasar al siguiente elemento
					p:= a[i]^.dato; //Asignamos los valores del elemento minimo, para posteriormente guardarlo
				end;
			end;
		end;
		if(p.ID <> 32767) then  //Si el ID cambio, quiere decir que se obtuvo el mas pequeño, por lo que se pasa al elemento siguiente
			a[indiceMin]:= a[indiceMin]^.sig;
	end;
var
	pr: prestamo;
begin
	L:= nil;
	ISBNMenor(a, pr);
	while(pr.ID <> 32767) do begin
		agregarAtras(L, pr);
		ISBNMenor(a, pr);
	end;
end;
var
	a: arrPrestamos;
	i: rangoMes;
	LMerge: lista;
begin
	i:= 1;
	inicializarVector(a);
	cargarVector(a);
	imprimirArreglo(a, i);
	writeln('Antes del merge');
	merge(LMerge,a);
	writeln('Antes de imprimir lista mergeada');
	imprimirLista(LMerge);
end.
