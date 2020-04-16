CREATE DATABASE myspatialdb;

CREATE EXTENSION postgis; 

CREATE TABLE budynki(
	id_budynku serial PRIMARY KEY,
	geometria geometry,
	nazwa varchar(20),
	wysoko�� int
);

CREATE TABLE drogi(
	id_drogi serial PRIMARY KEY,
	geometria geometry,
	nazwa varchar(20)
);

CREATE TABLE pktinfo(
	id_punktu serial PRIMARY KEY,
	geometria geometry,
	nazwa varchar(20),
	liczprac int
);	

INSERT INTO budynki (geometria, nazwa, wysoko��) VALUES ( ST_GeomFromText('Polygon((8 1.5, 10.5 1.5, 10.5 4, 8 4 , 8 1.5))', -1), 'BuildingA', 25);
INSERT INTO budynki (geometria, nazwa, wysoko��) VALUES ( ST_GeomFromText('Polygon((4 5, 6 5, 6 7, 4 7, 4 5))', -1), 'BuildingB', 10);
INSERT INTO budynki (geometria, nazwa, wysoko��) VALUES ( ST_GeomFromText('Polygon((3 6, 5 6, 5 9, 3 8, 3 6))', -1), 'BuildingC', 21);
INSERT INTO budynki (geometria, nazwa, wysoko��) VALUES ( ST_GeomFromText('Polygon((9 8, 10 8, 10 9, 9 9, 9 8))', -1), 'BuildingD', 9);
INSERT INTO budynki (geometria, nazwa, wysoko��) VALUES ( ST_GeomFromText('Polygon((1 1, 2 1, 2 2, 1 2, 1 1))', -1), 'BuildingF', 7);


INSERT INTO drogi (geometria, nazwa) VALUES ( ST_GeomFromText('LineString(0 4.5, 12 4.5)', -1), 'RoadX');
INSERT INTO drogi (geometria, nazwa) VALUES ( ST_GeomFromText('LineString(7.5 0, 7.5 10.5)', -1), 'RoadY');


INSERT INTO pktinfo (geometria, nazwa, liczprac) VALUES (ST_GeomFromText('Point(1 3.5)', -1), 'G', 8);
INSERT INTO pktinfo (geometria, nazwa, liczprac) VALUES (ST_GeomFromText('Point(5.5 1.5)', -1), 'H', 9);
INSERT INTO pktinfo (geometria, nazwa, liczprac) VALUES (ST_GeomFromText('Point(9.5 6)', -1), 'I', 6);
INSERT INTO pktinfo (geometria, nazwa, liczprac) VALUES (ST_GeomFromText('Point(6.5 6)', -1), 'J', 5);
INSERT INTO pktinfo (geometria, nazwa, liczprac) VALUES (ST_GeomFromText('Point(6 9.5)', -1), 'K', 2);



SELECT * FROM budynki;
SELECT * FROM drogi;
SELECT * FROM pktinfo;

--1. Wyznacz ca�kowit� d�ugo�� dr�g w analizowanym mie�cie.
--2. Wypisz geometri� (WKT), pole powierzchni oraz obw�d poligonu reprezentuj�cego BuildingA.
--3. Wypisz nazwy i pola powierzchni wszystkich poligon�w w warstwie budynki. Wyniki posortuj alfabetycznie.
--4. Wypisz nazwy i obwody 2 budynk�w o najwi�kszej powierzchni.
--5. Wyznacz najkr�tsz� odleg�o�� mi�dzy budynkiem BuildingC a punktem G.
--6. Wypisz pole powierzchni tej cz�ci budynku BuildingC, kt�ra znajduje si� w odleg�o�ci wi�kszej ni� 0.5 od budynku BuildingB.
--7. Wybierz te budynki, kt�rych centroid (ST_Centroid) znajduje si� powy�ej drogi RoadX.
--8. Oblicz pole powierzchni tych cz�ci budynku BuildingC i poligonu o wsp�rz�dnych (4 7, 6 7, 6 8, 4 8, 4 7), kt�re nie s� wsp�lne dla tych dw�ch obiekt�w.

--1)
select sum(ST_Length(geometria)) as "Ca�kowita d�ugo�� dr�g" from drogi;


--2) 
select geometria as "Geometria", ST_Area(geometria) as "Pole powierzchni", ST_Perimeter(geometria) as "Obw�d" from budynki where nazwa = 'BuildingA';


--3)
select nazwa, ST_Area(geometria) as "Pole powierzchni" from budynki order by nazwa;


--4) 
select nazwa, ST_Perimeter(geometria) as "Obw�d" from budynki order by ST_Area(geometria) desc limit 2;


--5)
select ST_Distance(budynki.geometria, pktinfo.geometria) as "Najkr�tszy dystans" from budynki, pktinfo where budynki.nazwa = 'BuildingC' and pktinfo.nazwa = 'G';


--7)  
select budynki.nazwa from budynki, drogi where ST_Y(ST_Centroid(budynki.geometria))>ST_Y(ST_Centroid(drogi.geometria)) and drogi.nazwa = 'RoadX';


--8)
select ST_Area(ST_SymDifference(budynki.geometria, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', -1))) as "Pole" from budynki where nazwa = 'BuildingC';


