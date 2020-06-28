:- use_rendering(table).
:- use_module(library(clpfd)).


/*
 * Los predicados upgrade/2 reciben una mamushka de cualquier color
 * y devuelven su tamaño siguiente. Si es tamaño 3, solo queda en 3.
 * */
upgrade(v1,v2).
upgrade(v2,v3).
upgrade(v3,v3).

upgrade(a1,a2).
upgrade(a2,a3).
upgrade(a3,a3).

upgrade(r1,r2).
upgrade(r2,r3).
upgrade(r3,r3).

/*
 * Retorna la columna ubicada en la posicion Num en el Tablero.
 * */
obtenerColumna(Num ,Tablero,  Columna):-
   transpose(Tablero, TableroTransp),
   obtenerFila(Num, TableroTransp, Columna).
/*
 * Retorna la fila ubicada en la posicion Num en el Tablero.
 * */
obtenerFila(1,[ X | _Tail],  X).
obtenerFila(Num ,[_X | Tail],Fila):-
  Num1 is Num-1,
  obtenerFila(Num1, Tail,  Fila).



/*
 * Ubica una lista dada en la posicion que se le indique en el
 * tablero y retorna el tablero nuevo.
 * */
setFila(1,L,[_L1,L2,L3,L4,L5],[L,L2,L3,L4,L5]).
setFila(2,L,[L1,_L2,L3,L4,L5],[L1,L,L3,L4,L5]).
setFila(3,L,[L1,L2,_L3,L4,L5],[L1,L2,L,L4,L5]).
setFila(4,L,[L1,L2,L3,_L4,L5],[L1,L2,L3,L,L5]).
setFila(5,L,[L1,L2,L3,L4,_L5],[L1,L2,L3,L4,L]).



/*
 * Ubica una columna en la posicion Num del tablero y retorna
 * el tablero resultante.
 * */
setColumna(Num,[E1,E2,E3,E4,E5],[L1,L2,L3,L4,L5],[NL1,NL2,NL3,NL4,NL5]):-
  setElem(E1,L1,Num,NL1),
  setElem(E2,L2,Num,NL2),
  setElem(E3,L3,Num,NL3),
  setElem(E4,L4,Num,NL4),
  setElem(E5,L5,Num,NL5).

/*
 * Dada una lista, retorna el elemento que se encuentra en la
 * posicion indicada.
 * */
obtenerElem(1,[E1,_E2,_E3,_E4,_E5],E1).
obtenerElem(2,[_E1,E2,_E3,_E4,_E5],E2).
obtenerElem(3,[_E1,_E2,E3,_E4,_E5],E3).
obtenerElem(4,[_E1,_E2,_E3,E4,_E5],E4).
obtenerElem(5,[_E1,_E2,_E3,_E4,E5],E5).

/*
 * Dado Elem y una lista, Elem es añadido en la
 * posicion indicada. Retorna la lista resultante.
 * */
setElem(Elem,[_E1,E2,E3,E4,E5],1,[Elem,E2,E3,E4,E5]).
setElem(Elem,[E1,_E2,E3,E4,E5],2,[E1,Elem,E3,E4,E5]).
setElem(Elem,[E1,E2,_E3,E4,E5],3,[E1,E2,Elem,E4,E5]).
setElem(Elem,[E1,E2,E3,_E4,E5],4,[E1,E2,E3,Elem,E5]).
setElem(Elem,[E1,E2,E3,E4,_E5],5,[E1,E2,E3,E4,Elem]).

/*
 * Genera el tablero inicial
 * */
generarTablero(Tablero):-
  generarFila(F1),
  generarFila(F2),
  generarFila(F3),
  generarFila(F4),
  generarFila(F5),
  Tablero = [F1,F2,F3,F4,F5].

/*
 * Genera listas con mamushkas random (todas de tamaño 1)
 * que representan las filas del tablero principal.
 * */
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

/*
 * Dado un numero 1,2 o 3, genera una mamushka de color azul,
 * rojo o verde respectivamente.
 * */
mamushka(E,Elem):-
  E is 1,
  Elem = a1.
mamushka(E,Elem):-
  E is 2,
  Elem = r1.
mamushka(E,Elem):-
  E is 3,
  Elem = v1.

%**********************************************************************
%//////////////GENERO EL TABLERO 1: TABLERO DESPLAZADO\\\\\\\\\\\\\\\\\
%**********************************************************************

/*
 * Desplaza la fila (o columna) de la posicion Num del Tablero
 * Cant veces hacia la direccion Dir. Retorna una lista con 4 tableros.
 * */
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

/*
 * Dada una lista (que puede ser una fila o una columna),
 * la rota Cant veces hacia el Sentido que se le indique.
 * */
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

/*
 * Dir indica si movimos una columna o una fila.
 * Dado el Tablero ya desplazado, genera tableros despues
 * de ser colapsados, con las x ubicadas hacia abajo por gravedad
 * y con las x reemplazadas por randoms.
 * Si no hubo colapsos, devuelve una lista con el primer tablero.
 * Si hubo colapsos, devuelve una lista con los 4 tableros descriptos arriba
 * */
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
  addLast(TRandom,L3,ListaT),
  corregir_lista(ListaT,ListaTableros).%si no hubo colapsos, devuelve la lista solo con el tablero desplazado

generarEvolTablero(Dir,Num,Tablero,ListaTableros):-
  (Dir = 'der' ; Dir = 'izq'),
  addLast(Tablero,[],L1),
  buscar_colapsos(Num,Tablero,TColapsos),%genera colapsos si existen dsp de un desplazamiento
  addLast(TColapsos,L1,L2),
  gravedad_columnas(TColapsos,TGravedad),%tira para abajo todas las mamushkas por gravedad
  addLast(TGravedad,L2,L3),
  random_tablero(TGravedad,TRandom),%reemplaza las x por mamushkas randoms
  addLast(TRandom,L3,ListaT),
  corregir_lista(ListaT,ListaTableros).%si no hubo colapsos, devuelve la lista solo con el tablero desplazado

/*
 * Si el primer elemento es igual al segundo, implica que todos los elementos
 * son iguales, luego, devuelvo una lista solamente con el primer elemento
 * */
corregir_lista([H1,H2,_T],ListaN):-
    H1 = H2,
    ListaN = [H1].
corregir_lista(Lista,Lista).

%**********************************************************************
%////////////////GENERO EL TABLERO 2: TABLERO COLAPSADO\\\\\\\\\\\\\\\\
%**********************************************************************



/*
 * Busco colapsos que generen un cruce con la fila (o columna) que movi.
 * (Si hubo un colapso en la fila/columna que movi, posiblemente haya un cruce)
 * */
buscar_colapsos(NumFila,Tablero,TableroNuevo):-
  obtenerFila(NumFila,Tablero,Fila),
  hay_colapso(Fila,ElemColapso),
  buscar_cruce(NumFila,Fila,ElemColapso,Tablero,TNuevo),
  obtenerFila(NumFila,TNuevo,FilaNueva),
  colapsar_lista(3,FilaNueva,FilaN),
  setFila(NumFila,FilaN,TNuevo,TableroNuevo),!.

/*
 * Busco solo colapsos en las columnas/filas.
 * (Si no hay colapso en la fila/columna que movi, imposible que haya un cruce)
 * */
buscar_colapsos(NumFila,Tablero,TableroNuevo):-
  obtenerFila(NumFila,Tablero,Fila),
  not(hay_colapso(Fila,_ElemColapso)),
  buscar_en_columnas(NumFila,Tablero,TableroNuevo),!.

/*
 * Dada una fila o columna, retorna true si hubo un colapso en esta y ademas,
 * nos devuelve el elemento que hizo que colapse la misma.
 * */
hay_colapso(Fila,ElemColapso):-
  iguales_cuatro(3,Fila,_FilaNueva,ElemColapso);
  iguales_tres(3,Fila,_FilaNueva,ElemColapso),!.

/*
 * Predicado cascara que recorre todas las filas/columnas
 * colapsando cruces si existen.
 * */
buscar_cruce(NumFila,Fila,ColapsoFila,Tablero,TableroNuevo):-
  Cont is 1,
  buscar_cruce_aux(Cont,NumFila,Fila,ColapsoFila,Tablero,TableroNuevo).

/*
 * CASO 1: NO HAY COLAPSO EN LA COLUMNA, SALTEO
 * */
buscar_cruce_aux(Cont,NumFila,Fila,ColapsoFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  obtenerElem(Cont,Fila,ElemFila),
  setElem(ElemFila,Columna,NumFila,ColOriginal),
  not(hay_colapso(ColOriginal,_ElemColapso)),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,Fila,ColapsoFila,Tablero,TableroNuevo).

/*
 * CASO 2: HAY COLAPSO EN LA COLUMNA PERO NO SALE DE LA FILA QUE DESPLACE
 * */
buscar_cruce_aux(Cont,NumFila,Fila,ColapsoFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  obtenerElem(Cont,Fila,ElemFila),
 	setElem(ElemFila,Columna,NumFila,ColOriginal),
  hay_colapso(ColOriginal,ElemColapso),
  obtenerElem(NumFila,ColOriginal,ElemFila),
  not(check(NumFila,ElemColapso,ElemFila,ColOriginal)),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,Fila,ColapsoFila,Tablero,TableroNuevo).

/*
 * CASO 3: HAY COLAPSO EN LA COLUMNA Y SALE DEL COLAPSO DE LA FILA
 * (CRUCE EFECTIVO)
 * */
buscar_cruce_aux(Cont,NumFila,Fila,ColapsoFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  obtenerElem(Cont,Fila,ElemFila),
  setElem(ElemFila,Columna,NumFila,ColOriginal),
  hay_colapso(ColOriginal,ElemColapso),
  ColapsoFila = ElemColapso,
  colapsar_lista(Cont,Fila,FilaNueva),
  colapsar_lista(NumFila,ColOriginal,ColNueva),
  setFila(NumFila,FilaNueva,Tablero,TNuevo),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,Fila,ColapsoFila,TNuevo,TNuevo1),
  setColumna(Cont,ColNueva,TNuevo1,TableroNuevo).
/*
 * CASO 4: HAY COLAPSO EN LA COLUMNA Y SALE DESDE LA FILA QUE FUE
 * DESPLAZADA
 * */
buscar_cruce_aux(Cont,NumFila,_Fila,ColapsoFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  hay_colapso(Columna,ElemColapso),
  obtenerElem(NumFila,Columna,ElemFila),
  check(NumFila,ElemColapso,ElemFila,Columna),
  colapsar_lista(NumFila,Columna,ColNueva),
  setColumna(Cont,ColNueva,Tablero,TNuevo),
  obtenerFila(NumFila,TNuevo,FilaNueva),
  C is Cont + 1,
  buscar_cruce_aux(C,NumFila,FilaNueva,ColapsoFila,TNuevo,TableroNuevo).


buscar_cruce_aux(6,_NumFila,_Fila,_ColapsoFila,Tablero,Tablero).

/*
 * Predicado cascara que recorre las columnas/filas buscando solo colapsos
 * en filas/columnas. ACLARACION: todos los nombres de las variables son
 * referidos a cuando muevo una fila. Si muevo una columna, tambien se usan
 * estos predicados.
 * */
buscar_en_columnas(NumFila,Tablero,TableroNuevo):-
  Cont is 1,
  buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo).

/*
 * CASO 1: NO HAY COLAPSO EN LA COLUMNA ENTONCES LA SALTEO
 * */
buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  not(hay_colapso(Columna,_ElemColapso)),
  C is Cont + 1,
  buscar_en_columnasAux(C,NumFila,Tablero,TableroNuevo).

/*
 * CASO 2: HAY COLAPSO EN LA COLUMNA PERO NO SALE DE LA FILA
 * QUE DESPLACE
 * */
buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  hay_colapso(Columna,ElemColapso),
  obtenerElem(NumFila,Columna,ElemFila),
  not(check(NumFila,ElemColapso,ElemFila,Columna)),
  C is Cont + 1,
  buscar_en_columnasAux(C,NumFila,Tablero,TableroNuevo).

/*
 * CASO 3: HAY UN COLAPSO EN LA COLUMNA Y SALE DE LA FILA
 * QUE DESPLACE
 * */
buscar_en_columnasAux(Cont,NumFila,Tablero,TableroNuevo):-
  Cont < 6,
  obtenerColumna(Cont,Tablero,Columna),
  hay_colapso(Columna,ElemColapso),
  obtenerElem(NumFila,Columna,ElemFila),
  check(NumFila,ElemColapso,ElemFila,Columna),
  colapsar_lista(NumFila,Columna,ColNueva),
  setColumna(Cont,ColNueva,Tablero,TN),
  C is Cont + 1,
  buscar_en_columnasAux(C,NumFila,TN,TableroNuevo).


buscar_en_columnasAux(6,_NumFila,Tablero,Tablero).

/*
 * Verifica que el colapso se genere a partir de la fila
 * que desplace
 * */
check(NumFila,ElemColapso,ElemFila,Columna):-
	NumUp is NumFila - 1,
  obtenerElem(NumUp,Columna,ElemUp),
  ElemUp = ElemColapso,
  ElemColapso = ElemFila.

check(NumFila,ElemColapso,ElemFila,Columna):-
	NumDown is NumFila + 1,
  obtenerElem(NumDown,Columna,ElemDown),
  ElemDown = ElemColapso,
  ElemColapso = ElemFila.

/*
 * Dada una lista, colapsa 4 o 3 mamushkas iguales hacia la
 * fila/columna desplazada en la posicion Num del tablero.
 * */
colapsar_lista(Num,L,LN):-
  iguales_cuatro(Num,L,LN,_ElemColapso),
  !.

colapsar_lista(Num,L,LN):-
  iguales_tres(Num,L,LN,_ElemColapso),
  !.
colapsar_lista(_Num,L,L).

/*
 * Busca colapsos de 3 mamushkas en las 3 posibles combinaciones:
 * las primeras 3, las ultimas 3 o las 3 del medio.
 * */
iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN,ElemColapso):-
  (E1=E2,E2=E3),
  LN = [x,x,x,E4,E5],
  upgrade(E1,NElem),
  ElemColapso = E1,
  setElem(NElem,LN,Num,ListaN).

iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN,ElemColapso):-
  (E2=E3,E3=E4),
  LN=[E1,x,x,x,E5],
  upgrade(E2,NElem),
  ElemColapso = E2,
  setElem(NElem,LN,Num,ListaN).

iguales_tres(Num,[E1,E2,E3,E4,E5],ListaN,ElemColapso):-
  (E3=E4,E4=E5),
  LN=[E1,E2,x,x,x],
  upgrade(E3,NElem),
  ElemColapso = E3,
  setElem(NElem,LN,Num,ListaN).

/*
 * Busca colapsos de 4 mamushkas en las unicas 2 combinaciones posibles:
 * las primeras 4 o las ultimas 4.
 * */
iguales_cuatro(Num,[E1,E2,E3,E4,E5],ListaN,ElemColapso):-
  (E1=E2,E2=E3,E3=E4),
  LN=[x,x,x,x,E5],
  upgrade(E4,NElem),
  ElemColapso = E4,
  setElem(NElem,LN,Num,ListaN).

iguales_cuatro(Num,[E1,E2,E3,E4,E5],ListaN,ElemColapso):-
  (E2=E3,E3=E4,E4=E5),
  LN=[E1,x,x,x,x],
  upgrade(E5,NElem),
  ElemColapso = E5,
  setElem(NElem,LN,Num,ListaN).

%**********************************************************************
%/////////////GENERO EL TABLERO 3: TABLERO CON GRAVEDAD\\\\\\\\\\\\\\\\
%**********************************************************************

/*
 * Dado un tablero, busca x en todas las columnas y las tira hacia arriba,
 * emulando una gravedad en el tablero.
 * */
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

/*
 * Dada una lista, la ordena posicionando las x a la izquierda y
 * el resto de los elementos a la derecha en el orden original.
 * */
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

%**********************************************************************
%//////////////GENERO TABLERO 4: TABLERO CON RANDOMS\\\\\\\\\\\\\\\\\\\
%**********************************************************************

/*
 * Recorre todas las filas y reemplaza todas las x por
 * mamushkas randoms.
 * */
random_tablero([L1,L2,L3,L4,L5],[NL1,NL2,NL3,NL4,NL5]):-
  randomPorX(L1,NL1),
  randomPorX(L2,NL2),
  randomPorX(L3,NL3),
  randomPorX(L4,NL4),
  randomPorX(L5,NL5),!.

/*
 * Dada una lista con mamushkas y x, reemplaza las x por mamushkas randoms nuevas
 * */
randomPorX([],[]).
randomPorX([H|T],[Elem|LN]):-
  H = x,
  random(1,4,E),
  mamushka(E,Elem),
  randomPorX(T,LN).
randomPorX([H|T],[H|LN]):-
  H \= x,
  randomPorX(T,LN).


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
