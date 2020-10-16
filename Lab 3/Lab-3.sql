--we are looking for the number of all students
SELECT COUNT(*) FROM uczestnik;

--we are looking for names of available language courses
select opis FROM kurs_opis
WHERE opis LIKE 'Język%';

--we are looking for a participant with the best result (among all courses)
SELECT ucz.nazwisko, ucz.imie, oc.punkty
FROM ocena oc JOIN uczestnik ucz ON ucz.id_uczestnik = oc.id_uczestnik
WHERE punkty >= 90
ORDER BY punkty DESC
LIMIT 1;

--we are looking for groups and their participants
SELECT ku.id_grupa, ucz.nazwisko, ucz.imie 
FROM kurs ku JOIN uczest_kurs uczkur ON ku.id_kurs = uczkur.id_kurs AND ku.id_grupa = uczkur.id_grupa
JOIN uczestnik UCZ ON ucz.id_uczestnik = uczkur.id_uczestnik
ORDER BY id_grupa ASC;

--we are looking for the lowest and the highest number of points scored by participants in all courses
SELECT MIN(punkty), MAX(punkty)
FROM ocena;

--we are looking for what courses are conducted by which lecturers
SELECT DISTINCT kuop.opis, wyk.imie, wyk.nazwisko
FROM kurs ku JOIN kurs_opis kuop ON ku.id_kurs = kuop.id_kurs
JOIN wykl_kurs wyku ON wyku.id_kurs = kuop.id_kurs
JOIN wykladowca wyk ON wyk.id_wykladowca = wyku.id_wykl;

--we are looking for participants that passed, apart from a student named Gajda who we are sure about :)
SELECT ucz.nazwisko, ucz.imie, oc.punkty
FROM kurs ku JOIN  uczest_kurs uczkur ON ku.id_kurs = uczkur.id_kurs AND ku.id_grupa = uczkur.id_grupa
JOIN uczestnik ucz ON ucz.id_uczestnik = uczkur.id_uczestnik
JOIN kurs_opis kuop ON kuop.id_kurs = ku.id_kurs
JOIN ocena oc ON oc.id_uczestnik = ucz.id_uczestnik
WHERE punkty >= 50

EXCEPT 

SELECT ucz.nazwisko, ucz.imie, oc.punkty
FROM kurs ku JOIN  uczest_kurs uczkur ON ku.id_kurs = uczkur.id_kurs AND ku.id_grupa = uczkur.id_grupa
JOIN uczestnik ucz ON ucz.id_uczestnik = uczkur.id_uczestnik
JOIN kurs_opis kuop ON kuop.id_kurs = ku.id_kurs
JOIN ocena oc ON oc.id_uczestnik = ucz.id_uczestnik
WHERE nazwisko LIKE 'Gaj' AND imie LIKE 'Tom';

--we are looking for the top three participants (among all courses)
SELECT ucz.nazwisko, ucz.imie, oc.punkty
FROM ocena oc JOIN uczestnik ucz ON ucz.id_uczestnik = oc.id_uczestnik
ORDER BY punkty DESC
LIMIT 3;

--we are looking for a group with less than 20 members (e.g. to add new ones to it, filling the limit)
SELECT COUNT(ku.id_grupa), ku.id_grupa
FROM kurs ku JOIN uczest_kurs uczkur ON ku.id_kurs = uczkur.id_kurs AND ku.id_grupa = uczkur.id_grupa
JOIN uczestnik UCZ ON ucz.id_uczestnik = uczkur.id_uczestnik

GROUP BY (ku.id_grupa)
HAVING COUNT(ku.id_grupa) < 20;