--Ve kterych kategoriich maji staty nejvyssi trzby
SELECT
    c.State, 
    p.Category,
    SUM(s.Revenue) AS RevenueSum
FROM
    Country c 
    JOIN Sales s ON s.Zip = c.Zip
    JOIN Product p ON s.ProductID = p.ProductID
GROUP BY
    c.State,
    Category
ORDER BY
   c.State,
    RevenueSum DESC

-- Na kterem zip kodu jsme nic neprodali v cervnu 2015?
SELECT
    *
FROM
    Country c 
    LEFT JOIN Sales s ON s.zip = c.zip
    AND Year(s.Date) = 2015 AND Month(s.Date) = 06
WHERE
    s.Zip is NULL