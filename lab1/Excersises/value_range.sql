-- 1.
SELECT *
FROM Products
WHERE Products.UnitPrice < 10 OR Products.UnitPrice > 20

-- 2.
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice >= 20 AND Products.UnitPrice <= 30
