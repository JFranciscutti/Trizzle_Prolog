:- use_rendering(table).

obtenerT(X,1):- member(X,[v1,a1,r1]).
obtenerT(X,2):- member(X,[v2,a2,r2]).
obtenerT(X,3):- member(X,[v3,a3,r3]).


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


add(Elem , Lista , ListaN):-
  Elem is 1,
  addLast(a1,Lista,ListaN).
add(Elem , Lista , ListaN):-
    Elem is 2,
    addLast(r1,Lista,ListaN).
add(Elem , Lista , ListaN):-
  Elem is 3,
  addLast(v1,Lista,ListaN).



desplazar(Dir, Num, Cant, Tablero, EvolTablero):-
  (Dir = 'der' ; Dir = 'izq'),
  obtenerFila(Num,Tablero,Lista),
  C is Cant mod 5, %verifico que el numero este entre 0 y 4 para no hacer movimientos redundantes
  rotar(Dir,C,Lista,ListaN),
  setFila(Num,ListaN,Tablero,EvolTablero).
  %generarEvolTablero(TableroNuevo,EvolTablero).

desplazar(Dir, Num, Cant, Tablero, EvolTablero):-
    (Dir = 'abj' ; Dir = 'arb'),
    obtenerColumna(Num,Tablero,Lista),
    C is Cant mod 5,  %verifico que el numero este entre 0 y 4 para no hacer movimientos redundantes
    rotar(Dir,C,Lista,ListaN),
    setColumna(Num,ListaN,Tablero,EvolTablero).
    %generarEvolTablero(TableroNuevo,EvolTablero).


/*generarEvolTablero(Tablero,ListaTableros):-
  addLast(Tablero,[],L1),
  buscar_colapsos(Tablero,TColapsos),%genera colapsos si existen dsp de un desplazamiento
  addLast(TColapsos,L1,L2),
  agregar_x(TColapsos,TX), %llena de X los espacios en blanco.
  addLast(TX,L2,L3),
  randomPorX(TX,TFinal),%reemplaza las X por mamushkas random
  addLast(TFinal,L3,ListaTableros).*/



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
  addLast(X,[H|T],R):- addLast(X,T,Z),R=[H|Z].

  addFirst(X, L, [X | L]).

  shift_derecha(L,R):- ultimo(L,U),addFirst(U,L,T),borrarUltimo(T,R),!.

  shift_izquierda([H|T],R):- borrar(H,[H|T],X), addLast(H,X,R),!.

  borrarUltimo([_], []).
  borrarUltimo([H, Next|T], [Head|NT]):-
    borrarUltimo([Next|T], NT). 

  ultimo([H],H).
  ultimo([_H|T],R):- ultimo(T,R).

  borrar(X,[X|T],T).
  borrar(X,[H|T],[H|R]):- borrar(X,T,R).
