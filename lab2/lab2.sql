SELECT Orders.OrderID, Orders.CustomerID
FROM Orders
WHERE Orders.OrderDate < '8/1/96'

SELECT Orders.OrderID, Orders.CustomerID, Orders.OrderDate
FROM Orders
WHERE Orders.OrderDate >= '1996-01-01' AND Orders.OrderDate <= '1996-12-31'