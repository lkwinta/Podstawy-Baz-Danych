-- Test query
SELECT * FROM Products

-- Print out version of the server
SELECT @@VERSION

SELECT * FROM Customers
SELECT * FROM Suppliers
SELECT * FROM Categories

-- Use "", [] to select from table named with space
SELECT * FROM [Order Details] WHERE OrderID = 10250
SELECT * FROM "Order Details" WHERE OrderID = 10250