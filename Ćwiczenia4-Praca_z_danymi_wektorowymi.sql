--4. Wyznacz liczbê budynków (tabela: popp, atrybut: f_codedesc, reprezentowane, jako punkty) po³o¿onych w odleg³oœci mniejszej ni¿ 100000 m od g³ównych rzek. Budynki spe³niaj¹ce to kryterium zapisz do osobnej tabeli tableB.
--5. Utwórz tabelê o nazwie airportsNew. Z tabeli airports do zaimportuj nazwy lotnisk, ich geometriê, a tak¿e atrybut elev, reprezentuj¹cy wysokoœæ n.p.m.
--a) ZnajdŸ lotnisko, które po³o¿one jest najbardziej na zachód i najbardziej na wschód.
--b) Do tabeli airportsNew dodaj nowy obiekt - lotnisko, które po³o¿one jest w po³owie drogi pomiêdzy lotniskami znalezionymi w punkcie a. Lotnisko nazwij airportB. Oblicz wysokoœæ n.p.m., jako œredni¹ wartoœæ atrybutów elev.
--Uwaga: geodezyjny uk³ad wspó³rzêdnych prostok¹tnych p³askich (x – oœ pionowa, y – oœ pozioma)
--6. Wyznacz pole powierzchni obszaru, który oddalony jest mniej ni¿ 1000 jednostek od najkrótszej linii ³¹cz¹cej jezioro o nazwie ‘Iliamna Lake’ i lotnisko o nazwie „AMBLER”.
--7. Napisz zapytanie, które zwróci sumaryczne pole powierzchni poligonów reprezentuj¹cych poszczególne typy drzew znajduj¹cych siê na obszarze tundry i bagien.

--4

CREATE TABLE tableB AS SELECT f_codedesc as liczba_budynkow FROM popp p,majrivers m 
WHERE Contains(Buffer(m.Geometry, 100000), p.Geometry);

SELECT * FROM tableB;

--5
CREATE TABLE airportsNew AS SELECT NAME, Geometry, ELEV FROM airports;

--5a
--zachód
SELECT NAME, Geometry FROM airportsNew ORDER BY MbrMinY(Geometry) asc limit 1;
--wschód
SELECT NAME, Geometry FROM airportsNew ORDER BY MbrMaxY(Geometry) desc limit 1;

--5b
INSERT INTO airportsNew VALUES ('airportB', (0.5*ST_Distance((SELECT Geometry FROM airportsNew WHERE NAME='NOATAK'),(SELECT Geometry FROM airportsNew WHERE NAME='NIKOLSKI AS') )),
(0.5*((SELECT ELEV FROM airportsNew WHERE NAME='NOATAK')+(SELECT ELEV FROM airportsNew WHERE NAME='NIKOLSKI AS'))) );

select * from airportsNew where NAME="airportB";


--6
SELECT Area(Buffer((ShortestLine(lakes.Geometry, airports.Geometry)),1000))
FROM lakes, airports WHERE lakes.NAMES='Iliamma Lake' AND airports.NAME='AMBLER';

--7
SELECT SUM(Area(Intersection(tundra.Geometry, trees.Geometry))) as "tundra", S
UM(Area(Intersection(swamp.Geometry, trees.Geometry))) AS "bagna", VEGDESC FROM swamp, trees, tundra GROUP BY  VEGDESC;




