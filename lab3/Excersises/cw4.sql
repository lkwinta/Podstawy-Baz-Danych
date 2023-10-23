/*1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z
podziałem na lata i miesiące*/
SELECT EmployeeID, MONTH(OrderDate) AS Miesiac, YEAR(OrderDate) AS Rok, COUNT(*) AS Ilosc_zamowien
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)

/*2. Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej
kategorii*/
SELECT CategoryID, MAX(UnitPrice) AS MaxPrice, MIN(UnitPrice) AS MinPrice
FROM Products
GROUP BY CategoryID