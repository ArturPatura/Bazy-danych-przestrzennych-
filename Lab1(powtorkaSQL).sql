-- ZAD1
--Utwórz nową bazę danych

create database s299640;

-- ZAD2
--Dodaj schemat o nazwie firma
CREATE SCHEMA firma;

-- ZAD3
--Stwórz rolę o nazwie księgowość i nadaj jej uprawnienia tylko do odczytu
CREATE ROLE ksiegowosc;

GRANT SELECT on all tables in SCHEMA "firma" TO ksiegowosc;

-- ZAD4
--Dodaj cztery tabele:
--pracownicy (id_pracownika, imie, nazwisko, adres, telefon) godziny(id_godziny, data, liczba_godzin , id_pracownika)
--pensja_stanowisko(id_pensji, stanowisko, kwota)
--premia(id_premii, rodzaj, kwota)
--wynagrodzenie(id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
--wykonując następujące działania:
--a) Ustal typy danych tak, aby przetwarzanie i składowanie danych było najbardziej optymalne. Zastanów się, które pola muszą przyjmować wartość NOT NULL.
--b) Ustaw klucz główny dla każdej tabeli – użyj polecenia ALTER TABLE
--c) Zastanów się jakie relacje zachodzą pomiędzy tabelami, a następnie dodaj klucze obce tam, gdzie występują
--d) Załóż indeks tam, gdzie uznasz, iż jest on potrzebny. Indeksowanie metodą B-drzewa. Wybierz odpowiednią kolumnę!
--e) Ustaw opisy/komentarze każdej tabeli – użyj polecenia COMMENT
--f) Ustal więzy integralności tak, aby po usunięciu, czy modyfikacji nie wyzwalano żadnej akcji

CREATE TABLE firma.pracownicy (

    id_pracownika SERIAL,
    imie varchar(20)  NOT NULL,
    nazwisko varchar(40)  NOT NULL,
    adres varchar(60)  NOT NULL,
    telefon varchar(20)  NOT NULL,
    CONSTRAINT pracownicy_pk PRIMARY KEY (id_pracownika)
);


CREATE INDEX id_index ON firma.pracownicy (nazwisko);

CREATE TABLE firma.godziny (

    id_godziny SERIAL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL,
    CONSTRAINT godziny_pk PRIMARY KEY (id_godziny)
);

ALTER TABLE firma.godziny ADD CONSTRAINT godziny_pracownicy
    FOREIGN KEY (id_pracownika)
    REFERENCES firma.pracownicy (id_pracownika)  
    ON DELETE CASCADE
    on update CASCADE
;

CREATE TABLE firma.pensja_stanowisko (
    id_pensji serial  NOT NULL,
    stanowisko varchar(30)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT pensja_stanowisko_pk PRIMARY KEY (id_pensji)
);

CREATE TABLE firma.premia (
    id_premii serial  NOT NULL,
    rodzaj varchar(30)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT premia_pk PRIMARY KEY (id_premii)
);

CREATE TABLE firma.wynagrodzenie (
    id_wynagrodzenia serial  NOT NULL,
    data date  NOT NULL,
    id_pracownika int  NOT NULL,
    id_godziny int  NOT NULL,
    id_pensji int  NOT NULL,
    id_premii int  NOT NULL,
    CONSTRAINT wynagrodzenie_pk PRIMARY KEY (id_wynagrodzenia)
);

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_godziny
    FOREIGN KEY (id_godziny)
    REFERENCES firma.godziny (id_godziny)  
    ON DELETE cascade
	on update cascade 
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pensja_stanowisko
    FOREIGN KEY (id_pensji)
    REFERENCES firma.pensja_stanowisko (id_pensji)  
    ON DELETE cascade
	on update cascade 
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pracownicy
    FOREIGN KEY (id_pracownika)
    REFERENCES firma.pracownicy (id_pracownika)  
    ON DELETE cascade
   on update cascade 
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_premia
    FOREIGN KEY (id_premii)
    REFERENCES firma.premia (id_premii)  
    on delete cascade
 	on update cascade
;

COMMENT ON TABLE firma.godziny IS 'liczba przepracowanych godzin'

COMMENT ON TABLE firma.pensja_stanowisko IS 'podstawowa pensja'

COMMENT ON TABLE firma.pracownicy IS 'informacje o pracownikach'

COMMENT ON TABLE firma.premia IS 'informacje o premii'

COMMENT ON TABLE firma.wynagrodzenie IS 'informacje o końcowym wynagrodzeniu'
;

-- ZAD5
--Wypełnij tabele treścią wg poniższego wzoru (każda tabela ma zawierać min. 10 rekordów).
--a) W tabeli godziny, dodaj pola przechowujące informacje o miesiącu oraz numerze tygodnia danego roku (rok ma 53 tygodnie). Oba mają być typu DATE.
--b) W tabeli wynagrodzenie zamień pole data na typ tekstowy.
--c) Pole ‘rodzaj’ w tabeli premia ma przyjmować także wartość ‘brak’. Wtedy kwota premii równa się zero.

	--a 
ALTER TABLE firma.godziny ADD miesiac int4 NOT NULL;
ALTER TABLE firma.godziny ADD tydzien int4 NOT NULL;

	--b
ALTER TABLE firma.wynagrodzenie ALTER COLUMN "data" TYPE varchar(20) USING "data"::varchar;

	--c
ALTER TABLE firma.premia ALTER COLUMN rodzaj DROP NOT NULL;
ALTER TABLE firma.wynagrodzenie ALTER COLUMN id_premii DROP NOT NULL;

INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Oskar', 'Padrak', 'Skośna 48, 31-425 Krakow', '666324654');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Franciszek', 'Maurer', 'Królewska45, 30-716 Krakow', '502345678');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Waldemar', 'Morawiec', 'Wysoka 98, 31-466 Krakow', '690879880');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Janusz', 'Kaptur', 'Pamiętliwa 9, 30-134 Krakow', '882345124');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Miłosz', 'Czesław', 'Niska 4, 30-698 Krakow', '590876234');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Konrad', 'Gilewicz', 'Plemienna 102, 30-050 Krakow', '555908234');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Katarzyna', 'Nowaczyk', 'Kotarbińskiego 9, 30-837 Krakow', '902313567');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Magdalena', 'Kowalczyk', 'Gołębia 1, 31-422 Krakow', '620908368');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Patrycja', 'Dawidowicz', 'Korzenna 99, 30-498 Krakow', '880990770');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Leon', 'Ziemba', 'Dzieci Polskich 19, 30-426 Krakow', '505405305');

INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-20', 108, 1, extract(month from DATE '2020-03-20'), extract(week from DATE '2020-03-20'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-18', 130, 2, extract(month from DATE '2020-03-18'), extract(week from DATE '2020-03-18'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-22', 183, 7, extract(month from DATE '2020-03-22'), extract(week from DATE '2020-03-22'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-21', 170, 3, extract(month from DATE '2020-03-21'), extract(week from DATE '2020-03-21'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-19', 152, 10, extract(month from DATE '2020-03-19'), extract(week from DATE '2020-03-19'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-20', 169, 9, extract(month from DATE '2020-03-20'), extract(week from DATE '2020-03-20'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-20', 124, 4, extract(month from DATE '2020-03-20'), extract(week from DATE '2020-03-20'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-23', 153, 5, extract(month from DATE '2020-03-23'), extract(week from DATE '2020-03-23'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-24', 140, 8, extract(month from DATE '2020-03-24'), extract(week from DATE '2020-03-24'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-03-18', 166, 6, extract(month from DATE '2020-03-18'), extract(week from DATE '2020-03-18'));

INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Junior Developer', 3500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Administrator IT', 4000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Team Lider', 4500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Administrator baz danych', 4600);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Senior Developer', 6000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Asystent kierownika', 6500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Kierownik', 7000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Dyrektor', 8000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Prezes', 9000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Szef', 9500);

INSERT INTO firma.premia (rodzaj, kwota) VALUES('uznaniowa', 200);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('frekwencyjna', 300);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('za nadgodziny', 400);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('roczna', 500);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('kwartalna', 250);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('miesięczna', 100);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('motywacyjna', 150);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('za innowacyjny pomysł', 200);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('za pracę w trudnych warunkach', 150);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('za pracę w święta', 200);

INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 1, 7, 2, 4);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 2, 6, 8, 7);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 7, 2, 1, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 3, 1, 4, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 10, 10, 3, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 9, 4, 7, 6);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 4, 5, 5, 3);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 5, 3, 9, 5);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 8, 8, 6, 3);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-22', 6, 9, 10, 6);


--ZAD6
--Wykonaj następujące zapytania:
--a) Wyświetl tylko id pracownika oraz jego nazwisko
--b) Wyświetl id pracowników, których płaca jest większa niż 1000
--c) Wyświetl id pracowników nie posiadających premii, których płaca jest większa niż 2000
--d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’
--e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’
--f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie.
--g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000
--h) Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii

	--a
SELECT id_pracownika, nazwisko FROM firma.pracownicy;

	--b
select w.id_pracownika, pen.kwota, pre.kwota from firma.wynagrodzenie w join firma.pensja_stanowisko pen on pen.id_pensji = w.id_pensji 
join firma.premia pre on pre.id_premii = w.id_premii where pre.kwota+pen.kwota >1000;

	--c
select w.id_pracownika, pen.kwota, pre.kwota from firma.wynagrodzenie w join firma.pensja_stanowisko pen on pen.id_pensji = w.id_pensji 
join firma.premia pre on pre.id_premii = w.id_premii where pre.kwota=0 and pen.kwota> 2000;

	--d
select imie from firma.pracownicy where imie like 'J%';

	--e
select * from firma.pracownicy where nazwisko like '%n%' or nazwisko like '%N%' and imie like '%a';

	--f
select firma.pracownicy.imie, firma.pracownicy.nazwisko , case when firma.godziny.liczba_godzin<160 
then 0 else firma.godziny.liczba_godzin-160 end as "nadgodziny" from firma.pracownicy 
join firma.godziny on firma.pracownicy.id_pracownika = firma.godziny.id_pracownika;

	--g
select firma.pracownicy.imie, firma.pracownicy.nazwisko from firma.pracownicy 
join firma.wynagrodzenie  on firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika 
join firma.pensja_stanowisko  on firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
where firma.pensja_stanowisko.kwota >= 1500 and firma.pensja_stanowisko.kwota <= 3000;

	--h
select firma.pracownicy.imie, firma.pracownicy.nazwisko from firma.pracownicy join firma.godziny
on firma.pracownicy.id_pracownika = firma.godziny.id_pracownika join firma.wynagrodzenie
on firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika join firma.premia 
on firma.wynagrodzenie.id_premii = firma.premia.id_premii where firma.premia.kwota = 0 
and firma.godziny.liczba_godzin > 160;


--ZAD 7 
--Wykonaj poniższe polecenia:
--a) Uszereguj pracowników według pensji
--b) Uszereguj pracowników według pensji i premii malejąco
--c) Zlicz i pogrupuj pracowników według pola ‘stanowisko’
--d) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne)
--e) Policz sumę wszystkich wynagrodzeń
--f) Policz sumę wynagrodzeń w ramach danego stanowiska
--g) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska
--h) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł

	--a 
select pr.*, pen.kwota from firma.pracownicy pr join firma.wynagrodzenie w 
on pr.id_pracownika = w.id_pracownika join firma.pensja_stanowisko pen 
on pen.id_pensji = w.id_pensji order by pen.kwota;

	--b
select firma.pracownicy.*, firma.pensja_stanowisko.kwota+firma.premia.kwota as "wyplata" from firma.pracownicy
join firma.wynagrodzenie on firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika 
join firma.pensja_stanowisko  on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji 
join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii 
order by firma.pensja_stanowisko.kwota+firma.premia.kwota desc;

	--c
select firma.pensja_stanowisko.stanowisko, count(firma.pensja_stanowisko.stanowisko) 
from firma.pensja_stanowisko join firma.wynagrodzenie
on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji join firma.pracownicy 
on firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika group by firma.pensja_stanowisko.stanowisko;


	--d
select firma.pensja_stanowisko.stanowisko, avg(firma.pensja_stanowisko.kwota+firma.premia.kwota), 
min(firma.pensja_stanowisko.kwota+firma.premia.kwota), max(firma.pensja_stanowisko.kwota+firma.premia.kwota) 
from firma.pensja_stanowisko join firma.wynagrodzenie on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji 
join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii
where firma.pensja_stanowisko.stanowisko = 'Prezes' group by firma.pensja_stanowisko.stanowisko;


	--e
select sum(firma.pensja_stanowisko.kwota+ firma.premia.kwota) as "Suma wynagrodzeń" 
from firma.wynagrodzenie join firma.pensja_stanowisko on firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
join firma.premia on firma.wynagrodzenie.id_premii = firma.premia.id_premii;

	--f
select firma.pensja_stanowisko.stanowisko, sum(firma.pensja_stanowisko.kwota+firma.premia.kwota) 
as "Suma wynagrodzeń" from firma.wynagrodzenie join firma.pensja_stanowisko on firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji 
join firma.premia on firma.wynagrodzenie.id_premii = firma.premia.id_premii group by firma.pensja_stanowisko.stanowisko;

	--g
select firma.pensja_stanowisko.stanowisko, count(firma.premia.kwota>0) as "liczba premii" 
from firma.pensja_stanowisko join firma.wynagrodzenie on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii where firma.premia.kwota > 0 group by firma.pensja_stanowisko.stanowisko;

	--h
delete from firma.pracownicy using firma.wynagrodzenie, firma.pensja_stanowisko 
where firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika
and firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji and firma.pensja_stanowisko.kwota < 1200;

--ZAD8
--Wykonaj poniższe polecenia:
--a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodając do niego kierunkowy dla Polski w nawiasie (+48)
--b) Zmodyfikuj kolumnę telefon w tabeli pracownicy tak, aby numer oddzielony był myślnikami wg wzoru: ‘555-222-333’
--c) Wyświetl dane pracownika, którego nazwisko jest najdłuższe, używając wielkich liter
--d) Wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5

--a

UPDATE firma.pracownicy SET telefon=CONCAT('(+48) ', telefon);

--b

UPDATE firma.pracownicy SET telefon=CONCAT(SUBSTRING(telefon, 1, 9), '-', SUBSTRING(telefon, 10, 3), '-', SUBSTRING(telefon, 13, 3));

--c 
select imie, upper(nazwisko) as "nazwisko", adres, telefon from firma.pracownicy where length(nazwisko) = (select max(length(nazwisko)) from firma.pracownicy);

--d
select md5(firma.pracownicy.imie) as "imie", md5(firma.pracownicy.nazwisko) as "nazwisko", md5(firma.pracownicy.adres) 
as "adres", md5(firma.pracownicy.telefon) as "telefon", md5(cast(firma.pensja_stanowisko.kwota as varchar(20))) as "pensja" from firma.pracownicy 
join firma.wynagrodzenie on firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika join firma.pensja_stanowisko on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji;

--ZAD 9 Raport końcowy
select concat('Pracownik ', firma.pracownicy.imie, ' ', firma.pracownicy.nazwisko, ', w dniu ', firma.wynagrodzenie."data", ' otrzymał pensję całkowitą na kwotę ',
firma.pensja_stanowisko.kwota + firma.premia.kwota,'zł, gdzie wynagrodzenie zasadnicze wynosiło: ', firma.pensja_stanowisko.kwota, 'zł, premia: ', 
firma.premia.kwota, 'zł.') as "raport" from firma.pracownicy join firma.wynagrodzenie on firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika 
join firma.pensja_stanowisko on firma.pensja_stanowisko .id_pensji = firma.wynagrodzenie.id_pensji join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii;








