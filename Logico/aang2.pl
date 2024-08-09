esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).
controla(momo, fuego).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

%-------------- Punto 1 --------------

esElAvatar(Personaje):-
    %controla(Personaje, _),
    controlaElementosBasicos(Personaje).

%-------------- Punto 2 --------------

controlaElementosBasicos(Personaje):-
    controla(Personaje, _),
    forall(controla(Personaje, Elemento), esElementoBasico(Elemento)).


clasificar(Personaje, Clasificacion):-
    esPersonaje(Personaje),
    clasificarPersonaje(Personaje, Clasificacion).

clasificarPersonaje(Personaje, noEsMaestro):-
    not(controla(Personaje, _)).

clasificarPersonaje(Personaje, maestroPrincipiante):-
    controlaAlgunElementobasico(Personaje),
    not(controlaElementoAvanzado(Personaje)).

clasificarPersonaje(Personaje, maestroAvanzado):-
    controlaElementoAvanzado(Personaje).

clasificarPersonaje(Personaje, maestroDeMaestros):-
    esElAvatar(Personaje).

controlaAlgunElementobasico(Personaje):-
    controla(Personaje, Elemento),
    esElementoBasico(Elemento).

controlaElementoAvanzado(Personaje):-
    controla(Personaje, Elemento),
    elementoAvanzadoDe(_, Elemento).

%-------------- Punto 3 --------------
sigueA(Seguido, Seguidor):-
    esPersonaje(Seguido),
    esPersonaje(Seguidor),
    forall(visito(Seguido, Lugar), visito(Seguidor, Lugar)).

sigueA(aang, zuko).

sonPersonajes(Seguido, Seguidor):-
    esPersonaje(Seguido),
    esPersonaje(Seguidor).

%-------------- Punto 4 --------------
esDignoDeConocer(Lugar):-
    visito(_, Lugar),
    esLugarDigno(Lugar).

esLugarDigno(temploAire(_)).
esLugarDigno(tribuAgua(norte)).
esLugarDigno(reinoTierra(_, Estructuras)):-
    not(member(muro, Estructuras)).

%-------------- Punto 5 --------------
esPopular(Lugar):-
    esLugar(Lugar),
    listadoDeVisitantes(Lugar, Personajes),
    cantidadDeVisitantes(Personajes, Cantidad),
    Cantidad > 4.

esLugar(Lugar):-
    visito(_, Lugar).

listadoDeVisitantes(Lugar, Personajes):-
    esLugar(Lugar),
    findall(Personaje, visito(Personaje, Lugar), Personajes).

cantidadDeVisitantes(Personajes, Cantidad):-
    length(Personajes, Cantidad).






