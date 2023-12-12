/**
  Ćwiczenie 1.
1. Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)*/
SELECT SUM(UnitPrice*Quantity) +
       (SELECT Freight FROM Orders WHERE OrderID = 10250) AS TotalPrice
FROM [Order Details]
WHERE OrderID = 10250
GROUP BY OrderID

SELECT SUM(UnitPrice*Quantity) + o.Freight AS TotalPrice
FROM [Order Details] AS od INNER JOIN Orders AS o ON od.OrderID = o.OrderID
WHERE od.OrderID = 10250
GROUP BY od.OrderID, Freight

/*2. Podaj łączną wartość każdego zamówienia (uwzględnij cenę za przesyłkę)*/


SELECT od.OrderID, SUM(UnitPrice*Quantity)
        AS TotalPrice
FROM [Order Details] AS od
GROUP BY od.OrderID

/*3. Dla każdego produktu podaj maksymalną wartość zakupu tego produktu*/


/*4. Dla każdego produktu podaj maksymalną wartość zakupu tego produktu w 1997
 */