:- use_rendering(table).

upgrade(v1,v2).
upgrade(v2,v3).
upgrade(v3,v3).

upgrade(a1,a2).
upgrade(a2,a3).
upgrade(a3,a3).

upgrade(r1,r2).
upgrade(r2,r3).
upgrade(r3,r3).


obtenerFila(N,[L1,_L2,_L3,_L4,_L5],L1):-
  N is 1.
obtenerFila(N,[_L1,L2,_L3,_L4,_L5],L2):-
  N is 2.
obtenerFila(N,[_L1,_L2,L3,_L4,_L5],L3):-
  N is 3.
obtenerFila(N,[_L1,_L2,_L3,L4,_L5],L4):-
  N is 4.
obtenerFila(N,[_L1,_L2,_L3,_L4,L5],L5):-
  N is 5.


setFila(N,L,[_L1,L2,L3,L4,L5],[L,L2,L3,L4,L5]):-
  N is 1.
setFila(N,L,[L1,_L2,L3,L4,L5],[L1,L,L3,L4,L5]):-
  N is 2.
setFila(N,L,[L1,L2,_L3,L4,L5],[L1,L2,L,L4,L5]):-
  N is 3.
setFila(N,L,[L1,L2,L3,_L4,L5],[L1,L2,L3,L,L5]):-
  N is 4.
setFila(N,L,[L1,L2,L3,L4,_L5],[L1,L2,L3,L4,L]):-
  N is 5.

obtenerColumna(Num,[L1,L2,L3,L4,L5],ListaN):-
  obtenerElem(Num,L1,E1),
  obtenerElem(Num,L2,E2),
  obtenerElem(Num,L3,E3),
  obtenerElem(Num,L4,E4),
  obtenerElem(Num,L5,E5),
  ListaN=[E1,E2,E3,E4,E5].

/*
  Num=posicion en la que quiero la columna,
  [E1..E5]= columnna a insertar,
  [L1..L5]= tablero en el que quiero insertar la columnna,
  [NL1..NL5]= tablero con columna nueva.
*/
setColumna(Num,[E1,E2,E3,E4,E5],[L1,L2,L3,L4,L5],[NL1,NL2,NL3,NL4,NL5]):-
  setElem(E1,L1,Num,NL1),
  setElem(E2,L2,Num,NL2),
  setElem(E3,L3,Num,NL3),
  setElem(E4,L4,Num,NL4),
  setElem(E5,L5,Num,NL5).


obtenerElem(Num,[E1,_E2,_E3,_E4,_E5],E1):-
  Num is 1.
obtenerElem(Num,[_E1,E2,_E3,_E4,_E5],E2):-
  Num is 2.
obtenerElem(Num,[_E1,_E2,E3,_E4,_E5],E3):-
  Num is 3.
obtenerElem(Num,[_E1,_E2,_E3,E4,_E5],E4):-
  Num is 4.
obtenerElem(Num,[_E1,_E2,_E3,_E4,E5],E5):-
  Num is 5.

setElem(Elem,[_E1,E2,E3,E4,E5],Pos,[Elem,E2,E3,E4,E5]):-
  Pos is 1.
setElem(Elem,[E1,_E2,E3,E4,E5],Pos,[E1,Elem,E3,E4,E5]):-
  Pos is 2.
setElem(Elem,[E1,E2,_E3,E4,E5],Pos,[E1,E2,Elem,E4,E5]):-
  Pos is 3.
setElem(Elem,[E1,E2,E3,_E4,E5],Pos,[E1,E2,E3,Elem,E5]):-
  Pos is 4.
setElem(Elem,[E1,E2,E3,E4,_E5],Pos,[E1,E2,E3,E4,Elem]):-
  Pos is 5.


generarTablero(Tablero):-
  generarFila(F1),
  generarFila(F2),
  generarFila(F3),
  generarFila(F4),
  generarFila(F5),
  Tablero = [F1,F2,F3,F4,F5].

generarFila(L):-
  random(1,4,E1), %genera un random entre 1 y 4 (4 excluido)
  mamushka(E1,C1), %dado el random, genera la mamushka v1, r1 o a1
  random(1,4,E2),
  mamushka(E2,C2),
  random(1,4,E3),
  mamushka(E3,C3),
  random(1,4,E4),
  mamushka(E4,C4),
  random(1,4,E5),
  mamushka(E5,C5),
  addLast(C1,[],L1),
  addLast(C2,L1,L2),
  addLast(C3,L2,L3),
  addLast(C4,L3,L4),
  addLast(C5,L4,L5),
  L = L5.

mamushka(E,Elem):-
  E is 1,
  Elem = a1.
mamushka(E,Elem):-
  E is 2,
  Elem = r1.
mamushka(E,Elem):-
  E is 3,
  Elem = v1.

desplazar(Dir, Num, Cant, Tablero, EvolTablero):-
  (Dir = 'der' ; Dir = 'izq'),
  obtenerFila(Num,Tablero,Lista),
  rotar(Dir,Cant,Lista,ListaN),
  setFila(Num,ListaN,Tablero,TableroNuevo),
  generarEvolTablero(TableroNuevo,EvolTablero).

desplazar(Dir, Num, Cant, Tablero, EvolTablero):-
  (Dir = 'abj' ; Dir = 'arb'),
  obtenerColumna(Num,Tablero,Lista),
  rotar(Dir,Cant,Lista,ListaN),
  setColumna(Num,ListaN,Tablero,TableroNuevo),
  generarEvolTablero(Dir,Num,TableroNuevo,EvolTablero).


generarEvolTablero(Dir,Num,Tablero,ListaTableros):-
  (Dir = 'abj' ; Dir = 'arb'),
  addLast(Tablero,[],L1),
  buscar_colapsos_vert(Num,Tablero,TColapsos),%genera colapsos si existen dsp de un desplazamiento
  addLast(TColapsos,L1,L2),
  gravedad_columnas(TColapsos,TGravedad),%tira para abajo todas las mamushkas por gravedad
  addLast(TGravedad,L2,L3),
  random_tablero(TGravedad,TRandom),%reemplaza las x por mamushkas randoms
  addLast(TRandom,L3,ListaTableros).

generarEvolTablero(Dir,Num,Tablero,ListaTableros):-
  (Dir = 'der' ; Dir = 'izq'),
  addLast(Tablero,[],L1),
  buscar_colapsos_hor(Num,Tablero,TColapsos),%genera colapsos si existen dsp de un desplazamiento
  addLast(TColapsos,L1,L2),
  gravedad_columnas(TColapsos,TGravedad),%tira para abajo todas las mamushkas por gravedad
  addLast(TGravedad,L2,L3),
  random_tablero(TGravedad,TRandom),%reemplaza las x por mamushkas randoms
  addLast(TRandom,L3,ListaTableros).


buscar_colapsos_hor(NumFila,Tablero,TableroNuevo):-
  %buscar colapso en la fila actual
  %si hay colapso, buscar algun cruce con alguna columna que colapse tambien
  %meterle mamushka grande en la interseccion de ambas



buscar_colapsos_hor(NumFila,Tablero,TableroNuevo):-
  buscar_en_columnas(NumFila,Tablero,TableroNuevo).

buscar_en_columnas(NumFila,Tablero,TableroNuevo):-
  Cont is 1,
  buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo).

buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  %obtenerFila(NumFila,Tablero,Fila),
  %colapsar_lista(Cont,Fila,FilaNueva),
  colapsar_lista(NumFila,Columna,ColNueva),
  setColumna(Cont,ColNueva,Tablero,TN),
  %setFila(NumFila,FilaNueva,TN,TN1)
  C is Cont + 1,
  buscar_en_columnasAux(C,NumFila,TN1,TableroNuevo).

  %hay que hacer un colapsar lista nuevo

buscar_colapsos_vert(NumCol,Tablero,TableroNuevo):-
  %buscar colapso en la columna actual
  %si hay colapso, buscar algun cruce con alguna fila que colapse tambien
  %meterle mamushka grande en la interseccion de ambas

buscar_colapsos_vert(NumCol,Tablero,TableroNuevo):-
  buscar_en_filas(NumCol,Tablero,TableroNuevo).

buscar_en_filas(NumCol,Tablero,TableroNuevo):-
  Cont is 1,
  buscar_en_filasAux(Cont,NumCol,Tablero,TableroNuevo).

buscar_en_filasAux(Cont,NumCol,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerFila(Cont,Tablero,Fila),
  colapsar_lista(NumCol,Fila,FilaNueva),
  setFila(Cont,FilaNueva,Tablero,TN),
  C is Cont + 1,
  buscar_en_filasAux(C,NumCol,TN,TableroNuevo).




colapsar_lista(Num,L,LN):-
  iguales_cuatro(Num,L,LN),
  !.

colapsar_lista(Num,L,LN):-
  iguales_tres(Num,L,LN),
  !.
colapsar_lista(Num,L,L).


iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E1=E2,E2=E3),
  LN = [x,x,x,E4,E5],
  upgrade(E1,NElem),
  setElem(NElem,LN,Num,ListaN).

iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E2=E3,E3=E4),
  LN=[E1,x,x,x,E5],
  upgrade(E2,NElem),
  setElem(NElem,LN,Num,ListaN).

iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E3=E4,E4=E5),
  LN=[E1,E2,x,x,x],
  upgrade(E3,NElem),
  setElem(NElem,LN,Num,ListaN).

iguales_cuatro(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E1=E2,E2=E3,E3=E4),
  LN=[x,x,x,x,E5],
  upgrade(E4,NElem),
  setElem(NElem,LN,Num,ListaN).

iguales_cuatro(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E2=E3,E3=E4,E4=E5),
  LN=[E1,x,x,x,x],
  upgrade(E5,NElem),
  setElem(NElem,LN,Num,ListaN).

gravedad_columnas(Tablero,TableroN):-
  obtenerColumna(1,Tablero,C1),
  obtenerColumna(2,Tablero,C2),
  obtenerColumna(3,Tablero,C3),
  obtenerColumna(4,Tablero,C4),
  obtenerColumna(5,Tablero,C5),
  gravedad(C1,NC1),
  gravedad(C2,NC2),
  gravedad(C3,NC3),
  gravedad(C4,NC4),
  gravedad(C5,NC5),
  setColumna(1,NC1,Tablero,T1),
  setColumna(2,NC2,T1,T2),
  setColumna(3,NC3,T2,T3),
  setColumna(4,NC4,T3,T4),
  setColumna(5,NC5,T4,TableroN),!.


gravedad(Lista,ListaN):-
  obtenerElems(Lista,ListaE),
  size(ListaE,Cant),
  C is 5 - Cant,
  rellenar(C,ListaE,ListaN),!.

obtenerElems([],[]).
obtenerElems([H|T],ListaN):-
  H = x ,
  obtenerElems(T,ListaN).
obtenerElems([H|T],[H|LN]):-
  H \= x,
  obtenerElems(T,LN).

rellenar(0,Lista,Lista).
rellenar(Cant,Lista,LN):-
  C is Cant -1,
  addFirst(x,Lista,ListaN),
  rellenar(C,ListaN,LN).


random_tablero([L1,L2,L3,L4,L5],[NL1,NL2,NL3,NL4,NL5]):-
  randomPorX(L1,NL1),
  randomPorX(L2,NL2),
  randomPorX(L3,NL3),
  randomPorX(L4,NL4),
  randomPorX(L5,NL5),!.


randomPorX([],[]).
randomPorX([H|T],[Elem|LN]):-
  H = x,
  random(1,4,E),
  mamushka(E,Elem),
  randomPorX(T,LN).
randomPorX([H|T],[H|LN]):-
  H \= x,
  randomPorX(T,LN).



rotar(_Sentido,0,Lista,Lista):-!.

rotar(Sentido,Cant,Lista,ListaN):-
  (Sentido = 'der'; Sentido= 'abj'),
  shift_derecha(Lista,LN),
  C is Cant - 1,
  rotar(Sentido,C,LN,ListaN).

rotar(Sentido,Cant,Lista,ListaN):-
  (Sentido = 'izq'; Sentido='arb'),
  shift_izquierda(Lista,LN),
  C is Cant - 1,
  rotar(Sentido,C,LN,ListaN).


/*PREDICADOS AUXILIARES REUTILIZADOS DE LOS PRACTICOS*/
addLast(X,[],[X]).
addLast(X,[H|T],R):-
  addLast(X,T,Z),R=[H|Z].

addFirst(X, L, [X | L]).

shift_derecha(L,R):-
  ultimo(L,U),
  addFirst(U,L,T),
  borrarUltimo(T,R),!.

shift_izquierda([H|T],R):-
  borrar(H,[H|T],X),
  addLast(H,X,R),!.

borrarUltimo([_], []).
borrarUltimo([H, Next|T], [H|NT]):-
  borrarUltimo([Next|T], NT).

ultimo([H],H).
ultimo([_H|T],R):-
  ultimo(T,R).

borrar(X,[X|T],T).
borrar(X,[H|T],[H|R]):-
  borrar(X,T,R).

size([],0).
size([_|T],Num):-
  size(T,Num2),
  Num is Num2 +1.
