{
2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}

program ej2P1;
const 
	DIMF = 300;
type
	rangoOficinas = 1..300;
	oficina = record
		codeId: -1..DIMF;
		dniProp: integer;
		valorExp: real;
	end;
	arrOficinas = array[rangoOficinas] of oficina;
procedure leerOficina (var o: oficina);
begin
	writeln('Ingrese codigo de identificacion: ');
	readln(o.codeId);
	if(o.codeId <> -1) then begin
		writeln('Ingrese DNI del Propietario: ');
		readln(o.dniProp);
		writeln('Ingrese Valor de la Expensa: ');
		readln(o.valorExp);
	end;
end;
procedure cargarVector (var v: arrOficinas; var dimL: integer; o: oficina);
begin
	if((dimL+1) <= DIMF) then begin
		dimL:= dimL + 1;
		v[dimL]:= o;
	end;
end;
procedure ordenarInsercion (var v: arrOficinas; dimL: integer);
var
	i, j: integer;
	o: oficina;
begin
	for i:= 2 to dimL do begin
		o:= v[i];
		j:= i - 1;
		while (j > 0) and (v[j].codeId > o.codeId) do begin
			v[j+1]:= v[j];
			j:= j - 1;
		end;
		v[j+1]:= o;
	end;
end;
procedure ordenarSeleccion (var v: arrOficinas; dimL: integer);
var
	i, j, p: integer;
	o: oficina;
begin
	for i:= 1 to dimL - 1 do begin
		p:= i;
		for j:= i + 1 to dimL do begin
			if v[j].codeId < v[p].codeId then p:= j;
		end;
		o:= v[p];
		v[p] := v[i];
		v[i]:= o;
	end;
end;
procedure imprimirVector (v: arrOficinas; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln('Codigo de Identificacion: ', v[i].codeId);
		writeln('DNI del Propietario: ', v[i].dniProp);
		writeln('Valor de las expensas: ', v[i].valorExp:0:0);
	end;
end;
var
	v: arrOficinas;
	dimL: integer;
	o: oficina;
begin
	dimL:= 0;
	leerOficina(o);
	while(o.codeId <> -1) do begin
		cargarVector(v, dimL, o); {Inciso a}
		leerOficina(o);
	end;
	writeln('---');
	imprimirVector(v, dimL);
	writeln('---');
	{
	ordenarInsercion(v, dimL); Inciso b
	imprimirVector(v, dimL);
	writeln('---');}
	ordenarSeleccion(v, dimL); {Inciso c}
	imprimirVector(v, dimL);
end.
