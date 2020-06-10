:- user_rendering(table).

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
   generarFila(F1);
   generarFila(F2);
   generarFila(F3);
   generarFila(F4);
   generarFila(F5);
   Tablero=[F1,F2,F3,F4,F5].

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
  agregamos(C5,L4,L5).

corrimineto
colapso
acom


agregamos(elem)

  addLast(X,[],[X]).
  addLast(X,[H|T],R):- addLast(X,T,Z),R=[H|Z].

  shift_derecha(L,X):- ultimo(L,U),borrar(U,L,X),X=[U|L].

  shift_izquierda([H|T],R):- borrar(H,[H|T],X), addLast(H,X,R).

  ultimo([H],H).
  ultimo([_H|T],R):- ultimo(T,R).

  borrar(X,[X|T],T).
  borrar(X,[H|T],[H|R]):- borrar(X,T,R).
