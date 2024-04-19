
--Listado de Funciones:
--1. productoCorriente
--2. productoDeLujo
--3. productoCodiciado
--4. productoDeElite
--5. descodiciarProducto
--6. productoXL
--8. aplicarDescuento
--9. entregaSencilla
--10. aplicarCostoDeEnvio
--11. precioTotal



--productoDeElite: Un producto es de elite si es de lujo, codiciado y no es un producto corriente.

--descodiciarProducto: Dado el nombre de un producto, generar uno que no sea codiciado. Para esto le vamos a sacar las últimas letras hasta que la cantidad de letras en el nombre quede igual a 10 (ó menor a 10 en productos con nombres cortos)







productoCorriente :: String -> Bool
productoCorriente producto = head producto == 'A' || head producto == 'E' || head producto == 'I' || head producto == 'O' || head producto == 'U'

productoDeLujo :: String -> Bool
productoDeLujo producto = elem 'x' producto || elem 'z' producto

productoCodiciado :: String -> Bool
productoCodiciado producto = length producto > 10

productoDeElite :: String -> Bool
productoDeElite producto = productoDeLujo producto && productoCodiciado producto && not (productoCorriente producto)

voltearNombre :: String -> String
voltearNombre producto = reverse producto

eliminarLetras :: String -> String
eliminarLetras producto = drop 1 producto

descodiciarProducto :: String -> String
descodiciarProducto producto = take 10 ((voltearNombre . eliminarLetras) producto)

productoXL :: String -> String
productoXL producto = producto ++ " XL"

versionBarata :: String -> String
versionBarata producto = (reverse . descodiciarProducto) producto

aplicarDescuento:: Float->Float->Float
aplicarDescuento precio descuento = precio - (precio * (descuento / 100))

entregaSencilla :: String -> Bool
entregaSencilla fecha = even (length fecha)

precioTotal :: Float -> Float -> Float -> Float -> Float
precioTotal precioUnitario cantidad descuento costoDeEnvio = (aplicarDescuento precioUnitario descuento)*cantidad + costoDeEnvio


sumarNumero :: Int -> Int
sumarNumero x = x + 10

multiNumero :: Int -> Int
multiNumero x = x * 2















