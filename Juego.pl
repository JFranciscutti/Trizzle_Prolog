:- use_rendering(table).
:- use_module(library(clpfd)).

upgrade(v1,v2).
upgrade(v2,v3).
upgrade(v3,v3).

upgrade(a1,a2).
upgrade(a2,a3).
upgrade(a3,a3).

upgrade(r1,r2).
upgrade(r2,r3).
upgrade(r3,r3).


obtenerFila(1,[L1,_L2,_L3,_L4,_L5],L1).
obtenerFila(2,[_L1,L2,_L3,_L4,_L5],L2).
obtenerFila(3,[_L1,_L2,L3,_L4,_L5],L3).
obtenerFila(4,[_L1,_L2,_L3,L4,_L5],L4).
obtenerFila(5,[_L1,_L2,_L3,_L4,L5],L5).


setFila(1,L,[_L1,L2,L3,L4,L5],[L,L2,L3,L4,L5]).
setFila(2,L,[L1,_L2,L3,L4,L5],[L1,L,L3,L4,L5]).
setFila(3,L,[L1,L2,_L3,L4,L5],[L1,L2,L,L4,L5]).
setFila(4,L,[L1,L2,L3,_L4,L5],[L1,L2,L3,L,L5]).
setFila(5,L,[L1,L2,L3,L4,_L5],[L1,L2,L3,L4,L]).

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


obtenerElem(1,[E1,_E2,_E3,_E4,_E5],E1).
obtenerElem(2,[_E1,E2,_E3,_E4,_E5],E2).
obtenerElem(3,[_E1,_E2,E3,_E4,_E5],E3).
obtenerElem(4,[_E1,_E2,_E3,E4,_E5],E4).
obtenerElem(5,[_E1,_E2,_E3,_E4,E5],E5).

setElem(Elem,[_E1,E2,E3,E4,E5],1,[Elem,E2,E3,E4,E5]).
setElem(Elem,[E1,_E2,E3,E4,E5],2,[E1,Elem,E3,E4,E5]).
setElem(Elem,[E1,E2,_E3,E4,E5],3,[E1,E2,Elem,E4,E5]).
setElem(Elem,[E1,E2,E3,_E4,E5],4,[E1,E2,E3,Elem,E5]).
setElem(Elem,[E1,E2,E3,E4,_E5],5,[E1,E2,E3,E4,Elem]).


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
  generarEvolTablero(Dir,Num,TableroNuevo,EvolTablero).

desplazar(Dir, Num, Cant, Tablero, EvolTablero):-
  (Dir = 'abj' ; Dir = 'arb'),
  obtenerColumna(Num,Tablero,Lista),
  rotar(Dir,Cant,Lista,ListaN),
  setColumna(Num,ListaN,Tablero,TableroNuevo),
  generarEvolTablero(Dir,Num,TableroNuevo,EvolTablero).


generarEvolTablero(Dir,Num,Tablero,ListaTableros):-
  (Dir = 'abj' ; Dir = 'arb'),
  addLast(Tablero,[],L1),
  transpose(Tablero,TableroTrasp),
  buscar_colapsos(Num,TableroTrasp,TColapsos),%genera colapsos si existen dsp de un desplazamiento
  transpose(TColapsos,TColapsosN),
  addLast(TColapsosN,L1,L2),
  gravedad_columnas(TColapsosN,TGravedad),%tira para abajo todas las mamushkas por gravedad
  addLast(TGravedad,L2,L3),
  random_tablero(TGravedad,TRandom),%reemplaza las x por mamushkas randoms
  addLast(TRandom,L3,ListaTableros).

generarEvolTablero(Dir,Num,Tablero,ListaTableros):-
  (Dir = 'der' ; Dir = 'izq'),
  addLast(Tablero,[],L1),
  buscar_colapsos(Num,Tablero,TColapsos),%genera colapsos si existen dsp de un desplazamiento
  addLast(TColapsos,L1,L2),
  gravedad_columnas(TColapsos,TGravedad),%tira para abajo todas las mamushkas por gravedad
  addLast(TGravedad,L2,L3),
  random_tablero(TGravedad,TRandom),%reemplaza las x por mamushkas randoms
  addLast(TRandom,L3,ListaTableros).


buscar_colapsos(NumFila,Tablero,TableroNuevo):-
  obtenerFila(NumFila,Tablero,Fila),
  hay_colapso(Fila),
  buscar_cruce(NumFila,Fila,Tablero,TNuevo),
  obtenerFila(NumFila,TNuevo,FilaNueva),
  colapsar_lista(3,FilaNueva,FilaN),
  setFila(NumFila,FilaN,TNuevo,TableroNuevo),!.

buscar_colapsos(NumFila,Tablero,TableroNuevo):-
  obtenerFila(NumFila,Tablero,Fila),
  not(hay_colapso(Fila)),
  buscar_en_columnas(NumFila,Tablero,TableroNuevo),!.


hay_colapso(Fila):-
  iguales_cuatro(3,Fila,_FilaNueva);
  iguales_tres(3,Fila,_FilaNueva),!.

buscar_cruce(NumFila,Fila,Tablero,TableroNuevo):-
  Cont is 1,
  buscar_cruce_aux(Cont,NumFila,Fila,Tablero,TableroNuevo).

buscar_cruce_aux(Cont,NumFila,Fila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  hay_colapso(Columna),
  obtenerElem(NumFila,Columna,Elem),
  cruzar(Cont,Elem,Fila,FilaNueva),
  colapsar_lista(NumFila,Columna,ColNueva),
  setFila(NumFila,FilaNueva,Tablero,TNuevo),
  setColumna(Cont,ColNueva,TNuevo,TNuevo1),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,FilaNueva,TNuevo1,TableroNuevo).

buscar_cruce_aux(Cont,NumFila,Fila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  not(hay_colapso(Columna)),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,Fila,Tablero,TableroNuevo).

buscar_cruce_aux(Cont,NumFila,Fila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  hay_colapso(Columna),
  obtenerElem(NumFila,Columna,Elem),
  not(cruzar(Cont,Elem,Fila,FilaNueva)),
  colapsar_lista(NumFila,Columna,ColNueva),
  setColumna(Cont,ColNueva,Tablero,TNuevo),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,FilaNueva,TNuevo,TableroNuevo).


buscar_cruce_aux(6,_NumFila,_Fila,Tablero,Tablero).


buscar_en_columnas(NumFila,Tablero,TableroNuevo):-
  Cont is 1,
  buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo).

buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  colapsar_lista(NumFila,Columna,ColNueva),
  setColumna(Cont,ColNueva,Tablero,TN),
  C is Cont + 1,
  buscar_en_columnasAux(C,NumFila,TN,TableroNuevo).
buscar_en_columnasAux(6,_NumFila,Tablero,Tablero).


cruzar(Cont,Elem,[E1,E2,E3,E4,E5],FilaNueva):-
  (Cont = 1;Cont = 2; Cont = 3; Cont = 4),
  Elem = E1,
  E1 = E2,
  E2 = E3,
  E3 = E4,
  colapsar_lista(Cont,[E1,E2,E3,E4,E5],FilaNueva).

cruzar(Cont,Elem,[E1,E2,E3,E4,E5],FilaNueva):-
  (Cont = 1;Cont = 2; Cont = 3; Cont = 4),
  Elem = E2,
  E2 = E3,
  E3 = E4,
  E4 = E5,
  colapsar_lista(Cont,[E1,E2,E3,E4,E5],FilaNueva).

cruzar(Cont,Elem,[E1,E2,E3,E4,E5],FilaNueva):-
  (Cont = 1;Cont = 2; Cont = 3),
  Elem = E1,
  E1 = E2,
  E2 = E3,
  colapsar_lista(Cont,[E1,E2,E3,E4,E5],FilaNueva).

cruzar(Cont,Elem,[E1,E2,E3,E4,E5],FilaNueva):-
  (Cont = 2;Cont = 3; Cont = 4),
  Elem = E2,
  E2 = E3,
  E3 = E4,
  colapsar_lista(Cont,[E1,E2,E3,E4,E5],FilaNueva).

cruzar(Cont,Elem,[E1,E2,E3,E4,E5],FilaNueva):-
  (Cont = 3; Cont = 4, Cont = 5),
  Elem = E3,
  E3 = E4,
  E4 = E5,
  colapsar_lista(Cont,[E1,E2,E3,E4,E5],FilaNueva).


colapsar_lista(Num,L,LN):-
  iguales_cuatro(Num,L,LN),
  !.

colapsar_lista(Num,L,LN):-
  iguales_tres(Num,L,LN),
  !.
colapsar_lista(_Num,L,L).

checkPos(Num,Ext1,_Ext2,PosFinal):-
    Num < Ext1,
    PosFinal is Num + 1.
checkPos(Num,_Ext1,Ext2,PosFinal):-
    Num > Ext2,
    PosFinal is Num - 1.
checkPos(Num,Ext1,Ext2,Num):-
    Num = Ext1;
    Num = Ext2;
    Num < Ext2;
    Num > Ext1.



iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E1=E2,E2=E3),
  LN = [x,x,x,E4,E5],
  checkPos(Num,1,3,PosFinal),
  upgrade(E1,NElem),
  setElem(NElem,LN,PosFinal,ListaN).

iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E2=E3,E3=E4),
  LN=[E1,x,x,x,E5],
  checkPos(Num,2,4,PosFinal),
  upgrade(E2,NElem),
  setElem(NElem,LN,PosFinal,ListaN).

iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E3=E4,E4=E5),
  LN=[E1,E2,x,x,x],
  checkPos(Num,3,5,PosFinal),
  upgrade(E3,NElem),
  setElem(NElem,LN,PosFinal,ListaN).

iguales_cuatro(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E1=E2,E2=E3,E3=E4),
  LN=[x,x,x,x,E5],
  checkPos(Num,1,4,PosFinal),
  upgrade(E4,NElem),
  setElem(NElem,LN,PosFinal,ListaN).

iguales_cuatro(Num,[E1,E2,E3,E4,E5],ListaN):-
  (E2=E3,E3=E4,E4=E5),
  LN=[E1,x,x,x,x],
  checkPos(Num,2,5,PosFinal),
  upgrade(E5,NElem),
  setElem(NElem,LN,PosFinal,ListaN).

gravedad_columnas(Tablero,TableroN):-
  Cont = 1,
  gravedad_columnas_aux(Cont,Tablero,TableroN).
gravedad_columnas_aux(Cont,Tablero,TableroN):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  gravedad(Columna,ColNueva),
  setColumna(Cont,ColNueva,Tablero,TN),
  C is Cont + 1,
  gravedad_columnas_aux(C,TN,TableroN).
gravedad_columnas_aux(6,Tablero,TableroN):-
    TableroN = Tablero.

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
