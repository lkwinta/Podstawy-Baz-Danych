--cross join JoinDB
--SELECT buyer_name, qty FROM Buyers CROSS JOIN Sales



/*
1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy
20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy, interesują nas
tylko produkty z kategorii ‘Meat/Poultryʼ
*/
SELECT ProductName, UnitPrice, Address
FROM Products
    INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
    INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Meat/Poultry' AND UnitPrice BETWEEN 20 AND 30


/*2. Wybierz nazwy i ceny produktów z kategorii ‘Confectionsʼ dla każdego produktu podaj
nazwę dostawcy.*/

/*
3. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki
dostarczała firma ‘United Packageʼ
*/
SELECT c.CompanyName, c.Phone
FROM Customers as c
    INNER JOIN Orders as o ON c.CustomerID = o.CustomerID
    INNER JOIN Shippers as s ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'United Package' AND YEAR(OrderDate) = 1997

/*
4. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
‘Confectionsʼ*/
SELECT DISTINCT c.CompanyName, c.Phone
FROM Customers as c
    INNER JOIN Orders as o ON c.CustomerID = o.CustomerID
    INNER JOIN [Order Details] as od ON o.OrderID = od.OrderID
    INNER JOIN Products as p ON od.ProductID = p.ProductID
    INNER JOIN Categories as cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Confections'

-- self join
select a.employeeid, a.lastname as name
     , a.title as title
     , b.employeeid, b.lastname as name
     , b.title as title
from employees as a join employees as b on a.title = b.title
where a.employeeid < b.employeeid

/*
1. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza
northwind) */
SELECT DISTINCT a.FirstName AS Pracownik_Imie, a.LastName AS Pracownik_Nazwisko
FROM Employees AS a JOIN Employees AS b ON a.EmployeeID = b.ReportsTo

/*2. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza
orthwind)*/
SELECT a.FirstName, a.LastName
FROM Employees AS a LEFT JOIN Employees AS b ON a.EmployeeID = b.ReportsTo
WHERE b.EmployeeID IS NULL


