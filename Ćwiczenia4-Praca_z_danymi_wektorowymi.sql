--4. Wyznacz liczb� budynk�w (tabela: popp, atrybut: f_codedesc, reprezentowane, jako punkty) po�o�onych w odleg�o�ci mniejszej ni� 100000 m od g��wnych rzek. Budynki spe�niaj�ce to kryterium zapisz do osobnej tabeli tableB.
--5. Utw�rz tabel� o nazwie airportsNew. Z tabeli airports do zaimportuj nazwy lotnisk, ich geometri�, a tak�e atrybut elev, reprezentuj�cy wysoko�� n.p.m.
--a) Znajd� lotnisko, kt�re po�o�one jest najbardziej na zach�d i najbardziej na wsch�d.
--b) Do tabeli airportsNew dodaj nowy obiekt - lotnisko, kt�re po�o�one jest w po�owie drogi pomi�dzy lotniskami znalezionymi w punkcie a. Lotnisko nazwij airportB. Oblicz wysoko�� n.p.m., jako �redni� warto�� atrybut�w elev.
--Uwaga: geodezyjny uk�ad wsp�rz�dnych prostok�tnych p�askich (x � o� pionowa, y � o� pozioma)
--6. Wyznacz pole powierzchni obszaru, kt�ry oddalony jest mniej ni� 1000 jednostek od najkr�tszej linii ��cz�cej jezioro o nazwie �Iliamna Lake� i lotnisko o nazwie �AMBLER�.
--7. Napisz zapytanie, kt�re zwr�ci sumaryczne pole powierzchni poligon�w reprezentuj�cych poszczeg�lne typy drzew znajduj�cych si� na obszarze tundry i bagien.

--4

CREATE TABLE tableB AS SELECT f_codedesc as liczba_budynkow FROM popp p,majrivers m 
WHERE Contains(Buffer(m.Geometry, 100000), p.Geometry);

SELECT * FROM tableB;

--5
CREATE TABLE airportsNew AS SELECT NAME, Geometry, ELEV FROM airports;

--5a
--zach�d
SELECT NAME, Geometry FROM airportsNew ORDER BY MbrMinY(Geometry) asc limit 1;
--wsch�d
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




