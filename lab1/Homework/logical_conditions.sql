-- 1.
SELECT Customers.CompanyName, Customers.Country
FROM Customers
WHERE Customers.Country = 'Japan' OR Customers.Country = 'Italy'