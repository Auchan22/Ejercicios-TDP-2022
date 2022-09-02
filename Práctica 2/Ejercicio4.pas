{
4.- Escribir un programa que:
a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 
b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.
}

program ej4P2;
const
	dimF = 20;
type
	rangoArray = 1..dimF;
	arrNum = array[rangoArray] of integer;
procedure generarVector(var v: arrNum; var dimL: integer);
	function randomNum (): integer;
	begin
		randomNum:= random(100);
	end;
	
var
	n: integer;
begin
	n:= randomNum();
	if (dimL <> dimF) then begin
		dimL:= dimL + 1;
		v[dimL]:= n;
		generarVector(v, dimL);
	end;
end;
procedure imprimirVector (v: arrNum; dimL: integer);
begin
	if(dimL = 1) then
		writeln('Numero: ', v[dimL])
	else begin
		imprimirVector(v, dimL - 1);
		writeln('Numero a: ', v[dimL]);
	end;
end;
function maxi(v: arrNum; dimL, Emax: integer): integer;
	function max (n, maxNum: integer): integer;
	begin
		if (n >= maxNum) then begin
			{writeln('Maximo antes: ', maxNum);
			writeln('Numero: ', n);}
			maxNum:= n;
			max:= maxNum;
			{writeln('Maximo despues: ', maxNum);}
		end
		else
			max:= maxNum;
	end;
var
	Ea: integer;
begin
	if (dimL = 1) then begin
		maxi:= Emax;
	end
	else begin
		Ea:= v[dimL];
		{writeln('Actual: ',Ea);
		writeln('Maximo antes: ',Emax);}
		Emax:= max(Ea, Emax);
		{writeln('Maximo despues: ',Emax);}
		maxi(v, dimL - 1, Emax);
	end;
end;
function total(v: arrNum; dimL: integer): integer;
begin
	if(dimL = 1) then begin
		total:= v[dimL];
	end
	else begin
		total:= v[dimL] + total(v, dimL - 1);
	end;
end;
var
	v: arrNum;
	dimL,Emax: integer;
begin
	dimL:= 0;
	Emax:= 0;
	generarVector(v, dimL);
	imprimirVector(v, dimL);
	Emax:= maxi(v, dimL, Emax);
	writeln(Emax);
	writeln(total(v, dimL));
end.
