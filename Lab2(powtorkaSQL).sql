--ZAD2
--Dodaj do projektu nowy schemat o nazwie „sklep”
CREATE SCHEMA sklep;

--ZAD3
--Wewn¹trz schematu „sklep” utwórz dwie tabele produkty i producenci, dobieraj¹c odpowiednie typy danych

CREATE TABLE sklep.producenci (
    id_producenta serial  NOT NULL,
    nazwa_producenta varchar(50)  NOT NULL,
    mail varchar(50)  NOT NULL,
    telefon varchar(20)  NOT NULL,
    CONSTRAINT producenci_pk PRIMARY KEY (id_producenta)
);

CREATE TABLE sklep.produkty (
    id_produktu serial  NOT NULL,
    nazwa_produktu varchar(50)  NOT NULL,
    cena double precision NOT NULL,
    id_producenta int  NOT NULL,
    CONSTRAINT produkty_pk PRIMARY KEY (id_produktu)
);

ALTER TABLE sklep.produkty ADD CONSTRAINT produkty_producenci
    FOREIGN KEY (id_producenta)
    REFERENCES sklep.producenci (id_producenta)  
    on delete cascade
    on update cascade
;

--ZAD4 
--Zaprojektuj tabelê (pola oraz ich typy danych itd.) zamówienia, która powi¹zana bêdzie z tabelami 
--produkty i producenci. Pomyœl, jakie pola powinna zawieraæ taka tabela, aby generowaæ na jej
--podstawie raporty sprzeda¿y.

--produkty(id_produktu, nazwa_produktu, cena, id_producenta) 
--producenci(id_producenta, nazwa_producenta, mail, telefon)
--zamowienia(pole1 typ, pole2 typ, ...)

CREATE TABLE sklep.zamowienia (
    id_zamowienia serial  NOT NULL,
    ilosc_produktu int  NOT NULL,
    id_produktu int  NOT NULL,
    data_zamowienia date  NOT NULL,
    CONSTRAINT zamowienia_pk PRIMARY KEY (id_zamowienia)
);

ALTER TABLE sklep.zamowienia ADD CONSTRAINT zamowienia_produkty
    FOREIGN KEY (id_produktu)
    REFERENCES sklep.produkty (id_produktu)  
    on delete cascade
    on update cascade
;

--ZAD6
--Wype³nij bazê dodaj¹c 10 rekordów do ka¿dej tabeli.
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('£owicz', 'lowicz@gmail.com', '666456786');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('¯ywiec', 'zywiec@gmail.com', '505908768');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Soko³ów', 'sokolow@gmail.com', '882345764');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Vitanella', 'vitanella@gmail.com', '555223432');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Nestle', 'nestle@gmail.com', '989732444');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Ferrero', 'ferrero@gmail.com', '444566787');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Indykpol', 'indykpol@gmail.com', '324567908');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Bakalland', 'bakalland@gmail.com', '880980999');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Pi¹tnica', 'piatnica@gmail.com', '452222546');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Prymat', 'prymat@gmail.com', '848999000');

INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Parówki', 4, 7);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Jogurt naturalny', 1.50, 9);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Woda mineralna', 1.50, 5);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Piwo', 5, 2);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Czekoladki', 10, 6);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Bakalie', 7, 8);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Kie³basa', 8, 3);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Mleko', 1.99, 1);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Piperz zio³owy', 1.50, 10);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Serek wiejski', 2, 9);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('D¿em', 3.99, 1);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Curry', 1.50, 10);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Nutella', 8.99, 6);


INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(20, 5, '2020-03-24');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(15, 3, '2020-03-23');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(21, 6, '2020-03-20');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(4, 8, '2020-02-11');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(19, 7, '2020-03-03');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(23, 1, '2020-03-04');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(24, 10, '2020-03-01');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(9, 2, '2020-02-20');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(8, 9, '2020-02-22');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(19, 4, '2020-01-01');

-- ZAD11 Wykonaj nastêpuj¹ce zapytania:
--a) Wypisz liczbê oraz kwotê ca³kowit¹ zamówieñ wed³ug wzoru:
--Producent: <nazwa_producenta>, liczba_zamowien: <calkowita_liczba zamowionych_produktow>, wartosc_zamowienia: <liczba_sztuk*cena>
--b) Wyswietl raport zawierajacy podsumowanie wg wzoru:
	--Produkt: <nazwa_produktu>, liczba_zamowien: <calkowita_liczba_zamowien_produktu>
--c) Dokonaj z³¹czenia naturalnego tabel produkty i zamówienia
--d) Je¿eli nie uwzglêdni³eœ pola data w tabeli zamówienia, to je dodaj. Wykorzystaj typ danych DATE.
--e) Poka¿ wszystkie zamówienia z³o¿one w styczniu.
--f) W jakich dniach tygodnia by³a najwy¿sza sprzeda¿?
--g) Jakie produkty zamawiane by³y najczêœciej?

-- a)

select sklep.producenci.nazwa_producenta as "producent", sum(sklep.zamowienia.ilosc_produktu) as "liczba_zamowien", sum(sklep.zamowienia.ilosc_produktu * sklep.produkty.cena) 
as "wartosc_zamowienia" from sklep.zamowienia join sklep.produkty on sklep.produkty.id_produktu = sklep.zamowienia.id_produktu 
join sklep.producenci on sklep.producenci.id_producenta = sklep.produkty.id_producenta group by sklep.producenci.nazwa_producenta;

-- b)


select concat('Produkt: ', sklep.produkty.nazwa_produktu, ', liczba zamowien: ', sum(sklep.zamowienia.ilosc_produktu)) as "raport" 
from sklep.produkty join sklep.zamowienia on sklep.produkty.id_produktu = sklep.zamowienia.id_produktu group by sklep.produkty.nazwa_produktu;

-- c)

select z.id_zamowienia, pr.nazwa_produktu from sklep.zamowienia z natural join sklep.produkty pr;

-- e)

select * from sklep.zamowienia where data_zamowienia >= '2020-01-01' and data_zamowienia <= '2020-01-31';

-- f)



-- g)

select sklep.produkty.nazwa_produktu, sum(sklep.zamowienia.ilosc_produktu) as "Najczesciej zamawiane" from sklep.produkty join sklep.zamowienia
on sklep.zamowienia.id_produktu = sklep.produkty.id_produktu group by sklep.produkty.nazwa_produktu order by sum(sklep.zamowienia.ilosc_produktu) desc limit 4;

-- ZAD12 Wykonaj poni¿sze polecenia:
--a)Dla ka¿dego zamówienia wyœwietl zdanie "Produkt xxxx, którego producentem jest yyyy, zamówiono zzzz razy", gdzie:
	-- - xxxx to nazwa produktu wypisana du¿ymi literami
	-- - yyyy to nazwa producenta wypisana ma³ymi literami
	-- - zzzz to ca³kowita liczba zamówieñ. Otrzymanemu polu nadaj alias opis. Uszereguj zamówienia wed³ug ich liczby, malej¹co.
--b) Wypisz wszystkie zamówienia z wy³¹czeniem trzech o najmniejszej wartoœci (cena*iloœæ sztuk)
--c) Utwórz tabelê klienci, która zawieraæ bêdzie identyfikator klienta, jego e-mail oraz numer telefonu
--d) Zmodyfikuj relacje, tak, aby uwzglêdniæ now¹ tabelê.
--e) Wypisz wszystkich klientów, nazwy produktów, które zamówili, iloœæ sztuk, wartoœæ ca³kowit¹ ka¿dego zamówienia (nadaj mu alias wartoœæ_zamówienia)
--f) Wyœwietl klientów, którzy zamówili najwiêcej i najmniej, dodaj¹c przed ich danymi „NAJCZÊŒCIEJ ZAMAWIAJ¥CY” i „NAJRZADZIEJ ZAMAWIAJ¥CY”. Oprócz tego do³¹cz ca³kowit¹ kwotê wszystkich ich zamówieñ.
--g) SprawdŸ (odpowiednim zapytaniem), czy w tabeli produkty istniej¹ te, które nie zosta³y ani razu zamówione. Je¿eli tak, usuñ je.

-- a)

select concat('Produkt ', upper(sklep.produkty.nazwa_produktu), ', ktorego producentem jest ', lower(sklep.producenci.nazwa_producenta), ', zamówiono ', sum(sklep.zamowienia.ilosc_produktu), ' razy.') 
as "opis" from sklep.produkty join sklep.zamowienia on sklep.zamowienia.id_produktu = sklep.produkty.id_produktu join sklep.producenci  
on sklep.producenci.id_producenta = sklep.produkty.id_producenta group by sklep.producenci.nazwa_producenta, sklep.produkty.nazwa_produktu order by sum(sklep.zamowienia.ilosc_produktu) desc;

-- b)

select sklep.zamowienia.id_zamowienia, sklep.produkty.nazwa_produktu, sum(sklep.zamowienia.ilosc_produktu * sklep.produkty.cena) from sklep.zamowienia
natural join sklep.produkty group by sklep.zamowienia.id_zamowienia, sklep.produkty.nazwa_produktu
order by sum(sklep.zamowienia.ilosc_produktu * sklep.produkty.cena) desc limit (SELECT COUNT(*) FROM sklep.zamowienia) - 3;

-- c)

CREATE TABLE sklep.klienci (
    id_klienta serial  NOT NULL,
    mail varchar(50)  NOT NULL,
    telefon varchar(20)  NOT NULL,
    CONSTRAINT "sklep.klienci_pk" PRIMARY KEY (id_klienta)
);

INSERT INTO sklep.klienci (mail, telefon) VALUES('aaaaaaaaa@gmail.com', '666345657');
INSERT INTO sklep.klienci (mail, telefon) VALUES('bbbbbbbbb@gmail.com', '323444666');
INSERT INTO sklep.klienci (mail, telefon) VALUES('cccccccc@gmail.com', '909888777');
INSERT INTO sklep.klienci (mail, telefon) VALUES('dddddddd@gmail.com', '882456777');
INSERT INTO sklep.klienci (mail, telefon) VALUES('eeeeeeeee@gmail.com', '505205605');
INSERT INTO sklep.klienci (mail, telefon) VALUES('fffffffff@gmail.com', '606999787');
INSERT INTO sklep.klienci (mail, telefon) VALUES('ggggggggg@gmail.com', '510209766');
INSERT INTO sklep.klienci (mail, telefon) VALUES('hhhhhhhhh@gmail.com', '502640565');
INSERT INTO sklep.klienci (mail, telefon) VALUES('kkkkkkkkk@gmail.com', '696808787');
INSERT INTO sklep.klienci (mail, telefon) VALUES('mmmmmmmmm@gmail.com', '504123456');

-- d)

alter table sklep.zamowienia add id_klienta int;

ALTER TABLE sklep.zamowienia ADD CONSTRAINT zamowienia_klienci
    FOREIGN KEY (id_klienta)
    REFERENCES sklep.klienci (id_klienta)  
    on delete cascade
    on update CASCADE
;

UPDATE sklep.zamowienia SET id_klienta=1 WHERE id_zamowienia=3;
UPDATE sklep.zamowienia SET id_klienta=2 WHERE id_zamowienia=1;
UPDATE sklep.zamowienia SET id_klienta=3 WHERE id_zamowienia=5;
UPDATE sklep.zamowienia SET id_klienta=4 WHERE id_zamowienia=8;
UPDATE sklep.zamowienia SET id_klienta=5 WHERE id_zamowienia=2;
UPDATE sklep.zamowienia SET id_klienta=6 WHERE id_zamowienia=4;
UPDATE sklep.zamowienia SET id_klienta=7 WHERE id_zamowienia=10;
UPDATE sklep.zamowienia SET id_klienta=8 WHERE id_zamowienia=7;
UPDATE sklep.zamowienia SET id_klienta=9 WHERE id_zamowienia=6;
UPDATE sklep.zamowienia SET id_klienta=10 WHERE id_zamowienia=9;

-- e)

select sklep.klienci.id_klienta, sklep.klienci.mail, sklep.klienci.telefon, sklep.produkty.nazwa_produktu, sklep.zamowienia.ilosc_produktu, sum(sklep.zamowienia.ilosc_produktu * cena) 
as "wartosc_zamowienia" from sklep.zamowienia join sklep.klienci on sklep.klienci.id_klienta = sklep.zamowienia.id_klienta join sklep.produkty 
on sklep.produkty.id_produktu = sklep.zamowienia.id_produktu group by sklep.produkty.nazwa_produktu, sklep.klienci.id_klienta, sklep.zamowienia.ilosc_produktu;

-- f)



-- g)

--13
--Wykonaj nastêpuj¹ce polecenia:
--a) Utwórz tabelê numer, zawieraj¹c¹ jedno pole liczba (czterocyfrowe)
--b) Utwórz sekwencjê liczba_seq zaczynaj¹c¹ siê od 100 maj¹c¹ minimaln¹ wartoœæ 0, maksymalna 125, zwiêkszaj¹c¹ siê co 5, posiadaj¹c¹ cykl
--c) Wstaw 7 wierszy do tabeli numer u¿ywaj¹c sekwencji liczba_seq.
--d) Modyfikuj sekwencje tak by zwiêksza³a wartoœæ o 6
--e) SprawdŸ aktualn¹ i nastêpn¹ wartoœæ sekwencji
--f) Usuñ powy¿sz¹ sekwencjê

	--a
create table sklep.numer(
	liczba smallint not null
);

	--b
create sequence sklep.liczba_seq increment by 5 minvalue 0 maxvalue 125 start with 100 cycle;

	--c
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));

	--d
alter sequence sklep.liczba_seq increment by 6;

	--e
select currval('sklep.liczba_seq');
select nextval('sklep.liczba_seq');

	--f
drop sequence sklep.liczba_seq;

--14
--Wykonaj nastêpuj¹ce polecenia:
--a) Napisz zapytanie wyœwietlaj¹ce listê u¿ytkowników bazy
--b) Utwórz nowego u¿ytkownika o nazwie SuperuserNrIndeksu, który bêdzie posiada³ uprawnienia superu¿ytkownika (superuser) oraz u¿ytkownika, guestNumerIndeksu , który bêdzie mia³ tylko uprawnienia przegl¹dania bazy. Ponownie wyœwietl listê u¿ytkowników.
--c) Zmieñ nazwê u¿ytkownika SuperuserNrIndeksu na student, odbieraj¹c mu uprawnienia, ograniczaj¹c je wy³¹cznie do przegl¹dania. Usuñ u¿ytkownika guestNumerIndeksu
	--a
SELECT u.usename AS "Role name",
  	   CASE WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create database' AS pg_catalog.text)
       WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
       WHEN u.usecreatedb THEN CAST('create database' AS pg_catalog.text)
       ELSE CAST('' AS pg_catalog.text)
       END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;

	--b

create user Superuser299640;
ALTER ROLE superuser299640 SUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
GRANT  USAGE ON SCHEMA sklep TO Superuser299640;

create user guest299640;
ALTER ROLE guest299640 NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT  USAGE ON SCHEMA sklep TO guest299640;
GRANT SELECT on all tables in schema "sklep" TO guest299640;

	--c

ALTER USER superuser299640 RENAME TO student;
ALTER ROLE student NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT SELECT on all tables in schema "sklep" TO student;

revoke ALL on all tables in schema "sklep" FROM guest299640;
drop USER guest299640;

-- ZAD15
--Wykonaj nastêpuj¹ce polecenia:
--a) Zwiêksz cenê ka¿dego produktu o 10 z³ u¿ywaj¹c transakcji.
--b) Rozpocznij now¹ transakcjê. Zwiêksz cenê produku o id = 3 o 10%. Utwórz punkt bezpieczeñstwa S1. 
	--Zwiêksz zamówienia wszystkich produktów o 25%. Utwórz punkt bezpieczeñstwa S2. 
	--Usuñ klienta, który zamówi³ najwiêcej. Wycofaj transakcjê do punktu S1. 
	--Spróbuj wycofaæ transakcjê do punktu S2. Wycofaj ca³¹ transakcjê
--c) Napisz procedurê wbudowan¹, zwracaj¹c¹ procentowy udzia³ producentów poszczególnych 
	--produktów w zamówieniach. Np. ASUS – 34% wszystkich zamówieñ

	-- a)

start transaction;
update sklep.produkty set cena = cena +10; 
end transaction;

	-- b)

start transaction;
update sklep.produkty set cena = (cena + 0.1*cena) where sklep.produkty.id_produktu = 3; 
savepoint S1;
update sklep.zamowienia set ilosc_produktu = (ilosc_produktu + 0.25 * ilosc_produktu);
savepoint S2;
delete from sklep.klienci where id_klienta = 5;
rollback to savepoint S1;
rollback to savepoint S2;
end transaction;
