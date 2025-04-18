-- TASK - ONE

SELECT C.Name AS Country, CT.Name AS City
FROM country AS C
INNER JOIN city AS CT ON C.Capital = CT.ID
WHERE C.Code = "AZE";

-- TASK - TWO

SELECT C.Name AS COUNTRY, COUNT(CT.ID) AS COUNT
FROM country AS C
INNER JOIN city AS CT
ON C.code = CT.CountryCode
GROUP BY C.Name
ORDER BY COUNT DESC
LIMIT 1;

-- TASK - THREE

SELECT C.Name AS COUNTRY, C.SurfaceArea AS AREA, C.Population AS POPULATION
FROM country AS C
WHERE C.Population > 10000000
ORDER BY C.SurfaceArea
LIMIT 1;

-- TASK - FOUR

SELECT C.Name AS COUNTRY, CL.Language AS LANGUAGE
FROM country AS C
INNER JOIN countrylanguage AS CL
ON CL.CountryCode = C.Code
WHERE CL.Language = 'Spanish' AND CL.IsOfficial = 'T';

-- TASK - FIVE

SELECT C.Name AS COUNTRY
FROM country AS C
LEFT JOIN countrylanguage AS CL
ON CL.CountryCode = C.Code AND CL.IsOfficial = 'T'
WHERE CL.CountryCode IS NULL;

-- TASK - SIX

SELECT Continent AS CONTINENT, SUM(Population) AS POPULATION
FROM country
GROUP BY CONTINENT
ORDER BY POPULATION DESC
LIMIT 1;