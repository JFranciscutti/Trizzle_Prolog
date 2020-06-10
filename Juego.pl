:- use_rendering(table).

obtenerT(r1,1).
obtenerT(r2,2).
obtenerT(r3,3).

obtenerT(a1,1).
obtenerT(a2,2).
obtenerT(a3,3).

obtenerT(v1,1).
obtenerT(v2,2).
obtenerT(v3,3).

generarTablero(Tablero):-
   generarFila(F1),
   generarFila(F2),
   generarFila(F3),
   generarFila(F4),
   generarFila(F5),
   Tablero = [F1,F2,F3,F4,F5].

generarFila(L):-
  random(1,4,C1),
  agregamos(C1,[],L1),
  random(1,4,C2),
  agregamos(C2,L1,L2),
  random(1,4,C3),
  agregamos(C3,L2,L3),
  random(1,4,C4),
  agregamos(C4,L3,L4),
  random(1,4,C5),
  agregamos(C5,L4,L5),
  L = L5.

/*corrimineto
colapso
acom*/


agregamos(Elem , Lista , ListaN):-
  Elem is 1,
  addLast(a1,Lista,ListaN).
agregamos(Elem , Lista , ListaN):-
    Elem is 2,
    addLast(r1,Lista,ListaN).
agregamos(Elem , Lista , ListaN):-
  Elem is 3,
  addLast(v1,Lista,ListaN).




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
