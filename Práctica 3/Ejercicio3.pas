{
3.	Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y almacene en una estructura de datos sólo a aquellos alumnos que posean año de ingreso posterior al 2010.
*  De cada alumno se lee legajo, DNI y año de ingreso. La estructura generada debe ser eficiente para la búsqueda por número de legajo. 
b. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro. 
c. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo esté comprendido entre dos valores que se reciben como parámetro. 
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.

}

program ej3P3;
type
	alumno = record
		legajo: integer;
		dni: integer;
		anoI: integer;
	end;
	arbol = ^nodo;
	nodo = record
		dato: alumno;
		HI: arbol;
		HD: arbol;
	end;
procedure leerAlumno(var a: alumno);
begin
	writeln('Ingrese numero de legajo: ');
	readln(a.legajo);
	if(a.legajo <> -1) then begin
		writeln('Ingrese numero de dni: ');
		readln(a.dni);
		writeln('Ingrese anio de ingreso: ');
		readln(a.anoI);
	end;
end;
procedure imprimirAlumno(al: alumno; okLeg: boolean);
	begin
		if(okLeg) then
			writeln('Legajo: ', al.legajo);
		writeln('Dni: ', al.dni);
		writeln('Ingreso: ', al.anoI);
		writeln('---');
	end;
procedure crearArbol(var a: arbol; al: alumno);
begin
	if(a = nil) then begin
		new(a);
		a^.dato:= al;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else
		if (al.legajo < a^.dato.legajo) then
			crearArbol(a^.HI, al)
		else
			crearArbol(a^.HD, al);
end;
procedure imprimirArbol(a: arbol);
begin
	if(a <> nil) then begin
		imprimirArbol(a^.HI);
		imprimirAlumno(a^.dato, TRUE);
		writeln('---');
		imprimirArbol(a^.HD);
	end;
end;
procedure buscarHastaLegajo(a: arbol; legajoMax: integer);
	
begin
	if (a <> nil) then begin
		if(a^.dato.legajo <= legajoMax) then
			imprimirAlumno(a^.dato, FALSE);
		buscarHastaLegajo(a^.HI, legajoMax);
		buscarHastaLegajo(a^.HD, legajoMax);
	end;
end;
procedure buscarEntreLegajos(a: arbol; legMin, legMax: integer);
begin
if (a <> nil) then begin
		if (a^.dato.legajo >= legMin) and (a^.dato.legajo <= legMax) then
			imprimirAlumno(a^.dato, FALSE);
		buscarEntreLegajos(a^.HI, legMin, legMax);
		buscarEntreLegajos(a^.HD, legMin, legMax);
	end;
end;
function maxDni (a: arbol): integer;
	function max (a, b: integer): integer;
	begin
		if(a >= b) then 
			max:= a
		else
			max:= b;
	end;
begin
	if(a <> nil) then 
		maxDni:= max(max(a^.dato.dni, maxDni(a^.HI)), max(a^.dato.dni, maxDni(a^.HD)))
	else
		maxDNI:= -9999;
end;
function cantLegImp(a: arbol): integer;
	function esImpar(leg: integer): boolean;
	begin
		esImpar:= false;
		if(not((leg MOD 10) MOD 2 = 0)) then
			esImpar:= true;
	end;
begin
	if(a <> nil) then begin
		if(esImpar(a^.dato.legajo)) then 
			cantLegImp:=1 + cantLegImp(a^.HI) + cantLegImp(a^.HD)
		else
			cantLegImp:=cantLegImp(a^.HI) + cantLegImp(a^.HD)
	end
	else
		cantLegImp:= 0;
end;
var
	a: arbol;
	al: alumno;
	legajoMax, legajoMin: integer;
begin
	leerAlumno(al);
	while (al.legajo <> -1) do begin
		if(al.anoI >= 2010) then
			crearArbol(a, al);
		leerAlumno(al);
	end;
	imprimirArbol(a);
	writeln('Ingrese hasta que numero de legajo desea buscar: ');
	readln(legajoMax);
	buscarHastaLegajo(a, legajoMax);
	writeln('---');
	writeln('Ingrese a partir de que numero de legajo desea buscar: ');
	readln(legajoMin);
	writeln('Ingrese hasta que numero de legajo desea buscar: ');
	readln(legajoMax);
	buscarEntreLegajos(a, legajoMin, legajoMax);
	writeln('Dni maximo: ', maxDni(a));
	writeln('Cantidad de alumnos con Legajo Impar: ', cantLegImp(a));
end.

