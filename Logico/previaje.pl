comercioAdherido(iguazu, grandHotelIguazu).
comercioAdherido(iguazu, gargantaDelDiabloTour).
comercioAdherido(bariloche, aerolineas).
comercioAdherido(iguazu, aerolineas).

%factura(Persona, DetalleFactura).
%Detalles de facturas posibles:
% hotel(ComercioAdherido, ImportePagado)
% excursion(ComercioAdherido, ImportePagadoTotal,CantidadPersonas)
% vuelo(NroVuelo,NombreCompleto)
factura(estanislao, hotel(grandHotelIguazu, 2000)).
factura(antonieta, excursion(gargantaDelDiabloTour, 5000, 4)).
factura(antonieta, vuelo(1515, antonietaPerez)).
valorMaximoHotel(5000).

%registroVuelo(NroVuelo,Destino,ComercioAdherido,Pasajeros,Precio)
registroVuelo(1515, iguazu, aerolineas, [estanislaoGarcia,antonietaPerez, danielIto], 10000).

% ----------------- Punto 1 -----------------
dineroADevolver(Persona, DineroADevolver):-
    factura(Persona, DetalleFactura),
    devolucionPorFactura(DetalleFactura, DineroPorFacturas),
    ciudadesVisitadas(Persona, CiudadesVisitadas),
    DineroADevolver is DineroPorFacturas + CiudadesVisitadas * 1000.

devolucionPorFactura(hotel(_, ImportePagado), DineroADevolver):-
    descuento(50, ImportePagado, DineroADevolver).

devolucionPorFactura(excursion(_, ImportePagadoTotal, CantidadPersonas), DineroADevolver):-
    MontoPorPersona is ImportePagadoTotal / CantidadPersonas,
    descuento(80, MontoPorPersona, DineroADevolver).

devolucionPorFactura(vuelo(NroVuelo, _), DineroADevolver):-
    destinoVuelo(NroVuelo, Destino),
    Destino \= buenosAires,
    precioVuelo(NroVuelo, Precio),
    descuento(30, Precio, DineroADevolver).

destinoVuelo(NroVuelo, Destino):-
    registroVuelo(NroVuelo, Destino, _, _, _).

precioVuelo(NroVuelo, Precio):-
    registroVuelo(NroVuelo, _, _, _, Precio).

descuento(Porcentaje, Importe, ImporteConDescuento):-
    ImporteConDescuento is Importe - (Importe * Porcentaje) / 100.

ciudadesVisitadas(Persona, CiudadesVisitadas):-
    findall(CiudadAlojada, factura(Persona, hotel(CiudadAlojada, _)), CiudadesAlojadas),
    length(CiudadesAlojadas, CiudadesVisitadas).