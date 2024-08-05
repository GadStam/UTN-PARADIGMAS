% ----------- PUNTO 1 -----------
turno(dodain, lunes, 9, 15).
turno(dodain, miercoles, 9, 15).
turno(dodain, viernes, 9, 15).

turno(lucas, martes, 10, 20).

turno(juanC, sabados, 18, 22).
turno(juanC, domingo, 18, 22).

turno(juanFdS, jueves, 10, 20).
turno(juanFdS, viernes, 12, 20).

turno(leoC, lunes, 14, 18).
turno(leoC, miercoles, 14, 18).

turno(martu, miercoles, 23, 24).

turno(vale, Dia, HorarioInicio, HorarioFin):-
   turno(dodain, Dia, HorarioInicio, HorarioFin).

turno(vale, Dia, HorarioInicio, HorarioFin):-
    turno(juanC, Dia, HorarioInicio, HorarioFin).

% ----------- PUNTO 2 -----------

quienAtiende(Dia, Horario, Persona):-
    turno(Persona, Dia, HoraInicio, HoraFin),
    between(HoraInicio, HoraFin, Horario).

% ----------- PUNTO 3 -----------

foreverAlone(Persona, Dia, Hora):-
    turno(Persona, Dia, HoraInicio, HoraFin),
    between(HoraInicio, HoraFin, Hora),
    not((quienAtiende(Dia, Hora, OtraPersona), Persona \= OtraPersona)).

% ----------- PUNTO 4 -----------

posibilidadesAtencion(Dia, PersonasPosibles):-
    findall(Persona, distinct(Persona, quienAtiende(Dia,_,Persona)), PersonasPosibles).
  
  

venta(dodain, lunes, 10, agosto, golosina(1200)).
venta(dodain, lunes, 10, agosto, golosina(50)).
venta(dodain, lunes, 10, agosto, cigarrillos([jockey])).

venta(dodain, miercoles, 12, agosto, golosina(10)).
venta(dodain, miercoles, 12, agosto, bebidas(alcoholicas, 8)).
venta(dodain, miercoles, 12, agosto, bebidas(no-alcoholicas, 1)).

venta(martu, miercoles, 12, agosto, golosina(1000)).
venta(martu, miercoles, 12, agosto, cigarrillos([chesterfield, colorado, parisiennes])).

venta(lucas, martes, 11, agosto, golosina(600)).

venta(lucas, martes, 18, agosto, bebidas(no-alcoholicas, 2)).
venta(lucas, martes, 18, agosto, cigarrillos([derby])).

esSuertuda(Persona):-
    venta(Persona, _, _, _, _),
    forall(venta(Persona, _, _, _, Producto), tieneSuerte(Producto)).

tieneSuerte(golosina(Precio)):-
    Precio > 100.

tieneSuerte(bebidas(_, Cantidad)):-
    Cantidad > 5.

tieneSuerte(bebidas(alcoholicas, _)).

tieneSuerte(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.




