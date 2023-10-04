-- 1.
SELECT Orders.OrderID, Orders.OrderDate, Orders.CustomerID
FROM Orders
WHERE Orders.ShippedDate IS NULL AND Orders.ShipRegion = 'Argentina'