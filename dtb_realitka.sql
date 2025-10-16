SELECT
    DISTINCT typ
FROM
    reality_import_jeski

--vypis null hodnot
SELECT
    *
FROM
    reality_import_jeski
WHERE 
    typ IS NULL

--doplneni chybejicich hodnot
UPDATE
    reality_import_jeski
SET
    typ = CASE 
        WHEN id = 11 THEN N'Pozemek'
        WHEN id = 79 THEN N'Byt'
    END
WHERE
    typ IS NULL

--vlozeni do dimenze
INSERT INTO
    dim_typ_jeski (nazev)
SELECT
    DISTINCT typ
FROM
    reality_import_jeski

SELECT * FROM dim_typ_jeski



SELECT
    DISTINCT mestska_cast, psc
FROM
    reality_import_jeski

BEGIN TRAN
UPDATE
    reality_import_jeski
SET
    mestska_cast = N'Bohunice' 
WHERE
    psc = '61900'

COMMIT TRAN

--oddelani z mestske casti "Brno -" 
BEGIN TRAN
UPDATE
    reality_import_jeski
SET
    mestska_cast = REPLACE(mestska_cast, N'Brno-', N'')
WHERE
    mestska_cast LIKE N'Brno-%'
COMMIT TRAN


INSERT INTO
    dim_mestska_cast_jeski (nazev, psc)
SELECT DISTINCT
    mestska_cast, psc
FROM
    reality_import_jeski
