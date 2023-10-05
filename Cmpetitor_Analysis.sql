--- List of all potential competitors--
SELECT DISTINCT
    MAX(DBAName) AS DBAName,
    OwnershipName,
    BusinessStartDate,
    COUNT(NAB) AS Num_Locations
FROM [RB$] a
WHERE (a.DBAName LIKE '%Tech%' OR a.DBAName LIKE '%Computer%')
    AND a.NAICSCode = '5400-5499'
    AND a.City LIKE '%San Francisco%'
    AND a.BusinessEndDate IS NULL
GROUP BY OwnershipName, BusinessStartDate
ORDER BY BusinessStartDate ASC;

--- List of top competitors based on how long they been in business & and if they have multiple locations--
SELECT DISTINCT
    MAX(DBAName) AS DBAName,
    OwnershipName,
    BusinessStartDate,
    COUNT(NAB) AS Num_Locations
FROM [RB$] a
WHERE (a.DBAName LIKE '%Tech%' OR a.DBAName LIKE '%Computer%')
    AND a.NAICSCode = '5400-5499'
    AND a.City LIKE '%San Francisco%'
    AND a.BusinessEndDate IS NULL
	AND DATEDIFF(YEAR, a.BusinessStartDate, GETDATE()) >= 15
GROUP BY OwnershipName, BusinessStartDate
ORDER BY Num_Locations DESC;

---neighborhoods with the most companies from above list---
WITH TopCompetitors AS (
    SELECT DISTINCT
        MAX(DBAName) AS DBAName,
        OwnershipName,
        BusinessStartDate,
        NAB,  -- Include neighborhood information
        COUNT(NAB) AS Num_Locations
    FROM [RB$] a
    WHERE (a.DBAName LIKE '%Tech%' OR a.DBAName LIKE '%Computer%')
        AND a.NAICSCode = '5400-5499'
        AND a.City LIKE '%San Francisco%'
        AND a.BusinessEndDate IS NULL
        AND DATEDIFF(YEAR, a.BusinessStartDate, GETDATE()) >= 15 -- Select companies open for 15 or more years
    GROUP BY OwnershipName, BusinessStartDate, NAB
)
SELECT NAB AS Neighborhood, COUNT(DBAName) AS Num_Competitors
FROM TopCompetitors
GROUP BY NAB
ORDER BY Num_Competitors DESC;
