/*
-- podaj listę dzieci będących członkami biblioteki które w dniu 2001-12-14 zwróciły do biblioteki książkę o tytule Walking
*/

;with
     all_members_with_walking AS ( --wszyscy członkowie którzy zwrócili Walking w 2001-12-14
         SELECT member_no
         FROM loanhist
                  INNER JOIN title ON loanhist.title_no = title.title_no
         WHERE
                 YEAR(in_date) = 2001 AND MONTH(in_date) = 12 AND DAY(in_date) = 14 AND
                 title = 'Walking'
     )
SELECT firstname, lastname, street, city, zip, juvenile.member_no
FROM juvenile
    INNER JOIN all_members_with_walking ON juvenile.member_no = all_members_with_walking.member_no
    INNER JOIN member ON juvenile.member_no = member.member_no
    INNER JOIN adult ON juvenile.adult_member_no = adult.member_no



/*
---Podaj liczbę zamóień oraz wartość zamówień opłatę za przesyłkę ) obsłużonyhc przez każdego pracownika w lutym 1997.
Jeśli praownik nie obsłużył w tym okresie żadnego zamówienia, to też powinein pojawić sie na liście.
Zbiór powinei zawierać: imię anzwisko, liczbe obsłużonych zamówień, wartość zamóien
*/

;with
     order_values as (
         select OrderID, SUM(Quantity*UnitPrice*(1 - Discount)) as price
         from [Order Details]
         group by OrderID
     ),
    employees_with_values as (
        select EmployeeID, count(*) as orders_count, sum(price + Freight) as orders_value
        from Orders inner join order_values on order_values.OrderID = Orders.OrderID
        where year(OrderDate) = 1997 and month(OrderDate) = 2
        group by EmployeeID
    )
select FirstName, LastName, isnull(orders_count, 0) as total_count, isnull(orders_value, 0) as total_value
from Employees left outer join employees_with_values ON employees_with_values.EmployeeID = Employees.EmployeeID

/*
-- podaj kategorie w której produkty wygenerowały najwyższe przychody w 1997. wartość przychodu podaj z rozbiciem na meisiące
*/

;WITH
     top_category AS (
         SELECT TOP 1  CategoryID, SUM(Quantity*[Order Details].UnitPrice*(1-Discount)) AS OrderValue
         FROM [Order Details]
                INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
                INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
         WHERE YEAR(OrderDate) = 1997
         GROUP BY CategoryID
         ORDER BY SUM(Quantity*[Order Details].UnitPrice*(1-Discount)) DESC
     )
SELECT MAX(top_category.CategoryID) as CategoryID, MONTH(OrderDate) AS Month, SUM(Quantity*[Order Details].UnitPrice*(1-Discount)) AS Income
FROM [Order Details]
    INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
    INNER JOIN top_category ON Products.CategoryID = top_category.CategoryID
    INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY MONTH(OrderDate)


-- ZAD 1, niezerowy zysk z produktu w 1996, nazwa produktu
SELECT ProductName, SUM(Products.UnitPrice*Quantity - [Order Details].UnitPrice*Quantity*(1-Discount)) AS value
FROM [Order Details]
         INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
         INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE YEAR(OrderDate) = 1996
GROUP BY [Order Details].ProductID, ProductName
HAVING SUM(Products.UnitPrice*Quantity - [Order Details].UnitPrice*Quantity*(1-Discount)) > 0
ORDER BY SUM(Products.UnitPrice*Quantity - [Order Details].UnitPrice*Quantity*(1-Discount)) DESC

SELECT ProductName
FROM Products
         INNER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
         INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(OrderDate) = 1996
GROUP BY Products.ProductID, ProductName


-- ZAD 2, tytuły ksiazek poozyczoneprzez wiecej niz 1 czytelnika, imiona i nazwiska, tacy ktorzy mają dzieci
SELECT title_no, COUNT(*)
FROM loanhist
    INNER JOIN juvenile ON juvenile.adult_member_no = loanhist.member_no
GROUP BY title_no

-- ZAD 3, podaj wszystkie zamówienia dla których opłata za przesyłke > od sredniej w danym roku

;WITH
    year_avg AS (SELECT YEAR(OrderDate) AS year, AVG(Freight) AS avg
                 FROM Orders
                 GROUP BY YEAR(OrderDate))
SELECT OrderID, Freight
 FROM Orders INNER JOIN year_avg ON YEAR(OrderDate) = year_avg.year
WHERE Freight > avg

/*zad 3)
Dla każdego przewoźnika podaj nazwę produktu z kategorii 'Seafood', który ten
przewoźnik przewoził najczęściej w kwietniu 1997. Podaj też informację ile razy
dany przewoźnik przewoził ten produkt w tym okresie (jeśli takich produktów jest
więcej to wystarczy podać nazwę jednego z nich). Zbiór wynikowy powinien
zawierać nazwę przewoźnika, nazwę produktu oraz informację ile razy dany produkt
był przewożony (baza northwind)
*/

; WITH
      counts AS (SELECT SupplierID, Products.ProductID, COUNT(*) as product_count
                 FROM [Order Details]
                          INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
                          INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
                          INNER JOIN Orders ON [Order Details].OrderID = Orders.OrderID
                 WHERE CategoryName = 'Seafood'
                 GROUP BY SupplierID, Products.ProductID),
      max_counts AS ( SELECT SupplierID, MAX(product_count) AS max_count
                 FROM counts
                 GROUP BY SupplierID
      )
SELECT CompanyName, ProductName, max_count
FROM counts
    INNER JOIN max_counts ON counts.product_count = max_counts.max_count AND counts.SupplierID = counts.SupplierID
    INNER JOIN Suppliers ON counts.SupplierID = Suppliers.SupplierID
    INNER JOIN Products ON counts.ProductID = Products.ProductID

/*
zad 2)
Podaj tytuły książek, które nie są aktualnie zarezerwowane przez dzieci mieszkające
w Arizonie (AZ). (baza library)
*/

;WITH
     reserved AS (
        SELECT isbn, juvenile.member_no
        FROM reservation
            INNER JOIN juvenile ON reservation.member_no = juvenile.member_no
            INNER JOIN adult ON juvenile.adult_member_no = adult.member_no
        WHERE adult.state = 'AZ'
    )
SELECT title
FROM reservation
    LEFT OUTER JOIN reserved ON
         reserved.isbn = reservation.isbn AND
         reserved.member_no = reservation.member_no
    INNER JOIN item ON reservation.isbn = item.isbn
    INNER JOIN title ON item.title_no = title.title_no
WHERE reserved.isbn IS NULL

