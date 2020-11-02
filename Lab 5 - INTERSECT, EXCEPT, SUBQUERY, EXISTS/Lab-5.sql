-- 1. Użyć operatora INTERSECT w celu otrzymania listy uczestników, którzy uczestniczyli na 1 i 2 stopniu kursu języka angielskiego.

SELECT nazwisko, imie, U_K.id_kurs, U_K.id_uczestnik FROM uczestnik U join uczest_kurs U_K ON U_K.id_uczestnik = U.id_uczestnik
INTERSECT
SELECT nazwisko, imie, U_K.id_kurs, U_K.id_uczestnik FROM uczest_kurs U_K JOIN uczestnik U ON U_K.id_kurs = 1 OR U_K.id_kurs = 2
ORDER BY id_kurs;

-- 2. Użyć operatora EXCEPT w celu otrzymania listy wykładowców, którzy nie prowadzą kursów.

SELECT nazwisko, imie FROM wykladowca

EXCEPT

SELECT WY.nazwisko, WY.imie -- ,COUNT(*) -- do sprawdzenia ilości
FROM wykladowca WY JOIN wykl_kurs WY_KU ON WY.id_wykladowca = WY_KU.id_wykl
GROUP BY id_wykl, WY.imie, WY.nazwisko 
HAVING COUNT(*) >= 1;

-- 3. Napisać podzapytanie skorelowane w celu otrzymania listy kursów dla których suma opłat jest większa od zadanej wartości.

SELECT KU_OP.opis, 
( 
	SELECT SUM(OC.oplata)
    FROM ocena OC 
    WHERE OC.id_kurs = KU_OP.id_kurs
    GROUP BY OC.id_kurs
) as suma_oplat

FROM kurs_opis KU_OP
JOIN ocena OC ON OC.id_kurs = KU_OP.id_kurs
GROUP BY KU_OP.opis, KU_OP.id_kurs HAVING sum(OC.oplata) > 500
ORDER BY suma_oplat desc;

-- 4. Użyć predykatu EXISTS w celu otrzymania listy wykładowców, którzy mają zajęcia i jakie prowadzą przedmioty

SELECT WY.nazwisko, WY.imie, ku_op.opis
FROM wykladowca WY JOIN wykl_kurs WY_KU ON WY.id_wykladowca = WY_KU.id_wykl
JOIN kurs_opis KU_OP ON WY_KU.id_kurs = KU_OP.id_kurs
WHERE EXISTS ( SELECT 1 FROM wykladowca WY WHERE WY.id_wykladowca = WY_KU.id_wykl );