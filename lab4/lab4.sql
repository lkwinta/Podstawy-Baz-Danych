/*1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy
20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy*/
SELECT Products.ProductName, Products.UnitPrice, Suppliers.Address
FROM Products INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE UnitPrice BETWEEN 20.00 AND 30.00

/*2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych
przez firmę ‘Tokyo Tradersʼ*/
SELECT Products.ProductName, Products.UnitsInStock
FROM Products INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Tokyo Traders'

/*3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to
pokaż ich dane adresowe */

SELECT Customers.CompanyName, Customers.Address
FROM Customers LEFT OUTER JOIN (
    SELECT CustomerID
    FROM Orders
    WHERE YEAR(OrderDate) = 1997) AS OrderIn1997
                               ON Customers.CustomerID = OrderIn1997.CustomerID
WHERE OrderIn1997.CustomerID IS NULL

--Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku,
--jeśli tak to pokaż ich dane adresowe
SELECT c.CompanyName, c.Address
FROM Customers AS c LEFT OUTER JOIN Orders AS o
                                    ON o.CustomerID = c.CustomerID AND YEAR(o.OrderDate) = 1997
WHERE OrderDate IS NULL


/*4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których
aktualnie nie ma w magazynie.*/
SELECT Suppliers.CompanyName, Suppliers.Phone
FROM Suppliers INNER JOIN Products ON Suppliers.SupplierID = Products.SupplierID
WHERE Products.UnitsInStock = 0