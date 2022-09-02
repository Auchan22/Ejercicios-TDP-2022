{
3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario. 
}

program ej3P2;
const
	maxNums = 100;
type
	rangoNums = 1..maxNums;
	lista = ^nodo;
	nodo = record
		num: integer;
		sig: lista;
	end;
procedure generarLista(var L: lista);
var
	n: integer;
	nuevo: lista;
begin
	{Randomize;}
	n:= random(100);
	if(n <> 0) then begin
		new(nuevo);
		nuevo^.num:= n;
		nuevo^.sig:= L;
		L:= nuevo;
		generarLista(L);
	end;
end;
procedure imprimirLista(L: lista);
begin
	if(L <> nil) then begin
		writeln('Numero: ', L^.num);
		L:= L^.sig;
		imprimirLista(L);
	end;
end;
function max(L: lista; var maxNum: integer): integer;
begin
	if(L <> nil) then begin
		if(L^.num >= maxNum) then maxNum:= L^.num;
		L:= L^.sig;
		max(L, maxNum);
	end;
	max:= maxNum;
end;
function min(L: lista; var minNum: integer): integer;
begin
	if(L <> nil) then begin
		if(L^.num <= minNum) then minNum:= L^.num;
		L:= L^.sig;
		min(L, minNum);
	end;
	min:= minNum;
end;
function esta(L: lista; num: integer): boolean;
var
	ok: boolean;
begin
	ok:= false;
	if (L <> nil) and (not ok) then begin
		if (L^.num = num) then begin
			ok:= true;
			esta:= ok;
		end
		else begin
			L:= L^.sig;
			esta:= esta(L, num);
		end;
	end;
end;
var
	L: lista;
	maxNum, maxEncontrado: integer;
	minNum, minEncontrado: integer;
begin
	generarLista(L);
	imprimirLista(L);
	maxNum:= 0;
	minNum:= 100;
	maxEncontrado:= max(L, maxNum);
	minEncontrado:= min(L, minNum);
	writeln('Maximo: ',maxEncontrado);
	writeln('Minimo: ',minEncontrado);
	writeln(esta(L, 85));
end.
