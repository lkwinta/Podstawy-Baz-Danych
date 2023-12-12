/*
1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
library). Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkania
dziecka. */



/*2. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
library). Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkania
dziecka oraz imię i nazwisko rodzica
*/
SELECT m.firstname, m.lastname, j.birth_date, ad.street, ad.city, ad.zip, ad.state, ma.firstname, ma.lastname
FROM member AS m
    INNER JOIN juvenile AS j ON m.member_no = j.member_no
    INNER JOIN adult AS ad ON j.adult_member_no = ad.member_no
    INNER JOIN member AS ma ON ad.member_no = ma.member_no

/*3. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci
urodzone przed 1 stycznia 1996 (baza library)*/


/*4. Napisz polecenie, które wyświetla adresy członków biblioteki, którzy mają dzieci
urodzone przed 1 stycznia 1996. Interesują nas tylko adresy takich członków
biblioteki, którzy aktualnie nie przetrzymują książek. (baza library)*/
SELECT a.member_no, a.street
FROM member as m
    INNER JOIN juvenile as j ON m.member_no = j.member_no
    INNER JOIN adult as a ON j.adult_member_no = a.member_no
    LEFT JOIN loan as l ON m.member_no = l.member_no
WHERE YEAR(j.birth_date) < 1996 AND l.member_no IS NULL
GROUP BY a.member_no, a.street
