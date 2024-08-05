trabajaEn(bakunin,aviacionMilitar).
esBueno(bakunin,conduciendoAutos).
historialCriminal(bakunin,[roboDeAeronaves,fraude,tenenciaDeCafeina]).

trabajaEn(ravachol,inteligenciaMilitar).
esBueno(ravachol,tiroAlBlanco).
leGusta(ravachol,juegosDeAzarar).
leGusta(ravachol,ajedrez).
leGusta(ravachol,tiroAlBlanco).
historialCriminal(ravachol,[falsificacionDeVacunas,fraude]).

esBueno(rosaDubovsky,construyendoPuntes).
esBueno(rosaDubovsky,mirandoPeppaPig).
leGusta(rosaDubovsky,mirarPeppaPig).
leGusta(rosaDubovsky,construirPuentes).
leGusta(rosaDubovsky,fisicaCuantica).

trabajaEn(emmaGoldman,profesoraDeJudo).
trabajaEn(emmaGoldman,cineasta).
esBueno(emmaGoldman,Actividad):-
    esBueno(judithButler,Actividad).

esBueno(emmaGoldman,Gusto):-
    esBueno(elisaBachofen,Gusto).

leGusta(emmaGoldman,Actividad):-
    leGusta(judithButler,Actividad).

trabajaEn(judithButler,profesoraDeJudo).
trabajaEn(judithButler,inteligenciaMilitar).
esBueno(judithButler,judo).
leGusta(judithButler,judo).
leGusta(judithButler,carrerasDeAutomovilismo).
historialCriminal(judithButler,[falsificaciónDeCheques,fraude]).

trabajaEn(elisaBachofen,ingenieriaMecanica).
esBueno(elisaBachofen,armandoBombas).
leGusta(elisaBachofen,elFuego).
leGusta(elisaBachofen,laDestruccion).

leGusta(juanSuriano,judo).
esBueno(juanSuriano,judo).
leGusta(juanSuriano,armarBombas).
esBueno(juanSuriano,armandoBombas).
leGusta(juanSuriano,elRingRaje).
esBueno(juanSuriano,elRingRaje).
historialCriminal(juanSuriano,[falsificacionDeDinero,fraude]).

% ---------------------- Punto 2 ----------------------------

viveEn(laSeverino, bakunin).
viveEn(laSeverino, elisaBachofen).
viveEn(laSeverino, rosaDubovsky).
vivienda(laSeverino, cuartoSecreto(4,8)).
vivienda(laSeverino,pasadizo(1)).
vivienda(laSeverino,tunelSecreto(8)).
vivienda(laSeverino,tunelSecreto(5)).
vivienda(laSeverino,tunelSecreto(1)).

viveEn(comisaria48, ravachol).

viveEn(casaDePapel, emmaGoldman).
viveEn(casaDePapel, juanSuriano).
viveEn(casaDePapel, judithButler).
vivienda(casaDePapel, pasadizo(2)).
vivienda(casaDePapel,cuartoSecreto(5,3)).
vivienda(casaDePapel,cuartoSecreto(4,7)).
vivienda(casaDePapel,tunelSecreto(9)).
vivienda(casaDePapel,tunelSecreto(2)).

vivienda(casaDelSolNaciente, pasadizo(1)).

% ---------------------- Punto 3 ----------------------------
esGuardiaRebelde(Vivienda):-
    vivienda(Vivienda, _),
    %viveDesidente(Vivienda),
    findall(Superficie, superficieMayorA50(Vivienda, Superficie), Superficies),
    sumlist(Superficies, Total),
    Total > 50.
    

superficieMayorA50(Vivienda, Superficie):-
    vivienda(Vivienda, cuartoSecreto(Ancho, Largo)),
    Superficie is (Ancho * Largo * Ancho).

superficieMayorA50(Vivienda, Superficie):-
    vivienda(Vivienda, tunelSecreto(Longitud)),
    Superficie is (Longitud * 2).

superficieMayorA50(Vivienda, Superficie):-
    vivienda(Vivienda, pasadizo(Superficie)).

% ---------------------- Punto 4 ----------------------------
noViveNadie(Vivienda):-
    vivienda(Vivienda, _),
    not(viveEn(Vivienda, _)).

noViveNadie(Vivienda):-
    vivienda(Vivienda,_),
    viveEn(Vivienda,_),
    forall(viveEn(Vivienda, Persona), leGusta(Persona, Gusto)).

% ---------------------- Punto 5 ----------------------------

esDisidente(Persona):-
    tieneHabilidadTerrorista(Persona),
    leGustaTodoONada(Persona),
    masDeUnCrimenOVivirConCriminal(Persona).

tieneHabilidadTerrorista(Persona):-
    esBueno(Persona, armandoBombas).

tieneHabilidadTerrorista(Persona):-
    esBueno(Persona, tiroAlBlanco).

tieneHabilidadTerrorista(Persona):-
    esBueno(Persona, mirandoPeppaPig).

leGustaTodoONada(Persona):-
    leGusta(Persona,_),
    forall(leGusta(Persona, Gusto), esBueno(Persona, Gusto)).

leGustaTodoONada(Persona):-
    not(leGusta(Persona,_)).

masDeUnCrimenOVivirConCriminal(Persona):-
    historialCriminal(Persona, Crimenes),
    length(Crimenes, Cantidad),
    Cantidad > 1.

masDeUnCrimenOVivirConCriminal(Persona):-
    viveEn(Vivienda, Persona),
    viveEn(Vivienda, OtraPersona),
    historialCriminal(OtraPersona, _).

% ---------------------- Punto 6 ----------------------------
batallonDeRebeldes(Batallon):-
    batallonDeCriminales(Batallon),
    sumaHabilidades(Batallon).

batallonDeCriminales(Batallon):-
    findall(Persona, masDeUnCrimenOVivirConCriminal(Persona), Batallon).

sumaHabilidades(Batallon):-
    findall(Habilidad, (member(Persona, Batallon), esBueno(Persona, Habilidad)), Habilidades),
    sumlist(Habilidades, Total),
    Total > 10.

    




    


    




