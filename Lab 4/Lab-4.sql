-- 1. Liczba osób na poszczególnych kursach (nazwa kursu, liczba osób)
SELECT KUOP.opis, COUNT(U_K.id_uczestnik) 
-- używam left join, by uwzględnić 3 kursy, które mają 0 uczestników
FROM kurs KU LEFT JOIN uczest_kurs U_K ON KU.id_kurs = U_K.id_kurs
JOIN kurs_opis KUOP ON KU.id_kurs = KUOP.id_kurs
GROUP BY (kuop.opis);

-- 2. Suma opłat za poszczególne kursy (nazwa kursu, suma opłat)
SELECT KUOP.opis, SUM(OC.oplata)
-- używam left join, by uwzględnić kursy, w których nie ma opłat
FROM kurs KU LEFT JOIN ocena OC ON KU.id_kurs = OC.id_kurs
JOIN kurs_opis KUOP ON KU.id_kurs = KUOP.id_kurs
GROUP BY (kuop.opis);

-- 3. Średnia ocen na poszczegónych kursach (nazwa kursu, średnia ocen)
SELECT KUOP.opis, AVG(OC.punkty)
-- używam left join, by uwzględnić kursy, w których nie ma ocen
FROM kurs KU LEFT JOIN ocena OC ON KU.id_kurs = OC.id_kurs
JOIN kurs_opis KUOP ON KU.id_kurs = KUOP.id_kurs
GROUP BY (kuop.opis);

-- 4. Lista wykładowców, którzy mają co najmniej jeden kurs (imię, nazwisko)
SELECT WY.imie, WY.nazwisko -- ,COUNT(*) -- do sprawdzenia ilości
FROM wykladowca WY JOIN wykl_kurs WY_KU ON WY.id_wykladowca = WY_KU.id_wykl
GROUP BY id_wykl, WY.imie, WY.nazwisko 
HAVING COUNT(*) >= 1;

-- 5. Lista wykładowców, którzy nie mają żadnego kursu (imię, nazwisko)
SELECT imie, nazwisko FROM wykladowca

EXCEPT

SELECT WY.imie, WY.nazwisko -- ,COUNT(*) -- do sprawdzenia ilości
FROM wykladowca WY JOIN wykl_kurs WY_KU ON WY.id_wykladowca = WY_KU.id_wykl
GROUP BY id_wykl, WY.imie, WY.nazwisko 
HAVING COUNT(*) >= 1;

-- 6. Lista osób, którzy uczestniczyli w co najmniej dwóch kursach (imię, nazwisko)
SELECT UCZ.imie, UCZ.nazwisko, COUNT(*)
FROM uczestnik UCZ LEFT JOIN uczest_kurs UCZ_KUR ON UCZ.id_uczestnik = UCZ_KUR.id_uczestnik
GROUP BY UCZ.id_uczestnik, UCZ.imie, UCZ.nazwisko
HAVING COUNT(*) >= 2;

-- 7. Lista zawierająca sumy wpłat przez poszczególnych uczestników (imię, nazwisko, suma)
SELECT UCZ.imie, UCZ.nazwisko, SUM(OC.oplata) 
FROM uczestnik UCZ LEFT JOIN ocena OC ON UCZ.id_uczestnik = OC.id_uczestnik
GROUP BY UCZ.imie, UCZ.nazwisko;

-- 8. Uczestnik, który wpłacił najwięcej za kursy (imię, nazwisko, kwota)
SELECT UCZ.imie, UCZ.nazwisko, SUM(OC.oplata)
FROM uczestnik UCZ JOIN ocena OC ON UCZ.id_uczestnik = OC.id_uczestnik
WHERE OC.oplata IS NOT NULL
GROUP BY UCZ.imie, UCZ.nazwisko
ORDER BY SUM(OC.oplata) DESC
LIMIT 1;