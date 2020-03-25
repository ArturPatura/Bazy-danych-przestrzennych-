--ZAD2
--Dodaj do projektu nowy schemat o nazwie �sklep�
CREATE SCHEMA sklep;

--ZAD3
--Wewn�trz schematu �sklep� utw�rz dwie tabele produkty i producenci, dobieraj�c odpowiednie typy danych

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
--Zaprojektuj tabel� (pola oraz ich typy danych itd.) zam�wienia, kt�ra powi�zana b�dzie z tabelami 
--produkty i producenci. Pomy�l, jakie pola powinna zawiera� taka tabela, aby generowa� na jej
--podstawie raporty sprzeda�y.

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
--Wype�nij baz� dodaj�c 10 rekord�w do ka�dej tabeli.
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('�owicz', 'lowicz@gmail.com', '666456786');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('�ywiec', 'zywiec@gmail.com', '505908768');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Soko��w', 'sokolow@gmail.com', '882345764');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Vitanella', 'vitanella@gmail.com', '555223432');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Nestle', 'nestle@gmail.com', '989732444');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Ferrero', 'ferrero@gmail.com', '444566787');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Indykpol', 'indykpol@gmail.com', '324567908');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Bakalland', 'bakalland@gmail.com', '880980999');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Pi�tnica', 'piatnica@gmail.com', '452222546');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Prymat', 'prymat@gmail.com', '848999000');

INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Par�wki', 4, 7);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Jogurt naturalny', 1.50, 9);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Woda mineralna', 1.50, 5);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Piwo', 5, 2);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Czekoladki', 10, 6);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Bakalie', 7, 8);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Kie�basa', 8, 3);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Mleko', 1.99, 1);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Piperz zio�owy', 1.50, 10);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Serek wiejski', 2, 9);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('D�em', 3.99, 1);
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

-- ZAD11 Wykonaj nast�puj�ce zapytania:
--a) Wypisz liczb� oraz kwot� ca�kowit� zam�wie� wed�ug wzoru:
--Producent: <nazwa_producenta>, liczba_zamowien: <calkowita_liczba zamowionych_produktow>, wartosc_zamowienia: <liczba_sztuk*cena>
--b) Wyswietl raport zawierajacy podsumowanie wg wzoru:
	--Produkt: <nazwa_produktu>, liczba_zamowien: <calkowita_liczba_zamowien_produktu>
--c) Dokonaj z��czenia naturalnego tabel produkty i zam�wienia
--d) Je�eli nie uwzgl�dni�e� pola data w tabeli zam�wienia, to je dodaj. Wykorzystaj typ danych DATE.
--e) Poka� wszystkie zam�wienia z�o�one w styczniu.
--f) W jakich dniach tygodnia by�a najwy�sza sprzeda�?
--g) Jakie produkty zamawiane by�y najcz�ciej?

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

-- ZAD12 Wykonaj poni�sze polecenia:
--a)Dla ka�dego zam�wienia wy�wietl zdanie "Produkt xxxx, kt�rego producentem jest yyyy, zam�wiono zzzz razy", gdzie:
	-- - xxxx to nazwa produktu wypisana du�ymi literami
	-- - yyyy to nazwa producenta wypisana ma�ymi literami
	-- - zzzz to ca�kowita liczba zam�wie�. Otrzymanemu polu nadaj alias opis. Uszereguj zam�wienia wed�ug ich liczby, malej�co.
--b) Wypisz wszystkie zam�wienia z wy��czeniem trzech o najmniejszej warto�ci (cena*ilo�� sztuk)
--c) Utw�rz tabel� klienci, kt�ra zawiera� b�dzie identyfikator klienta, jego e-mail oraz numer telefonu
--d) Zmodyfikuj relacje, tak, aby uwzgl�dni� now� tabel�.
--e) Wypisz wszystkich klient�w, nazwy produkt�w, kt�re zam�wili, ilo�� sztuk, warto�� ca�kowit� ka�dego zam�wienia (nadaj mu alias warto��_zam�wienia)
--f) Wy�wietl klient�w, kt�rzy zam�wili najwi�cej i najmniej, dodaj�c przed ich danymi �NAJCZʌCIEJ ZAMAWIAJ�CY� i �NAJRZADZIEJ ZAMAWIAJ�CY�. Opr�cz tego do��cz ca�kowit� kwot� wszystkich ich zam�wie�.
--g) Sprawd� (odpowiednim zapytaniem), czy w tabeli produkty istniej� te, kt�re nie zosta�y ani razu zam�wione. Je�eli tak, usu� je.

-- a)

select concat('Produkt ', upper(sklep.produkty.nazwa_produktu), ', ktorego producentem jest ', lower(sklep.producenci.nazwa_producenta), ', zam�wiono ', sum(sklep.zamowienia.ilosc_produktu), ' razy.') 
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
--Wykonaj nast�puj�ce polecenia:
--a) Utw�rz tabel� numer, zawieraj�c� jedno pole liczba (czterocyfrowe)
--b) Utw�rz sekwencj� liczba_seq zaczynaj�c� si� od 100 maj�c� minimaln� warto�� 0, maksymalna 125, zwi�kszaj�c� si� co 5, posiadaj�c� cykl
--c) Wstaw 7 wierszy do tabeli numer u�ywaj�c sekwencji liczba_seq.
--d) Modyfikuj sekwencje tak by zwi�ksza�a warto�� o 6
--e) Sprawd� aktualn� i nast�pn� warto�� sekwencji
--f) Usu� powy�sz� sekwencj�

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
--Wykonaj nast�puj�ce polecenia:
--a) Napisz zapytanie wy�wietlaj�ce list� u�ytkownik�w bazy
--b) Utw�rz nowego u�ytkownika o nazwie SuperuserNrIndeksu, kt�ry b�dzie posiada� uprawnienia superu�ytkownika (superuser) oraz u�ytkownika, guestNumerIndeksu , kt�ry b�dzie mia� tylko uprawnienia przegl�dania bazy. Ponownie wy�wietl list� u�ytkownik�w.
--c) Zmie� nazw� u�ytkownika SuperuserNrIndeksu na student, odbieraj�c mu uprawnienia, ograniczaj�c je wy��cznie do przegl�dania. Usu� u�ytkownika guestNumerIndeksu
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
--Wykonaj nast�puj�ce polecenia:
--a) Zwi�ksz cen� ka�dego produktu o 10 z� u�ywaj�c transakcji.
--b) Rozpocznij now� transakcj�. Zwi�ksz cen� produku o id = 3 o 10%. Utw�rz punkt bezpiecze�stwa S1. 
	--Zwi�ksz zam�wienia wszystkich produkt�w o 25%. Utw�rz punkt bezpiecze�stwa S2. 
	--Usu� klienta, kt�ry zam�wi� najwi�cej. Wycofaj transakcj� do punktu S1. 
	--Spr�buj wycofa� transakcj� do punktu S2. Wycofaj ca�� transakcj�
--c) Napisz procedur� wbudowan�, zwracaj�c� procentowy udzia� producent�w poszczeg�lnych 
	--produkt�w w zam�wieniach. Np. ASUS � 34% wszystkich zam�wie�

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
