

type Autor = String
type Titulo = String
type Paginas = Int
type Libro = (Autor, Titulo, Paginas)
type Biblioteca = [Libro]
type Sagaeragon = [Libro]
type Autores = [Autor]
type Titulos = [Titulo]

elVisitante :: Libro
elVisitante = ("Stephen King", "El Visitante", 592)

shingekiNoKyojinCap1 :: Libro
shingekiNoKyojinCap1 = ("Hajime Isayama", "Shingeki No Kyojin Capitulo 1", 40)

shingekiNoKyojinCap2 :: Libro
shingekiNoKyojinCap2 = ("Hajime Isayama", "Shingeki No Kyojin Capitulo 2", 40)

shingekiNoKyojinCap127 :: Libro
shingekiNoKyojinCap127 = ("Hajime Isayama", "Shingeki No Kyojin Capitulo 127", 40)

fundacion :: Libro
fundacion = ("Isaac Asimov", "Fundacion", 230)

sandmanCap5 :: Libro
sandmanCap5 = ("Neil Gaiman", "Sandman Capitulo 5", 35)

sandmanCap10 :: Libro
sandmanCap10 = ("Neil Gaiman", "Sandman Capitulo 10", 35)

sandmanCap12 :: Libro
sandmanCap12 = ("Neil Gaiman", "Sandman Capitulo 12", 35)

eragon :: Libro
eragon = ("Christopher Paolini", "Eragon", 544)

eldest :: Libro
eldest = ("Christopher Paolini", "Eldest", 704)

brisignr :: Libro
brisignr = ("Christopher Paolini", "Brisignr", 700)

legado :: Libro
legado = ("Christopher Paolini", "Legado", 811)

biblioteca :: Biblioteca
biblioteca = [elVisitante, shingekiNoKyojinCap1, shingekiNoKyojinCap2, shingekiNoKyojinCap127, fundacion, sandmanCap5, sandmanCap10, sandmanCap12, eragon, eldest, brisignr, legado]

promedioDeHojas :: Biblioteca -> Int
promedioDeHojas miBiblioteca = div (cantidadHojasTotales miBiblioteca)(cantidadLibros miBiblioteca) +3

cantidadHojasTotales :: Biblioteca -> Int
cantidadHojasTotales miBiblioteca = (sum . cantidadPaginasPorLibro) miBiblioteca

cantidadPaginasPorLibro :: Biblioteca -> [Int]
cantidadPaginasPorLibro miBiblioteca = map cantidadPaginas miBiblioteca

cantidadPaginas :: Libro -> Int
cantidadPaginas (_, _, paginas) = paginas

cantidadLibros :: Biblioteca -> Int
cantidadLibros miBiblioteca = length miBiblioteca

------------lectura obligatoria---------
sagaEragon :: Sagaeragon
sagaEragon = [eragon, eldest, brisignr, legado]


esLecturaObligatoria :: Libro -> Bool
esLecturaObligatoria libro = esDe "Stephen King" libro || esDeEragon sagaEragon libro || esDe "Isaac Asimov" libro

esDe :: Autor -> Libro -> Bool
esDe autorLibro libro = autor libro == autorLibro

autor :: Libro -> Autor
autor (autorLibro, _, _) = autorLibro

esDeEragon :: Sagaeragon -> Libro -> Bool
esDeEragon sagaEragon libro = elem libro sagaEragon

---------------fantasiosa----------------
esFantasiosa :: Biblioteca -> Bool
esFantasiosa miBiblioteca = tieneAutor "Christopher Paolini" miBiblioteca || tieneAutor "Neil Gaiman" miBiblioteca



tieneAutor :: Autor -> Biblioteca -> Bool
tieneAutor autorLibro miBiblioteca = any (esDe autorLibro) miBiblioteca

---------------nombreDeLaBiblioteca----------------

nombreDeLaBiblioteca :: Biblioteca -> String
nombreDeLaBiblioteca miBiblioteca = (sacarVocales . concatenarTitulos) miBiblioteca

sacarVocales :: String -> String
sacarVocales tituloConcatenado = filter (not . esVocal) tituloConcatenado --lo que hace el filter es quedarse con los elementos que cumplen la condicion, en este caso, que no sean vocales

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiouAEIOU"

concatenarTitulos :: Biblioteca -> String
concatenarTitulos miBiblioteca = (concat . nombresTitulos) miBiblioteca

nombresTitulos :: Biblioteca -> Titulos
nombresTitulos miBiblioteca = map titulo miBiblioteca

titulo :: Libro -> String
titulo (_, tituloLibro, _) = tituloLibro

-------bibliotecaLigera--------------
esBibliotecaLigera :: Biblioteca -> Bool
esBibliotecaLigera unaBiblioteca = all esLecturaLigera unaBiblioteca

esLecturaLigera :: Libro -> Bool
esLecturaLigera unLibro = ((<= 40) . cantidadPaginas) unLibro








