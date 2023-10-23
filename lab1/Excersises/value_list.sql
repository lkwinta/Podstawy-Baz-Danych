-- 1. Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer klienta dla wszystkich
-- niezrealizowanych jeszcze zleceń, dla których krajem odbiorcy jest Argentyna
SELECT Orders.OrderID, Orders.OrderDate, Orders.CustomerID
FROM Orders
WHERE (Orders.ShippedDate > GETDATE() OR Orders.ShippedDate IS NULL) AND Orders.ShipCountry = 'Argentina'
