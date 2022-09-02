program ej1P3;
type
	socio = record
		num: integer;
		nombre: string[20];
		edad: integer;
	end;
	arbol = ^nodo;
	nodo = record
		dato: socio;
		HI: arbol;
		HD: arbol;
	end;
procedure leerSocio (var s: socio);
begin
	writeln('Ingrese numero de socio: ');
	readln(s.num);
	if(s.num <> 0) then begin
		writeln('Ingrese nombre de socio: ');
		readln(s.nombre);
		writeln('Ingrese edad del socio: ');
		readln(s.edad);
	end;
end;
procedure crearArbol (var a: arbol; s: socio);
begin
	if(a = nil) then begin 
		new(a);
		a^.dato:= s;
		a^.HI:= nil;
		a^.HD:= nil;
		writeln('¡Socio Creado!');
	end
	else
		if (s.num < a^.dato.num) then crearArbol(a^.HI, s)
		else 
			crearArbol(a^.HD, s);
end;
procedure descomponerDatosSocio(s: socio);
begin
	writeln('Numero de socio: ', s.num);
	writeln('Nombre de socio: ', s.nombre);
	writeln('Edad de socio: ', s.edad);
end;
procedure imprimirArbol(a: arbol);
begin
	if(a<> nil) then begin
		imprimirArbol(a^.HI);
		descomponerDatosSocio(a^.dato);
		writeln('---');
		imprimirArbol(a^.HD);
	end;
end;
function numMax (a: arbol): integer;
begin
	if (a^.HD = nil) then 
		numMax:= a^.dato.num
	else 
		numMax:= numMax(a^.HD);
end;
function numMin (a: arbol): socio;
begin
	if (a^.HI = nil) then 
		numMin:= a^.dato
	else 
		numMin:= numMin(a^.HI);
end;
function mayorEdad(a: arbol; maxEdad: integer): integer;
begin
	if (a <> nil) then begin
		if(a^.dato.edad > maxEdad) then
			maxEdad:= a^.dato.edad;
		maxEdad:= mayorEdad(a^.HI, maxEdad);
		maxEdad:= mayorEdad(a^.HD, maxEdad);
		{Una vez que termina cada recorrido entre el nodo y sus hijos, este va a setear en maxEdad, el maxEdad anterior o el nuevo}
	end;
	mayorEdad:= maxEdad; {Aca, devuelve el valor anterior o nuevo de maxEdad, para que este se siga pasando entre nodos}
end;
procedure aumentarEdad (var a: arbol);
begin
	if (a <> nil) then begin
		a^.dato.edad:= a^.dato.edad + 1;
		aumentarEdad(a^.HI);
		aumentarEdad(a^.HD);
	end;
end;
function buscarPorNum(a: arbol; num: integer):boolean;
begin
	if (a = nil) then
		buscarPorNum:= false
	else if (num = a^.dato.num) then
		buscarPorNum:= true
	else
		if (num < a^.dato.num) then
			buscarPorNum:= buscarPorNum(a^.HI, num)
		else
			buscarPorNum:= buscarPorNum(a^.HD, num);
end;
function buscarPorNombre(a: arbol; nombre: string):boolean;
begin
	if (a <> nil) then begin
		buscarPorNombre(a^.HI, nombre);
		buscarPorNombre(a^.HD, nombre);
		buscarPorNombre:= a^.dato.nombre = nombre;
	end;
end;
var
	a: arbol;
	s: socio;
	maxEdad, num: integer;
	nombre: string;
begin
	a:= nil;
	maxEdad:= 0;
	leerSocio(s);
	while (s.num <> 0) do begin
		crearArbol(a, s);
		leerSocio(s);
	end;
	imprimirArbol(a);
	writeln('Numero de socio maximo: ',numMax(a));
	writeln('Datos de socio con numero de socio minimo: ');
	descomponerDatosSocio(numMin(a));
	writeln('Edad del socio mas viejo: ', mayorEdad(a, maxEdad));
	writeln('---');
	aumentarEdad(a);
	imprimirArbol(a);
	writeln('---');
	writeln('Ingrese el numero del socio a buscar: ');
	readln(num);
	if(buscarPorNum(a, num)) then
		writeln('Lo encontramos!')
	else
		writeln('No se encuentra cargado :P');
	writeln('---');
	writeln('Ingrese el nombre del socio a buscar: ');
	readln(nombre);
	if(buscarPorNombre(a, nombre)) then
		writeln('Lo encontramos!')
	else
		writeln('No se encuentra cargado :P');
end.
