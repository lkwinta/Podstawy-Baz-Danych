-- 1.
SELECT [Order Details].ProductID,
       ([Order Details].UnitPrice - [Order Details].Discount) * [Order Details].Quantity
                AS Total_Price
From [Order Details]
WHERE [Order Details].OrderID = 10250

-- 2. Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę zawierającą nr telefonu i
-- nr faksu w formacie
-- (numer telefonu i faksu mają być oddzielone przecinkiem)
SELECT Suppliers.SupplierID,
       Suppliers.Phone + IIF(Suppliers.Fax IS NULL, '', ', ' + Suppliers.Fax)
FROM Suppliers

SELECT Suppliers.SupplierID,
       Suppliers.Phone + ISNULL( ', ' + Suppliers.Fax, '')
FROM Suppliers

SELECT Suppliers.SupplierID,
       CONCAT(Suppliers.Phone, ', ', Suppliers.Fax)
FROM Suppliers

SELECT Suppliers.SupplierID,
       CONCAT_WS(', ', Suppliers.Phone, Suppliers.Fax)
FROM Suppliers