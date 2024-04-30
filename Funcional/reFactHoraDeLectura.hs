


data Libro = UnLibro {
    autor :: String,
    titulo :: String,
    paginas :: Int
} deriving (Show, Eq)

type Biblioteca = [Libro]

elVisitante :: Libro
elVisitante = UnLibro "Stephen King" "El Visitante" 560

shingekiNoKyojinCap1 :: Libro
shingekiNoKyojinCap1 = UnLibro "Hajime Isayama" "Shingeki No Kyojin Capitulo 1" 40

shingekiNoKyojinCap2 :: Libro
shingekiNoKyojinCap2 = UnLibro"Hajime Isayama" "Shingeki No Kyojin Capitulo 2" 40

shingekiNoKyojinCap127 :: Libro
shingekiNoKyojinCap127 = UnLibro"Hajime Isayama" "Shingeki No Kyojin Capitulo 127" 40

fundacion :: Libro
fundacion = UnLibro "Isaac Asimov" "Fundacion" 230

sandmanCap5 :: Libro
sandmanCap5 = UnLibro "Neil Gaiman" "Sandman Capitulo 5" 35

sandmanCap10 :: Libro
sandmanCap10 = UnLibro "Neil Gaiman" "Sandman Capitulo 10" 35

sandmanCap12 :: Libro
sandmanCap12 = UnLibro "Neil Gaiman" "Sandman Capitulo 12" 35

eragon :: Libro
eragon = UnLibro "Christopher Paolini" "Eragon" 544

eldest :: Libro
eldest = UnLibro "Christopher Paolini" "Eldest" 704

brisignr :: Libro
brisignr = UnLibro "Christopher Paolini" "Brisignr" 700

legado :: Libro
legado = UnLibro "Christopher Paolini" "Legado" 811

miBiblioteca :: Biblioteca
miBiblioteca = [elVisitante, shingekiNoKyojinCap1, shingekiNoKyojinCap2, shingekiNoKyojinCap127, fundacion, sandmanCap5, sandmanCap10, sandmanCap12, eragon, eldest, brisignr, legado]

sagaEragon :: Biblioteca
sagaEragon = [eragon, eldest, brisignr, legado]

--------------promedio De Hojas----------------
promedioDeHojas :: Biblioteca -> Int
promedioDeHojas miBiblioteca = (cantidadHojasTotales miBiblioteca) `div` (tamanioBiblioteca miBiblioteca)

cantidadHojasTotales :: Biblioteca -> Int
cantidadHojasTotales miBiblioteca = (sum . map paginas) miBiblioteca

tamanioBiblioteca :: Biblioteca -> Int
tamanioBiblioteca miBiblioteca = length miBiblioteca

--------------lectura obligatoria---------
esLecturaObligatoria :: Libro -> Bool
esLecturaObligatoria libro = esDe "Stephen King" libro || esDeEragon libro sagaEragon || esDe "Isaac Asimov" libro

esDe :: String -> Libro -> Bool
esDe autorDelLibro libro = autor libro == autorDelLibro

esDeEragon :: Libro -> Biblioteca -> Bool
esDeEragon libro sagaEragon = elem libro sagaEragon

-----------------fantasiosa----------------
esFantasiosa :: Biblioteca -> Bool
esFantasiosa miBiblioteca = any (esDe "Christopher Paolini") miBiblioteca || any (esDe "Neil Gaiman") miBiblioteca

