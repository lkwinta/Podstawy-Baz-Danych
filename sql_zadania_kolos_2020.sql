;WITH
    counts AS (
        SELECT Orders.CustomerID, Products.CategoryID, COUNT(*) AS categories_count
        FROM [Order Details]
            INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
            INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
            INNER JOIN Orders ON Orders.OrderID = [Order Details].OrderID
            WHERE YEAR(OrderDate) = 1997
        GROUP BY Orders.CustomerID, Products.CategoryID
    ),
    maxes AS (
        SELECT CustomerID, MAX(categories_count) AS max_count
        FROM counts
        GROUP BY CustomerID
    )
SELECT CompanyName, CategoryName, maxes.max_count
FROM maxes
    LEFT OUTER JOIN counts ON counts.categories_count = maxes.max_count AND counts.CustomerID = maxes.CustomerID
    INNER JOIN Categories ON counts.CategoryID = Categories.CategoryID
    INNER JOIN Customers ON maxes.CustomerID = Customers.CustomerID



