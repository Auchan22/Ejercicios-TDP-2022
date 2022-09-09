{
2.	Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, fecha y cantidad de unidades vendidas.
*  La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto.
*  Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.
               Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.

}

program ej2P3;
type
	fechaReg = record
		day: integer;
		month: integer;
		year: integer;
	end;
	venta = record
		code: integer;
		fecha: fechaReg;
		cantVendidas: integer;
	end;
	arbol = ^nodo;
	nodo = record
		dato: venta;
		HI: arbol;
		HD: arbol;
	end;
procedure generarVenta (var v: venta);
		procedure leerFecha (var f: fechaReg);
		begin
			writeln('Ingresé dia de la venta: ');
			readln(f.day);
			writeln('Ingresé mes de la venta: ');
			readln(f.month);
			writeln('Ingresé año de la venta: ');
			readln(f.year);
		end;
begin
		writeln('Ingrese codigo del producto: ');
		readln(v.code);
		if(v.code <> 0) then begin
			writeln('Ingrese Fecha de venta del producto: ');
			leerFecha(v.fecha);
			writeln('Ingrese cantidades vendidas: ');
			readln(v.cantVendidas);
		end;
end;
procedure crearArbol (var a: arbol; v: venta);
begin
	if (a = nil) then begin
			new(a);
			a^.dato:= v;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
			if (v.code <= a^.dato.code) then crearArbol(a^.HI, v)
			else crearArbol(a^.HD, v);
end;
procedure imprimirArbol (a: arbol);
	procedure imprimirVenta(v: venta);
		procedure imprimirFecha(f: fechaReg);
		begin
			writeln('Dia: ', f.day);
			writeln('Mes: ', f.month);
			writeln('Año: ', f.year);
		end;
	begin
		writeln('Codigo de producto: ', v.code);
		writeln('Fecha de venta: ');
		imprimirFecha(v.fecha);
		writeln('Cantidades vendidas: ', v.cantVendidas);
	end;
begin
	if(a <> nil) then begin
		imprimirArbol(a^.HI);
		imprimirVenta(a^.dato);
		writeln('---');
		imprimirArbol(a^.HD);
	end
end;

var
	a: arbol;
	v: venta;
begin
	a:= nil;
	generarVenta(v);
	while (v.code <> 0) do begin
		crearArbol(a, v);
		generarVenta(v);
	end;
	imprimirArbol(a);
end.
