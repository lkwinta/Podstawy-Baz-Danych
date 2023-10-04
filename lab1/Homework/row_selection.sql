-- 1.
SELECT Customers.CompanyName, Customers.Address
FROM Customers
WHERE Customers.City = 'London'

-- 2.
SELECT Customers.CompanyName, Customers.Address
FROM Customers
WHERE Customers.Country = 'France' OR Customers.Country = 'Spain'

-- 3.
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice BETWEEN 20.0 AND 30.0

-- 4.
SELECT Products.ProductName, Products.UnitPrice
FROM Products INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Meat/Poultry'

-- 5.
SELECT Products.ProductName, Products.UnitsInStock
FROM Products INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Tokyo Traders'

-- 6.
SELECT Products.ProductName
FROM Products
WHERE Products.UnitsInStock = 0