-- 1. Napisz polecenie, które:
--  – wybiera numer członka biblioteki (member_no), isbn książki (isbn) i watrość
--      naliczonej kary (fine_assessed) z tablicy loanhist dla wszystkich wypożyczeń
--      dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed)
--  – stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny
--      fine_assessed
--  – stwórz alias ‘double fine’ dla tej kolumny
SELECT member_no, isbn, fine_assessed, 2*fine_assessed AS [Doube Fine]
FROM loanhist
WHERE fine_assessed IS NOT NULL AND fine_assessed <> 0