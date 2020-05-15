--1. Dla warstwy trees zmień ustawienia tak, aby lasy liściaste, iglaste i mieszane wyświetlane były innymi kolorami. Podaj pole powierzchni wszystkich lasów o charakterze mieszanym. 
--2.Podziel warstwę trees na trzy warstwy. Na każdej z nich umieść inny typ lasu.
--3. Oblicz długość linii kolejowych dla regionu Matanuska-Susitna.
--4. Oblicz, na jakiej średniej wysokości nad poziomem morza położone są lotniska o charakterze militarnym. Ile jest takich lotnisk? Usuń z warstwy airports lotniska o charakterze militarnym, które są dodatkowo położone powyżej 1400 m n.p.m. Ile było takich lotnisk?
--5. Utwórz warstwę, na której znajdować się będą jedynie budynki położone w regionie Bristol Bay (wykorzystaj warstwę popp). Podaj liczbę budynków. Na warstwie zostaw tylko te budynki, które są położone nie dalej niż 100 km od rzek (rivers). Ile jest takich budynków?
--6. Sprawdź w ilu miejscach przecinają się rzeki (majrivers) z liniami kolejowymi (railroads).
--7. Wydobądź węzły dla warstwy railroads. Ile jest takich węzłów?
--8. Wyszukaj najlepsze lokalizacje do budowy hotelu. Hotel powinien być oddalony od lotniska nie więcej niż 100 km i nie mniej niż 50 km od linii kolejowych. Powinien leżeć także w pobliżu sieci drogowej.
--9. Uprość geometrię warstwy przedstawiającej bagna (swamps). Ustaw tolerancję na 100. Ile wierzchołków zostało zredukowanych? Czy zmieniło się pole powierzchni całkowitej ws
zystkich poligonów (jeżeli tak, to podaj różnicę)?


--Ad 1
Uruchomiłem właściwości warstwy trees, następnie wybrałem wartość unikalną,w oparciu o pole VEGDESC i ustawiłem 3 różne kolory dla 3 różnych rodzajów lasów. (Załącznik 1.jpg)
Pole powierzchni lasów mieszanych:
SELECT SUM(trees.AREA_KM2) AS Pole_mieszanych FROM trees WHERE VEGDESC='Mixed Trees';

Wyniosło: 189273.327 

--Ad.2
Podzieliłem warstwę trees na 3 warstwy poprzez opcję:
wektor-narzędzie zarządzania danymi-podziel warstwę wektorową-zapisz w katalogu (pole z unikalnym ID-VEGDESC).

--Ad.3
SELECT SUM(ST_Length(railroads.GEOMETRY)) AS Dlugość_linii_kolejowych FROM regions, railroads WHERE regions.NAME_2='Matanuska-Susitna';
Wyniosło: 2768932.05

--Ad.4
--Średnia wysokość nad poziomem morza, na której położone są lotniska o charakterze militarnym:
SELECT AVG(ELEV) AS Srednia_wysokosc FROM airports WHERE USE='Military';

---Średnia wysokość:593.25

--Ilość lotnisk o charakterze militarnym:
SELECT airports.ID as Obiekt FROM airports WHERE USE='Military';

---Ilość-8

--Ilość lotnisk o charakterze militarnym położonych na wysokości powyżej 1400m
SELECT COUNT(*) as Ilosc_obiektow FROM airports WHERE USE='Military' AND ELEV > 1400;

--- 1 lotnisko

--Ad.5

SELECT * FROM popp, regions WHERE regions.NAME_2='Bristol Bay' AND popp.F_CODEDESC='Building' AND Contains(regions.GEOMETRY, popp.GEOMETRY);

--Jest 5 takich budynków

--Ad.6

SELECT COUNT(*) FROM majrivers, railroads WHERE ST_Intersects(majrivers.GEOMETRY, railroads.GEOMETRY);
--- Przecinają się w 5 miejscach

--Ad.7
Skorzystałem z narzędzia wektor-narzędzia geometrii-wydobądź wierzchołki (Załącznik 7.jpg)
-- Są 662 wierzchołki(węzły) 

--Ad.8
SELECT  NAME_2 FROM regions , airports , railroads  WHERE ST_Distance(airports.GEOMETRY, regions.GEOMETRY) < 100000  AND ST_Distance(railroads.GEOMETRY, regions.GEOMETRY) >= 50000  LIMIT 1;


--Ad.9
SELECT SUM(AREAKM2) from swamp;

Uprościłem geometrię warstwy przedstawiającej bagna (swamps) i ustawiłem tolerancję na 100 narzędziem:
wektor- narzędzia geometrii -uprość geometrię- tolerancja 100

Po uproszczeniu pole nie uległo zmianie, a zostały zredukowane 1294 wierzchołki. 








