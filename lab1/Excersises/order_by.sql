-- 1.
SELECT Customers.CompanyName, Customers.Country
FROM Customers
ORDER BY Customers.Country, Customers.CompanyName

-- 2.
SELECT Categories.CategoryName, Products.ProductName, Products.UnitPrice
FROM Products INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
ORDER BY Products.UnitPrice DESC

-- 3.
SELECT Customers.CompanyName, Customers.Country
FROM Customers
WHERE Customers.Country IN ('Japan', 'Italy')
ORDER BY Customers.Country, Customers.CompanyName