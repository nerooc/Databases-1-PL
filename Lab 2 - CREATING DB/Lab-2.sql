-- SQL GENERATED BY POWER ARCHITECT

CREATE SEQUENCE public.wykladowca_id_wykladowca_seq;

CREATE TABLE public.Wykladowca (
                id_wykladowca INTEGER NOT NULL DEFAULT nextval('public.wykladowca_id_wykladowca_seq'),
                nazwisko VARCHAR(30) NOT NULL,
                imie VARCHAR(30) NOT NULL,
                CONSTRAINT wykladowca_pk PRIMARY KEY (id_wykladowca)
);


ALTER SEQUENCE public.wykladowca_id_wykladowca_seq OWNED BY public.Wykladowca.id_wykladowca;

CREATE TABLE public.Kurs_opis (
                id_kurs INTEGER NOT NULL,
                opis VARCHAR(30) NOT NULL,
                CONSTRAINT kurs_opis_pk PRIMARY KEY (id_kurs)
);


CREATE TABLE public.Kurs (
                id_grupa INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_kurs_nazwa INTEGER NOT NULL,
                termin VARCHAR(30) NOT NULL,
                CONSTRAINT kurs_pk PRIMARY KEY (id_grupa, id_kurs)
);


CREATE TABLE public.wykl_kurs (
                id_wykl INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                CONSTRAINT wykl_kurs_pk PRIMARY KEY (id_wykl, id_grupa, id_kurs)
);


CREATE SEQUENCE public.uczestnik_id_uczestnik_seq;

CREATE TABLE public.Uczestnik (
                id_uczestnik INTEGER NOT NULL DEFAULT nextval('public.uczestnik_id_uczestnik_seq'),
                imie VARCHAR(30) NOT NULL,
                nazwisko VARCHAR(30) NOT NULL,
                CONSTRAINT uczestnik_pk PRIMARY KEY (id_uczestnik)
);


ALTER SEQUENCE public.uczestnik_id_uczestnik_seq OWNED BY public.Uczestnik.id_uczestnik;

CREATE TABLE public.uczest_kurs (
                id_uczestnik INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                CONSTRAINT uczest_kurs_pk PRIMARY KEY (id_uczestnik, id_grupa, id_kurs)
);


ALTER TABLE public.wykl_kurs ADD CONSTRAINT wykladowca_wykl_kurs_fk
FOREIGN KEY (id_wykl)
REFERENCES public.Wykladowca (id_wykladowca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs)
REFERENCES public.Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_grupa, id_kurs)
REFERENCES public.Kurs (id_grupa, id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.uczest_kurs ADD CONSTRAINT kurs_uczest_kurs_fk
FOREIGN KEY (id_grupa, id_kurs)
REFERENCES public.Kurs (id_grupa, id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.uczest_kurs ADD CONSTRAINT uczestnik_uczest_kurs_fk
FOREIGN KEY (id_uczestnik)
REFERENCES public.Uczestnik (id_uczestnik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- QUERIES added in SQL Manager for PostgreSQL

insert into uczestnik ( id_uczestnik, nazwisko, imie ) values 
( 1, 'Flisikowski', 'Jan'),
( 2, 'Olech', 'Andrzej'       ),
( 3, 'Plochocki', 'Piotr'    ),
( 4, 'Stachyra', 'Krzysztof' ),
( 5, 'Sztuka', 'Stanislaw'   ),
( 6, 'Sosin', 'Tomasz'       ),
( 7, 'Glowala', 'Pawel'      ),
( 8, 'Straszewski', 'Jozef'  ),
( 9, 'Dwojak', 'Marcin'      ),
(10, 'Kotulski', 'Marek'    ),
(11, 'Laski', 'Michal'       ),
(12, 'Iwanowicz', 'Grzegorz' ),
(13, 'Barnas', 'Jerzy'       ),
(14, 'Stachera', 'Tadeusz'   ),
(15, 'Gzik', 'Adam'          ),
(16, 'Calus', '�ukasz'       ),
(17, 'Kolodziejek', 'Zbigniew'),
(18, 'Bukowiecki', 'Ryszard' ),
(19, 'Sielicki', 'Dariusz'   ),
(20, 'Radziszewski', 'Henryk'),
(21, 'Szczezniak', 'Mariusz' ),
(22, 'Nawara', 'Kazimierz'   ),
(23, 'Koski', 'Wojciech'     ),
(24, 'Rafalski', 'Robert'    ),
(25, 'Holownia', 'Mateusz'   ),
(26, 'Niedzialek', 'Marian'  ),
(27, 'Matuszczak', 'Rafa�'   ),
(28, 'Wolf', 'Jacek'         ),
(29, 'Kolczynski', 'Janusz'  ),
(30, 'Chrobok', 'Miroslaw'   )  ;
--
-- inserting data - table kurs_opis
insert into kurs_opis ( id_kurs, opis ) values
( 1, 'Jezyk angielski, stopien 1'),
( 2, 'Jezyk angielski, stopien 2'),
( 3, 'Jezyk angielski, stopien 3'), 
( 4, 'Jezyk angielski, stopien 4'),
( 5, 'Jezyk angielski, stopien 5'),
( 6, 'Jezyk niemiecki, stopien 1'),
( 7, 'Jezyk niemiecki, stopien 2'),
( 8, 'Jezyk niemiecki, stopien 3'),
( 9, 'Jezyk niemiecki, stopien 4'),
(10, 'Jezyk hiszpa�ski, stopien 1'),
(11, 'Jezyk hiszpa�ski, stopien 2'),
(12, 'Jezyk hiszpa�ski, stopien 3') ;
--
-- inserting data - table wykladowca
insert into wykladowca ( id_wykladowca, imie, nazwisko ) values 
( 1, 'Marcin','Szymczak'),
( 2, 'Joanna','Baranowska'),
( 3, 'Maciej','Szczepanski'),
( 4, 'Czeslaw','Wrobel'),
( 5, 'Grazyna','Gorska'),
( 6, 'Wanda','Krawczyk'),
( 7, 'Renata','Urbanska'),
( 8, 'Wieslawa','Tomaszewska'),
( 9, 'Bozena','Baranowska'),
(10, 'Ewelina','Malinowska'),
(11, 'Anna','Krajewska'),
(12, 'Mieczyslaw','Zajac'),
(13, 'Wieslaw','Przybylski'),
(14, 'Dorota','Tomaszewska'),
(15, 'Jerzy','Wroblewski') ;
--
-- inserting data - table kurs
insert into kurs ( id_kurs, id_grupa, id_kurs_nazwa, termin ) values
( 1, 1, 1, '1.01.2017-31.03.2017'),
( 2, 2, 1, '1.01.2017-31.03.2017'),
( 3, 1, 2, '1.04.2017-30.06.2017'),
( 4, 1, 3, '1.08.2017-10.10.2017'),
( 5, 1, 4, '1.11.2017-23.12.2017'),
( 6, 1, 6, '1.01.2017-31.03.2017'),
( 7, 2, 6, '1.01.2017-31.03.2017'),
( 8, 1, 7, '1.04.2017-30.06.2017'),
( 9, 1, 8, '1.07.2017-31.07.2017'),
(10, 1, 10, '1.02.2017-31.05.2017'),
(11, 1, 11, '1.09.2017-30.11.2017') ; 
--
-- inserting data - table wykl_kurs
insert into wykl_kurs ( id_kurs, id_grupa, id_wykl ) values
( 1, 1, 1 ),
( 2, 2, 2 ),
( 3, 1, 1 ),
( 4, 1, 1 ),
( 5, 1, 3 ),
( 6, 1, 4 ),
( 7, 2, 5 ),
( 8, 1, 4 ),
( 9, 1, 4 ),
(10, 1, 11 ),
(11, 1, 11 ) ; 
--
-- inserting data - table uczest_kurs 
insert into uczest_kurs ( id_kurs, id_grupa, id_uczestnik ) values
-- kurs 1 - angielski 1 gr 1
( 1, 1,  1 ),
( 1, 1,  3 ),
( 1, 1,  5 ),
( 1, 1,  7 ),
( 1, 1,  8 ),
( 1, 1, 10 ),
( 1, 1, 11 ),
( 1, 1, 12 ),
-- kurs 2 - angielski 1 gr 2
( 2, 2,  2 ),
( 2, 2, 16 ),
( 2, 2, 17 ),
( 2, 2, 18 ),
( 2, 2, 20 ),
-- kurs 3 - angielski 2 gr 1
( 3, 1,  1 ),
( 3, 1,  2 ),
( 3, 1,  3 ),
( 3, 1,  5 ),
( 3, 1,  7 ),
( 3, 1, 17 ),
( 3, 1, 18 ),
( 3, 1, 20 ),
-- kurs 4 - angielski 3 gr 1
( 4, 1,  1 ),
( 4, 1,  2 ),
( 4, 1,  3 ),
( 4, 1,  5 ),
( 4, 1, 21 ),
( 4, 1, 22 ),
( 4, 1, 25 ),
-- kurs 5 - angielski 4 gr 1
( 5, 1,  1 ),
( 5, 1,  2 ),
( 5, 1,  3 ),
( 5, 1,  5 ),
( 5, 1, 21 ),
( 5, 1, 22 ),
-- kurs 6 - niemiecki 1 gr 1
( 6, 1,  8 ),
( 6, 1,  9 ),
( 6, 1, 13 ),
( 6, 1, 15 ),
( 6, 1, 19 ),
( 6, 1, 24 ),
( 6, 1, 27 ),
-- kurs 7 - niemiecki 1 gr 2
( 7, 2, 11 ),
( 7, 2, 17 ),
( 7, 2, 18 ),
( 7, 2, 23 ),
( 7, 2, 25 ),
( 7, 2, 28 ),
( 7, 2, 30 ),
-- kurs 8 - niemiecki 2 gr 1
( 8, 1,  8 ),
( 8, 1,  9 ),
( 8, 1, 13 ),
( 8, 1, 15 ),
( 8, 1, 19 ),
( 8, 1, 24 ),
( 8, 1, 27 ),
-- kurs 9 - niemiecki 3 gr 1
( 9, 1,  8 ),
( 9, 1,  9 ),
( 9, 1, 13 ),
( 9, 1, 24 ),
( 9, 1, 27 ),
-- kurs 10 - hiszpanski 1 gr 1
(10, 1,  6 ),
(10, 1, 16 ),
(10, 1, 18 ),
(10, 1, 22 ),
(10, 1, 24 ),
(10, 1, 29 ),
(10, 1, 30 ),
-- kurs 11 - hiszpanski 2 gr 1
(11, 1,  6 ),
(11, 1, 16 ),
(11, 1, 18 ),
(11, 1, 22 ),
(11, 1, 24 ),
(11, 1, 29 ),
(11, 1, 30 ) ;

-- testing:
select * from kurs;

select KUOP.opis, KU.id_kurs_nazwa, KU.termin, UCZ.nazwisko, UCZ.imie
from kurs KU JOIN uczest_kurs UCZKUR ON KU.id_kurs = UCZKUR.id_kurs AND KU.id_grupa = uczkur.id_grupa
JOIN uczestnik UCZ ON UCZ.id_uczestnik = uczkur.id_uczestnik
JOIN kurs_opis KUOP ON KUOP.id_kurs = KU.id_kurs