/*
 zad 1)
Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
pracownikow to wystarczy podać imię nazwisko jednego nich). Za datę obsłużenia
zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać nazwę
klienta, imię i nazwisko pracownika oraz liczbę obsłużonych zamówień. (baza
northwind)
 */

;with
    t1 AS  (
        SELECT Customers.CustomerID, EmployeeID, COUNT(*) AS order_count
        FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
        WHERE YEAR(OrderDate) = 1997
        GROUP BY Customers.CustomerID, EmployeeID
    ),
    t2 AS (
        SELECT CustomerID, MAX(order_count) AS max_count
        FROM t1
        GROUP BY CustomerID
    ),
    t3 AS (
        SELECT t1.CustomerID, EmployeeID, max_count
        FROM t1 LEFT OUTER JOIN t2 ON t1.order_count = t2.max_count AND t1.CustomerID = t2.CustomerID
        WHERE t2.CustomerID IS NOT NULL
    )

SELECT CompanyName, FirstName, LastName, max_count
FROM t3
    INNER JOIN Customers ON t3.CustomerID = Customers.CustomerID
    INNER JOIN Employees ON t3.EmployeeID = Employees.EmployeeID

/*
zad 2)
Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
obsłużonych przez każdego pracownika w lutym 1997. Za datę obsłużenia
zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
(liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
zamówień, wartość obsłużonych zamówień. (baza northwind)
 */

with
    order_values AS (
        SELECT OrderID, SUM(Quantity * UnitPrice * (1 - Discount)) AS order_value
        FROM [Order Details]
        GROUP BY OrderID
    ),
    t1 AS (
       SELECT EmployeeID, COUNT(*) AS order_count, SUM(order_value + Orders.Freight) AS order_value
       FROM Orders INNER JOIN order_values ON Orders.OrderID = order_values.OrderID
       WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 2
       GROUP BY EmployeeID
    )

SELECT LastName, FirstName, IIF(order_count IS NULL, 0, order_count) AS order_count, IIF(order_value IS NULL, 0, order_value) AS order_value
FROM Employees LEFT OUTER JOIN t1 ON t1.EmployeeID = Employees.EmployeeID
--------------------------------------------------------------------------
SELECT MAX(LastName), MAX(FirstName), COUNT(DISTINCT Orders.OrderID), SUM(Quantity * UnitPrice * (1 - Discount))
FROM Employees
    LEFT OUTER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID AND YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 2
    LEFT OUTER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Employees.EmployeeID

/*
 zad 3)
Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14'
zwróciły do biblioteki książkę o tytule 'Walking'. Zbiór wynikowy powinien zawierać
imię i nazwisko oraz dane adresowe dziecka. (baza library)
 */

;WITH
    children_loan AS (
        SELECT juvenile.member_no AS child_member_no, adult_member_no
        FROM juvenile
                INNER JOIN loanhist ON juvenile.member_no = loanhist.member_no
                INNER JOIN item ON loanhist.isbn = item.isbn
                INNER JOIN title ON item.title_no = title.title_no
        WHERE YEAR(in_date) = 2001
         AND MONTH(in_date) = 12
         AND DAY(in_date) = 14
         AND title = 'Walking'
    ),
    children_name AS (
        SELECT juvenile.member_no, firstname, lastname
        FROM juvenile INNER JOIN member ON juvenile.member_no = member.member_no
    ),
    children_address AS (
        SELECT juvenile.member_no, street, city
        FROM adult INNER JOIN juvenile on adult.member_no = juvenile.adult_member_no
    )
SELECT firstname, lastname, street, city
FROM children_name
    INNER JOIN children_loan ON children_name.member_no = children_loan.child_member_no
    INNER JOIN children_address ON children_name.member_no = children_address.member_no

/*zad 1)
Podaj tytuły książek zarezerwowanych przez dorosłych członków biblioteki
mieszkających w Arizonie (AZ). Zbiór wynikowy powinien zawierać imię i nazwisko
członka biblioteki, jego adres oraz tytuł zarezerwowanej książki. Jeśli jakaś osoba
dorosła mieszkająca w Arizonie nie ma zarezerwowanej żadnej książki to też
powinna znaleźć się na liście, a w polu przeznaczonym na tytuł książki powinien
pojawić się napis BRAK. (baza library)
  */
SELECT lastname, firstname, street, city, zip, IIF(title is null, 'BRAK', title)
FROM adult
    INNER JOIN member ON adult.member_no = member.member_no
    LEFT OUTER JOIN reservation ON adult.member_no = reservation.member_no
    LEFT JOIN item ON reservation.isbn = item.isbn
    LEFT JOIN title ON item.title_no = title.title_no
WHERE adult.state = 'AZ'

  /*
zad 2)
Pokaż nazwy produktów, kategorii 'Beverages' które nie były kupowane w okresie
od '1997.02.20' do '1997.02.25' Dla każdego takiego produktu podaj jego nazwę,
nazwę dostawcy (supplier), oraz nazwę kategorii. Zbiór wynikowy powinien
zawierać nazwę produktu, nazwę dostawcy oraz nazwę kategorii. (baza northwind)
*/

;WITH
    products_which_was_bought AS (SELECT ProductID
                                  FROM [Order Details]
                                           INNER JOIN Orders ON Orders.OrderID = [Order Details].OrderID
                                  WHERE OrderDate BETWEEN '1997.02.20' AND '1997.02.25'
                                  GROUP BY ProductID)
SELECT Products.ProductName, Suppliers.CompanyName, CategoryName
FROM Products
    LEFT OUTER JOIN products_which_was_bought ON Products.ProductID = products_which_was_bought.ProductID
    INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
    INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE products_which_was_bought.ProductID IS NULL AND CategoryName = 'Beverages'

/*
  zad 3)
Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
złożonych przez każdego klienta w lutym 1997. Jeśli klient nie złożył w tym okresie
żadnego zamówienia, to też powinien pojawić się na liście (liczba złożonych
zamówień oraz ich wartość jest w takim przypadku równa 0). Zbiór wynikowy
powinien zawierać: nazwę klienta, liczbę obsłużonych zamówień, oraz wartość
złożonych zamówień. (baza northwind)*/

; WITH
      grouped_order_value AS (
          SELECT OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS OrderValue
          FROM [Order Details]
          GROUP BY OrderID
      ),
      customer_orders AS (
          SELECT CustomerID, COUNT(*) AS order_count, SUM(OrderValue + Freight) AS total_order_value
          FROM Orders INNER JOIN grouped_order_value ON grouped_order_value.OrderID = Orders.OrderID
          WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 2
          GROUP BY CustomerID
      )
SELECT CompanyName, ISNULL(order_count, 0) AS OrderCount, ISNULL(total_order_value, 0) AS OrderValue
FROM Customers
    LEFT OUTER JOIN customer_orders ON customer_orders.CustomerID = Customers.CustomerID



