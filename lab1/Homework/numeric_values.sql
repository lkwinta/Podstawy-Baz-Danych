-- 1.
SELECT [Order Details].ProductID,
       ([Order Details].UnitPrice - [Order Details].Discount) * [Order Details].Quantity
                AS Total_Price
From [Order Details]
WHERE [Order Details].OrderID = 10250

-- 2.
SELECT Suppliers.SupplierID,
       Suppliers.Phone + ',' + IIF(Suppliers.Fax IS NULL, '', Suppliers.Fax)
FROM Suppliers