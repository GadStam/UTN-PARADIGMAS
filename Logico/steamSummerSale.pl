/*
● accion(NombreDelJuego)
● mmorpg(NombreDelJuego, CantidadDeUsuarios)
● puzzle(NombreDelJuego, CantidadDeNiveles, Dificultad)*/

juego(accion(callOfDuty),5).
juego(accion(batmanAA),10).
juego(mmorpg(wow,5000000),30).
juego(mmorpg(lineage2,6000000),15).
juego(puzzle(plantsVsZombies,40,media),10).
juego(puzzle(tetris,10,facil),0).

oferta(callOfDuty,10).
oferta(plantsVsZombies,50).
oferta(tetris,75).

usuario(nico,[batmanAA,plantsVsZombies,tetris],[compra(lineage2)]).
usuario(fede,[],[regalo(callOfDuty,eli),regalo(wow,nico)]).
usuario(eli,[wow],[regalo(callOfDuty,fede)]).
usuario(rasta,[lineage2],[]).
usuario(agus,[],[]).
usuario(felipe,[plantsVsZombies],[compra(tetris)]).

%------------ Punto 1 ------------

cuantoSale(Juego, Precio):-
    precioJuego(Juego, Precio),
    not(oferta(Juego, _)).

cuantoSale(Juego, Precio):-
    precioJuego(Juego, PrecioSinDescuento),
    oferta(Juego, Porcentaje),
    descuento(PrecioSinDescuento, Porcentaje, Precio).

precioJuego(Juego, Precio):-
    juego(accion(Juego), Precio).

precioJuego(Juego, Precio):-
    juego(puzzle(Juego, _, _), Precio).

precioJuego(Juego, Precio):-
    juego(mmorpg(Juego, _), Precio).

descuento(Precio, Porcentaje, PrecioFinal):-
    PrecioFinal is Precio - (Precio * Porcentaje / 100).

%------------ Punto 2 ------------
juegoPopular(Juego):-
    juego(accion(Juego), _).

juegoPopular(Juego):-
    juego(mmorpg(Juego, CantidadUsuarios), _),
    CantidadUsuarios > 1000000.

juegoPopular(Juego):-
    juego(puzzle(Juego, _, facil), _).

juegoPopular(Juego):-
    juego(puzzle(Juego, 25,_), _).

%------------ Punto 3 ------------
tieneBuenDescuento(Juego):-
    oferta(Juego, Porcentaje),
    Porcentaje > 50.

%------------ Punto 4 ------------
adictoALosDescuentos(Usuario):-
    usuario(Usuario,_,JuegosAComprar),
    listadoJuegos(JuegosAComprar, Juegos),
    Juegos \= [], %algunos al tener lista vacia, van a entrar al forall y va a ser true, aca corroboro que haya conmprado algo
    forall(member(Juego, Juegos), tieneBuenDescuento(Juego)).

listadoJuegos(JuegosAComprar, Juegos):-
    findall(Juego, (member(compra(Juego), JuegosAComprar)), Juegos).

%------------ Punto 5 ------------
fanaticoDe(Usuario, Genero) :-
    usuario(Usuario, JuegosPoseidos, _),
    member(Juego1, JuegosPoseidos),
    member(Juego2, JuegosPoseidos),
    Juego1 \= Juego2,
    esDelGenero(Juego1, Genero),
    esDelGenero(Juego2, Genero).
    
esDelGenero(Juego, accion):-
    juego(accion(Juego),_).
esDelGenero(Juego,mmorpg):-
    juego(mmorpg(Juego,_),_).
esDelGenero(Juego,puzzle):-
    juego(puzzle(Juego,_,_),_).

%------------ Punto 6 ------------
monotematico(Usuario, Genero):-
    usuario(Usuario, JuegosPoseidos, _),
    JuegosPoseidos \= [],
    member(UnJuego, JuegosPoseidos),
    esDelGenero(UnJuego, Genero),
    forall(member(Juego, JuegosPoseidos), esDelGenero(Juego, Genero)).

buenosAmigos(Personaje, OtroPersonaje):-
    usuario(Personaje, _, _),
    usuario(OtroPersonaje, _, _),
    regalaA(Personaje, OtroPersonaje),
    regalaA(OtroPersonaje, Personaje).

regalaA(Personaje, OtroPersonaje):-
    usuario(Personaje, _, Regalos),
    member(regalo(Juego, OtroPersonaje), Regalos),
    juegoPopular(Juego).

%------------ Punto 7 ------------

cuantoGastara(Usuario, GastoTotal):-
    usuario(Usuario,_,Regalos),
    findall(Precio, precioPorJuego(Regalos,Precio), Precios),
    sum_list(Precios, GastoTotal).

precioPorJuego(Regalos,Precio):-
    member(regalo(Juego,_),Regalos),
    cuantoSale(Juego,Precio).

precioPorJuego(Regalos,Precio):-
    member(compra(Juego),Regalos),
    cuantoSale(Juego,Precio).













    