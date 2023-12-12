/*

1. Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko oraz liczbę jego
dzieci.
2. Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci,
liczbę zarezerwowanych książek oraz liczbę wypożyczonych książek.
3. Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci,
oraz liczbę książek zarezerwowanych i wypożyczonych przez niego i jego dzieci.
4. Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2001r
5. Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2002r
*/


WITH
    counts AS (
        SELECT member_no, COUNT(*) AS book_count
        FROM loan
        GROUP BY member_no)
SELECT lastname, firstname, book_count
FROM member INNER JOIN counts ON counts.member_no = member.member_no

WITH
    children AS (SELECT adult_member_no, COUNT(*) AS children_count
                  FROM juvenile
                  GROUP BY adult_member_no),
    books_adult AS (SELECT adult.member_no AS adult_no, COUNT(*) AS books_count
                FROM adult INNER JOIN loan ON adult.member_no = loan.member_no
                GROUP BY adult.member_no),
    books_children AS (SELECT juvenile.adult_member_no, COUNT(*) AS books_count
                FROM juvenile INNER JOIN loan ON juvenile.member_no = loan.member_no
                GROUP BY adult_member_no)

SELECT lastname, firstname,
       children_count,
       IIF(books_adult.books_count IS NULL, 0, books_adult.books_count) AS books_count,
       IIF(books_children.books_count IS NULL, 0, books_children.books_count) AS books_children_count
FROM member
    INNER JOIN adult ON adult.member_no = member.member_no
    LEFT JOIN children ON children.adult_member_no = member.member_no
    LEFT JOIN books_adult ON books_adult.adult_no = member.member_no
    LEFT JOIN books_children ON books_children.adult_member_no = member.member_no


