--trzby 01_2014 vs 01_2015
SELECT               
    YEAR(Date) AS Rok,
    SUM(Revenue) AS YearRevenue
FROM                        
    Sales
WHERE                             
    MONTH(Date) = 1 AND YEAR(Date) IN (2014,2015)
GROUP BY
    YEAR (Date)



--Ktere floridske mesto je zhruba stejne velke jako Brno (ma 32)?

SELECT  
    City,
    COUNT(DISTINCT Zip)
FROM
    Country
WHERE
 State = N'FL'
GROUP BY
    City
HAVING
    COUNT(DISTINCT Zip) BETWEEN 25 AND 35



--Na kterem Zip kodu jsem v dubnu 2014 vydelali nejvic?

SELECT
    Zip,
    SUM(Revenue) AS TotalRevenue
FROM    
    Sales
WHERE
    YEAR(Date) = 2014 AND MONTH(Date) = 04
GROUP BY
    Zip
ORDER BY
    TotalRevenue DESC



--Jaky nazev mesta se objevuje v nejvice statech?
SELECT 
    LEFT(City, CHARINDEX(N',', City) -1),
    COUNT(DISTINCT State) AS CountStates
FROM    
    Country
GROUP BY
    LEFT(City, CHARINDEX(N',', City) -1)
ORDER BY
    CountStates DESC



--view
CREATE VIEW SalesByManufacturerAndSales
AS
SELECT
    m.Manufacturer,
    c.State,
    SUM (Revenue) as TotalRevenue
FROM
    Sales s
    JOIN Product p ON s.ProductID = p.ProductID
    JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
    JOIN Country c ON s.Zip = c.Zip 

-- Ktery vyrobce nam vydelava nejvice?
SELECT
    Manufacturer,
    SUM(TotalRevenue) AS ManufacturerRevenue
FROM
    SalesByManufacturerAndState
GROUP BY
    Manufacturer
ORDER BY
    ManufacturerRevenue DESC