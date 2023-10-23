/* 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień */
SELECT EmployeeID, COUNT(*)
FROM Orders
GROUP BY EmployeeID

/*2. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
przewożonych przez niego zamówień */
SELECT ShipVia, SUM(Freight)
FROM Orders
GROUP By ShipVia

/* 3. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
przewożonych przez niego zamówień w latach o 1996 do 1997 */
SELECT ShipVia, SUM(Freight)
FROM Orders
WHERE YEAR(ShippedDate) IN (1996, 1997)
GROUP By ShipVia