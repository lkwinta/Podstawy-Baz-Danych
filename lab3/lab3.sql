-- 1. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
-- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
SELECT MAX(UnitPrice) AS MaxPrice
FROM [Order Details]
WHERE UnitPrice < 20

-- 3. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach
--  sprzedawanych w butelkach (‘bottle’)
SELECT MAX(UnitPrice) AS MaxPrice, MIN(UnitPrice) AS MinPrice, AVG(UnitPrice) AS AvgPrice
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%'

-- 4. Wypisz informację o wszystkich produktach o cenie powyżej średniej
SELECT *
FROM Products
WHERE Products.UnitPrice > (SELECT AVG(UnitPrice) FROM Products)


-- 5. Podaj sumę/wartość zamówienia o numerze 10250
SELECT ROUND(SUM([Order Details].UnitPrice*[Order Details].Quantity*(1 - [Order Details].Discount)), 2) AS Price
FROM [Order Details]
WHERE [Order Details].OrderID = 10250

SELECT CAST(SUM([Order Details].UnitPrice*[Order Details].Quantity*(1 - [Order Details].Discount)) AS DECIMAL(10,2)) AS Price
FROM [Order Details]
WHERE [Order Details].OrderID = 10250

-- ################# GRUPOWANIE #################
SELECT productid, SUM(orderhist.quantity) AS total_quantity
FROM orderhist
GROUP BY productid

-- 1. Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
-- 2. Posortuj zamówienia wg maksymalnej ceny produktu
-- 3. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
-- 4. Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
-- 5. Który z spedytorów był najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY ShipVia
ORDER BY COUNT(*)

-- 1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
-- 2. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg
-- łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
SELECT CustomerID
FROM Orders
WHERE YEAR(OrderDate) = 1998
GROUP BY CustomerID
HAVING COUNT(*) > 8
ORDER BY SUM(Freight) DESC
