herramientasRequeridas(ordenarCuarto, [aspiradora(200), trapeador]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

persona(egon, aspiradora(200)).
persona(egon, trapeador).
persona(peter, trapeador).
persona(winston, varitaDeNeutrones).

satisfaceherramienta(Persona, Herramienta):-
    persona(Persona, Herramienta).

satisfaceherramienta(Persona, aspiradora(PotenciaRequerida)):-
    persona(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

puedeRealizar(Persona, Tarea):-
    herramientasDeLapersona(Persona, Herramientas),
    herramientasRequeridas(Tarea, Herramientas).

puedeRealizar(Persona, Tarea):-
    persona(Persona, varitaDeNeutrones),
    herramientasRequeridas(Tarea, _).

herramientasDeLapersona(Persona, Herramientas):-
    persona(Persona, _),
    findall(Herramienta, persona(Persona, Herramienta), Herramientas).


%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

precioCliente(Tarea, Precio):-
    tareaPedida(Tarea,_, MetrosCuadrados),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is MetrosCuadrados * PrecioPorMetroCuadrado.

quienAceptaria(Persona, Pedido):- 
    puedeRealizar(Persona, Pedido),
    estadispuestoARealizarlo(Persona, Pedido).

estadispuestoARealizarlo(ray, Pedido):-
    Pedido \= limpiarTecho.

estadispuestoARealizarlo(winston, Pedido):-
    precioCliente(Pedido, Precio),
    Precio > 500.

estadispuestoARealizarlo(egon, Pedido):-
    not(esTareaCompleja(Pedido)).

esTareaCompleja(Pedido):-
    herramientasRequeridas(Pedido, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.

esTareaCompleja(limpiarTecho).

estadispuestoARealizarlo(peter, Pedido):-
    herramientasRequeridas(Pedido,_).







