CREATE DATABASE gis5;

CREATE EXTENSION postgis;

CREATE TABLE obiekty
(
	nazwa varchar(40),
	geometria geometry
);

--obiekt1
INSERT INTO obiekty(nazwa, geometria) 
VALUES ('obiekt1', ST_GeomFromText('COMPOUNDCURVE(LINESTRING(0 1, 1 1), CIRCULARSTRING(1 1, 2 0, 3 1), 
CIRCULARSTRING(3 1, 4 2, 5 1), LINESTRING(5 1, 6 1))', -1));

--obiekt2
INSERT INTO obiekty(nazwa, geometria) 
VALUES('obiekt2', ST_GeomFromText('CURVEPOLYGON(COMPOUNDCURVE(LINESTRING(10 6, 14 6), CIRCULARSTRING(14 6, 16 4, 14 2),
 CIRCULARSTRING(14 2, 12 0, 10 2), LINESTRING(10 2, 10 6)),CIRCULARSTRING(11 2, 12 1, 13 2, 12 3, 11 2))', -1));

--obiekt3
INSERT INTO obiekty VALUES('obiekt3', ST_GeomFromText('POLYGON((10 17, 7 15, 12 13, 10 17))',-1));

--obiekt4
INSERT INTO obiekty(nazwa, geometria) 
VALUES ('obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)', -1));

--obiekt5
INSERT INTO obiekty(nazwa, geometria) 
VALUES ('obiekt5', ST_GeomFromText('GEOMETRYCOLLECTION(MULTIPOINT(30 30 59 , 38 32 234))', -1));

--obiekt6
INSERT INTO obiekty(nazwa, geometria) 
VALUES ('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(POINT(4 2), LINESTRING(1 1, 3 2))', -1));


--ZADANIA

--1. Wyznacz pole powierzchni bufora o wielkoœci 5 jednostek, który zosta³ utworzony wokó³ najkrótszej linii ³¹cz¹cej obiekt 3 i 4.
--2. Zamieñ obiekt4 na poligon. Jaki warunek musi byæ spe³niony, aby mo¿na by³o wykonaæ to zadanie? Zapewnij te warunki.
--3. W tabeli obiekty, jako obiekt7 zapisz obiekt z³o¿ony z obiektu 3 i obiektu 4.
--4. Wyznacz pole powierzchni wszystkich buforów o wielkoœci 5 jednostek, które zosta³y utworzone wokó³ obiektów nie zawieraj¹cych ³uków.

--1
SELECT ST_Area(ST_Buffer(ST_ShortestLine(geometry1.geometria, geometry2.geometria), 5)) 
FROM obiekty geometry1, obiekty geometry2 WHERE geometry1.nazwa='obiekt3' AND geometry2.nazwa='obiekt4';

--2
UPDATE obiekty SET geometria = ST_MAKEPOLYGON(ST_AddPoint(geometria, ST_StartPoint(geometria))) WHERE nazwa = 'obiekt4';

--3
INSERT INTO obiekty 
VALUES ('obiekt7', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(10 17, 7 15),LINESTRING(7 15, 12 13),LINESTRING(12 13, 10 17),
								   LINESTRING(20 20, 25 25),LINESTRING(25 25, 27 24),LINESTRING(27 24, 25 22), LINESTRING(25 22, 26 21),
								   LINESTRING(26 21, 22 19),LINESTRING(22 19, 20.5 19.5))', -1));

--4
SELECT nazwa, ST_Area(ST_Buffer(geometria, 5)) FROM obiekty WHERE NOT ST_HasArc(geometria);