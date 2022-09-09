program ej2P4;
const
	maxG = 8;
	codigoMaximo = 9999;
type
	rangoGen = 1..maxG;
	peliculaGeneric = record
		code: integer;
		gen: rangoGen;
		puntaje: real;
	end;
	peliculaInsert = record
		code: integer;
		puntaje: real;
	end;
	lista = ^nodo;
	nodo = record
		dato: peliculaInsert;
		sig: lista;
	end;
	arrGeneros = array[rangoGen] of lista;
procedure cargarVector (var v: arrGeneros);

	procedure inicializarVector(var v: arrGeneros);
	var
		i: rangoGen;
	begin
		for i:= 1 to maxG do
			v[i]:= nil;
	end;
	
	procedure leerPelicula (var p: peliculaGeneric);
	begin
		writeln('Ingresar codigo de pelicula: ');
		readln(p.code);
		if(p.code <> -1) then begin
			writeln('Ingresar genero numerico de pelicula: ');
			readln(p.gen);
			writeln('Ingresar puntaje de la pelicula: ');
			p.puntaje := random(100) + 1;
			writeln(p.puntaje:0:0);
		end;
	end;
	
	procedure rellenarPeliculaAguardar(var pi: peliculaInsert; pg: peliculaGeneric);
	begin
		pi.code:= pg.code;
		pi.puntaje:= pg.puntaje;
	end;
	
	procedure insertarOrdenado(var L: lista; pi: peliculaInsert);
	var
		act, ant, nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= pi;
		nuevo^.sig:= nil;
		if(L = nil) then
			L:= nuevo
		else begin
			act:= L;
			while (act <> nil) and (act^.dato.code <= nuevo^.dato.code) do begin
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
var
	pi: peliculaInsert;
	pg: peliculaGeneric;
begin
	inicializarVector(v);
	leerPelicula(pg);
	while(pg.code <> -1) do begin
		rellenarPeliculaAguardar(pi, pg);
		insertarOrdenado(v[pg.gen], pi);
		leerPelicula(pg);
	end;
end;
	procedure imprimirLista(L: lista);
		
		procedure imprimirPelicula(pi: peliculaInsert);
		begin
			writeln('');
			writeln('	---');
			writeln('	Codigo de pelicula: ', pi.code);
			writeln('	Puntaje de pelicula: ', pi.puntaje:0:0);
			writeln('	---');
			writeln('');
		end;
		
	begin
		if(L <> nil) then begin
			imprimirPelicula(L^.dato);
			imprimirLista(L^.sig);
		end;
	end;
procedure imprimirVector (v: arrGeneros);
var
	i: rangoGen;
begin
	for i:= 1 to maxG do begin
		write;
		writeln('Imprimiendo genero ', i);
		imprimirLista(v[i]);
	end;
end;
procedure merge(var L: lista; v: arrGeneros);
	
	procedure min(var v: arrGeneros; var pi: peliculaInsert);
	var
		indiceMin, i: rangoGen;
	begin
		pi.code:= codigoMaximo;
		for i:= 1 to maxG do begin
			if(v[i] <> nil) then
				if(v[i]^.dato.code <= pi.code) then begin
					indiceMin:= i;
					pi:= v[i]^.dato;
				end;
		end;
		if(pi.code <> codigoMaximo) then
			v[indiceMin]:= v[indiceMin]^.sig;
	end;
	
	procedure agregarAtras(var pri, ult: lista; pi: peliculaInsert);
	var
		nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= pi;
		nuevo^.sig:= nil;
		if(L = nil) then
			L:= nuevo
		else 
			ult^.sig:= nuevo;
		ult:= nuevo;
	end;
var
	pi: peliculaInsert;
	ult: lista;
begin
	min(v, pi);
	while(pi.code <> codigoMaximo) do begin
		agregarAtras(L, ult, pi);
		min(v, pi);
	end;
end;
var
	v: arrGeneros;
	Lmerge: lista;
begin
	Lmerge:= nil;
	cargarVector(v);
	imprimirVector(v);
	merge(Lmerge, v);
	writeln('Imprimiendo lista mergeada...');
	imprimirLista(Lmerge);
end.
