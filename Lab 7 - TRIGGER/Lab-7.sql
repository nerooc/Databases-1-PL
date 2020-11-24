-- 1. Napisać wyzwalacz walidujący fname i lname w tabeli person, tylko litery, bez pustych wartości.

CREATE OR REPLACE FUNCTION validate_input ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
    
    -- Bez pustych wartości
    IF LENGTH(TRIM(NEW.lname)) = 0 OR LENGTH(TRIM(NEW.fname)) = 0 OR 
    
      -- Tylko litery (zrobione w ten sposób ponieważ regex nie działał)
    LENGTH(TRIM(TRANSLATE(NEW.lname, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0 OR 
    LENGTH(TRIM(TRANSLATE(NEW.fname, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0
    THEN
      RAISE EXCEPTION 'Błąd w lname lub fname! Pola nie mogą być puste i muszą składać się z samych liter';
    END IF;
  
    RETURN NEW;                                                          
    END;
    $$;


CREATE TRIGGER person_valid 
    AFTER INSERT OR UPDATE OR DELETE ON lab08.person
    FOR EACH ROW EXECUTE PROCEDURE validate_input(); 

-- Test
INSERT INTO lab08.person (lname, fname, primary_group, secondary_group ) VALUES ( 'Te8st', 'Test', 'A', 'B' );
SELECT * FROM lab08.person;


-- 2. Napisać wyzwalacz normalizujący fname i lname w tabeli person, Pierwsze litery powinny być "duże", reszta małe.

CREATE OR REPLACE FUNCTION normalizuj_name () 
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.fname := upper(substring(NEW.fname from 1 for 1)) || lower(substring(NEW.fname from 2 for length(NEW.fname)));
        NEW.lname := upper(substring(NEW.lname from 1 for 1)) || lower(substring(NEW.lname from 2 for length(NEW.lname)));
  	RETURN NEW;
	END;
$$;


CREATE TRIGGER person_normalizuj
    BEFORE INSERT OR UPDATE ON lab08.person
    FOR EACH ROW
    EXECUTE PROCEDURE normalizuj_name();
 
-- Test
INSERT INTO lab08.person (lname, fname, primary_group, secondary_group ) VALUES ( 'TeStOwE', 'ImIe', 'A', 'B' );  
SELECT * FROM lab08.person;


-- 3. Napisać wyzwalacz aktualizujący tabelę zawierającą liczbę wszystkich osób w danej grupie.

CREATE OR REPLACE FUNCTION group_count() 
	RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    BEGIN
    	
    	-- Jesli takiej grupy jeszcze nie było
        IF NOT EXISTS(SELECT 1 FROM lab08.person_count WHERE name = NEW.primary_group) THEN
            INSERT INTO lab08.person_count VALUES(NEW.primary_group, 1);
            RETURN NEW;   
            
        -- Jesli taka grupa sie juz pojawila         
       	ELSE
            UPDATE lab08.person_count 
            SET count = count + 1 WHERE name = NEW.primary_group;
            RETURN NEW;
        END IF;  
        

    END;
$$;

CREATE TRIGGER person_count_insert 
    BEFORE INSERT OR UPDATE ON lab08.person
    FOR EACH ROW EXECUTE PROCEDURE group_count();

-- Test
INSERT INTO lab08.person (lname, fname, primary_group, secondary_group ) VALUES ( 'TeStOwE', 'ImIe', 'A', 'B' );  
SELECT * FROM lab08.person_count;