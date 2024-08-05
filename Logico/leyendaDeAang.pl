% esPersonaje/1 nos permite saber qué personajes tendrá el juego
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

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)


visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).
visito(aang, temploAire(suroeste)).

% -----------punto 1-------------

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    controlaElementosbasicos(Personaje).

controlaElementosbasicos(Personaje):-
    controla(Personaje, _),
    forall(controla(Personaje, Elemento), esElementoBasico(Elemento)).

% -----------punto 2 A-------------
noEsMaestro(Personaje):-
    not(controlaElementosbasicos(Personaje)),
    not(controlaElementosAvanzados(Personaje)).


controlaElementosAvanzados(Personaje):-
    controla(Personaje, _),
    forall(controla(Personaje, Elemento), elementoAvanzadoDe(_,Elemento)).

% -----------punto 2 B-------------
esMaestroprincipiante(Personaje):-
    controlaAlgunElementoBasico(Personaje),
    not(controlaElementosAvanzados(Personaje)).

controlaAlgunElementoBasico(Personaje):-
    controla(Personaje, _),
    controla(Personaje, Elemento),
    esElementoBasico(Elemento).

% -----------punto 2 C-------------
esMaestroAvanzado(Personaje):-
    controlaAlgunElementoAvanzado(Personaje).

esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

controlaAlgunElementoAvanzado(Personaje):-
    controla(Personaje, _),
    controla(Personaje, Elemento),
    elementoAvanzadoDe(_,Elemento).

% -----------punto 3-------------

sigueA(Seguido, Seguidor):-
    esPersonaje(Seguido),
    esPersonaje(Seguidor),
    forall(visito(Seguido, Lugar), visito(Seguidor, Lugar)).
    

% -----------punto 4-------------

esDignoDeConocer(temploAire).
esDignoDeConocer(temploAire(norte)).


esDignoDeConocer(Lugar):-
    visito(_, Lugar),
    zonasDelReinoDeTierra(Lugar, Zonas),
    noTieneMuros(Zonas).

zonasDelReinoDeTierra(reinoTierra(_,Zonas), Zonas).

noTieneMuros(Zonas):-
    not(member(muro, Zonas)).




% -----------punto 5-------------
esPopular(Lugar) :-
    esLugar(Lugar),
    listaDeVisitantes(Lugar, Personajes),
    visitantes(Personajes, Cantidad),
    Cantidad > 4.

esLugar(Lugar):-
    visito(_, Lugar).

listaDeVisitantes(Lugar, Personajes):-
    visito(_, Lugar),
    findall(Personaje, visito(Personaje, Lugar), Personajes).

visitantes(Personajes, Cantidad):-
    length(Personajes, Cantidad).
    

% -----------punto 6-------------


esPersonaje(bumi).
esPersonaje(suki).

controla(bumi, tierra).
visito(bumi, reinoTierra(baSingSe, [])).

visito(suki, nacionDelFuego(prisionDeMaximaSeguridad, 200)).







