-- 1. Lista z nazwiskami i imionami uczestników z kolumną o wartościach ('duża', 'średnia', 'mała', 'brak'). Wartości tej kolumny zależne od kolumny obecnosc.

WITH obecnosci as ( 
	SELECT SUM(fk.obecnosc) as obec, u.id_uczestnik
    FROM uczestnik u JOIN uczest_kurs uk ON u.id_uczestnik=uk.id_uczestnik
	JOIN frekwencja fk ON fk.id_uczestnik = uk.id_uczestnik
    WHERE fk.id_uczestnik = uk.id_uczestnik
    GROUP BY u.id_uczestnik
) SELECT DISTINCT u.imie, u.nazwisko,
  CASE 
     WHEN ob.obec >= 5 and ob.obec < 9 THEN 'mała'
     WHEN ob.obec >= 9 and ob.obec < 11 THEN 'średnia'
     WHEN ob.obec >= 11 THEN 'duża'
     ELSE 'brak'
  END
FROM obecnosci ob 
JOIN uczestnik u ON ob.id_uczestnik = u.id_uczestnik;

-- 2. Lista z nazwiskami i imionami wykładowców z kolumną o wartościach ('poniżej limitu', 'limit', 'powyżej limitu' ). Wartości tej kolumny zależne od ilosci uczestników na kursach danego wykładowcy.

SELECT wyk.imie, wyk.nazwisko, 

  CASE 
      WHEN count(id_uczestnik) < 13 THEN 'poniżej limitu'
      WHEN count(id_uczestnik) = 13 THEN 'limit'
      WHEN count(id_uczestnik) > 13 THEN 'powyżej limitu'
      ELSE 'brak'
  END
  
FROM wykladowca wyk
JOIN wykl_kurs wy_ku ON wy_ku.id_wykl = wyk.id_wykladowca
JOIN uczest_kurs ucz_kur on wy_ku.id_kurs = ucz_kur.id_kurs
GROUP BY imie, nazwisko;


-- 3. Korzystając z CTE pokazać średnią ilość uczestników na kursie. Nie korzystamy z agregatu AVG.

WITH ilosc AS ( 
	SELECT id_kurs, id_grupa, COUNT(*) AS ile 
    FROM uczest_kurs
	GROUP BY id_kurs, id_grupa 
) SELECT SUM(ile) / COUNT(ko.opis) as avg_ucz
FROM ilosc 
JOIN kurs k USING ( id_kurs, id_grupa)
JOIN kurs_opis ko ON k.id_kurs_nazwa = ko.id_kurs;