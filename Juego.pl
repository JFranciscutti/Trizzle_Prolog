:- use_rendering(table).

obtenerT(X,1):- member(X,[v1,a1,r1]).
obtenerT(X,2):- member(X,[v2,a2,r2]).
obtenerT(X,3):- member(X,[v3,a3,r3]).


obtenerFila(N,[L1,_L2,_L3,_L4,_L5],ListaD):-
  N is 1,
  ListaD = L1.
obtenerFila(N,[_L1,L2,_L3,_L4,_L5],ListaD):-
  N is 2,
  ListaD = L2.
obtenerFila(N,[_L1,_L2,L3,_L4,_L5],ListaD):-
  N is 3,
  ListaD = L3.
obtenerFila(N,[_L1,_L2,_L3,L4,_L5],ListaD):-
  N is 4,
  ListaD = L4.
obtenerFila(N,[_L1,_L2,_L3,_L4,L5],ListaD):-
  N is 5,
  ListaD = L5.

generarTablero(Tablero):-
   generarFila(F1),
   generarFila(F2),
   generarFila(F3),
   generarFila(F4),
   generarFila(F5),
   Tablero = [F1,F2,F3,F4,F5].

generarFila(L):-
  random(1,4,C1),
  add(C1,[],L1),
  random(1,4,C2),
  add(C2,L1,L2),
  random(1,4,C3),
  add(C3,L2,L3),
  random(1,4,C4),
  add(C4,L3,L4),
  random(1,4,C5),
  add(C5,L4,L5),
  L = L5.

/*corrimineto
colapso
acom*/


add(Elem , Lista , ListaN):-
  Elem is 1,
  addLast(a1,Lista,ListaN).
add(Elem , Lista , ListaN):-
    Elem is 2,
    addLast(r1,Lista,ListaN).
add(Elem , Lista , ListaN):-
  Elem is 3,
  addLast(v1,Lista,ListaN).



/*desplazar(+Dir, +Num, +Cant, +Tablero, -EvolTablero):-
  (Dir is   der ; Dir is  izq),
  rotarHorizontal(Dir, )*/

/*rotarHorizontal(Sentido,0,Lista,ListaN).

rotarHorizontal(Sentido,Cant,Lista,ListaN):-
  Sentido is der,
  shift_derecha(Lista,LN),
  rotarHorizontal(Sentido,Cant-1,LN,ListaN).

rotarHorizontal(Sentido,Cant,Lista,ListaN):-
  Sentido is izq,
  shift_izquierda(Lista,LN),
  rotarHorizontal(Sentido,Cant-1,LN,ListaN).*/


/*PREDICADOS AUXILIARES REUTILIZADOS DE LOS PRACTICOS*/
  addLast(X,[],[X]).
  addLast(X,[H|T],R):- addLast(X,T,Z),R=[H|Z].

  shift_derecha(L,X):- ultimo(L,U),borrar(U,L,X),X=[U|L].

  shift_izquierda([H|T],R):- borrar(H,[H|T],X), addLast(H,X,R).

  ultimo([H],H).
  ultimo([_H|T],R):- ultimo(T,R).

  borrar(X,[X|T],T).
  borrar(X,[H|T],[H|R]):- borrar(X,T,R).

 /*    Idea columna
 movercolumna(Board, C , Cant, NBoard
:-
shift(Board, C, NBoard),
Cant is Cant-1
movercolumna
  shiftAux(Board, Columna, Fila, NBoard)
shift(Board, C, NBoard):-
     shiftAux(Board, Columna, 0, NBoard).
shift(Board, C, NBoard):-
     getElemento(Board, Columna, 0, E),
     shiftAux(Board, Columna, 0, E, NBoard).
shiftAux(Board, Columna, Fila, Elemento, NBoard):-
    Fila is Fila+1,
    reemplazar(Board, Columna, Fila, Elemento, E1, Board1),
    shiftAux(Board1, Columna, Fila, E1, NBoard)
shiftAux(Board, Columna, 4, E, NBoard):-
    reemplazar(Board, Columna, 0, _X, E).

*/

/*Agregar metodo para reemplazar una columna entera por una lista dada
insertar_columna(Nro_de_Columna,Lista,Tablero?)*/

/*cuando colapsan, agregar x en lugares vacios y luego
reemplazarlos por random */
