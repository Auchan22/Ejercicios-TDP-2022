{
5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el siguiente encabezado:
   	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice); 
	Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector
}

program ej5P2;
const
	DIMF = 10;
type
	rangoVector = 1..DIMF;
	arrNum = array[rangoVector] of integer;
procedure generarVector(var v: arrNum; var dimL: integer);

	function randomNum(): integer;
	begin
		randomNum:= random(100);
	end;
	
var
	n: integer;
begin
	if (dimL <> DIMF) then begin
		n:= randomNum();
		dimL:= dimL + 1;
		v[dimL]:= n;
		generarVector(v, dimL);
	end;
end;
procedure imprimirVector(v: arrNum; dimL: integer);
begin
	if(dimL = 1) then
		writeln(v[dimL])
	else begin
		imprimirVector(v, dimL - 1);
		writeln(v[dimL]);
	end;
end;
procedure ordenarSeleccion(var v: arrNum; dimL: integer);
var
	i, j, p, item: integer;
begin
	for i:= 1 to dimL - 1 do begin
		p:= i;
		for j:= i + 1 to dimL do begin
			if (v[j] < v[p]) then p:= j;
			item:= v[p];
			v[p]:= v[i];
			v[i]:= item;
		end;
	end;
end;
procedure ordenarInserccion (var v: arrNum; dimL: integer);
var
	i, j, actual: integer;
begin
	for i:= 2 to dimL do begin
		actual:= v[i]; //Obtenemos el elemento siguiente
		j:= i -1; //Obtenemos el elemento anterior
		while (j > 0) and (v[j] > actual) do begin //Mientras no se llegue al inicio del array y el elem anterior sea mayor que el actual
			v[j+1]:= v[j]; // El element siguiente va a ser igual al elemento anterior
			j:= j - 1; //Pasamos al indice anterior
		end;
		v[j+1]:= actual; //Desplazamos los elementos anteriores, para "hacer" espacio y poder actualizar el elemento
	end;
end;
procedure busquedaDicotomica (v: arrNum; ini, fin, num: integer; var pos: integer);
var
	medio: integer;
begin
	medio:= (ini + fin) div 2;
	while (ini <= fin) and (num <> v[medio]) do begin
		if(num < v[medio]) then
			fin := medio - 1
		else
			ini:= medio + 1;
		medio:= (ini + fin) div 2;
	end;
	if(ini <= fin) and (num = v[medio]) then
		pos:= medio;
end;
procedure bdRecursiva(v: arrNum; ini, fin, num: integer; var pos: integer);
var
	medio: integer;
begin
	medio:= (ini + fin) div 2;
	if (ini <= fin) and (num = v[medio]) then
		pos:= medio
	else begin
		if(num < v[medio]) then
			bdRecursiva(v, ini, medio - 1, num, pos)
		else
			bdRecursiva(v, medio + 1, fin, num, pos);
	end;
end;
var
	v: arrNum;
	dimL, pos, num: integer;
begin
	dimL:= 0;
	pos:= -1;
	generarVector(v, dimL);
	imprimirVector(v, dimL);
	ordenarInserccion(v, dimL);
	writeln('---Despues de ordenarlo---');
	imprimirVector(v, dimL);
	writeln('Ingrese numero a buscar: ');
	readln(num);
	busquedaDicotomica(v, 1, dimL, num, pos);
	if(not (pos = -1)) then
		writeln('Elemento ' ,num,' encontrado en la pos: ', pos)
	else
		writeln('Elemento no encontrado');
	bdRecursiva(v, 1, dimL, num, pos);
	if(not (pos = -1)) then
		writeln('Elemento ' ,num,' encontrado en la pos: ', pos)
	else
		writeln('Elemento no encontrado');
end.
