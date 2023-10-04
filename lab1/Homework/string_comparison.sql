-- 1.
SELECT *
FROM Products
WHERE Products.QuantityPerUnit LIKE '%bottles%'

-- 2.
SELECT Employees.LastName, Employees.Title
FROM Employees
WHERE Employees.LastName LIKE '[B-L]%'

-- 3.
SELECT Employees.LastName, Employees.Title
FROM Employees
WHERE Employees.LastName LIKE '[BL]%'

-- 4.
SELECT Categories.CategoryName
FROM Categories
WHERE Categories.Description LIKE '%,%'

-- 5.
SELECT *
FROM Customers
WHERE Customers.CompanyName LIKE '%Store%'