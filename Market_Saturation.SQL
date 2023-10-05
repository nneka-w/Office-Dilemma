--Market Saturation--

-- NAICS code is a range, when the code we need is 5415 so in order to narrow down alike businesses, I compared names to ones similar to ours---
SELECT COUNT(*) as Total_Businesses
FROM [RB$]
WHERE ( DBAName LIKE '%Tech%' OR
      DBAName LIKE '%Computer%' ) AND
	  NAICSCode = '5400-5499' AND
      City LIKE '%San Francisco%' AND 
	  BusinessEndDate IS NULL --counts only businesses still active--


SELECT BusinessCorridor, COUNT(DBAName) as Total
FROM RB$
WHERE ( DBAName LIKE '%Tech%' OR
      DBAName LIKE '%Computer%' ) AND 
	  NAICSCode = '5400-5499' AND
      City LIKE '%San Francisco%' AND 
	  BusinessEndDate IS NULL AND
	  BusinessCorridor IS NOT NULL --Not counting businesses outside a business corridor--
GROUP BY BusinessCorridor
ORDER BY BusinessCorridor ASC;

SELECT NAB as Neighborhood, COUNT(DBAName) as Total
FROM RB$
WHERE ( DBAName LIKE '%Tech%' OR
      DBAName LIKE '%Computer%' ) AND
	  NAICSCode = '5400-5499' AND
      City LIKE '%San Francisco%' AND 
	  BusinessEndDate IS NULL 
GROUP BY NAB
ORDER BY NAB ASC;




